<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div class="dialogContainment">
	<div class="row">
		<div class="form form-horizontal">
			<div class="col-md-2">
				<ul class="ver-inline-menu tabbable margin-bottom-10">
					<li>
						<a class="backToTable">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-chevron-left"></i>
								</span>
								<span class="vertical-menu-info">
									<spring:message code="system.viewManuscriptList"/>
								</span>
							</span>
						</a>
						<span class="after">
						</span>
					</li>
					<li <c:if test="${v == 'summary'}">class="active"</c:if>>
						<a data-toggle="tab" class="${pageType}basicMenuClick" href="#${pageType }manuscriptSummary">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-list-ul "></i>
								</span>
								<span class="vertical-menu-info">
									<spring:message code="system.viewManuscriptSummary"/>
									<br/>
									<small>- 
										<c:if test="${manuscript.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
										<c:if test="${manuscript.revisionCount > 0 }"><spring:message code="system.revision"/> #${manuscript.revisionCount }</c:if>
									</small>
								</span>
							</span>
						</a>
						<span class="after">
						</span>
					</li>
					<c:if test="${not empty manuscript.decisions }">
						<c:forEach var="fd" varStatus="status" items="${manuscript.decisions}" >
							<c:set var="completed" value="false"/>
							<c:if test="${fd.revisionCount == status.index and fd.decision != 0 }">
								<c:set var="completed" value="true"/>
							</c:if>
							<c:if test="${completed == true}">
								<li>
									<a data-toggle="tab" class="${pageType}basicMenuClick" href="#${pageType }reviewScore${status.index }">
										<span class="vertical-menu">
											<span class="vertical-menu-icon">
												<i class="fa fa-pencil-square-o"></i>
											</span>
											<span class="vertical-menu-info">
												<spring:message code="system.reviewResult"/><br/>
												<small>- 
													<c:if test="${status.index == 0 }"><spring:message code="system.original"/></c:if>
													<c:if test="${status.index > 0 }"><spring:message code="system.revision"/> #${status.index }</c:if>
												</small>
											</span>
										</span>
									</a>
								</li>						
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${journal.paid == true and (pageType == 'accepted' or pageType == 'published')}">
						<c:if test="${manuscript.status != 'A'}">
							<li <c:if test="${v == 'cameraReady'}">class="active"</c:if>>
								<a data-toggle="tab" id="${pageType}cameraReadyClick" href="#${pageType}cameraReady">
									<span class="vertical-menu">
										<span class="vertical-menu-icon">
											<i class="fa fa-paperclip "></i>
										</span>
										<span class="vertical-menu-info">
											<c:if test="${manuscript.status == 'M' }">
												<spring:message code="manager.action.manageCameraReady"/>
											</c:if>
											<c:if test="${manuscript.status != 'M' }">
												<spring:message code="author.action.viewCameraReady"/>
											</c:if>
										</span>
									</span>
								</a>
								<span class="after">
								</span>
							</li>
							<c:if test="${manuscript.cameraReadyConfirm == true }">
								<li <c:if test="${v == 'galleryProof'}">class="active"</c:if>>
									<a data-toggle="tab" id="${pageType}galleryProofClick" href="#${pageType}galleryProof">
										<span class="vertical-menu">
											<span class="vertical-menu-icon">
												<i class="fa fa-thumb-tack  "></i>
											</span>
											<span class="vertical-menu-info">
												<c:choose>
													<c:when test="${manuscript.status == 'G' and manuscript.galleryProofConfirm == true}">
														<spring:message code="manager.action.changeToPub"/>
													</c:when>
													<c:otherwise>
														<c:if test="${manuscript.status == 'G' }">
															<spring:message code="manager.action.manageGalleryProof"/>
														</c:if>
														<c:if test="${manuscript.status != 'G' }">
															<spring:message code="author.action.viewGalleryProof"/>
														</c:if>
													</c:otherwise>
												</c:choose>
											</span>
										</span>
									</a>
									<span class="after">
									</span>
								</li>
							</c:if>
						</c:if>
					</c:if>
				</ul>
			</div>
			<div class="col-md-10">
				<div class="tab-content">
					<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }manuscriptSummary">
						<security:authorize ifAnyGranted="ROLE_MANAGER">
							<c:choose>
								<c:when test="${journal.paid == true and manuscript.status == 'I'}">
									<c:choose>
										<c:when test="${manuscript.manuscriptTrackId == 0 }">
											<div class="form-section">
												<h4><spring:message code="manager.action.pre-filteringAndconfirmWhileSeletingChiefEditor"/></h4>
												<div class="form-group">
													<label class="control-label col-md-2"><spring:message code="system.chiefEditorInCharge"/>:</label>
													<div class="col-md-9">
														<p class="form-control-static">
															<c:choose>
																<c:when test="${fn:length(chiefUsers) > 1 }">
																	<select id="chiefSelect" class="form-control input-sm select2 preFiltering">
																		<c:forEach var="chief" items="${chiefUsers }">
																			<option value="${chief.user.id }">
																			<c:choose>
																				<c:when test="${journal.languageCode == 'ko'}">
																					<c:if test="${fn:trim(chief.user.contact.localFullName) != ''}">
																						${chief.user.contact.localFullName}
																					</c:if>
																					<c:if test="${fn:trim(chief.user.contact.localFullName) == ''}">
																						${chief.user.contact.firstName} ${chief.user.contact.lastName} 
																					</c:if>
																				</c:when>
																				<c:otherwise>
																					${chief.user.contact.firstName} ${chief.user.contact.lastName} 
																				</c:otherwise>
																			</c:choose>
																			</option>
																		</c:forEach>
																	</select>
																</c:when>
																<c:otherwise>
																	<c:if test="${not empty chiefUsers }">
																		<c:choose>
																			<c:when test="${journal.languageCode == 'ko'}">
																				<c:if test="${fn:trim(chiefUsers[0].user.contact.localFullName) != ''}">
																					${chiefUsers[0].user.contact.localFullName}
																				</c:if>
																				<c:if test="${fn:trim(chiefUsers[0].user.contact.localFullName) == ''}">
																					${chiefUsers[0].user.contact.firstName } ${chiefUsers[0].user.contact.lastName }
																				</c:if>
																			</c:when>
																			<c:otherwise>
																				${chiefUsers[0].user.contact.firstName } ${chiefUsers[0].user.contact.lastName }
																			</c:otherwise>
																		</c:choose>
																		<input type="hidden" id="chiefId" value="${chiefUsers[0].user.id}"/>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</p>
													</div>
												</div>
												<div class="row">
													<div class="col-md-offset-2 col-md-10">
														<br/><br/>
														<div class="row">
															<div class="col-md-4 formRight">
																<button id="returnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="manager.action.returnBack"/></button>
															</div>
															<div class="col-md-offset-1 col-md-7 pull-left">
																<button id="confirm" class="btn green"><spring:message code="system.confirm"/> <i class="m-icon-swapright m-icon-white"></i></button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="form-section">
												<h4><spring:message code="manager.action.pre-filteringAndconfirm"/></h4>
												<div class="form-group">
													<label class="control-label col-md-2"><spring:message code="system.guestEditorInCharge"/></label>
													<div class="col-md-9">
														<p class="form-control-static">
															<c:choose>
																<c:when test="${journal.languageCode == 'ko'}">
																	<c:if test="${fn:trim(editor.contact.localFullName) != ''}">
																		${editor.contact.localFullName}
																	</c:if>
																	<c:if test="${fn:trim(editor.contact.localFullName) == ''}">
																		${editor.contact.firstName } ${editor.contact.lastName }
																	</c:if>
																</c:when>
																<c:otherwise>
																	${editor.contact.firstName } ${editor.contact.lastName }
																</c:otherwise>
															</c:choose>
														</p>
													</div>
												</div>
												<div class="row">
													<div class="col-md-offset-2 col-md-10">
														<br/><br/>
														<div class="row">
															<div class="col-md-5 formRight">
																<button id="returnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="manager.action.declineReturnBacktoAuthor"/></button>
															</div>
															<div class="col-md-offset-1 col-md-6 pull-left">
																<button id="confirm" class="btn green"><spring:message code="manager.action.confirmSubmission"/> <i class="m-icon-swapright m-icon-white"></i></button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:otherwise>
									</c:choose>

								</c:when>
								<c:when test="${journal.paid == true and manuscript.status == 'V'}">
									<div class="form-section">
										<h4><spring:message code="manager.action.pre-filteringAndconfirm"/></h4>
										<div class="form-group">
											<c:choose>
												<c:when test="${manuscript.manuscriptTrackId == 0 }">
													<label class="control-label col-md-2"><spring:message code="system.associateEditorInCharge"/></label>
												</c:when>
												<c:otherwise>
													<label class="control-label col-md-2"><spring:message code="system.guestEditorInCharge"/></label>
												</c:otherwise>
											</c:choose>
											<div class="col-md-9">
												<p class="form-control-static">
													<c:choose>
														<c:when test="${journal.languageCode == 'ko'}">
															<c:if test="${fn:trim(editor.contact.localFullName) != ''}">
																${editor.contact.localFullName}
															</c:if>
															<c:if test="${fn:trim(editor.contact.localFullName) == ''}">
																${editor.contact.firstName } ${editor.contact.lastName }
															</c:if>
														</c:when>
														<c:otherwise>
															${editor.contact.firstName } ${editor.contact.lastName }
														</c:otherwise>
													</c:choose>
												</p>
											</div>
										</div>
										<div class="row">
											<div class="col-md-offset-2 col-md-10">
												<br/><br/>
												<div class="row">
													<div class="col-md-5 formRight">
														<button id="returnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="manager.action.declineReturnBacktoAuthor"/></button>
													</div>
													<div class="col-md-offset-1 col-md-6 pull-left">
														<button id="revisedConfirm" class="btn green"><spring:message code="manager.action.confirmSubmission"/> <i class="m-icon-swapright m-icon-white"></i></button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:when>
							</c:choose>
							<br/>	
						</security:authorize>
						<customTagFile:manuscriptSummary locale="${locale}"/>
					</div>
					<%@ include file="/WEB-INF/views/roles/common/manuscripts/reviewResults.jsp" %>
					<c:if test="${journal.paid == true and (pageType == 'accepted' or pageType == 'published')}">
						<c:choose>
							<c:when test="${manuscript.status != 'A'}">
								<div class="tab-pane fade <c:if test="${v == 'cameraReady'}">active</c:if> in" id="${pageType}cameraReady">
									<div class="loadingCenter"><img src="images/loading.gif"/></div>
								</div>
								<c:if test="${manuscript.cameraReadyConfirm == true }">
									<div class="tab-pane fade <c:if test="${v == 'galleryProof'}">active</c:if> in" id="${pageType}galleryProof">
										<div class="loadingCenter"><img src="images/loading.gif"/></div>
									</div>
								</c:if>
							</c:when>
						</c:choose>
					</c:if>
				</div>
			</div>
		</div>			
	</div>
	<div id="returnBackDisplay" class="modalDialog"></div>
	<div id="cameraReadyReturnBackDisplay" class="modalDialog"></div>
