var SignupReviewer = function (url, pageType) {
	var handleRegister = function (url, pageType) {

	function format(state) {
            if (!state.id) return state.text; // optgroup
            return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
        }


	$("#" + pageType + "reviewerCountry").select2({
		  	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;&nbsp;&nbsp;' + errorMessages['signup.countryHelp'],
            allowClear: true,
            formatResult: format,
            formatSelection: format,
            escapeMarkup: function (m) {
                return m;
            }
        });


	$("#" + pageType + "reviewerCountry").change(function () {
            $("#" + pageType + "reviewerRegisterForm").validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });



        $("#" + pageType + "reviewerRegisterForm").validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
            	"user.username": {
                    required: true,
                    email: true,
                    minlength: 3,
                    maxlength: 55,
                    remote: function () {
                    	var r = {
                                url: 'usernameDuplicateCheck?username=' + $("#" + pageType + "reviewerEmail").val(),
                                type: "POST",  
                                contentType: "application/json; charset=utf-8",  
                                dataType: "json",  
                        };
                    	return r;
                    },
                },
                "user.contact.localFullName": {
                    required: true,
                    minlength: 2,
                    maxlength: 50,
                },
                "user.contact.firstName": {
                    required: true,
                    minlength: 2,
                    maxlength: 40,
                },
                "user.contact.lastName": {
                    required: true,
                    minlength: 2,
                    maxlength: 30,
                },
                "user.contact.institution": {
                    required: true,
                    minlength: 2,
                    maxlength: 70,
                },
                "user.contact.department": {
             	   required: false,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "user.contact.localInstitution": {
             	   required: true,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "user.contact.localDepartment": {
             	   required: false,
             	   minlength: 2,
             	   maxlength: 70,
                },
                "user.contact.degree": {
                    required: true,
                },
                "user.contact.salutation": {
                    required: true,
                },
            },
            
            messages: {
            	"user.username": {
            	    required: errorMessages['user.required.newUser.email'],
                    email: errorMessages['user.required.validEmail'],
                    minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength']),
                    remote: jQuery.format(errorMessages['user.required.emailAlreadyUsed']),
                },
                
                "user.contact.localFullName": {
                    required: errorMessages['user.required.newUser.fullnameNative'],
                    minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.firstName": {
             	   required: errorMessages['user.required.newUser.firstname'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.lastName": {
                	   required: errorMessages['user.required.newUser.lastname'],
                	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                	   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.institution": {
                	   required: errorMessages['user.required.newUser.institution'],
                	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                	   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.department": {
             	   required: errorMessages['user.required.newUser.department'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.localInstitution": {
             	   required: errorMessages['user.required.newUser.localInstitution'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.localDepartment": {
             	   required: errorMessages['user.required.newUser.localDepartment'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "user.contact.degree": {
                    required: errorMessages['user.required.newUser.degree'],
                },
                "user.contact.salutation": {
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
            	if ($(element).attr('id') == (pageType + "reviewerEmail")) {
            		$("#" + pageType + "reviewerUsername").val($("#" + pageType + "reviewerEmail").val());
            	}
            	/*
            	if ($(element).attr('id') == (pageType + "reviewerCountry")) {
            		$("#" + pageType + "reviewerCountry").select2({
            			containerCssClass: "mySpecialClass"
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
            }
        });

		$("#" + pageType + "reviewerRegisterForm input").keypress(function (e) {
            if (e.which == 13) {
                if ($("#" + pageType + "reviewerRegisterForm").validate().form()) {
                    $("#" + pageType + "reviewerRegisterForm").submit();
                }
                return false;
            }
        });
	};
    
    return {
        //main function to initiate the module
        init: function (url, pageType) {
            handleRegister(url, pageType);
        }
    };
}();
