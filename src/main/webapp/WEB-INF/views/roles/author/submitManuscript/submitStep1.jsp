<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<title>Step 1</title>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet" type="text/css" />
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
									<form action="${baseUrl}/journals/${jnid}/author/submitManuscript/step1" method="POST" class="form-horizontal" id="submit_form">
										<div class="form-wizard">
											<%@ include file="/WEB-INF/views/roles/author/submitManuscript/formWizardNavigation.jsp" %>

											
											<div class="tab-content">
												<div class="tab-pane active submitManuscriptTab" id="tab1_1">
													<h3 class="block"><spring:message code="author.newPaperSubmit.tabMenu.1"/></h3>
													<c:if test="${jc.textBasicInfo != null and fn:trim(jc.textBasicInfo) != ''}">
														<div class="row" id="textBasicInfo">
															<label class="control-label col-md-2">
																<i class="fa fa-bullhorn "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11 textByManager marginLeft15">
																			${jc.textBasicInfo}
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
													<c:if test="${manuscript.status == 'B' }">
														<!-- ManuscriptTrack -->
														<div class="row marginBottom10" id="manuscriptTrackDiv">
															<label class="control-label col-md-2">															
															<span class="required">
																 *
															</span>
															<spring:message code="author.newPaperSubmit.manuscriptTrack"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11">
																			<select id="manuscriptTrackSelect" name="manuscriptTrackId" class="form-control input-sm select2 manuscriptTrackSelect" <c:if test="${manuscript.revisionCount > 0 }">readonly="readonly"</c:if>>
																				<c:forEach var="manuscriptTrack" items="${manuscriptTracks}">
																					<option value="${manuscriptTrack.id}" <c:if test="${manuscriptTrack.id == manuscript.manuscriptTrackId}">selected</c:if>><spring:message code="author.newPaperSubmit.manuscriptTrack.${manuscriptTrack.id}"/></option>
																				</c:forEach>
																			</select>
																			<span id="manuscriptTrack-help-block" class="help-block">
																				 
																			</span>
																		</fieldset>
																	</div>
																</div>
															</div>
														</div>
														
														<!-- Special Issue -->
														<div class="row marginBottom10" id="speicalIssueDiv">
															<label class="control-label col-md-2"> 
															<span class="required">
																 *
															</span>
															<spring:message code="author.newPaperSubmit.specialIssue"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11">
																			<select id="specialIssueSelect" name="specialIssueId" class="form-control input-sm select2 specialIssueSelect">
																				<c:forEach var="si" items="${specialIssues}">
																					<option value="${si.id}" <c:if test="${si.id == manuscript.specialIssueId}">selected</c:if>>${si.title}</option>
																				</c:forEach>
																			</select>
																			<span id="specialIssue-help-block" class="help-block">
																				 
																			</span>
																		</fieldset>
																	</div>
																</div>
															</div>
														</div>
														<!-- ManuscriptType -->
														<div class="row marginBottom10" id="manuscriptTypeDiv">
															<label class="control-label col-md-2">
															<span class="required">
																 *
															</span>
															<spring:message code="author.newPaperSubmit.manuscriptType"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11">
																			<select id="manuscriptTypeSelect" name="manuscriptTypeId" class="form-control input-sm select2 manuscriptTypeSelect">
																				<c:forEach var="manuscriptType" items="${manuscriptTypes}">
																					<option value="${manuscriptType.id}" <c:if test="${manuscriptType.id == manuscript.manuscriptTypeId}">selected</c:if>><spring:message code="author.newPaperSubmit.manuscriptType.${manuscriptType.id}"/></option>
																				</c:forEach>
																			</select>
																			<span id="manuscriptType-help-block" class="help-block">
																				 
																			</span>
																		</fieldset>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<c:if test="${manuscript.status == 'D' }">
														<input type="hidden" name="manuscriptTrackId" value="${manuscript.manuscriptTrackId }"/>
														<input type="hidden" name="specialIssueId" value="${manuscript.specialIssueId }"/>
														<input type="hidden" name="manuscriptTypeId" value="${manuscript.manuscriptTypeId }"/>
														<div class="row marginBottom10" id="manuscriptTypeDiv">
															<label class="control-label col-md-2">
															<span class="required">
																 *
															</span>
															<spring:message code="author.newPaperSubmit.manuscriptType"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11">
																			<p class="form-control-static sentenseJustifyAlign">
																			<c:forEach var="manuscriptType" items="${manuscriptTypes}">
																				<c:if test="${manuscriptType.id == manuscript.manuscriptTypeId}"><spring:message code="author.newPaperSubmit.manuscriptType.${manuscriptType.id}"/></c:if>
																			</c:forEach>
																			</p>
																		</fieldset>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<div class="row marginBottom10">
														<label class="control-label col-md-2">
														<span class="required">
															 *
														</span>
														<spring:message code="manuscript.title"/> <i class="fa fa-caret-right smallFontAwesome "></i>
														</label>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11">
																		<input type="text" class="form-control" maxlength="500" name="title" id="title" value="${manuscript.title}"/>
																		<span id = "title-help-block" class="help-block">
																		</span>
																	</fieldset>
																</div>
															</div>
														</div>
													</div>
													<div class="row marginBottom10">
														<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
															<label class="control-label col-md-2">
															<span class="required">
																<c:if test="${jc.requiredRunninghead == true }">
																	*
																</c:if>
															</span>
															<spring:message code="manuscript.runningHead"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
														</c:if>
														<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
															<label class="control-label col-md-2">
															<span class="required">
																<c:if test="${jc.requiredRunninghead == true }">
																	*
																</c:if>
															</span>
															<spring:message code="manuscript.runningHead"/> <span style="font-size: 0.7em;">(Running Head)</span> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>		
														</c:if>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11">
																		<input type="text" class="form-control" maxlength="500" name="runningHead" id="runningHead" value="${manuscript.runningHead}"/>
																		<span id="runningHead-help-block" class="help-block">
																			 
																		</span>
																	</fieldset>
																</div>
															</div>
														</div>
													</div>
													<div class="row marginBottom10">
														<label class="control-label col-md-2">
														<span class="required">
															 *
														</span>
														<spring:message code="manuscript.abstract"/> <i class="fa fa-caret-right smallFontAwesome "></i>
														</label>
														<div class="col-md-10">
															<div class="portlet">
																<div class="portlet-body">
																	<fieldset class="col-md-11">
																		<textarea name="paperAbstract" id="maxlength_textarea" class="form-control" maxlength="4000" rows="6">${manuscript.paperAbstract}</textarea>
																		<span id = "abs-help-block" class="help-block">
																		</span>
																	</fieldset>
																</div>
															</div>
														</div>
													</div>
													<c:choose>
														<c:when test="${manuscript.revisionCount == 0 or jc.changeKeyword == true }">
															<div class="row  marginBottom10">
																<label class="control-label col-md-2">
																<span class="required">
																	<c:if test="${jc.requiredKeyword == true }">
																		*
																	</c:if>
																</span>
																<spring:message code="manuscript.keywords"/> <i class="fa fa-caret-right smallFontAwesome "></i>
																</label>
																<div class="col-md-10">
																	<div class="portlet">
																		<div class="portlet-body">
																			<fieldset class="col-md-11">
																				<c:set var="keywordString" value=""/>
																				<c:forEach var="key" items="${manuscript.keyword}">
																					<c:set var="keywordString" value="${keywordString },${key }"/>
																				</c:forEach>
																				<div id="keywordDiv">
																					<input id="tags_2" type="text" name="keyword" class="tags" placeholder="  <spring:message code="author.newPaperSubmit.keyword.add"/>  " value="${keywordString }"/>
																				</div>
																				<span id="keyword-help-block" class="help-block">
																					 <spring:message code="author.newPaperSubmit.keyword.desc"/> (<spring:message code="profile.expertise.text.2"/>, <spring:message code="profile.expertise.text.3"/>)
																				</span>
																			</fieldset>
																		</div>
																	</div>
																</div>
															</div>
														</c:when>
														<c:otherwise>
															<div class="row marginBottom10">
																<label class="control-label col-md-2">
																<span class="required">
																	<c:if test="${jc.requiredKeyword == true }">
																		*
																	</c:if>
																</span>
																<spring:message code="manuscript.keywords"/> <i class="fa fa-caret-right smallFontAwesome "></i>
																</label>
																<div class="col-md-10">
																	<div class="portlet">
																		<div class="portlet-body keywordDiv">
																			<div class="marginLeft15">
																				<c:set var="keywordString" value=""/>
																				<c:forEach var="k" items="${manuscript.keyword }">
																					<span class="tag label label-info">${k}</span>
																					<c:set var="keywordString" value="${keywordString },${k }"/>
																				</c:forEach>
																				<input type="hidden" name="keyword" value="${keywordString }"/>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</c:otherwise>
													</c:choose>
													<c:set var="divisionManaged" value="false"/>
													<c:if test="${jc.manageDivision == true and not empty divisions}">
														<c:set var="divisionManaged" value="true"/>
														<!-- division -->
														<div class="row marginBottom10" id="divisionDiv">
															<label class="control-label col-md-2">
															<span class="required">
																 *
															</span>
															<spring:message code="manuscript.division"/> <i class="fa fa-caret-right smallFontAwesome "></i>
															</label>
															<div class="col-md-10">
																<div class="portlet">
																	<div class="portlet-body">
																		<fieldset class="col-md-11">
																			<c:choose>
																				<c:when test="${manuscript.revisionCount == 0 or jc.changeDivision == true }">
																					<select id="divisionSelect" name="division" class="form-control input-sm select2 divisionSelect">
																						<c:forEach var="division" items="${divisions }">
																							<option value="${division.id }" <c:if test="${division.id == manuscript.divisionId}">selected</c:if>>${division.symbol}. ${division.name}</option>
																						</c:forEach>
																					</select>
																				</c:when>
																				<c:otherwise>
																					<p class="form-control-static sentenseJustifyAlign">
																						<c:forEach var="division" items="${divisions }">
																							<c:if test="${division.id == manuscript.divisionId}">${division.symbol}. ${division.name}</c:if>
																						</c:forEach>
																					</p>
																				</c:otherwise>
																			</c:choose>
																			<span id="division-help-block" class="help-block">
																			</span>
																		</fieldset>
																	</div>
																</div>
															</div>
														</div>
													</c:if>
													<c:choose>
														<c:when test="${manuscript.revisionCount == 0}">
															<div class="row marginBottom10">
																<label class="control-label col-md-2"><spring:message code="manuscript.inviteManuscript"/> <i class="fa fa-caret-right smallFontAwesome "></i>
																</label>
																<div class="col-md-10">
																	<div class="portlet">
																		<div class="portlet-body">
																			<fieldset class="col-md-11">
																				<div id="formInline" class="form-inline">
																					<div class="checkbox-list invitedManuscript">
																						<c:choose>
																							<c:when test="${manuscript.invite == true}">
																								<input type="checkbox" name="invite"  value="1" data-title="Invited Manuscript" checked/>
																							</c:when>
																							<c:otherwise>
																								<input type="checkbox" name="invite"  value="1" data-title="Invited Manuscript"/>
																							</c:otherwise>
																						</c:choose>
																						<spring:message code="manuscript.inviteManuscript.text"/>
																					</div>
																				</div>
																			</fieldset>
																		</div>
																	</div>
																</div>
															</div>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${manuscript.invite == true}">
																	<input type="hidden" name="invite"  value="1"/>
																</c:when>
																<c:otherwise>
																	<input type="hidden" name="invite"  value="0"/>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</div>
												<br/>
												<br/>
												<div class="row">
													<div class="col-md-offset-2 col-md-9">
														<div class="row">
															<div class="col-md-5 formRight">
																<div id="way"></div>
																<button type="button" id="back" class="btn default btn-previous disabled">
																	<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
																</button>
															</div>
															<div class="col-md-offset-1 col-md-6 pull-left">
																<button type="button" id="saveAndContinue" class="btn blue btn-next">
																	<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
																</button>
															</div>
														</div>
													</div>
												</div>
												<br/>
												<br/>
											</div>
										</div>
									</form>
								</div>
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
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/bootstrap-tagsinput.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap2-typeahead.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/components-form-tools.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/submitFormWizard.js" type="text/javascript"></script>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.keywordRequired'] = "<spring:message code='author.newPaperSubmit.keywordRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['system.error.maxlength'] = "<spring:message code='system.error.maxlength' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.divisionRequired'] = "<spring:message code='author.newPaperSubmit.divisionRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.manuscriptTypeRequired'] = "<spring:message code='author.newPaperSubmit.manuscriptTypeRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.enterTitle'] = "<spring:message code='author.newPaperSubmit.enterTitle' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.enterRunninghead'] = "<spring:message code='author.newPaperSubmit.enterRunninghead' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.enterAbstract'] = "<spring:message code='author.newPaperSubmit.enterAbstract' javaScriptEscape='true' />";

