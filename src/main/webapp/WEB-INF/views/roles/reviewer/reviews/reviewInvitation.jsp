<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="reviewer.invitation"/></title>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
<div class="page-container">
	<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<br/><br/>
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								<spring:message code="reviewer.invitation"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="form form-wizard" id="form_wizard_1">
								<c:if test="${reviewRequest.available == true}">
									<br/>
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"></label>
										<div class="col-md-9">
											<p class="form-control-static sentenseJustifyAlign">
											<c:if test="${journal.languageCode == 'en' }">Dear <spring:message code="signin.salutationDesignation.${reviewer.contact.salutation }"/> </c:if>${reviewerName } <c:if test="${journal.languageCode == 'ko' }">님</c:if>,<br/><br/>
											<spring:message code="reviewer.invitation.text.0"/><br/><br/>

											<spring:message code="manuscript.title2"/>: ${manuscript.title }<br/><br/>
											<spring:message code="manuscript.abstract"/>: <br/>
											${manuscript.paperAbstract } <br/><br/>
											<spring:message code="system.journal"/>: ${journal.title } <br/><br/>
											<spring:message code="user.role.journal_reviewer"/> <spring:message code="signin.email"/>: ${reviewer.username}<br/><br/>
											<spring:message code="reviewer.invitation.text.1"/> <br/><br/>
											</p>
										</div>
									</div>
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"></label>
										<div class="col-md-9">
											<fieldset class="col-md-8 padding0">
												<p class="form-control-static sentenseJustifyAlign">
												1) <spring:message code="reviewer.invitation.text.2"/>
												</p>
											</fieldset>

											<div class="row">
												<div class="col-md-6 pull-right">
													<button type="submit" id="takeinButton" class="btn green pull-right marginTop-20">
														<spring:message code="system.takein"/> <i class="m-icon-swapright m-icon-white"></i>
													</button>
												</div>
											</div>
										</div>
									</div>
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"></label>
										<div class="col-md-9">
											<p class="form-control-static sentenseJustifyAlign">
											2) <spring:message code="reviewer.invitation.text.3"/>
											<br/>
											</p>
										</div>
									</div>
									<form:form method="post" modelAttribute="rs" id="register-form" class="register-form" title="Reviewer Select" style="padding-top:0.7em;">
										<form:hidden path="reviewerUserId" value="${rs.reviewerUserId }"/>
										<form:hidden path="manuscriptId" value="${manuscript.id }"/>
										<div id="decisionDiv"></div>
										
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"><spring:message code="system.declineReason"/>:</label>
										<div class="col-md-9">
											<form:select path="reason" class="select2 form-control reasonSelect" name="reason">
												<c:forEach var="reviewerDeclineReason" items="${reviewerDeclineReasons}">
													<form:option value="${reviewerDeclineReason.id }"><spring:message code="reviewer.decline.reason.${reviewerDeclineReason.id}"/></form:option>
												</c:forEach>
											</form:select>
											<br/><br/><br/>
											<spring:message code="system.commentToEditorial"/><br/>
											<form:textarea class="form-control" path="comment" ></form:textarea>
										</div>
									</div>
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"><spring:message code="reviewer.reviewerSuggest"/>:</label>
										<div class="col-md-9">
											<fieldset class="col-md-5 padding0">
												<div class="form-group">
													<label class="control-label"><spring:message code="user.username"/></label>
													<div>
														<form:input path="email" type="text" class="form-control" id="email" maxlength="100"/>
														<span class="help-block">
														</span>
													</div>
												</div>
												<div class="row">
													<c:choose>
														<c:when test="${journal.languageCode == 'en'}" >
															<div class="form-group col-md-6">
																<label class="control-label"><spring:message code="user.institution"/></label>
																<div>
																	<form:input path="institution" type="text" id="institution" class="form-control" maxlength="70"/>
																	<span class="help-block">
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
																	<form:input path="department" id="department" type="text" class="form-control" maxlength="30"/>
																	<span class="help-block">
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
															<div class="form-group col-md-12">
																<label class="control-label"><spring:message code="user.institution"/></label>
																<div>
																	<form:input path="localInstitution" id="localInstitution" type="text" class="form-control" maxlength="70"/>
																	<span class="help-block"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)
																	</span>
																</div>
															</div>
														</c:when>
													</c:choose>
												</div>
												<div class="form-group country-group">
													<label class="control-label"><spring:message code="user.country"/></label>
													<form:select path="countryCode" id="select2_sample4" class="select2 form-control countrySelect">
														<%@ include file="/WEB-INF/views/includes/country.jsp" %>
													</form:select>
													<span class="help-block">
														<spring:message code="signup.countryHelp"/>
													</span>
												</div>
											</fieldset>
											<fieldset class="col-md-push-1 col-md-6 padding0">
												<c:choose>
													<c:when test="${journal.languageCode == 'en'}" >
														<div class="row">
															<div class="form-group col-md-7">
																<label class="control-label"><spring:message code="user.firstname"/></label>
																<div>
																	<form:input path="firstName" id="firstName" type="text" class="form-control" maxlength="40"/>
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
																	<form:input path="lastName" id="lastName" type="text" class="form-control" maxlength="30"/>
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
																	<form:input path="localFullName" id="localFullName" type="text" class="form-control" maxlength="50"/>
																	<span class="help-block"><spring:message code="user.koreanFullName"/> (<spring:message code="user.koreanFullnameSample"/>)
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
															<form:radiobutton path="degree" class="degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
														</c:forEach>				
													</div>
												</div>
												<div class="form-group salutationDiv">
													<label class="control-label"><spring:message code="user.salutation"/></label><br/>
													<div class="radio-list salutation">
														<c:forEach var="salutationDesignation" items="${salutationDesignations}">
															<label class="radio-inline">
															<form:radiobutton path="salutation" class="salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
														</c:forEach>
													</div>
												</div>
											</fieldset>
											<fieldset class="col-md-1">
											</fieldset>
											<div class="row">
												<div class="col-md-6 pull-right">
													<br/><br/><br/>
													<button class="btn btn-default pull-right" id="declineButton">
														<i class="fa fa-undo"></i> <spring:message code="system.decline"/>
													</button>
												</div>
											</div>
										</div>
									</div>

									</form:form>
								</c:if>
								<c:if test="${reviewRequest.available == false}">
									<div class="row form-section_noborder">
										<label class="control-label col-md-2"></label>
										<div class="col-md-9">
											<br/><br/><br/><br/><br/>
											<p class="form-control-static sentenseJustifyAlign">
												<spring:message code="reviewer.invitation.text.4"/>										
												<br/>
											</p>
											<br/><br/><br/><br/><br/>
										</div>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<br/><br/>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/reviewer/addReviewerSuggest.js" type="text/javascript"></script>
