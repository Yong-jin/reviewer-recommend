<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">
		<spring:message code="manager.menu.accountManagement"/>
	</h4>
</div>

<div class="modal-body">
	<div class="row">
		<label class="col-md-1"></label>
		<div class="col-md-10">
			<h5 style="margin-left:0px !important"><spring:message code="system.personalInfo"/></h5>
			<div id="tab_1-1">
				
				<form:form modelAttribute="editableUser" class="myaccount-form">
				<form:input path="username" type="hidden" value="${editableUser.username}"/>
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="signup.email"/></label>
						<input name="email" type="text" class="form-control" value="${editableUser.username}" disabled/>
						<span class="help-block">
						</span>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.signupdate"/></label>
						<input type="text" class="form-control" id="signupDateTime1" value="${editableUser.signupDate }" disabled>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.firstname"/></label><span class="required">*</span>
						<form:input path="contact.firstName" type="text" class="form-control" value="${editableUser.contact.firstName}"/>
						<span class="help-block">
						</span>
					</div>
					
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="myaccount.phone"/></label>
						<form:input path="contact.phone" type="text" placeholder="+1 646 580 6284" class="form-control" value="${editableUser.contact.phone}" />
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.lastname"/></label><span class="required">*</span>
						<form:input path="contact.lastName" type="text" class="form-control" value="${editableUser.contact.lastName}"/>
						<span class="help-block">
						</span>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="myaccount.mobile"/></label>
						<form:input path="contact.mobile" type="text" placeholder="+1 711 321 2398" class="form-control" value="${editableUser.contact.mobile}"/>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.institution"/></label><span class="required">*</span>
						<form:input path="contact.institution" type="text" class="form-control" value="${editableUser.contact.institution}"/>
						<span class="help-block">
						</span>
					</div>												
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="myaccount.fax"/></label>
						<form:input path="contact.fax" type="text" placeholder="+1 211 988 1321" class="form-control" value="${editableUser.contact.fax}"/>
					</div>
				</div>
				
				
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.department"/></label>
						<form:input path="contact.department" type="text" class="form-control" value="${editableUser.contact.department}"/>
						<span class="help-block">
						</span>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="myaccount.website"/></label>
						<form:input path="contact.website" type="text" placeholder="http://www.mywebsite.com" class="form-control" value="${editableUser.contact.website}"/>
						<span class="help-block">
						</span>
					</div>		
				</div>
				
				<div class="row">
					<div class="form-group country-group col-md-6">
						<label class="control-label"><spring:message code="user.country"/></label><span class="required">*</span>
						<div>
							<form:select path="contact.country" id="select2_country2" class="select2 form-control">
								<form:options items="${countries}" />
							</form:select>
							<span class="help-block">
								<spring:message code="signup.countryHelp"/>
							</span>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group degreeDiv col-md-6">
						<label class="control-label"><spring:message code="user.degree"/></label><span class="required">*</span><br/>
						<div class="radio-list degree" style="margin-left:1.6em;">
							<c:forEach var="degreeDesignation" items="${degreeDesignations}">
								<label class="radio-inline">
								<form:radiobutton path="contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
							</c:forEach>				
						</div>
						<span class="help-block">
						</span>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group salutationDiv col-md-6">
						<label class="control-label"><spring:message code="user.salutation"/></label><span class="required">*</span>
						<div class="radio-list salutation" style="margin-left:1.6em;">
							<c:forEach var="salutationDesignation" items="${salutationDesignations}">
								<label class="radio-inline">
								<form:radiobutton path="contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
							</c:forEach>
						</div>
						<span class="help-block">
						</span>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-12">
						<label class="control-label"><spring:message code="myaccount.about"/></label>
						<form:textarea path="contact.about" class="form-control" rows="3" placeholder="My primary research interests relate to ..." value="${editableUser.contact.about}" />
					</div>
				</div>
				<c:if test="${journal.languageCode != 'ko'}">
					<div class="col-md-offset-5 margin-top-10">
						<br/><br/>
						<button type="submit" class="btn green" id="infomationChange">
							<i class="fa fa-floppy-o"></i> <spring:message code="myaccount.saveChange"/>
						</button>
						
					</div>
				</c:if>
				</form:form>
			</div>
			<div class="row">
				<div class="col-md-12">
					<br/><br/>
					<hr class="soften"/>
				</div>
			</div>
			
			<c:if test="${journal.languageCode == 'ko'}">
			<h5 style="margin-left:0px !important"><spring:message code="system.personalLocalInfo"/></h5>
			<div id="tab_2-2">
				<form:form modelAttribute="editableUser" class="myLocalAccount-form">
				<form:input path="username" type="hidden" value="${editableUser.username}"/>
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.koreanFullName2"/></label><span class="required">*</span>
						<form:input path="contact.localFullName" type="text" class="form-control" value="${editableUser.contact.localFullName}"/>
						<span class="help-block">
						</span>
					</div>
					<div class="form-group jobTitle-group col-md-6">
						<label class="control-label"><spring:message code="user.jobTitle"/></label>
						<div>
							<form:select path="contact.localJobTitle" id="select2_jobTitle" class="select2 form-control">
								<c:forEach var="localJobTitleDesignation" items="${localJobTitleDesignations}">
									<option value="${localJobTitleDesignation.id}" <c:if test="${localJobTitleDesignation.id == editableUser.contact.localJobTitle}">selected</c:if>><spring:message code="signin.localJobTitleDesignation.${localJobTitleDesignation.id}"/></option>
								</c:forEach>
							</form:select>
							<span class="help-block">
							</span>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.koreanInstitution"/></label><span class="required">*</span>
						<form:input path="contact.localInstitution" type="text" class="form-control" value="${editableUser.contact.localInstitution}"/>
						<span class="help-block">
						</span>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.koreanDepartment"/></label>
						<form:input path="contact.localDepartment" type="text" class="form-control" value="${editableUser.contact.localDepartment}"/>
						<span class="help-block">
						</span>
					</div>	
				</div>
				<div class="row">
					<div class="form-group col-md-12">
						<spring:message code="user.koreanInfoRequiredMessage"/> 
					</div>
				</div>
				
				<div class="col-md-offset-5 margin-top-10">
					<br/><br/>
					<button type="submit" class="btn green" id="localInfomationChange">
						<i class="fa fa-floppy-o"></i> <spring:message code="myaccount.saveChange"/>
					</button>
				</div>
				</form:form>
			</div>
			</c:if>
		</div>		
	</div>
