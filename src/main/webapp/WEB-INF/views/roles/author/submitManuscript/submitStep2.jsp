<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Step 2</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/author/" label_2="user.role.journal_member"
																	link_3="${baseUrl}/journals/${jnid}/author/submitManuscript/" label_3="author.menu.submitNewManuscript"/>
																	
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								<spring:message code="author.menu.submitNewManuscript"/>
							</a>
						</li>
					</ul>
			
					<div class="tab-content">
						<div class="portlet" id="form_wizard_1">
							<div class="portlet-body form">
								<div class="form-wizard">
									<%@ include file="/WEB-INF/views/roles/author/submitManuscript/formWizardNavigation.jsp" %>
									<div class="tab-content">
										<div class="tab-pane active submitManuscriptTab" id="tab1_2">
											<h3 class="block"><spring:message code="author.newPaperSubmit.tabMenu.2"/></h3>
											<c:if test="${jc.textCoAuthor != null and fn:trim(jc.textCoAuthor) != ''}">
												<div class="row" id="textCoAuthor">
													<label class="control-label col-md-2">
														<p style="text-align:right"><i class="fa fa-bullhorn "></i></p>
													</label>
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body">
																<fieldset class="col-md-11 textByManager marginLeft15">
																	${jc.textCoAuthor}
																</fieldset>
															</div>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-2">
													</div>
													<div class="col-md-9 paddingLeft30">
														<hr class="soften"/>
													</div>
												</div>
												<br/>
											</c:if>
											<div class="row">
												<label class="control-label col-md-2">
												<table class="indentationTable">
													<tr>
														<td class="indentationNumber"></td>
														<td class="marginLeft-60">
															<span class="required">*</span>
															<spring:message code="author.newPaperSubmit.coauthor"/> <i class="fa fa-caret-right smallFontAwesome "></i> 
														</td>
													</tr>
												</table>
												</label>
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body">
															<fieldset class="col-md-11">
																<div id="coAuthorsDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
															</fieldset>
														</div>
													</div>
												</div>
											</div>
											<c:if test="${manuscript.revisionCount == 0 or jc.changeAuthor == true }">
											<div class="row">
												<div class="col-md-2">
												</div>
												<div class="col-md-9 paddingLeft30">
													<hr class="soften"/>
												</div>
											</div>
											
											<div class="row">
												<div class="control-label col-md-2">
													<table class="indentationTable">
														<tr>
															<td class="indentationNumber">1) </td><td><spring:message code="author.newPaperSubmit.coauthor.desc.1"/></td>
														</tr>
													</table>
												</div>
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body">
															<fieldset class="col-md-11">
																<div id = "coAuthorCandidatesDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
															</fieldset>
														</div>
													</div>
												</div>
											</div>
											
											<div class="row">
												<div class="col-md-2 cellCenter">
												<br/><spring:message code="system.or"/>
												</div>
												<div class="col-md-9 paddingLeft30">
													<hr class="soften"/>
												</div>
											</div>
											
											<div class="row">
												<div class="control-label col-md-2">
													<table class="indentationTable">
														<tr>
															<td class="indentationNumber">2) </td><td><spring:message code="author.newPaperSubmit.coauthor.desc.2"/></td>
														</tr>
													</table>
												</div>
												
												<form:form method="post" modelAttribute="user" id="register-form" class="register-form">
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body" >
														<fieldset class="col-md-5">
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
															<c:choose>
																<c:when test="${journal.languageCode == 'en'}" >
																	<div class="form-group col-md-6">
																		<label class="control-label"><spring:message code="user.institution"/></label>
																		<div>
																			<form:input path="contact.institution" type="text" class="form-control" maxlength="70"/>
																			<span class="help-block2">
																				<c:if test="${locale == 'en_US' and (param.lang == null || param.lang == 'en_US')}">
																				</c:if>
																				<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}">
																					<spring:message code="system.useEnglish"/>
																				</c:if>
																			</span>
																		</div>
																	</div>
																	
																	<div class="form-group col-md-6">
																		<label class="control-label"><spring:message code="user.department"/></label>
																		<div>
																			<form:input path="contact.department" type="text" class="form-control" maxlength="30"/>
																			<span class="help-block2">
																				<c:if test="${locale == 'en_US' and (param.lang == null || param.lang == 'en_US')}">
																				</c:if>
																				<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}">
																					<spring:message code="system.useEnglish"/>
																				</c:if>
																			</span>
																		</div>
																	</div>
																</c:when>
																<c:when test="${journal.languageCode == 'ko'}" >
																	<div class="form-group col-md-6">
																		<label class="control-label"><spring:message code="user.institution"/></label>
																		<div>
																			<form:input path="contact.localInstitution" type="text" class="form-control" maxlength="70"/>
																			<span class="help-block2"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)<br/><br/>
																			</span>
																		</div>
																		<label class="control-label"><spring:message code="user.department"/></label>
																		<div>
																			<form:input path="contact.localDepartment" type="text" class="form-control" maxlength="70"/>
																			<span class="help-block2"><spring:message code="system.korean"/> (<spring:message code="user.departmentSample-korean"/>)
																			</span>
																		</div>
																	</div>
																	<div class="form-group col-md-6">
																		<label class="control-label">&nbsp;</label>
																		<div>
																			<form:input path="contact.institution" type="text" class="form-control" maxlength="70"/>
																			<span class="help-block2"><spring:message code="system.english"/> (<spring:message code="user.institutionSample-english"/>)
																			</span>
																		</div>
																		<label class="control-label">&nbsp;</label>
																		<div>
																			<form:input path="contact.department" type="text" class="form-control" maxlength="70"/>
																			<span class="help-block2"><spring:message code="system.english"/> (<spring:message code="user.departmentSample-english"/>)
																			</span>
																		</div>
																	</div>
																</c:when>
															</c:choose>
														</div>
														
														<div class="row">
															<div class="form-group country-group col-md-12">
																<label class="control-label"><spring:message code="user.country"/></label>
																<div>
																	<form:select path="contact.country" id="select2_sample4" class="select2 form-control">
																		<%@ include file="/WEB-INF/views/includes/country.jsp" %>
																	</form:select>
																	<span class="help-block">
																	</span>
																</div>
															</div>			
														</div>
														</fieldset>
														
														<fieldset class="col-md-push-1 col-md-5">
														<c:choose>
															<c:when test="${journal.languageCode == 'en'}" >
																<div class="row">
																	<div class="form-group col-md-7">
																		<label class="control-label"><spring:message code="user.firstname"/></label>
																		<div>
																			<form:input path="contact.firstName" type="text" class="form-control" maxlength="40"/>
																			<span class="help-block">
																				<c:if test="${locale == 'en_US' and (param.lang == null || param.lang == 'en_US')}">
																				</c:if>
																				<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}">
																					<spring:message code="system.useEnglish"/>
																				</c:if>
																			</span>
																		</div>
																	</div>	
																	<div class="form-group col-md-5">
																		<label class="control-label"><spring:message code="user.lastname"/></label>
																		<div>
																			<form:input path="contact.lastName" type="text" class="form-control" maxlength="30"/>
																			<span class="help-block">
																				<c:if test="${locale == 'en_US' and (param.lang == null || param.lang == 'en_US')}">
																				</c:if>
																				<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}">
																					<spring:message code="system.useEnglish"/>
																				</c:if>
																			</span>
																		</div>
																	</div>
																</div>
															</c:when>
															<c:when test="${journal.languageCode == 'ko'}" >
																<div class="row">
																	<div class="form-group col-md-12">
																		<label class="control-label"><spring:message code="user.name"/></label>
																		<div>
																			<form:input path="contact.localFullName" type="text" class="form-control" maxlength="50"/>
																			<span class="help-block2"><spring:message code="user.koreanFullName"/> (<spring:message code="user.koreanFullnameSample"/>)
																			</span>
																		</div>
																	</div>
																</div>
																<div class="row" style="margin-top:0.4em;">
																	<div class="form-group col-md-7">
																		<div>
																			<form:input path="contact.firstName" type="text" class="form-control" maxlength="40"/>
																			<span class="help-block2"><spring:message code="user.firstname2"/> (<spring:message code="user.firstnameSample"/>)
																			</span>
																		</div>
																	</div>	
																	<div class="form-group col-md-5">
																		<div>
																			<form:input path="contact.lastName" type="text" class="form-control" maxlength="30"/>
																			<span class="help-block2"><spring:message code="user.lastname2"/> (<spring:message code="user.lastnameSample"/>)
																			</span>
																		</div>
																	</div>
																</div>
															</c:when>
														</c:choose>		

														<div class="form-group degreeDiv">
															<label class="control-label"><spring:message code="user.degree"/></label><br/>
															<div class="radio-list degreeSmallWidth">
																<c:forEach var="degreeDesignation" items="${degreeDesignations}">
																	<label class="radio-inline">
																	<form:radiobutton path="contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
																</c:forEach>
															</div>
														</div>
														
														<div class="form-group salutationDiv">
															<label class="control-label"><spring:message code="user.salutation"/></label><br/>
															<div class="radio-list salutation">
																<c:forEach var="salutationDesignation" items="${salutationDesignations}">
																	<label class="radio-inline">
																	<form:radiobutton path="contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
																</c:forEach>
															</div>
														</div>
														
														
														<c:choose>
															<c:when test="${journal.languageCode == 'ko'}" >
																<div class="form-group jobTitle-group">
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
															</c:when>
														</c:choose>

														<div>    
															<button type="submit" id="register-submit-btn" class="btn green pull-right">
																<spring:message code="system.createAndSelect"/> <i class="m-icon-swapright m-icon-white"></i>
															</button>
														</div>
														</fieldset>
														</div>
													</div>
												</div>
												</form:form>
											</div>
											</c:if>
											<br/>
											<br/>
											<div class="row">
												<div class="col-md-offset-2 col-md-10">
													<form id="submit_form" action="${baseUrl}/journals/${jnid}/author/submitManuscript/step2" method="POST" class="form-horizontal">
														<div class="row">
															<div class="col-md-5 formRight">
																<div id="way"></div>
																<button type="button" id="back" class="btn default btn-previous">
																	<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
																</button>
															</div>
															<div class="col-md-offset-1 col-md-6 pull-left">
																<button type="button" id="saveAndContinue" class="btn blue btn-next">
																	<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
																</button>
															</div>
														</div>
													</form>
												</div>
											</div>
											<br/>
											<br/>
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
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/signupCoAuthor.js"></script>
<script src="${baseUrl}/js/roles/author/submitFormWizard.js"></script>
</footer>

