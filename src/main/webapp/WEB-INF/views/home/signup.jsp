<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Sign Up</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/select2/select2.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/assets/plugins/select2/select2-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>

<body class="page-header-fixed">
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
<div class="clearfix">
</div>
<br/>
<br/>
<br/>
<c:if test="${not empty journal}">
<h3 class="text-center"><strong>${journal.title}</strong></h3>
<h3 class="text-center"><spring:message code='system.maintitle'/></h3>
</c:if>

<div class="row">
<div class="col-md-push-2 col-md-2">
<h2><spring:message code="signup.title"/></h2>
</div>
</div>
<div class="content row">
	<form:form method="post" modelAttribute="user" class="register-form">
		<div class="form-body">
		<fieldset class="col-md-push-2 col-md-4">
		
		<div class="row">
			<div class="form-group col-md-12">
				<label class="control-label"><spring:message code="signup.email"/></label>
				<div>
					<form:input path="username" type="text" class="form-control" id="email" maxlength="100"/>
					<span class="help-block">
					</span>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group col-md-6">
				<label class="control-label"><spring:message code="signup.password"/> (<spring:message code="signup.passwordHelp"/>)</label>
				<div>
					<form:input path="password" type="password" class="form-control"/>
					<span class="help-block" id="password-help">
					</span>
				</div>
			</div>
			<div class="form-group col-md-6">
				<label class="control-label"><br/><spring:message code="signup.rpassword"/></label>
				<div>
					<input type="password" class="form-control" name="passwordConfirm"/>
					<span class="help-block">
					</span>
				</div>
			</div>
		</div>

		
		<c:choose>
			<c:when test="${journal.languageCode == 'en' || locale == 'en_US'}" >
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.institution"/></label>
						<div>
							<form:input path="contact.institution" type="text" class="form-control" maxlength="70"/>
							<span class="help-block">
							</span>
						</div>
					</div>
					
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.department"/></label>
						<div>
							<form:input path="contact.department" type="text" class="form-control" maxlength="30"/>
							<span class="help-block">
							This is optional information.
							</span>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${journal.languageCode == 'ko' || locale == 'ko_KR'}" >
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.institution"/></label>
						<div>
							<form:input path="contact.localInstitution" type="text" class="form-control" maxlength="70"/>
							<span class="help-block"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)
							</span>
						</div>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label">&nbsp;</label>
						<div>
							<form:input path="contact.institution" type="text" class="form-control" maxlength="70"/>
							<span class="help-block"><spring:message code="system.english"/> (<spring:message code="user.institutionSample-english"/>)
							</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label"><spring:message code="user.department"/></label>
						<div>
							<form:input path="contact.localDepartment" id="contactLocalDepartment" type="text" class="form-control" maxlength="70"/>
							<span class="help-block2" id="contactLocalDepartment"><spring:message code="system.korean"/> (<spring:message code="user.departmentSample-korean"/>)
							</span>
						</div>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label">&nbsp;</label>
						<div>
							<form:input path="contact.department" type="text" class="form-control" maxlength="70"/>
							<span class="help-block2"><spring:message code="system.english"/> (<spring:message code="user.departmentSample-english"/>)
							</span>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>

		
		<div class="row">
			<div class="form-group country-group col-md-12">
				<label class="control-label"><spring:message code="user.country"/></label>
				<div>
					<form:select path="contact.country" id="select2_country2" class="select2 form-control">
						<%@ include file="/WEB-INF/views/includes/country.jsp" %>
					</form:select>
					<span class="help-block">
					</span>
				</div>
			</div>			
		</div>		
		</fieldset>
		
		<fieldset class="col-md-push-2 col-md-4">
		<c:choose>
		<c:when test="${journal.languageCode == 'en' || locale == 'en_US'}" >
			<div class="row">
				<div class="form-group col-md-7">
					<label class="control-label"><spring:message code="user.firstname"/></label>
					<div>
						<form:input path="contact.firstName" type="text" class="form-control" maxlength="40"/>
						<span class="help-block">
						</span>
					</div>
				</div>	
				<div class="form-group col-md-5">
					<label class="control-label"><spring:message code="user.lastname"/></label>
					<div>
						<form:input path="contact.lastName" type="text" class="form-control" maxlength="30"/>
						<span class="help-block">
						</span>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${journal.languageCode == 'ko' || locale == 'ko_KR'}" >
			<div class="row">
				<div class="form-group col-md-12">
					<label class="control-label"><spring:message code="user.name"/></label>
					<div>
						<form:input path="contact.localFullName" type="text" class="form-control" maxlength="50"/>
						<span class="help-block"><spring:message code="user.koreanFullName"/> (<spring:message code="user.koreanFullnameSample"/>)
						</span>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:0.4em;">
				<div class="form-group col-md-7">
					<div>
						<form:input path="contact.firstName" type="text" class="form-control" maxlength="40"/>
						<span class="help-block"><spring:message code="user.firstname2"/> (<spring:message code="user.firstnameSample"/>)
						</span>
					</div>
				</div>	
				<div class="form-group col-md-5">
					<div>
						<form:input path="contact.lastName" type="text" class="form-control" maxlength="30"/>
						<span class="help-block"><spring:message code="user.lastname2"/> (<spring:message code="user.lastnameSample"/>)
						</span>
					</div>
				</div>
			</div>
		</c:when>
		</c:choose>
		
		<div class="row">
			<div class="form-group degreeDiv col-md-12">
				<label class="control-label"><spring:message code="user.degree"/></label><br/>
				<div class="radio-list degree" style="margin-left:1.6em">
					<c:forEach var="degreeDesignation" items="${degreeDesignations}">
						<label class="radio-inline" style="margin-right:1.6em">
						<form:radiobutton path="contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> 
						</label>
					</c:forEach>				
				</div>
				<span class="help-block">
				</span>
			</div>
		</div>
		
		<div class="row">
			<div class="form-group salutationDiv col-md-12">
				<label class="control-label"><spring:message code="user.salutation"/></label><br/>
				<div class="radio-list salutation" style="margin-left:1.6em">
					<c:forEach var="salutationDesignation" items="${salutationDesignations}">
						<label class="radio-inline" style="margin-right:2.6em">
						<form:radiobutton path="contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/>
						</label>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<c:choose>
		<c:when test="${journal.languageCode == 'ko'|| locale == 'ko_KR'}" >
			<div class="row">
				<div class="form-group jobTitle-group col-md-12">
					<label class="control-label"><spring:message code="user.jobTitle"/></label>
					<div>
						<form:select path="contact.localJobTitle" id="select2_jobTitle" class="select2 form-control">
							<c:forEach var="localJobTitleDesignation" items="${localJobTitleDesignations}">
								<option value="${localJobTitleDesignation.id}" <c:if test="${localJobTitleDesignation.id == contact.localJobTitle}">selected</c:if>><spring:message code="signin.localJobTitleDesignation.${localJobTitleDesignation.id}"/></option>
							</c:forEach>
						</form:select>
						<span class="help-block">
						</span>
					</div>
				</div>
			</div>
		</c:when>
		</c:choose>
		
		<div class="row">
			<div class="form-group col-md-12">
				<br/>
				<label class="tncLabel">
				<input type="checkbox" name="tnc" id="tnc" /> <spring:message code="signup.tnc1"/>
				<a href="#">
					 <spring:message code="signup.tnc2"/>
				</a>
				 <spring:message code="signup.tnc3"/>
				<a href="#">
					 <spring:message code="signup.tnc4"/>
				</a>
				<spring:message code="signup.tnc5"/>
				</label>
				<span class="help-block" id="tnc">
				</span>
			</div>
		</div>
		
		<div class="form-actions">    
			<button id="register-back-btn" type="button" class="btn btn-sm"><i class="m-icon-swapleft"></i> <spring:message code="system.gotoback"/> </button>
			<button type="submit" id="register-submit-btn" class="btn green btn-sm pull-right">
			<spring:message code="signup.title"/> <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
		</fieldset>
	</div>
	<c:choose>
		<c:when test="${isFromSubmitJournal}">
			<input type="hidden" name="isFromSubmitJournal" value="true"/>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="isFromSubmitJournal" value="false"/>
		</c:otherwise>
		</c:choose>
	</form:form>
	</div>


