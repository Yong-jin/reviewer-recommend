var SignupMember = function (role) {
	var handleRegister = function (role) {
	function format(state) {
            if (!state.id) return state.text; // optgroup
            return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
    }
	
	function formatJobTitle(state) {
            if (!state.id) return state.text; // optgroup
            return state.text;
    }

	$("#" + role + "Country").select2({
            allowClear: true,
            formatResult: format,
            formatSelection: format,
            escapeMarkup: function (m) {
                return m;
            }
        });

	$('#' + role + 'Country').change(function () {
            $('#' + role + 'RegisterForm').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });

	$("#" + role + "jobTitle").select2({
            allowClear: true,
            formatResult: formatJobTitle,
            formatSelection: formatJobTitle,
            escapeMarkup: function (m) {
                return m;
            }
        });

	$("#" + role + "jobTitle").change(function () {
            $('#' + role + 'RegisterForm').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });

        $('#' + role + 'RegisterForm').validate({
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
                                url: 'usernameDuplicateCheck?username=' + $("#" + role + "Email").val(),
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
                "user.contact.localJobTitle": {
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
                "user.contact.localJobTitle": {
                    required: errorMessages['user.required.newUser.jobTitle'],
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
                } else if ($(element).attr('name') == "user.contact.localJobTitle") {
                    $('.localJobTitle').html(error);
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
            	if ($(element).attr('id') == (role + "Email")) {
            		$("#" + role + "Username").val($("#" + role + "Email").val());
            	}
            	
            	/*
            	if ($(element).attr('id') == "chiefEditorCountry") {
            		$("#chiefEditorCountry").select2({
            			containerCssClass: "mySpecialClass"
          		  	});
            	}*/
            	
                var iconDiv = $(element).parent('.input-icon');
                iconDiv.addClass("right");
                var icon = $(element).parent('.input-icon').children('i');
                $(element).closest('.form-group').removeClass('has-error'); // set success class to the control group
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

	$('#' + role + 'RegisterForm input').keypress(function (e) {
            if (e.which == 13) {
                if ($('#' + role + 'RegisterForm').validate().form()) {
                    $('#' + role + 'RegisterForm').submit();
                    App.scrollTo($('.table-bordered'));
                }
                return false;
            }
        });
	};
    
    return {
        //main function to initiate the module
        init: function (role) {
            handleRegister(role);        	       
        }
    };
}();
