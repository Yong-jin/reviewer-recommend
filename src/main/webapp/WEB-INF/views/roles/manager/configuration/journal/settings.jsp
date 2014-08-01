<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="manager.config.journalManagement"/></title>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/select2/select2-metronic.css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-datetimepicker/css/datetimepicker.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-editable/bootstrap-editable/css/bootstrap-editable.css"/>
<link rel="stylesheet" type="text/css" href="${baseUrl}/assets/plugins/bootstrap-editable/inputs-ext/address/address.css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/corporate/imgareaselect-default.css" rel="stylesheet" type="text/css" />
<!-- END PLUGINS USED BY X-EDITABLE -->
<!-- BEGIN THEME STYLES -->

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<input type="hidden" id="jnid" value="${jnid }"/>
<input type="hidden" id="baseUrl" value="${baseUrl }"/>
<body>
<c:if test="${pageType == 'setup' }">
<%@ include file="/WEB-INF/views/includes/headerBarEmpty.jsp" %>
</c:if>
<c:if test="${pageType == 'settings' }">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
</c:if>
<div class="page-container">
 <div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<c:if test="${pageType == 'setup' }">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/manager/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/manager/configuration/journal/step1" label_3="manager.config.journalManagement"/>
				</c:if>
				<c:if test="${pageType == 'settings' }">
				<br/><br/>
				</c:if>
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<c:if test="${pageType != 'settings' and jc.setupStep >= 0}">
							<li <c:if test="${pageType == 'setup' and step == '0'}">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_0" data-toggle="tab">
									<spring:message code="manager.config.tab.0"/>
								</a>
							</li>
						</c:if>
						<c:if test="${(pageType == 'setup' and jc.setupStep >= 1) or pageType == 'settings'}">
							<li <c:if test="${(pageType == 'setup' and step == '1') or pageType == 'settings'}">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_1" data-toggle="tab">
									<spring:message code="manager.config.tab.1"/>
								</a>
							</li>
						</c:if>
						<c:if test="${(pageType == 'setup' and jc.setupStep >= 2) or pageType == 'settings'}">
							<li <c:if test="${pageType == 'setup' and step == '2' }">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_2" data-toggle="tab">
									<spring:message code="manager.config.tab.2"/>
								</a>
							</li>
						</c:if>
						<c:if test="${(pageType == 'setup' and jc.setupStep >= 3) or pageType == 'settings'}">
							<li <c:if test="${pageType == 'setup' and step == '3' }">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_3" data-toggle="tab">
									<spring:message code="manager.config.tab.3"/>
								</a>
							</li>
						</c:if>
						<c:if test="${(pageType == 'setup' and jc.setupStep >= 4) or pageType == 'settings'}">
							<li <c:if test="${pageType == 'setup' and step == '4' }">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_4" data-toggle="tab">
									<spring:message code="manager.config.tab.4"/>
								</a>
							</li>
						</c:if>
						<c:if test="${(pageType == 'setup' and jc.setupStep >= 5) or pageType == 'settings'}">
							<li <c:if test="${pageType == 'setup' and step == '5' }">class="active"</c:if>>
								<a class="stepClick" href="#tab_1_5" data-toggle="tab">
									<spring:message code="manager.config.tab.5"/>
								</a>
							</li>
						</c:if>
					</ul>
					
					<div class="tab-content">
						<c:if test="${pageType != 'settings' and step == '0' }">
							<div class="tab-pane submitManuscriptTab active" id="tab_1_0">
								<div class="row">
									<div class="col-md-12">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td style="width:15%">
													</td>
													<td style="width:50%">
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
														
														</form:form>
													</td>
													<td style="width:35%">
														<span class="text-muted">
															
														</span>
													</td>
												</tr>
											</tbody>
										</table>
										<c:if test="${pageType == 'setup' }">
											<br/>
											<div class="row">
												<div class="col-md-offset-2 col-md-9">
													<div class="row">
														<div class="col-md-5 formRight">
															<div id="way"></div>
															<button type="button" class="btn default btn-previous disabled">
																<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
															</button>
														</div>
														<div class="col-md-offset-1 col-md-6 pull-left">
															<button type="submit" class="btn blue btn-next" onClick='moveTo("${step}", "forward");'>
																<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
															</button>
														</div>
													</div>
												</div>
											</div>
											<br/>
										</c:if>
									</div>
								</div>
							</div>
						</c:if>
						<div class="tab-pane submitManuscriptTab <c:if test="${(pageType == 'setup' and step == '1') or pageType == 'settings'}">active</c:if>" id="tab_1_1">
							<form:form method="post" modelAttribute="journal" id="submit_form" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td style="width:15%">
													 <spring:message code="journal.type"/>
												</td>
												<td style="width:50%">
													<select name="type" id="select2_journalType" class="select2 form-control">
														<option value="A"><spring:message code="system.typeA"/></option>
														<option value="B"><spring:message code="system.typeB"/></option>
														<option value="C"><spring:message code="system.typeC"/></option>
														<option value="D"><spring:message code="system.typeD"/></option>
													</select>
												</td>
												<td style="width:35%">
													<span class="text-muted">
														<div class="btn-group">
															<a class="btn btn-default btn-sm" id="ajax-typeA" data-toggle="modal">
																 A
															</a>
															<a class="btn btn-default btn-sm" id="ajax-typeB" data-toggle="modal">
																 B
															</a>
															<a class="btn btn-default btn-sm" id="ajax-typeC" data-toggle="modal">
																 C
															</a>
															<a class="btn btn-default btn-sm" id="ajax-typeD" data-toggle="modal">
																 D
															</a>
															<button class="btn btn-default btn-sm" disabled style="border:0px">
																 <spring:message code="system.clickToSeeServiceDetails"/>
															</button>
														</div>
													</span>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.category"/>
												</td>
												<td>
													<select name="journalCategory" id="select2_upperCategory" class="select2 form-control">
														<c:forEach var="index" begin="0" end="7" step="1">
															<option value="${index}"><spring:message code="journal.category.${index }"/></option>
														</c:forEach>
													</select>
												</td>
												<td>
													<span class="text-muted">
														 
													</span>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.lowerCategory"/><br/><br/>
													 <small>1) <spring:message code="journal.lowerCategoryDesc1"/></small><br/>
													 <small>2) <spring:message code="journal.lowerCategoryDesc2"/></small>
												</td>
												<td>
													<select id="lowerCategory" multiple class="form-control lowerCategory">
													</select>
												</td>
												<td>
													<span id="currentLowerCategory" class="text-muted">
														 
													</span>
												</td>
											</tr>
											
											<tr>
												<td>
													 <spring:message code="journal.title"/>
												</td>
												<td>
													<a href="#" id="title" data-type="text" data-pk="1" data-original-title="Enter <spring:message code="journal.title"/>">
														 ${journal.title }
													</a>
												</td>
												<td rowspan="6">
													<span class="text-muted">
														 
													</span>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.shortTitle"/>
												</td>
												<td>
													<a href="#" id="shortTitle" data-type="text" data-pk="1" data-original-title="Enter <spring:message code="journal.shortTitle"/>">
														 ${journal.shortTitle }
													</a>
												</td>

											</tr>
											<tr>
												<td>
													 <spring:message code="journal.homepage"/>
												</td>
												<td>
													<a href="#" id="homepage" data-type="text" data-pk="1" data-original-title="Enter <spring:message code="journal.homepage"/>">
														 ${journal.homepage }
													</a>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.organization"/>
												</td>
												<td>
													<a href="#" id="organization" data-type="text" data-pk="1" data-original-title="Enter <spring:message code="journal.organization"/>">
														 ${journal.organization }
													</a>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.publisherCountry"/>
												</td>
												<td>
													<select name="countryCode" id="select2_country" class="select2 form-control">
														<%@ include file="/WEB-INF/views/includes/country.jsp" %>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.language"/>
												</td>
												<td>
													<select name="languageCode" id="select2_language" class="select2 form-control">
														<option value="<%=SystemConstants.englishLanguageCode%>"><spring:message code="system.english"/></option>
														<option value="<%=SystemConstants.koreanLanguageCode%>"><spring:message code="system.korean"/></option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="journal.coverImage"/>
												</td>
												<td class="cellCenter">
													<div class="form-group">
														<div class="form-sub-group-image">
															<div class="col-md-12">
																<div class="btn-group">
																<span class="btn btn-default fileinput-button" style="float:left">
																	<i class="fa fa-plus"></i>
																	<span>
																		 <spring:message code="author.newPaperSubmit.addAndUpload"/>
																	</span>
																	<input type="file" id="file" name="coverImage">
						
																</span>
																<div id="coverImageSaveButton" style="float:left">
																	<button type="button" id="saveImage" class="btn blue btn-next">
																		<i class="fa fa-floppy-o"></i> <spring:message code="journal.saveImage"/>
																	</button>
																</div>
																</div>
																<span class="help-block" id="coverImage">
																	JPG, JPEG, GIF or PNG (max size: 2MB)
																</span>	

																<br/>							   	
															    <div class="uploadImageFrameBefore" id="upload" style="margin-left: 10px">
															    	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
															    	<spring:message code="system.notAvailable2"/>
															    	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
															    </div>
															    <span class="help-block">
															    	<strong class="cropMessage">Select a rectangular area of the above image by moving or resizing the selection area</strong>
															    </span>
															    <br/><br/>
															</div>
														</div>

													</div>
													<input type="hidden" name="x1" value="" />
													<input type="hidden" name="y1" value="" />
													<input type="hidden" name="x2" value="" />
													<input type="hidden" name="y2" value="" />
													<input type="hidden" name="w" value="" />
													<input type="hidden" name="h" value="" />
													<input type="hidden" name="imgName" value="" />
												</td>
												<td>
													<div class="col-md-12 currentPreviewDiv">
														<div class="center">
															<br/><br/>
															<h4 style="margin-top:10px !important"><spring:message code="journal.currentImage"/>:</h4>
															<img src="${baseUrl}/images/coverImages/${journal.coverImageFilename}" class="img-responsive" alt=""/>
														</div>															
													</div>
													<div class="col-md-12 previewDiv">
														<div class="center">
															<h4>Note:</h4>
															 <spring:message code="system.note.coverImage"/><br/><br/>
															<div class="preview col-md-offset-4" id="preview" style="margin-left: 40px !important">
															</div>
														</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
									<c:if test="${pageType == 'setup' }">
										<br/>
										<div class="row">
											<div class="col-md-offset-2 col-md-9">
												<div class="row">
													<div class="col-md-5 formRight">
														<div id="way"></div>
														<button type="button" class="btn default btn-previous"  onClick='moveTo("${step}", "backward");'>
															<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
														</button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button type="button" class="btn blue btn-next" onClick='moveTo("${step}", "forward");'>
															<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
										<br/>
									</c:if>
								</div>
							</div>
							</form:form>
						</div>
						<div class="tab-pane submitManuscriptTab <c:if test="${pageType == 'setup' and step == '2'}">active</c:if>" id="tab_1_2">
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td style="width:20%">
													<spring:message code="author.newPaperSubmit.alertMessage.1"/>
												</td>
												<td style="width:50%">
													<a href="#" id="textBasicInfo" data-type="text" data-pk="1" data-original-title="Enter Notes for Basic Information">
														${jc.textBasicInfo }
													</a>
												</td>
												<td style="width:30%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td style="width:10%">
													<spring:message code="author.newPaperSubmit.alertMessage.2"/>
												</td>
												<td style="width:60%">
													<a href="#" id="textCoAuthor" data-type="text" data-pk="1" data-original-title="Enter Notes for CoAuthors">
														${jc.textCoAuthor }
													</a>
												</td>
												<td style="width:30%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td style="width:10%">
													<spring:message code="author.newPaperSubmit.alertMessage.3-1"/><br/>- <spring:message code="author.newPaperSubmit.coverLetter"/>
												</td>
												<td style="width:60%">
													<a href="#" id="textCoverLetter" data-type="text" data-pk="1" data-original-title="Enter Notes for Cover Letter">
														${jc.textCoverLetter }
													</a>
												</td>
												<td style="width:30%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td style="width:10%">
													<spring:message code="author.newPaperSubmit.alertMessage.3-2"/><br/>- <spring:message code="manuscript.reviewerPreference"/>
												</td>
												<td style="width:60%">
													<a href="#" id="textRp" data-type="text" data-pk="1" data-original-title="Enter Notes for Reviewer Preference">
														${jc.textRp }
													</a>
												</td>
												<td style="width:30%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td style="width:10%">
													<spring:message code="author.newPaperSubmit.alertMessage.4"/>
												</td>
												<td style="width:60%">
													<a href="#" id="textFiles" data-type="text" data-pk="1" data-original-title="Enter Notes for Files">
														 ${jc.textFiles }
													</a>
												</td>
												<td style="width:30%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.numConfirmations"/>
												</td>
												<td>
													<a href="#" id="numberOfConfirms" data-type="text" data-pk="1" data-original-title="Enter Number of Confirmations">
														 ${jc.numberOfConfirms }
													</a>
												</td>
												<td id="numberOfConfirmsPreview" rowspan="${jc.numberOfConfirms + 1}">
													<span class="text-muted"><%-- <spring:message code="manager.config.preview"/> --%>
													</span>
												</td>
											</tr>
											<tr class="confirmsTr confirmShow1">
												<td>
													<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.confirmation"/> 1</p>
												</td>
												<td>
													<a href="#" id="confirm1" data-type="text" data-pk="1" data-original-title="Enter Confirm1">
														 ${jc.confirm1 }
													</a>
												</td>
											</tr>
											<tr class="confirmsTr confirmShow2">
												<td>
													<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.confirmation"/> 2
												</td>
												<td>
													<a href="#" id="confirm2" data-type="text" data-pk="1" data-original-title="Enter Confirm2">
														 ${jc.confirm2 }
													</a>
												</td>
											</tr>
											<tr class="confirmsTr confirmShow3">
												<td>
													<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.confirmation"/> 3
												</td>
												<td>
													<a href="#" id="confirm3" data-type="text" data-pk="1" data-original-title="Enter Confirm3">
														 ${jc.confirm3 }
													</a>
												</td>
											</tr>
											<tr class="confirmsTr confirmShow4">
												<td>
													<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.confirmation"/> 4
												</td>
												<td>
													<a href="#" id="confirm4" data-type="text" data-pk="1" data-original-title="Enter Confirm4">
														 ${jc.confirm4 }
													</a>
												</td>
											</tr>
											<tr class="confirmsTr confirmShow5">
												<td>
													<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="author.newPaperSubmit.confirmation"/> 5
												</td>
												<td>
													<a href="#" id="confirm5" data-type="text" data-pk="1" data-original-title="Enter Confirm5">
														 ${jc.confirm5 }
													</a>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.authorInfoAllow"/>
												</td>
												<td>
 													<input type="radio" name="reviewerViewAuthor" class="reviewerViewAuthorOrNot" style="margin-left:-5px" value="1" <c:if test="${jc.reviewerViewAuthor == true }">checked="checked"</c:if>/><spring:message code="system.yes"/>
													<input type="radio" name="reviewerViewAuthor" class="reviewerViewAuthorOrNot" style="margin-left:-5px" value="0" <c:if test="${jc.reviewerViewAuthor == false }">checked="checked"</c:if>/><spring:message code="system.no"/>
												</td>
												<td>
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.requirements"/>
												</td>
												<td>
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="author.newPaperSubmit.manuscriptTrack" /></br>
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="author.newPaperSubmit.manuscriptType" /></br> 
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="manuscript.title" /></br>
 													<input type="checkbox" name="requiredRunninghead" value="1" class="requirements form-control" <c:if test="${jc.requiredRunninghead == true }">checked</c:if>/> <spring:message code="manuscript.runningHead"/> <br/>
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="manuscript.abstract" /></br>
													<input type="checkbox" name="requiredKeyword" value="1" class="requirements form-control" <c:if test="${jc.requiredKeyword == true }">checked</c:if>/> <spring:message code="manuscript.keywords"/> <br/>
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="author.newPaperSubmit.tabMenu.2" /></br>
													<input type="checkbox" name="requiredCoverletter" value="1" class="requirements form-control" <c:if test="${jc.requiredCoverletter == true }">checked</c:if>/> <spring:message code="author.newPaperSubmit.coverLetter"/> <br/>
													<input type="checkbox" name="requiredRp" value="1" class="requirements form-control" <c:if test="${jc.requiredRp == true }">checked</c:if>/> <spring:message code="manuscript.reviewerPreference"/> <br/>
													<input type="checkbox" checked="checked" disabled="disabled" /> <spring:message code="manuscript.manuscriptFiles" /></br>
													<input type="checkbox" name="requiredAdditionalFiles" id="requiredAdditionalFiles" value="1" class="requirements form-control" <c:if test="${jc.requiredAdditionalFiles == true }">checked</c:if>/> <spring:message code="manuscript.additionalFiles"/> <br/>
												</td>
												<td>
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr class="additionalFilesOptionsView">
												<td>
													<spring:message code="manager.config.frontCoverAllow"/>
													<br/><br/>
												</td>
												<td>
													<c:set var="frontCoverManaging" value="false"/>
													<c:if test="${jc.frontCoverUrl != null or fn:trim(jc.frontCoverUrl) != ''}">
														<c:set var="frontCoverManaging" value="true"/>
													</c:if>
													<input type="radio" name="frontCoverManage" class="frontCoverManageOrNot additionalFilesOption" style="margin-left:-5px" value="1" <c:if test="${frontCoverManaging == true }">checked="checked"</c:if>/><spring:message code="system.yes"/>
													<input type="radio" name="frontCoverManage" class="frontCoverManageOrNot additionalFilesOption" style="margin-left:-5px" value="0" <c:if test="${frontCoverManaging == false }">checked="checked"</c:if>/><spring:message code="system.no"/>
												</td>
												<td>
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr id="frontCoverManageView" class="additionalFilesOptionsView">
												<td>
													<spring:message code="author.newPaperSubmit.additionalFileDesignation.0"/>
													<br/><br/>
												</td>
												<td>
													<input type="radio" class="<%=SystemConstants.fileTypeFC %>Radio" name="<%=SystemConstants.fileTypeFC %>Radio" style="margin-left:-5px" value="upload" checked><spring:message code="system.upload"/>
													<input type="radio" class="<%=SystemConstants.fileTypeFC %>Radio" name="<%=SystemConstants.fileTypeFC %>Radio" style="margin-left:-5px" value="paste"> <spring:message code="system.paste"/>
													<br/><br/>
													<div id="<%=SystemConstants.fileTypeFC %>UploadedFileView">
													</div>
													<br/>
													<div id="<%=SystemConstants.fileTypeFC %>UploadView">
														<form id="<%=SystemConstants.fileTypeFC %>Upload" enctype="multipart/form-data">
															<span class="btn btn-default btn-xs fileinput-button">
																<i class="fa fa-plus"></i>
																<span>
																	 <spring:message code="author.newPaperSubmit.addAndUpload"/>
																</span>
																<input type="hidden" name="designation" value="<%=SystemConstants.fileTypeFC %>"/>
																<input type="file" name="files">
															</span>
														</form>
													</div>
													<div id="<%=SystemConstants.fileTypeFC %>PasteView">
														<a href="#" id="<%=SystemConstants.fileTypeFC %>Url" data-type="text" data-pk="1" data-original-title="Paste Front Cover Template Url">
															 ${jc.frontCoverUrl }
														</a>
													</div>
												</td>
												<td>
													<span class="text-muted">
														<spring:message code="manager.config.currentFrontCover"/> URL: <br/><a href="#" id="current<%=SystemConstants.fileTypeFC %>Url"> ${jc.frontCoverUrl }</a>
													</span>
												</td>
											</tr>
											<tr class="additionalFilesOptionsView">
												<td>
													<spring:message code="manager.config.checkListAllow"/>
													<br/><br/>
												</td>
												<td>
													<c:set var="checkListManaging" value="false"/>
													<c:if test="${jc.checkListUrl != null or fn:trim(jc.checkListUrl) != ''}">
														<c:set var="checkListManaging" value="true"/>
													</c:if>
													<input type="radio" name="checkListManage" class="checkListManageOrNot additionalFilesOption" style="margin-left:-5px" value="1" <c:if test="${checkListManaging == true }">checked="checked"</c:if>/><spring:message code="system.yes"/>
													<input type="radio" name="checkListManage" class="checkListManageOrNot additionalFilesOption" style="margin-left:-5px" value="0" <c:if test="${checkListManaging == false }">checked="checked"</c:if>/><spring:message code="system.no"/>
												</td>
												<td>
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<tr id="checkListManageView" class="additionalFilesOptionsView">
												<td>
													<spring:message code="author.newPaperSubmit.additionalFileDesignation.1"/>
												</td>
												<br/>
												<td>
													<input type="radio" class="<%=SystemConstants.fileTypeCHK %>Radio" name="<%=SystemConstants.fileTypeCHK %>Radio" style="margin-left:-5px" value="upload" checked><spring:message code="system.upload"/>
													<input type="radio" class="<%=SystemConstants.fileTypeCHK %>Radio" name="<%=SystemConstants.fileTypeCHK %>Radio" style="margin-left:-5px" value="paste"> <spring:message code="system.paste"/>
													<br/><br/>
													<div id="<%=SystemConstants.fileTypeCHK %>UploadedFileView">
													</div>
													<br/>
													<div id="<%=SystemConstants.fileTypeCHK %>UploadView">
														<form id="<%=SystemConstants.fileTypeCHK %>Upload" enctype="multipart/form-data">
															<span class="btn btn-default btn-xs fileinput-button">
																<i class="fa fa-plus"></i>
																<span>
																	 <spring:message code="author.newPaperSubmit.addAndUpload"/>
																</span>
																<input type="hidden" name="designation" value="<%=SystemConstants.fileTypeCHK %>"/>
																<input type="file" name="files">
		
															</span>
														</form>
													</div>
													<div id="<%=SystemConstants.fileTypeCHK %>PasteView">
														<a href="#" id="<%=SystemConstants.fileTypeCHK %>Url" data-type="text" data-pk="1" data-original-title="Paste Author Check List Url">
															 ${jc.checkListUrl }
														</a>
													</div>
												</td>
												<br/>
												<td>
													<span class="text-muted">
														<spring:message code="manager.config.currentAuthorCheckList"/> URL: <br/><a href="#" id="current<%=SystemConstants.fileTypeCHK %>Url"> ${jc.checkListUrl }</a>
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.allowAtRevision"/>
												</td>
												<td>
													<input type="checkbox" name="changeAuthor" value="1" class="allowChange form-control" <c:if test="${jc.changeAuthor == true }">checked</c:if>/> <spring:message code="manuscript.authors"/> <br/>
													<input type="checkbox" name="changeKeyword" value="1" class="allowChange form-control" <c:if test="${jc.changeKeyword == true }">checked</c:if>/> <spring:message code="manuscript.keywords"/> <br/>
													<c:if test="${jc.manageDivision == true }">
														<input type="checkbox" name="changeDivision" value="1" class="allowChange form-control" <c:if test="${jc.changeDivision == true }">checked</c:if>/> <spring:message code="manuscript.division"/> <br/>
													</c:if>
													<%-- <input type="checkbox" name="changeInvited" value="1" class="allowChange form-control" <c:if test="${jc.changeInvited == true }">checked</c:if>/> <spring:message code="manuscript.inviteManuscript"/> <br/> --%>
													<input type="checkbox" name="changeRp" value="1" class="allowChange form-control" <c:if test="${jc.changeRp == true }">checked</c:if>/> <spring:message code="manuscript.reviewerPreference"/> <br/>
													<input type="checkbox" name="changeAdditionalFiles" value="1" class="allowChange form-control" <c:if test="${jc.changeAdditionalFiles == true }">checked</c:if>/> <spring:message code="manuscript.additionalFiles"/> <br/>
												</td>
												<td>
													<span class="text-muted">
													</span>
												</td>
											</tr>
										</tbody>
									</table>
									<c:if test="${pageType == 'setup' }">
										<br/>
										<div class="row">
											<div class="col-md-offset-2 col-md-9">
												<div class="row">
													<div class="col-md-5 formRight">
														<div id="way"></div>
														<button type="button" class="btn default btn-previous"  onClick='moveTo("${step}", "backward");'>
															<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
														</button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button type="button" class="btn blue btn-next" onClick='moveTo("${step}", "forward");'>
															<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
										<br/>
									</c:if>
								</div>
							</div>
						</div>
						<div class="tab-pane submitManuscriptTab <c:if test="${pageType == 'setup' and step == '3'}">active</c:if>" id="tab_1_3">	
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td style="width:20%">
													<spring:message code="manager.config.numReviewItems"/>
												</td>
												<td style="width:45%; padding-left: 10px">
													<a href="#" id="numberOfReviewItems" data-type="text" data-pk="1" data-original-title="Enter Number of Review Items">
														 ${jc.numberOfReviewItems }
													</a>
												</td>
												<td style="width:35%">
													<span class="text-muted">
													</span>
												</td>
											</tr>
											<c:forEach var="index" begin="1" end="10" step="1">
												<tr class="reviewItemIdsTr reviewItemShow${index }">
													<td>
														<p class="indenTation10"> <i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;<spring:message code="manager.config.reviewItem"/> ${index }
													</td>
													<td>
														<select name="reviewItemId${index }" id="reviewItemId${index }" class="select2 form-control reviewItemSelect">
															<c:forEach var="reviewItemDesignation" items="${reviewItemDesignations }">
																<option value="${reviewItemDesignation.id }"><spring:message code="review.item.${reviewItemDesignation.id }"/></option>
															</c:forEach>
														</select>
													</td>
													<td>
														<span class="text-muted">
														</span>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<c:if test="${pageType == 'setup' }">
										<br/>
										<div class="row">
											<div class="col-md-offset-2 col-md-9">
												<div class="row">
													<div class="col-md-5 formRight">
														<div id="way"></div>
														<button type="button" class="btn default btn-previous"  onClick='moveTo("${step}", "backward");'>
															<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
														</button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button type="button" class="btn blue btn-next" onClick='moveTo("${step}", "forward");'>
															<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
										<br/>
									</c:if>
								</div>
							</div>
						</div>
						
						<div class="tab-pane submitManuscriptTab <c:if test="${pageType == 'setup' and step == '4'}">active</c:if>" id="tab_1_4">
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td style="width:30%">
													 <spring:message code="manager.config.reviewCompleteCount"/>
												</td>
												<td class="cellCenter" style="width:5%">
													<a href="#" id="reviewCompleteCount" data-type="text" data-pk="1" data-original-title="Enter Review Complete Count">
														 ${jc.reviewCompleteCount }
													</a>
												</td>
												<td style="width:65%">
													<span class="text-muted">
														 <spring:message code="manager.config.reviewCompleteCount.note"/> (<spring:message code="manager.config.defaultValue"/>: 3)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													 <spring:message code="manager.config.reviewDueDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="reviewDueDuration" data-type="text" data-pk="1" data-original-title="Enter Review Due Duration">
														 ${jc.reviewDueDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														 <spring:message code="manager.config.reviewDueDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 6 <spring:message code="system.weeks"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.assignRemindDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="assignRemindDuration" data-type="text" data-pk="1" data-original-title="Enter Assign Remind Duration">
														 ${jc.assignRemindDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.assignRemindDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 2 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.assignCancelDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="assignCancelDuration" data-type="text" data-pk="1" data-original-title="Enter Assign Cancel Duration">
														 ${jc.assignCancelDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.assignCancelDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 7 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.inviteRemindDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="inviteRemindDuration" data-type="text" data-pk="1" data-original-title="Enter Invite Remind Duration">
														 ${jc.inviteRemindDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.inviteRemindDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 2 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.inviteCancelDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="inviteCancelDuration" data-type="text" data-pk="1" data-original-title="Enter Invite Cancel Duration">
														 ${jc.inviteCancelDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.inviteCancelDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 2 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.resubmitDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="resubmitDuration" data-type="text" data-pk="1" data-original-title="Enter Resubmit Duration">
														 ${jc.resubmitDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.resubmitDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 30 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.cameraSubmitDuration"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="cameraSubmitDuration" data-type="text" data-pk="1" data-original-title="Enter Camera Submit Duration">
														 ${jc.cameraSubmitDuration }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.cameraSubmitDuration.note"/> (<spring:message code="manager.config.defaultValue"/>: 15 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.gentleRemindReviewer"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="gentleRemindReviewer" data-type="text" data-pk="1" data-original-title="Enter Gentle Remind Reviewer">
														 ${jc.gentleRemindReviewer }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.gentleRemindReviewer.note"/> (<spring:message code="manager.config.defaultValue"/>: 7 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.gentleRemindResubmit"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="gentleRemindResubmit" data-type="text" data-pk="1" data-original-title="Enter Gentle Remind Resubmit">
														 ${jc.gentleRemindResubmit }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.gentleRemindResubmit.note"/> (<spring:message code="manager.config.defaultValue"/>: 7 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.gentleCameraSubmit"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="gentleRemindCameraSubmit" data-type="text" data-pk="1" data-original-title="Enter Gentle Remind Camera Ready Submit">
														 ${jc.gentleRemindCameraSubmit }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.gentleCameraSubmit.note"/> (<spring:message code="manager.config.defaultValue"/>: 7 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.remindReviewer"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="remindReviewer" data-type="text" data-pk="1" data-original-title="Enter Remind Reviewer">
														 ${jc.remindReviewer }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.remindReviewer.note"/> (<spring:message code="manager.config.defaultValue"/>: 3 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.remindResubmit"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="remindResubmit" data-type="text" data-pk="1" data-original-title="Enter Remind Resubmit">
														 ${jc.remindResubmit }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.remindResubmit.note"/> (<spring:message code="manager.config.defaultValue"/>: 3 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.remindCameraSubmit"/>
												</td>
												<td class="cellCenter" >
													<a href="#" id="remindCameraSubmit" data-type="text" data-pk="1" data-original-title="Enter Remind Camera Submit">
														 ${jc.remindCameraSubmit }
													</a>
												</td>
												<td>
													<span class="text-muted">
														  <spring:message code="manager.config.remindCameraSubmit.note"/> (<spring:message code="manager.config.defaultValue"/>: 3 <spring:message code="system.days"/>)
													</span>
												</td>
											</tr>
										</tbody>
									</table>
									<c:if test="${pageType == 'setup' }">
										<br/>
										<div class="row">
											<div class="col-md-offset-2 col-md-9">
												<div class="row">
													<div class="col-md-5 formRight">
														<div id="way"></div>
														<button type="button" class="btn default btn-previous"  onClick='moveTo("${step}", "backward");'>
															<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
														</button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button type="button" class="btn blue btn-next" onClick='moveTo("${step}", "forward");'>
															<spring:message code="author.newPaperSubmit.saveAndContinue"/> <i class="m-icon-swapright m-icon-white"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
										<br/>
									</c:if>
								</div>
							</div>
						</div>
						<div class="tab-pane submitManuscriptTab <c:if test="${pageType == 'setup' and step == '5'}">active</c:if>" id="tab_1_5">
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td style="width:15%">
													<spring:message code="manager.config.cameraReadyTemplate"/>
												</td>
												<td style="width:50%">
													<input type="radio" class="<%=SystemConstants.fileTypeCT %>Radio" name="<%=SystemConstants.fileTypeCT %>Radio" style="margin-left:0px" value="upload" checked><spring:message code="system.upload"/>
													<input type="radio" class="<%=SystemConstants.fileTypeCT %>Radio" name="<%=SystemConstants.fileTypeCT %>Radio" style="margin-left:0px" value="paste"><spring:message code="system.paste"/>
													<br/><br/>
													<div id="<%=SystemConstants.fileTypeCT %>UploadedFileView">
													</div>
													<br/>
													<div id="<%=SystemConstants.fileTypeCT %>UploadView">
														<form id="<%=SystemConstants.fileTypeCT %>Upload" enctype="multipart/form-data">
															<span class="btn btn-default btn-xs fileinput-button">
																<i class="fa fa-plus"></i>
																<span>
																	 <spring:message code="author.newPaperSubmit.addAndUpload"/>
																</span>
																<input type="hidden" name="designation" value="<%=SystemConstants.fileTypeCT %>">
																<input type="file" name="files">
															</span>
														</form>
													</div>
													<div id="<%=SystemConstants.fileTypeCT %>PasteView">
														<a href="#" id="<%=SystemConstants.fileTypeCT %>Url" data-type="text" data-pk="1" data-original-title="Paste CameraReady Template Url">
															 ${jc.cameraReadyTemplateUrl }
														</a>
													</div>
												</td>
												<td style="width:35%">
													<span class="text-muted">
														<spring:message code="manager.config.currentCameraReadyTemplate"/> URL: <br/><a href="#" id="current<%=SystemConstants.fileTypeCT %>Url"> ${jc.cameraReadyTemplateUrl }</a>
													</span>
												</td>
											</tr>
											<tr>
												<td>
													<spring:message code="manager.config.copyrightForm"/>
												</td>
												<td>
													<input type="radio" class="<%=SystemConstants.fileTypeCP %>Radio" name="<%=SystemConstants.fileTypeCP %>Radio" style="margin-left:0px" value="upload" checked><spring:message code="system.upload"/>
													<input type="radio" class="<%=SystemConstants.fileTypeCP %>Radio" name="<%=SystemConstants.fileTypeCP %>Radio" style="margin-left:0px" value="paste"><spring:message code="system.paste"/>
													<br/><br/>
													<div id="<%=SystemConstants.fileTypeCP %>UploadedFileView">
													</div>
													<br/>
													<div id="<%=SystemConstants.fileTypeCP %>UploadView">
														<form id="<%=SystemConstants.fileTypeCP %>Upload" enctype="multipart/form-data">
															<span class="btn btn-default btn-xs fileinput-button">
																<i class="fa fa-plus"></i>
																<span>
																	 <spring:message code="author.newPaperSubmit.addAndUpload"/>
																</span>
																<input type="hidden" name="designation" value="<%=SystemConstants.fileTypeCP %>">
																<input type="file" name="files">
		
															</span>
														</form>
													</div>
													<div id="<%=SystemConstants.fileTypeCP %>PasteView">
														<a href="#" id="<%=SystemConstants.fileTypeCP %>Url" data-type="text" data-pk="1" data-original-title="Paste Copyright Form Url">
															 ${jc.copyrightFormUrl }
														</a>
													</div>
												</td>
												<br/>
												<td>
													<span class="text-muted">
														<spring:message code="manager.config.currentCopyrightForm"/> URL: <br/><a href="#" id="current<%=SystemConstants.fileTypeCP %>Url"> ${jc.copyrightFormUrl }</a>
													</span>
												</td>
											</tr>
										</tbody>
									</table>
									<c:if test="${pageType == 'setup' }">
										<br/>
										<div class="row">
											<div class="col-md-offset-2 col-md-9">
												<div class="row">
													<div class="col-md-5 formRight">
														<div id="way"></div>
														<button type="button" class="btn default btn-previous"  onClick='moveTo("${step}", "backward");'>
															<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
														</button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button type="button" class="btn green btn-next" onClick='moveTo("${step}", "forward");'>
															<spring:message code="author.newPaperSubmit.saveAndComplete"/> <i class="m-icon-swapright m-icon-white"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
										<br/>
									</c:if>
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
<div id="typeA-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeB-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeC-modal" class="modal container fade" tabindex="-1"></div>
<div id="typeD-modal" class="modal container fade" tabindex="-1"></div>
<%@ include file="/WEB-INF/views/roles/manager/configuration/journal/settingScripts.jsp" %>
</footer>
</body>
</html>