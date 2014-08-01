var Signup = function () {
    var handleRegister = function () {
	    
	function formatJobTitle(state) {
	    if (!state.id) return state.text; // optgroup
	    return state.text;
	}
		
	$("#select2_country2").select2({
	    placeholder: '<i class="fa fa-map-marker"></i>&nbsp;&nbsp;&nbsp;' + errorMessages['signup.countryHelp'],
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
            }
        });

	$('#select2_country2').change(function () {
            $('.register-form').validate().element($(this));
        });
	
	$("#select2_jobTitle").select2({
            allowClear: true,
            formatResult: formatJobTitle,
            formatSelection: formatJobTitle,
            escapeMarkup: function (m) {
                return m;
            }
        });

	$('#select2_jobTitle').change(function () {
            $('#register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        });
	

        $('.register-form').validate({
           errorElement: 'span', //default input error message container
           errorClass: 'help-block', // default input error message class
           focusInvalid: false, // do not focus the last invalid input
           rules: {
           	   username: {
                   required: true,
                   email: true,
                   minlength: 3,
                   maxlength: 100,
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
               /*
               "contact.localJobTitle": {
                   required: true,
               },
               */
               password: {
                   required: true,
                   minlength: 8,
                   maxlength: 30,
               },
               passwordConfirm: {
            	   required: true,
            	   equalTo: "#password",
               },
               tnc: {
               		required: true,
               }
           },
           messages: {
               username: {
   			required: errorMessages['user.required.email'],
   			email: errorMessages['user.required.validEmail'],
   			minlength: jQuery.format(errorMessages['user.required.minlength']),
   			maxlength: jQuery.format(errorMessages['user.required.maxlength']),
   			remote: jQuery.format(errorMessages['user.required.emailAlreadyUsed']),
               },
               "contact.localFullName": {
                   required: errorMessages['user.required.fullnameNative'],
                   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.firstName": {
            	   required: errorMessages['user.required.firstname'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.lastName": {
               	   required: errorMessages['user.required.lastname'],
               	   minlength: jQuery.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.institution": {
               	   required: errorMessages['user.required.institution'],
               	   minlength: jQuery.format(errorMessages['user.required.minlength']),
               	   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.department": {
            	   required: errorMessages['user.required.department'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.localInstitution": {
            	   required: errorMessages['user.required.localInstitution'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
               },
               "contact.localDepartment": {
            	   required: errorMessages['user.required.localDepartment'],
            	   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
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
               /*
               "contact.localJobTitle": {
                   required: errorMessages['user.required.jobTitle'],
               },
               */
               password: {
                   required: errorMessages['user.required.password'],
                   minlength: jQuery.format(errorMessages['user.required.minlength']),
                   maxlength: jQuery.format(errorMessages['user.required.maxlength'])
               },
               passwordConfirm: {
                   required: errorMessages['user.required.passwordConfirm'],
                   equalTo: errorMessages['user.required.passwordEqual'],
               },
               tnc: {
               	   required: errorMessages['user.requried.tnc'],
               }
           },
           errorPlacement: function (error, element) { // render error placement for each input type
        	   if ($(element).attr('id') == "tnc") {
        	       $('span[id="tnc"]').replaceWith(error);
        	   } else if (element.parents('.degree').size() > 0) {
        	       error.insertAfter(element.parents('.degree'));
        	   } else if (element.parents('.salutation').size() > 0) {
        	       error.insertAfter(element.parents('.salutation'));
        	   } else if ($(element).attr('name') == "contact.localJobTitle") {
        	       $('.localJobTitle').html(error);
        	   } else {
        	       error.insertAfter(element);
        	   }
           },

           invalidHandler: function (event, validator) { //display error alert on form submit   
               //success.hide();
               //error.show();
               //App.scrollTo(error, -200);
           },

           highlight: function (element) { // highlight error inputs
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
        	   } 
        	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error');
        	   //errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
           },

           submitHandler: function(form) {
               form.submit();
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