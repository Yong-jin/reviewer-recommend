<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<title>Step 3</title>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>
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
						<div class="tab-pane active" id="tab_1_1">
							<div class="portlet" id="form_wizard_1">
								<div class="portlet-body form">
									<div class="form-wizard">
										
										<%@ include file="/WEB-INF/views/roles/author/submitManuscript/formWizardNavigation.jsp" %>
										<div class="tab-content">
											<div class="tab-pane active submitManuscriptTab" id="tab3">
												<h3 class="block"><spring:message code="author.newPaperSubmit.coverLetter"/></h3>
												<c:if test="${jc.textCoverLetter != null and fn:trim(jc.textCoverLetter) != ''}">
													<div class="row" id="textCoverLetter">
														<label class="control-label col-md-2">
															<p style="text-align:right"><i class="fa fa-bullhorn "></i></p>
														</label>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11 textByManager marginLeft15">
																		${jc.textCoverLetter}
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
													<div class="control-label col-md-2">
															<p style="text-align:right; font-size: 14px"><c:if test="${jc.requiredCoverletter == true}"><span class="required">*</span></c:if>
															<spring:message code="author.newPaperSubmit.coverletter"/> <i class="fa fa-caret-right smallFontAwesome"></i> 
															</p>
													</div>
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body">
																<fieldset class="col-md-11">
																	<textarea name="coverLetter" id="coverLetter" class="form-control" maxlength="4000" rows="6" placeholder="<spring:message code='author.newPaperSubmit.coverletter'/>">${manuscript.coverLetter}</textarea>
																	<span id="coverLetter-help-block" class="help-block">
																	</span>
																	<br/><br/>
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
												
												<h3 class="block"><spring:message code="manuscript.reviewerPreference"/></h3>
												<c:if test="${jc.textRp != null and fn:trim(jc.textRp) != ''}">
													<div class="row" id="textCoverLetter">
														<label class="control-label col-md-2">
															<p style="text-align:right"><i class="fa fa-bullhorn "></i></p>
														</label>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11 textByManager marginLeft15">
																		${jc.textRp}
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
														<p style="text-align:right; font-size: 14px">
															<c:if test="${jc.requiredRp == true}"><span class="required">*</span></c:if>
															<spring:message code="author.newPaperSubmit.preferredReviewers"/> <i class="fa fa-caret-right smallFontAwesome "></i>
														</p>
													</label>
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body">
																<fieldset class="col-md-11">
																	<div id="rpDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
																</fieldset>
															</div>
														</div>
													</div>
												</div>
												
												<c:if test="${manuscript.revisionCount == 0 or jc.changeRp == true }">
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
																<td class="indentationNumber">1) </td><td><spring:message code="author.newPaperSubmit.preferredReviewers.desc.1"/></td>
															</tr>
														</table>
													</div>
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body">
																<fieldset class="col-md-11">
																	<div id="rpCandidateDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
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
																<td class="indentationNumber">2) </td><td><spring:message code="author.newPaperSubmit.preferredReviewers.desc.2"/></td>
															</tr>
														</table>
													</div>
													<div class="col-md-10">
														
														<form:form method="post" modelAttribute="rp"  id="register-form" class="register-form" title="Reviewer Select" style="padding-top:0.7em;">
															<div class="portlet">
															<fieldset class="col-md-5">
															
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
																				<form:input path="institution" type="text" class="form-control" maxlength="70"/>
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
																				<form:input path="department" type="text" class="form-control" maxlength="30"/>
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
																				<form:input path="localInstitution" type="text" class="form-control" maxlength="70"/>
																				<span class="help-block"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)
																				</span>
																			</div>
																		</div>
																	</c:when>
																</c:choose>
															</div>
															<div class="form-group country-group">
																<label class="control-label"><spring:message code="user.country"/></label>
																<form:select path="countryCode" id="select2_sample4" class="select2 form-control">
																	<%@ include file="/WEB-INF/views/includes/country.jsp" %>
																</form:select>
																<span class="help-block">
																	<spring:message code="signup.countryHelp"/>
																</span>
															</div>
															</fieldset>

															<fieldset class="col-md-push-1 col-md-5">
															
															<c:choose>
																<c:when test="${journal.languageCode == 'en'}" >
																	<div class="row">
																		<div class="form-group col-md-7">
																			<label class="control-label"><spring:message code="user.firstname"/></label>
																			<div>
																				<form:input path="firstName" type="text" class="form-control" maxlength="40"/>
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
																				<form:input path="lastName" type="text" class="form-control" maxlength="30"/>
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
																				<form:input path="localFullName" type="text" class="form-control" maxlength="50"/>
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
																		<form:radiobutton path="degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
																	</c:forEach>				
																</div>
															</div>
															
															<div class="form-group salutationDiv">
																<label class="control-label"><spring:message code="user.salutation"/></label><br/>
																<div class="radio-list salutation">
																	<c:forEach var="salutationDesignation" items="${salutationDesignations}">
																		<label class="radio-inline">
																		<form:radiobutton path="salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
																	</c:forEach>
																</div>
															</div>
															<div>
																<button type="submit" id="register-submit-btn" class="btn green pull-right">
																	<spring:message code="system.suggest"/> <i class="m-icon-swapright m-icon-white"></i>
																</button>
															</div>
															</fieldset>
															<fieldset class="col-md-1">
															</fieldset>
															</div>
														</form:form>
													</div>
												</div>
												</c:if>
												<br/>
												<br/>
												<div class="row">
													<div class="col-md-offset-2 col-md-10">
														<form id="submit_form" action="${baseUrl}/journals/${jnid}/author/submitManuscript/step3" method="POST" class="form-horizontal">
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
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/addReviewerPreference.js"></script>
<script src="${baseUrl}/js/roles/author/submitFormWizard.js"></script>
</footer>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.enterCoverletter'] = "<spring:message code='author.newPaperSubmit.enterCoverletter' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['system.error.maxlength'] = "<spring:message code='system.error.maxlength' javaScriptEscape='true' />";