</div>
<script>
/* 
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

$("#select2_jobTitle").select2({
    escapeMarkup: function (m) {
        return m;
    }
});


 */
$('.myaccount-form').validate({
   errorElement: 'span', //default input error message container
   errorClass: 'help-block', // default input error message class
   focusInvalid: false, // do not focus the last invalid input
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
       username: {
   		   required: errorMessages['user.required.newUser.email'],
   		   email: errorMessages['user.required.validEmail'],
   		   minlength: jQuery.format(errorMessages['user.required.minlength']),
   		   maxlength: jQuery.format(errorMessages['user.required.maxlength']),
   		   remote: jQuery.format(errorMessages['user.required.emailAlreadyUsed']),
       },
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
	   /*
	   if ($(element).attr('id') == "select2_country2") {
 			$("#select2_country2").select2({
  				containerCssClass: "mySpecialClass2"
  			});
	   }
	   */
	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
   },

   submitHandler: function(form) {

	   $.ajax({
           type: 'POST',
           url: '${baseUrl}/journals/${jnid}/manager/configuration/accounts/saveAccount',
           data: $('.myaccount-form').serialize(),
           success: function(response) {
        	   location.href="${baseUrl}/journals/${jnid}/manager/configuration/accounts/manageAccounts";
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
 	   element.next('span.help-block').replaceWith(error);
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
           url: '${baseUrl}/journals/${jnid}/manager/configuration/accounts/saveAccount',
           data: $('.myaccount-form').serialize(),
           success: function(response) {
         	   $.ajax({
                   type: 'POST',
                   url: '${baseUrl}/account/myLocalInfoSave',
                   data: $('.myLocalAccount-form').serialize(),
                   success: function(response) {
                	   location.href="${baseUrl}/journals/${jnid}/manager/configuration/accounts/manageAccounts";
                   },
        	   	   error: function(response) {
                	   alert("error - " + response);
                   }
               });
           },
	   	   error: function(response) {
        	   alert("error - " + response);
           }
       });

        //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
    }
}); 
 
$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
</script>