</footer>
<script>
jQuery(document).ready(function() {
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
	$('#takeinButton').click(function(event) {
		event.preventDefault();
		var confirmText = "Thank you for agreeing to review this manuscript. Your participation in the journal helps ensure its success. You will now receive an email which gives you an access method to our review system.";
		bootbox.confirm(confirmText, function(result) {
			if(result == true) {
				$('#decisionDiv').html('<input type="hidden" name="decision" value="T"/>');
				$('#register-form').submit();
			}
		});
	});
	
	$('#declineButton').click(function(event) {
		event.preventDefault();

		$('#decisionDiv').html('<input type="hidden" name="decision" value="D"/>');
		var languageCode = "${journal.languageCode}";
		var success = true;
		if($('#email').val() == '') {
			bootbox.alert(errorMessages['user.required.newUser.email']);
			success = false;
		} else if($('.degree:checked').length < 1){
		    bootbox.alert(errorMessages['user.required.newUser.degree']);      
		    success = false;
		    event.preventDefault();
		} else if($('.salutation:checked').length < 1){
		    bootbox.alert(errorMessages['user.required.newUser.salutation']);   
		    success = false;
		    event.preventDefault();
		} else {
			if(languageCode == 'ko') {
				if($('#localInstitution').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.localInstitution']);
					success = false;
				} else if($('#localFullName').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.fullnameNative']);
					success = false;
				}
			} else {
				if($('#institution').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.institution']);
					success = false;
				} else if($('#department').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.department']);
					success = false;
				} else if($('#firstName').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.firstname']);
					success = false;
				} else if($('#lastName').val() == '') {
					bootbox.alert(errorMessages['user.required.newUser.lastname']);
					success = false;
				}
			}
		}
		
		if(success) {
			var confirmText = "We hope to call on you in the future.";
			bootbox.confirm(confirmText, function(result) {
				if(result == true) {
			$('.register-form').submit();
				}
			});
		}
	});
	
	$(".countrySelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	$(".reasonSelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
});  
</script>
</body>
</html>