var myAccount = function () {
	var handleRegister = function () {
		$("#select2_country2").select2({
		  	placeholder: '<i class="fa fa-map-marker"></i>&nbsp;&nbsp;&nbsp;Select a Country',
            allowClear: true,
            formatResult: function(state) {
            	if (!state.id) return state.text;
                return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png' />&nbsp;&nbsp;" + state.text;
            },
            formatSelection: function(state) {
            	if (!state.id) return state.text;
                return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
            },
            escapeMarkup: function (m) {
                return m;
            },
        });

		$('#select2_country2').change(function () {
            $('.myaccount-form').validate().element($(this));
        });

        $('.myaccount-form').validate({
           errorElement: 'span', //default input error message container
           errorClass: 'help-block', // default input error message class
           focusInvalid: false, // do not focus the last invalid input
           rules: {
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
               "contact.country": {
                   required: true,
               },
               "contact.degree": {
                   required: true,
               },
               "contact.salutation": {
                   required: true,
               },
               "contact.website": {
            	   url: true,
               }
           },
           messages: {
               "contact.firstName": {
            	   required: errorMessages['user.required.firstname'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               "contact.lastName": {
               	   required: errorMessages['user.required.lastname'],
               	   minlength: jQuery.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               "contact.institution": {
               	   required: errorMessages['user.required.institution'],
               	   minlength: jQuery.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               "contact.department": {
            	   required: errorMessages['user.required.department'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               "contact.country": {
                   required: errorMessages['user.required.country'],
               },
               "contact.degree": {
                   required: errorMessages['user.required.degree'],
               },
               "contact.salutation": {
                   required: errorMessages['user.required.salutation'],
               },
               "contact.website": {
            	   url: errorMessages['user.required.website'],
               }
           },
           errorPlacement: function (error, element) { // render error placement for each input type
        	   if ($(element).attr('id') == "tnc") {
        		    $('span[id="tnc"]').replaceWith(error);
        	   } else {
        		    element.next('span.help-block').replaceWith(error);
               }
           },

           invalidHandler: function (event, validator) { //display error alert on form submit   
               //success.hide();
               //error.show();
               //App.scrollTo(error, -200);
           },

           highlight: function (element) { // hightlight error inputs
               $(element)
                   .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
           },

           unhighlight: function (element) { // revert the change done by hightlight
               $(element)
                   .closest('.form-group').removeClass('has-error'); // set error class to the control group
           },

           success: function (errorLabel, element) {
        	   if ($(element).attr('id') == "email") {
                 	$("#realUsername").val($("#email").val());
        	   } else if ($(element).attr('id') == "select2_country2") {
         			$("#select2_country2").select2({
          				containerCssClass: "mySpecialClass2"
          			});
        	   }
        	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
           },

           submitHandler: function(form) {
               //form.submit();
        	   $.ajax({
                   type: 'POST',
                   url: 'account/myAccountSave',
                   data: $('.myaccount-form').serialize(),
                   success: function(response) {
                	   bootbox.alert("Your information has been saved successfully!");
                   },
        	   	   error: function(response) {
                	   alert("error - " + response);
                   }
               });
               //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
           }
       });
        
       $('.myLocalAccount-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                "contact.localFullName": {
                    required: true,
                    minlength: 2,
                    maxlength: 50,
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
            },
            messages: {
                "contact.localFullName": {
                    required: errorMessages['user.required.fullnameNative'],
                    minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "contact.localInstitution": {
             	   required: errorMessages['user.required.localInstitution'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
                "contact.localDepartment": {
             	   required: errorMessages['user.required.localDepartment'],
             	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                    maxlength: jQuery.format(errorMessages['user.required.maxlength'])
                },
            },
            errorPlacement: function (error, element) { // render error placement for each input type
         	   if ($(element).attr('id') == "tnc") {
         		    $('span[id="tnc"]').replaceWith(error);
         	   } else {
         		    element.next('span.help-block').replaceWith(error);
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit   
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (errorLabel, element) { 
         	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
            },

            submitHandler: function(form) {
                //form.submit();
         	   $.ajax({
                    type: 'POST',
                    url: 'account/myLocalInfoSave',
                    data: $('.myLocalAccount-form').serialize(),
                    success: function(response) {
                 	   bootbox.alert("Your information has been saved successfully!");
                    },
         	   	   error: function(response) {
                 	   alert("error - " + response);
                    }
                });
                //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
            }
       }); 
       
       
       $('.myPassword-form').validate({
           errorElement: 'span', //default input error message container
           errorClass: 'help-block', // default input error message class
           focusInvalid: false, // do not focus the last invalid input
           rules: {
               "cp": {
            	   required: true,
                   minlength: 8,
                   maxlength: 30,
                   remote: function () {
                	    var cp = $("input[name='cp']").val();
                	    var username = $("input[name='username']").val();
			          	var r = {  
	                      url: 'account/cpCheck',
	                      type: "POST",
	                      dataType: 'json', 
	                      data: username +"&" + cp,
	                      contentType: "application/json; charset=utf-8", 
	                      mimeType: 'application/json',
	                      dataType: "json",
			            };
			          	return r;
                   },
               },
               "np": {
            	   required: true,
                   minlength: 8,
                   maxlength: 30,
               },
               "nrp": {
            	   required: true,
            	   equalTo: "#np",
               },
           },
           messages: {
        	   "cp": {
        		   required: errorMessages['user.required.password'],
                   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
                   remote: jQuery.format(errorMessages['user.required.currentPasswordEqual'])
               },
               "np": {
            	   required: errorMessages['myaccount.required.newPasswordConfirm'],
                   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               "nrp": {
            	   required: errorMessages['myaccount.required.passwordConfirm'],
                   equalTo: errorMessages['user.required.passwordEqual'],
               },
           },
           errorPlacement: function (error, element) { // render error placement for each input type
        	   if ($(element).attr('id') == "tnc") {
        		    $('span[id="tnc"]').replaceWith(error);
        	   } else {
        		    element.next('span.help-block').replaceWith(error);
               }
           },

           invalidHandler: function (event, validator) { //display error alert on form submit   
           },

           highlight: function (element) { // hightlight error inputs
               $(element)
                   .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
           },

           unhighlight: function (element) { // revert the change done by hightlight
               $(element)
                   .closest('.form-group').removeClass('has-error'); // set error class to the control group
           },

           success: function (errorLabel, element) { 
        	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
           },

           submitHandler: function(form) {
               //form.submit();
        	   $.ajax({
                   type: 'POST',
                   url: 'account/passwordChange',
                   data: $('.myPassword-form').serialize(),
                   success: function(response) {
                	   if (response == "success") {
                		   bootbox.alert("Your password has been changed successfully.");
                	   } else {
                		   bootbox.alert("There is a problem at password change.");
                	   }
                   },
        	   	   error: function(response) {
                	   alert("error - " + response);
                   }
               });
               //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
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
       init: function () {
           handleRegister();        	       
       }
   };
}();