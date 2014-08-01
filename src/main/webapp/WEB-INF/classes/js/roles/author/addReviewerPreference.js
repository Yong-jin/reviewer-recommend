var AddReviewer = function (url) {
	var handleRegister = function (url) {

		function format(state) {
            if (!state.id) return state.text; // optgroup
            return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
        }


		$("#select2_sample4").select2({
            allowClear: true,
            formatResult: format,
            formatSelection: format,
            escapeMarkup: function (m) {
                return m;
            }
        });


		$('#select2_sample4').change(function () {
            $('.register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });


        $('.register-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
            	email: {
                    required: true,
                    email: true,
                    minlength: 3,
                    maxlength: 55,
                },
                firstName: {
                    required: true,
                    minlength: 2,
                    maxlength: 40,
                },
                lastName: {
                    required: true,
                    minlength: 2,
                    maxlength: 30,
                },
                degree: {
                    required: true,
                },
                salutation: {
                    required: true,
                },
                institution: {
                    required: true,
                    minlength: 2,
                    maxlength: 70,
                }
            },
            
            messages: {
            	username: {
                	required: "Please enter your email address.",
                    email: "Please enter a valid email address.",
                    minlength: jQuery.format("Please enter at least {0} characters."),
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                    remote: jQuery.format("{0} is already in use"),
                },
                "firstName": {
                	required: "Please enter your first name.",
                    minlength: jQuery.format("Please enter at least {0} characters."),
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                },
                "lastName": {
                	required: "Please enter your last name.",
                    minlength: jQuery.format("Please enter at least {0} characters."),
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                },
                "institution": {
                	required: "Please enter your institution.",
                    minlength: jQuery.format("Please enter at least {0} characters."),
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                },
                "degree": {
                    required: "Please select your degree.",
                },
                "salutation": {
                    required: "Please select your salutation.",
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit              
                //success.hide();
                //error.show();
                //App.scrollTo(error, -200);
            },

            errorPlacement: function (error, element) { // render error placement for each input type
                var icon = $(element).parent('.input-icon').children('i');
                icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
                
                if (element.parent(".input-group").size() > 0) {
                    error.insertAfter(element.parent(".input-group"));
                } else if (element.attr("data-error-container")) { 
                    error.appendTo(element.attr("data-error-container"));
                } else if (element.parents('.tncLabel').size() > 0) {
                    error.insertAfter(element.parents('.tncLabel'));
                } else if (element.parents('.degree').size() > 0) {
                    error.insertAfter(element.parents('.degree'));
                } else if (element.parents('.salutation').size() > 0) {
                    error.insertAfter(element.parents('.salutation'));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group   
            },

            unhighlight: function (element) { // revert the change done by hightlight
                
            },

            success: function (label, element) {
            	if ($(element).attr('id') == "email") {
            		$("#username").val($("#email").val());
            	}
            	
            	if ($(element).attr('id') == "select2_sample4") {
            		$("#select2_sample4").select2({
            			containerCssClass: "mySpecialClass"
          		  	});
            	}
            	
                var iconDiv = $(element).parent('.input-icon');
                iconDiv.addClass("right");
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group

                icon.addClass("fa-check");
                icon.removeClass("fa-envelope");
                icon.removeClass("fa-font");
                icon.removeClass("fa-bold");
                icon.removeClass("fa-building-o");
                icon.removeClass("fa-user");
                icon.removeClass("fa-lock");
                icon.removeClass("fa-warning");
            },

            submitHandler: function (form) {
                //success.show();
                //error.hide();
                //form.submit();
    			var parameter = $("#register-form").serialize();
    			$.ajax({
    				type: 'POST',
    				url: url + "/author/submitManuscript/addReviewerPreference",
    				data: parameter,
    				success: function(html){$('#register-form')[0].reset();
    					$.ajax({
    						type: 'GET',
    						url: url + "/author/submitManuscript/rpTable",
    						success: function(html){
    							$("#rpDisplay").html(html).show();
    							App.scrollTo($('#selectedReviewers tr:last'));
    						}
    					});

    					
    				}
    			});
            }
        });
        
        
		$('.register-form input').keypress(function (e) {
            if (e.which == 13) {
                if ($('.register-form').validate().form()) {
                    $('.register-form').submit();
                }
                return false;
            }
        });
	};
    
    return {
        //main function to initiate the module
        init: function (url) {
            handleRegister(url);        	       
        }
    };
}();