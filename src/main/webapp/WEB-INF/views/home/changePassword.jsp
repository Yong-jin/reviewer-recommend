<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="myaccount.password.changePassword"/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>

<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
<div class="clearfix">
</div>
<div class="page-container">
	<br/><br/>		
     
    <div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								 <spring:message code="system.passwordChange"/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="row">
								<div class="col-md-8 passwordChange">
									<div class="tab-content">
										<div id="tab_1-1" class="tab-pane active">
											<form method="post" id="change-form" class="myPassword-form col-md-8">
												<input name="email" type="hidden" value="${email}"/>
												<input name="code" type="hidden" value="${code}"/>
												<div class="form-group">
													<label class="control-label"><spring:message code="signin.username"/> (<spring:message code="signin.email"/>)</label>
													<input type="text" class="form-control" value="${email}" readonly="readonly"/>
												</div>
												<div class="form-group">
													<label class="control-label"><spring:message code="myaccount.password.newPassword"/></label><span class="required">*</span>
													<input type="password" name="np" id="np" class="form-control"/>
													<span class="help-block">
													</span>
												</div>
												<div class="form-group">
													<label class="control-label"><spring:message code="myaccount.password.reNewPassword"/></label><span class="required">*</span>
													<input type="password" name="nrp" id="nrp" class="form-control"/>
													<span class="help-block">
													</span>
												</div>
												<div class="margiv-top-10 pull-right">
													<button type="submit" class="btn green" id="passwordChange">
														 <spring:message code="myaccount.password.changePassword"/>
													</button>
													<br/>
												</div>
												
											</form>
										</div>
										<!--  end tab_3-3 -->
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
</footer>

<script>
var errorMessages = new Array();
errorMessages['user.required.currentPasswordEqual'] = "<spring:message code='user.required.currentPasswordEqual' javaScriptEscape='true' />";
errorMessages['user.required.password'] = "<spring:message code='user.required.password' javaScriptEscape='true' />";	
errorMessages['user.required.passwordConfirm'] = "<spring:message code='user.required.passwordConfirm' javaScriptEscape='true' />";
errorMessages['user.required.passwordEqual'] = "<spring:message code='user.required.passwordEqual' javaScriptEscape='true' />";
errorMessages['myaccount.required.newPasswordConfirm'] = "<spring:message code='myaccount.required.newPasswordConfirm' javaScriptEscape='true' />";
errorMessages['myaccount.required.passwordConfirm'] = "<spring:message code='myaccount.required.passwordConfirm' javaScriptEscape='true' />";

jQuery(document).ready(function() {
	App.init();
	$('#passwordChange').click(function(event) {
		var data = $('#change-form').serialize();
		
	});
	
    $('.myPassword-form').validate({
        errorElement: 'span', //default input error message container
        errorClass: 'help-block', // default input error message class
        focusInvalid: false, // do not focus the last invalid input
        rules: {
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
                url: 'changePassword',
                data: $('.myPassword-form').serialize(),
                success: function(response) {
             		bootbox.confirm("Your password has been changed successfully.", function(result) {
             			if(result == true)
             				location.href="${baseUrl}/activity/myActivity";
             		});
                },
     	   	   error: function(response) {
             	   alert("error - " + response);
                }
            });
            //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
        }
   }); 
});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>