<script>
var errorMessages = new Array();
errorMessages['user.required.newUser.email'] = "<spring:message code='user.required.newUser.email' javaScriptEscape='true' />";
errorMessages['user.required.validEmail'] = "<spring:message code='user.required.validEmail' javaScriptEscape='true' />";
errorMessages['user.required.emailAlreadyUsed'] = "<spring:message code='user.required.emailAlreadyUsed' javaScriptEscape='true' />";
errorMessages['user.required.newUser.fullnameNative'] = "<spring:message code='user.required.newUser.fullnameNative' javaScriptEscape='true' />";
errorMessages['user.required.newUser.firstname'] = "<spring:message code='user.required.newUser.firstname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.lastname'] = "<spring:message code='user.required.newUser.lastname' javaScriptEscape='true' />";
errorMessages['user.required.newUser.institution'] = "<spring:message code='user.required.newUser.institution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.department'] = "<spring:message code='user.required.newUser.department' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localInstitution'] = "<spring:message code='user.required.newUser.localInstitution' javaScriptEscape='true' />";
errorMessages['user.required.newUser.localDepartment'] = "<spring:message code='user.required.newUser.localDepartment' javaScriptEscape='true' />";
errorMessages['user.required.newUser.degree'] = "<spring:message code='user.required.newUser.degree' javaScriptEscape='true' />";
errorMessages['user.required.newUser.salutation'] = "<spring:message code='user.required.newUser.salutation' javaScriptEscape='true' />";	
errorMessages['user.required.minlength'] = "<spring:message code='user.required.minlength' javaScriptEscape='true' />";	
errorMessages['user.required.maxlength'] = "<spring:message code='user.required.maxlength' javaScriptEscape='true' />";
errorMessages['user.required.newUser.jobTitle'] = "<spring:message code='user.required.newUser.jobTitle' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.keywordRequired'] = "<spring:message code='author.newPaperSubmit.keywordRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.divisionRequired'] = "<spring:message code='author.newPaperSubmit.divisionRequired' javaScriptEscape='true' />";
var coAuthorValidation = true;
jQuery(document).ready(function() {
	SignupCoAuthor.init("${baseUrl}/journals/${jnid}");
	SubmitFormWizard.init("${baseUrl}/journals/${jnid}", "${manuscript.submitStep}", 2);
	
	$.ajax({
		type: 'GET',
		url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorTable",
		success: function(html){
			$("#coAuthorsDisplay").html(html).show();
		}
	});
	<c:if test="${manuscript.revisionCount == 0 or jc.changeAuthor == true}">
	$.ajax({
		type: 'GET',
		url: "${baseUrl}/journals/${jnid}/author/submitManuscript/coAuthorCandidateTable",
		success: function(html){
			$("#coAuthorCandidatesDisplay").html(html).show();
		}
	});
	</c:if>

	jQuery("#back").click(function(event) {
		event.preventDefault();
		$('#way').html('<input type="hidden" name="way" value="Back"/>');
		$('#submit_form').submit();
	});
	
	jQuery("#saveAndContinue").click(function(event) {
		event.preventDefault();
		$('#way').html('<input type="hidden" name="way" value="Forward"/>');
		// Author Order Check
		
		<c:if test="${manuscript.revisionCount == 0 or jc.changeAuthor == true}">

		var i = 0, j = 0;
		var selectors = $(".authorOrderSelector > option:selected");
		var orders = $('.authorOrder');
		var uniqueNames = [];
		var orderValues = [];
		var validOrderValues = [];
		var validCount = 0;
		
		for(i=0; i<selectors.length; i++) {
			validOrderValues[i] = i + 1;
			orderValues[i] = selectors[i].value;
			if(orderValues[i] == 0 || orderValues[i] > orders.length + 1)
				coAuthorValidation = false;
		}
		$.each(orderValues , function(index, el){
			if($.inArray(el, uniqueNames) === -1) 
				uniqueNames.push(el);
		});
		
		if(uniqueNames.length != selectors.length)
			coAuthorValidation = false;
		else {
			for(i=0; i<selectors.length; i++) {
				for(j=0; j<selectors.length; j++) {
					if(orderValues[i] == validOrderValues[j])
						validCount = validCount + 1;
				}
			}
			if(validCount != selectors.length)
				coAuthorValidation = false;
		}
		
		// Corresponding Author Check
		var corres = $('.correspondingRadio');
		var corresIndex = -1;
		for(i=0; i<corres.length; i++) {
			if(corres[i].checked) {
				corresIndex = i;
				break;
			}
		}
		if(corresIndex == -1)
			coAuthorValidation = false;
		</c:if>

		if(coAuthorValidation) {
			$('#submit_form').submit();

		} else 
			bootbox.alert("Invalid Author Order");
	});
});
</script>
</body>
</html>