<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerEmpty.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/js/homes/corporate/scripts/app.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/scripts/core/app.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/signup.js" type="text/javascript"></script>
</footer>
<script>
var errorMessages = new Array();
errorMessages['user.required.email'] = "<spring:message code='user.required.email' javaScriptEscape='true' />";
errorMessages['user.required.validEmail'] = "<spring:message code='user.required.validEmail' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed'] = "<spring:message code='user.required.emailAlreadyUsed' javaScriptEscape='true' />";
errorMessages['user.required.fullnameNative'] = "<spring:message code='user.required.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.firstname'] = "<spring:message code='user.required.firstname' javaScriptEscape='true' />";
errorMessages['user.required.lastname'] = "<spring:message code='user.required.lastname' javaScriptEscape='true' />";
errorMessages['user.required.institution'] = "<spring:message code='user.required.institution' javaScriptEscape='true' />";
errorMessages['user.required.department'] = "<spring:message code='user.required.department' javaScriptEscape='true' />";
errorMessages['user.required.localInstitution'] = "<spring:message code='user.required.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.localDepartment'] = "<spring:message code='user.required.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.country'] = "<spring:message code='user.required.country' javaScriptEscape='true' />";
errorMessages['user.required.degree'] = "<spring:message code='user.required.degree' javaScriptEscape='true' />";
errorMessages['user.required.salutation'] = "<spring:message code='user.required.salutation' javaScriptEscape='true' />";	
errorMessages['user.required.password'] = "<spring:message code='user.required.password' javaScriptEscape='true' />";	
errorMessages['user.required.passwordConfirm'] = "<spring:message code='user.required.passwordConfirm' javaScriptEscape='true' />";
errorMessages['user.required.passwordEqual'] = "<spring:message code='user.required.passwordEqual' javaScriptEscape='true' />";
errorMessages['user.requried.tnc'] = "<spring:message code='user.requried.tnc' javaScriptEscape='true' />";	
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";	
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['user.required.jobTitle'] = "<spring:message code='user.required.jobTitle' javaScriptEscape='true' />";
errorMessages['user.required.hangul'] = "<spring:message code='user.required.hangul' javaScriptEscape='true' />";
errorMessages['user.required.english'] = "<spring:message code='user.required.english' javaScriptEscape='true' />";
errorMessages['signup.countryHelp'] = "<spring:message code='signup.countryHelp' javaScriptEscape='true' />";

jQuery(document).ready(function() {
  Signup.init();
    
  $("#register-back-btn").click(function() {
		location.href = document.referrer;
	  return true;
  });
  
  $("input[name='contact.degree']").click(function() {
	  $(".degreeDiv").css("color", "#1C853B");
	  return true;
  });
  
  $("input[name='contact.salutation']").click(function() {
	  $(".salutationDiv").css("color", "#1C853B");
	  return true;
  });
});
</script>
</body>
</html>