var coverLetterRequired = false;
var rpRequired = false;
var changeRp = false;
<c:if test="${jc.requiredCoverletter == true}">
coverLetterRequired = true;
</c:if>
<c:if test="${jc.requiredRp == true}">
rpRequired = true;
</c:if>
<c:if test="${jc.changeRp == true}">
changeRp = true;
</c:if>
var coverLetter = $('#coverLetter');
var coverLetterSuccess = true;
var minLength = jQuery.validator.format(errorMessages['author.newPaperSubmit.minLength']);
var maxLength = jQuery.validator.format(errorMessages['system.error.maxlength']);
jQuery(document).ready(function() {  
	AddReviewer.init("${baseUrl}/journals/${jnid}");
	SubmitFormWizard.init("${baseUrl}/journals/${jnid}", "${manuscript.submitStep}", 3);
	$.ajax({
		type: 'GET',
		url: "journals/${jnid}/author/submitManuscript/rpTable",
		success: function(html){
			$("#rpDisplay").html(html).show();
		}
	});
	<c:if test="${manuscript.revisionCount == 0 or jc.changeRp == true}">
	$("input[name='contact.degree']").click(function() {
		$(".degreeDiv").css("color", "#1C853B");
		return true;
	});
	
	$("input[name='contact.salutation']").click(function() {
		$(".salutationDiv").css("color", "#1C853B");
		return true;
	});
	
	$.ajax({
		type: 'GET',
		url: "journals/${jnid}/author/submitManuscript/rpCandidateTable",
		success: function(html){
			$("#rpCandidateDisplay").html(html).show();
		}
	});
	</c:if>
	if(coverLetterRequired) {
		$("#coverLetter").on('change keyup paste', function() {
			if(coverLetter.val().length <= 5 || coverLetter.val().length > 4000) {
				if(coverLetter.val().length == 0)
					$('#coverLetter-help-block').text(errorMessages['author.newPaperSubmit.enterCoverletter']);
				else if(coverLetter.val().length <= 5)
					$('#coverLetter-help-block').text(minLength(5));
				else
					$('#coverLetter-help-block').text(maxLength(4000));
				coverLetterSuccess = false;
			} else
				coverLetterSuccess = true;
			
			if(!coverLetterSuccess) {
				coverLetter.removeClass('has-success').addClass('has-error');
				coverLetter.closest('.portlet-body').removeClass('has-success').addClass('has-error');
			} else {
				$('#coverLetter-help-block').text("");
				coverLetter.removeClass('has-error').addClass('has-success');
				coverLetter.closest('.portlet-body').removeClass('has-error').addClass('has-success');
			}
		});
	}

	jQuery("#back").click(function(event) {
		event.preventDefault();
		var cl = $('#coverLetter').val();
		$('#way').html('<input type="hidden" name="way" value="Back"/><input type="hidden" name="coverLetter" value="' + String(cl) + '"/>');
		$('#submit_form').submit();
	});
	
	jQuery("#saveAndContinue").click(function(event) {
		event.preventDefault();
		if(coverLetterRequired) {
			coverLetter = $('#coverLetter');
			if(coverLetter.val().length <= 5 || coverLetter.val().length > 4000) {
				if(coverLetter.val().length == 0)
					$('#coverLetter-help-block').text(errorMessages['author.newPaperSubmit.enterCoverletter']);
				else if(coverLetter.val().length <= 5)
					$('#coverLetter-help-block').text(minLength(5));
				else
					$('#coverLetter-help-block').text(maxLength(4000));
				coverLetterSuccess = false;
			}
			if(!coverLetterSuccess) {
				coverLetter.removeClass('has-success').addClass('has-error');
				coverLetter.closest('.portlet-body').removeClass('has-success').addClass('has-error');
				App.scrollTo($('.submitManuscriptTab'));
			} else {
				$('#coverLetter-help-block').text("");
				coverLetter.removeClass('has-error').addClass('has-success');
				coverLetter.closest('.portlet-body').removeClass('has-error').addClass('has-success');

			}
		}
			
		if(rpRequired && changeRp) {
			jQuery.ajax({
				type:"GET",
				url: "${baseUrl}/journals/${jnid}/author/submitManuscript/rpCount",
				success:function(html) {
					if(Number(html) == 0) {
						if(coverLetterSuccess) {
							App.scrollTo($('#rpDisplay'));
							bootbox.alert("<spring:message code='author.newPaperSubmit.preferredReviewers.desc.2' javaScriptEscape='true' />");
						}
					} else {
						if(coverLetterSuccess) {
							$('#way').html('<input type="hidden" name="way" value="Forward"/><input type="hidden" name="coverLetter" value="' + coverLetter.val() + '"/>');
							$('#submit_form').submit();
						}
						
					}
				}
			});
		} else {
			if(coverLetterSuccess) {
				$('#way').html('<input type="hidden" name="way" value="Forward"/><input type="hidden" name="coverLetter" value="' + coverLetter.val() + '"/>');
				$('#submit_form').submit();
			}
		}
	});

	var li_list = $('.centerMenu');
	var index = Number("${menuNumber}");
	jQuery(li_list[index]).addClass("active");
});  
</script>
</body>
</html>