</div>
<script src="${baseUrl}/js/roles/jquery-ui.js"></script>
<%@ include file="/WEB-INF/views/roles/common/manuscripts/viewScripts.jsp" %>
<script>
var cameraReadyConfirm = "${manuscript.cameraReadyConfirm}";
var galleryProofConfirm = "${manuscript.galleryProofConfirm}";
var errorMessages = new Array();
errorMessages['manager.action.writeReason'] = "<spring:message code='manager.action.writeReason' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";

function reviewerHistorySummaryView(revisionCount) {
	var summaryViewId = '#${pageType}' + revisionCount + 'reviewerHistorySummaryView';
	var summaryViewButtonId = '#${pageType}' + revisionCount + 'reviewerHistorySummaryButton';
	if($(summaryViewId).css("display") != "none") {
		$(summaryViewButtonId).html('<i class="fa fa-angle-down "></i>');
		$(summaryViewId).hide('normal');
	} else {
		$(summaryViewButtonId).html('<i class="fa fa-angle-up "></i>');
		$(summaryViewId).show('normal');
	}
}

$(document).ready(function() {
	$('.${pageType}reviewerHistorySummaryView').hide();
	$('.' + "${pageType}" + 'basicMenuClick').click(function(event) {
		$('#' + "${pageType}" + 'galleryProof').hide();
		$('#' + "${pageType}" + 'cameraReady').hide();
	});
	
	if(v == 'summary') {
		$('#' + "${pageType}" + 'galleryProof').hide();
		$('#' + "${pageType}" + 'cameraReady').hide();
	} else if(v == 'cameraReady') {
		var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/cameraReady/cameraReady";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'cameraReady').html(html).show('normal');
				$('#' + "${pageType}" + 'galleryProof').hide();
			}
		});
	} else if(v == 'galleryProof') {
		var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/galleryProof/galleryProof";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'galleryProof').html(html).show('normal');
				$('#' + "${pageType}" + 'cameraReady').hide();
			}
		});
	}
	
	$('#' + "${pageType}" + 'galleryProofClick').click(function(event) {
		var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/galleryProof/galleryProof";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'galleryProof').html(html).show('normal');
				$('#' + "${pageType}" + 'cameraReady').hide();
			}
		});
	});
	
	$('#' + "${pageType}" + 'cameraReadyClick').click(function(event) {
		var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/cameraReady/cameraReady";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'cameraReady').html(html).show('normal');
				$('#' + "${pageType}" + 'galleryProof').hide();
			}
		});
	});

	$("select.preFiltering").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$('#returnBack').click(function(event){
		event.preventDefault();
		var manuscriptId = "${manuscript.id}";
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/manager/manuscripts/returnBack",
			data: "manuscriptId=" + manuscriptId,
			success: function(html){
				$("#returnBackDisplay").html(html);
			}
		});	
		$("#returnBackDisplay").show();
		$("#returnBackDisplay").dialog("open");
		
		
	});
	
	$("#returnBackDisplay").dialog({
		width: currentWidth * 0.8,
		height: currentHeight * 0.8,
		resizable: true,
		modal:true,
		autoOpen: false,
	 	show: {
			 effect: "slide",
			 duration: 500
		}
	});
	
	$('#confirm').click(function(event){
		event.preventDefault();
		bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
			if(result == true) {
				var numOfChief = "${fn:length(chiefUsers)}";
				var manuscriptId = "${manuscript.id}";
				var manuscriptTrackId = "${manuscript.manuscriptTrackId}";
				var editorUserId = -1;
				if(manuscriptTrackId == 0) {
					if(numOfChief > 1)
						editorUserId = $("#chiefSelect option:selected").val();
					else
						editorUserId = $("#chiefId").val();
				} else
					editorUserId = "${editor.id}";

				$.ajax({
					type:"POST",
					url: "${baseUrl}/journals/${jnid}/manager/manuscripts/confirm",
					data: "manuscriptId=" + manuscriptId + "&editorUserId=" + editorUserId,
					success: function(html){
			            location.href="${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=submitted";
					}
				});	
			}
		});
	});
	
	$('#revisedConfirm').click(function(event){
		event.preventDefault();
		bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
			if(result == true) {
				var manuscriptId = "${manuscript.id}";
				$.ajax({
					type:"POST",
					url: "${baseUrl}/journals/${jnid}/manager/manuscripts/revisedConfirm",
					data: "manuscriptId=" + manuscriptId,
					success: function(html){
			            location.href="${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=revisionRequested";
					}
				});	
			}
		});
	});
});  
</script>
