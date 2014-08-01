var SignupCoAuthor = function (url) {
	var handleRegister = function (url) {
		function format(state) {
	        if (!state.id) return state.text; // optgroup
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
	    }
		
		function formatJobTitle(state) {
	        if (!state.id) return state.text; // optgroup
	        return state.text;
	    }
	
		$("#select2_sample4").select2({
	        allowClear: true,
	        formatResult: format,
	        formatSelection: format,
	        escapeMarkup: function (m) {
	            return m;
	        }
	    });
	
	/*	$('#select2_sample4').change(function () {
	            $('#register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
	        });*/
		
		$("#select2_jobTitle").select2({
	        allowClear: true,
	        formatResult: formatJobTitle,
	        formatSelection: formatJobTitle,
	        escapeMarkup: function (m) {
	            return m;
	        }
	    });

/*	$('#select2_jobTitle').change(function () {
            $('#register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });*/
	

        $('#register-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
            	username: {
                    required: true,
                    email: true,
                    minlength: 3,
                    maxlength: 55,
                    remote: function () {
                    	var r = {  
                                url: 'usernameDuplicateCheck?username=' + $("#email").val(),
                                type: "POST",  
                                contentType: "application/json; charset=utf-8",  
                                dataType: "json",  
                        };
                    	return r;
                    },
                },
                "contact.localFullName": {
                    required: true,
                    minlength: 2,
                    maxlength: 50,
                },
                "contact.firstName": {
                    required: true,
                    minlength: 2,
                    maxlength: 40,
                },
                "contact.lastName": {
                    required: true,
                    minlength: 2,
                    maxlength: 30,
                },
                "contact.institution": {
                    required: true,
                    minlength: 2,
                    maxlength: 70,
                },
                "contact.department": {
             	   required: false,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "contact.localInstitution": {
             	   required: true,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "contact.localDepartment": {
             	   required: false,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "contact.country": {
                    required: true,
                },
                "contact.degree": {
                    required: true,
                },
                "contact.salutation": {
                    required: true,
                },
            },
            
            messages: {
               username: {
		   		   required: errorMessages['user.required.newUser.email'],
		   		   email: errorMessages['user.required.validEmail'],
		   		   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
		   		   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
		   		   remote: jQuery.validator.format(errorMessages['user.required.emailAlreadyUsed']),
               },
               "contact.localFullName": {
                   required: errorMessages['user.required.newUser.fullnameNative'],
                   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.firstName": {
            	   required: errorMessages['user.required.newUser.firstname'],
            	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.lastName": {
               	   required: errorMessages['user.required.newUser.lastname'],
               	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.institution": {
               	   required: errorMessages['user.required.newUser.institution'],
               	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.department": {
            	   required: errorMessages['user.required.newUser.department'],
            	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.localInstitution": {
            	   required: errorMessages['user.required.newUser.localInstitution'],
            	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.localDepartment": {
            	   required: errorMessages['user.required.newUser.localDepartment'],
            	   minlength: jQuery.validator.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.validator.format(errorMessages['user.required.maxlength']),
               },
               "contact.countryCode": {
                   required: errorMessages['user.required.newUser.country'],
               },
               "contact.degree": {
                   required: errorMessages['user.required.newUser.degree'],
               },
               "contact.salutation": {
                   required: errorMessages['user.required.newUser.salutation'],
               },
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
                } else if (element.parents('.degreeSmallWidth').size() > 0) {
                    error.insertAfter(element.parents('.degreeSmallWidth'));
                } else if (element.parents('.salutation').size() > 0) {
                    error.insertAfter(element.parents('.salutation'));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            highlight: function (element) { // hightlight error inputs
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group   
            },

            unhighlight: function (element) { // revert the change done by hightlight
            	$(element).closest('.form-group').removeClass('has-error'); // set error class to the control group
            },
            
            success: function (label, element) {
            	if ($(element).attr('id') == "email") {
            		$("#username").val($("#email").val());
            	}
            	/*
            	if ($(element).attr('id') == "select2_sample4") {
            		$("#select2_sample4").select2({
            			containerCssClass: "mySpecialClass2"
          		  	});
            	}*/
            	
                var iconDiv = $(element).parent('.input-icon');
                iconDiv.addClass("right");
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('.form-group').removeClass('has-error');
                //$(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group

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
					url: url + "/author/submitManuscript/signupCoAuthor",
					data: parameter,
					success: function(html){
						$('#register-form')[0].reset();
						
						//$("#CoAuthorsDisplay").html(html).show();
						//location.reload();	
						$.ajax({
							type: 'GET',
							url: url + "/author/submitManuscript/coAuthorTable",
							success: function(html){
								$("#coAuthorsDisplay").html(html).show();
								App.scrollTo($('#coAuthorsDisplay tr:first'));
	
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