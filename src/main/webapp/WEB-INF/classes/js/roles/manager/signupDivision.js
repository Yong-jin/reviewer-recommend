var SignupDivision = function (baseUrl) {
	var handleRegister = function (baseUrl) {

		function format(state) {
            if (!state.id) return state.text; // optgroup
            return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
        }

        $('.register-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {

                "symbol": {
                    required: true,
                    maxlength: 3,
                },
                "name": {
                    required: true,
                    minlength: 3,
                    maxlength: 70,
                },
                "description": {
                    required: false,
                    maxlength: 3000,
                }

            },
            
            messages: {

                "symbol": {
                	required: "Please enter your division symbol.",
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                },
                "name": {
                	required: "Please enter your division name.",
                    minlength: jQuery.format("Please enter at least {0} characters."),
                    maxlength: jQuery.format("Please enter at most {0} characters."),
                },
                "description": {
                	required: "Please enter your division description.",
                    maxlength: jQuery.format("Please enter at most {0} characters."),
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
    				url: baseUrl + "/manager/configuration/divisions/createDivision",
    				data: parameter,
    				success: function(html){$('#register-form')[0].reset();
    				$.ajax({
						type: 'GET',
						url: baseUrl + "/manager/configuration/divisions/divisionTable",
						success: function(html){
							$("#divisionDisplay").html(html).show();
							App.scrollTo($('#divisionDisplay tr:last'));

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
        init: function (baseUrl) {
            handleRegister(baseUrl);        	       
        }
    };
}();