var minLength = jQuery.validator.format(errorMessages['author.newPaperSubmit.minLength']);
var maxLength = jQuery.validator.format(errorMessages['system.error.maxlength']);

var form = $('#submit_form');
var titleSuccess = true;
var absSuccess = true;
var keywordSuccess = true;
var runningHeadSuccess = true;
var title = $('#title');
var runningHead = $('#runningHead');
var abs = $('#maxlength_textarea');
var tags = $('#tags_2');

jQuery(document).ready(function() {
	ComponentsFormTools.init();
	SubmitFormWizard.init("${baseUrl}/journals/${jnid}", "${manuscript.submitStep}", 1);
	var track = $('.manuscriptTrackSelect').children("option:selected").val();
	if(track == 0)
		$('#speicalIssueDiv').hide();
	else
		$('#speicalIssueDiv').show();
	var divisionManaged = "${divisionManaged}";
	var divisionSelected = false;
	var manuscriptTypeSelected = false;
	var specialIssueSelected = false;
	var runningHeadRequired = false;
	var keywordRequired = false;
	
	<c:if test="${jc.requiredRunninghead == true}">
		runningHeadRequired = true;
	</c:if>
	<c:if test="${jc.requiredKeyword == true}">
		keywordRequired = true;
	</c:if>
	
	
	<c:if test="${manuscript.revisionCount == 0 or jc.changeKeyword == true }">
	var tags = $("#tags_2");
	tags.tagsinput({
		confirmKeys: [13, 44, 59, 186, 188],
		onTagExists: function(item, $tag) {
			bootbox.alert("<spring:message code='author.newPaperSubmit.keywordExistErrot1'/>" + item + "<spring:message code='author.newPaperSubmit.keywordExistErrot2'/>");
		},
		tagClass: function(item) {
			return 'label label-info';
		},
	});
	$("a[href='#tab_1_2']").click(function() {
		tags.tagsinput('focus');
		return true;
	});
	</c:if>

	<c:if test="${manuscript.revisionCount == 0 or jc.changeDivision == true }">
	if(divisionManaged) {
		$(".divisionSelect").select2({
			allowClear: true,
			dropdownAutoWidth: true,
			escapeMarkup: function (m) {
				return m;
			},
			containerCssClass: "muted"
		});
	}
	</c:if>
	$(".manuscriptTypeSelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	<c:if test="${manuscript.revisionCount == 0 }">
	$(".manuscriptTrackSelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$(".specialIssueSelect").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$(".manuscriptTrackSelect").change(function(event) {
		var track = $(this).children("option:selected").val();
		if(track == 1) {
			$('#speicalIssueDiv').show('normal');
		} else
			$('#speicalIssueDiv').hide('normal');
	});
	</c:if>
	
 	$("#title").on('change keyup paste', function() {
		var title = $('#title');
		if(title.val().length <= 5 || title.val().length > 500) {
			if(title.val().length == 0)
				$('#title-help-block').text(errorMessages['author.newPaperSubmit.enterTitle']);
			else if(title.val().length <= 5)
				$('#title-help-block').text(minLength(5));
			else
				$('#title-help-block').text(maxLength(500));
			titleSuccess = false;
		} else
			titleSuccess = true;
		
		if(!titleSuccess) {
			title.removeClass('has-success').addClass('has-error');
			title.closest('.portlet-body').removeClass('has-success').addClass('has-error');
		} else {
			$('#title-help-block').text("");
			title.removeClass('has-error').addClass('has-success');
			title.closest('.portlet-body').removeClass('has-error').addClass('has-success');
		}
	});
 	if(runningHeadRequired) {
	 	$("#runningHead").on('change keyup paste', function() {
			var runningHead = $('#runningHead');
			if(runningHead.val().length <= 5 || runningHead.val().length > 500) {
				if(runningHead.val().length == 0)
					$('#runningHead-help-block').text(errorMessages['author.newPaperSubmit.enterRunninghead']);
				else if(runningHead.val().length <= 5)
					$('#runningHead-help-block').text(minLength(5));
				else
					$('#runningHead-help-block').text(maxLength(500));
				runningHeadSuccess = false;
			} else
				runningHeadSuccess = true;
			
			if(!runningHeadSuccess) {
				runningHead.removeClass('has-success').addClass('has-error');
				runningHead.closest('.portlet-body').removeClass('has-success').addClass('has-error');
			} else {
				$('#runningHead-help-block').text("");
				runningHead.removeClass('has-error').addClass('has-success');
				runningHead.closest('.portlet-body').removeClass('has-error').addClass('has-success');
			}
		});
 	}
 	$("#maxlength_textarea").on('change keyup paste', function() {
		var abs = $('#maxlength_textarea');
		if(abs.val().length <= 5 || abs.val().length > 4000) {
			if(abs.val().length == 0)
				$('#abs-help-block').text(errorMessages['author.newPaperSubmit.enterAbstract']);
			else if(abs.val().length <= 5)
				$('#abs-help-block').text(minLength(5));
			else
				$('#abs-help-block').text(maxLength(4000));
			absSuccess = false;
		} else
			absSuccess = true;
		
		if(!absSuccess) {
			abs.removeClass('has-success').addClass('has-error');
			abs.closest('.portlet-body').removeClass('has-success').addClass('has-error');
		} else {
			$('#abs-help-block').text("");
			abs.removeClass('has-error').addClass('has-success');
			abs.closest('.portlet-body').removeClass('has-error').addClass('has-success');
		}
	});
	
	$("#saveAndContinue").click(function(event) {
		event.preventDefault();
		$('#way').html('<input type="hidden" name="way" value="Forward"/>');

		

		<c:if test="${jc.requiredKeyword == true and manuscript.revisionCount == 0 or jc.changeKeyword == true }">
		var keywords = tags.val();
		var keywordsArray = keywords.split(',');
		var realLength = 0;
		for(var i = 0; i < keywordsArray.length; i++)
			if(keywordsArray[i].trim() != '')
				realLength = realLength + 1;
		
		if(keywordRequired == true && realLength == 0)
			keywordSuccess = false;
		
		</c:if>
		
		if(title.val().length <= 5 || title.val().length > 500) {
			if(title.val().length == 0)
				$('#title-help-block').text(errorMessages['author.newPaperSubmit.enterTitle']);
			else if(title.val().length <= 5)
				$('#title-help-block').text(minLength(5));
			else
				$('#title-help-block').text(maxLength(500));
			titleSuccess = false;
		} else
			titleSuccess = true;
		
		if(!titleSuccess) {
			title.removeClass('has-success').addClass('has-error');
			title.closest('.portlet-body').removeClass('has-success').addClass('has-error');
		} else {
			$('#title-help-block').text("");
			title.removeClass('has-error').addClass('has-success');
			title.closest('.portlet-body').removeClass('has-error').addClass('has-success');
		}
		
		if(runningHeadRequired == true && (runningHead.val().length <= 5 || runningHead.val().length > 500)) {
			if(runningHead.val().length == 0)
				$('#runningHead-help-block').text(errorMessages['author.newPaperSubmit.enterRunninghead']);
			else if(runningHead.val().length <= 5)
				$('#runningHead-help-block').text(minLength(5));
			else
				$('#runningHead-help-block').text(maxLength(500));
			runningHeadSuccess = false;
		} else
			runningHeadSuccess = true;
		
		if(!runningHeadSuccess) {
			runningHead.removeClass('has-success').addClass('has-error');
			runningHead.closest('.portlet-body').removeClass('has-success').addClass('has-error');
		} else {
			$('#runningHead-help-block').text("");
			runningHead.removeClass('has-error').addClass('has-success');
			runningHead.closest('.portlet-body').removeClass('has-error').addClass('has-success');
		}
		
		if(abs.val().length <= 5 || abs.val().length > 4000) {
			if(abs.val().length == 0)
				$('#abs-help-block').text(errorMessages['author.newPaperSubmit.enterAbstract']);
			else if(abs.val().length <= 5)
				$('#abs-help-block').text(minLength(5));
			else
				$('#abs-help-block').text(maxLength(4000));
			absSuccess = false;
		} else
			absSuccess = true;
		
		if(!absSuccess) {
			abs.removeClass('has-success').addClass('has-error');
			abs.closest('.portlet-body').removeClass('has-success').addClass('has-error');
		} else {
			$('#abs-help-block').text("");
			abs.removeClass('has-error').addClass('has-success');
			abs.closest('.portlet-body').removeClass('has-error').addClass('has-success');
		}
		
		<c:if test="${manuscript.revisionCount == 0 or jc.changeKeyword == true }">
		if(!keywordSuccess) {
			tags.closest('.portlet-body').removeClass('has-success').addClass('has-error');
			$('#kewordDiv').removeClass('keyword-has-success').addClass('keyword-has-error');
			$(".bootstrap-tagsinput").css("border", "1px solid #a94442");
		}
		</c:if>
		<c:if test="${manuscript.revisionCount > 0 and jc.changeKeyword == false }">
			keywordSuccess = true;
		</c:if>
		if(titleSuccess && absSuccess && keywordSuccess && runningHeadSuccess) {
			title.removeClass('has-error').addClass('has-success');
			title.closest('.portlet-body').removeClass('has-error').addClass('has-success');
			
			if(runningHeadRequired) {
				runningHead.removeClass('has-error').addClass('has-success');
				runningHead.closest('.portlet-body').removeClass('has-error').addClass('has-success');
			}
			
			abs.removeClass('has-error').addClass('has-success');
			abs.closest('.portlet-body').removeClass('has-error').addClass('has-success');
			<c:if test="${manuscript.revisionCount == 0 or jc.changeKeyword == true }">
				tags.closest('.portlet-body').removeClass('has-error').addClass('has-success');
				$('#keywordDiv').removeClass('keyword-has-error').addClass('keyword-has-success');
				$('.bootstrap-tagsinput').css("border", "0px");
			</c:if>
			form.submit();
		}
	});
});
</script>
</footer>
</body>
</html>