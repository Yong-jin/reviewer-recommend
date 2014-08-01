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
<title><spring:message code='user.role.journal_c-editor'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<c:set var="firstTabHash" value="#submitted"/>
<c:if test="${pageType != null}"><c:set var="firstTabHash" value="#${pageType }"/></c:if>
<div id="associateEditorEmailRequestDisplay" class="modalDialog"></div>
<div id="forceToRejectDisplay" class="modalDialog"></div>
<div id="finalDecisionDisplay" class="modalDialog"></div>
<div id="commentsDisplay" class="modalDialog"></div>
<div id="emailFormDisplay" class="modalDialog"></div>
<div id="reviewResultsDisplay" class="modalDialog"></div>
<div id="reviewerHistoryDisplay" class="modalDialog"></div>
<div id="declineReasonDisplay" class="modalDialog"></div>
<div class="page-container">
	 
	<div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_c-editor"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts" label_3="system.manuscriptManagement"/>

				<c:choose>
				<c:when test="${journal.type == 'A' or journal.type == 'B'}">
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#submitted" data-pageType="submitted" data-toggle="tab">
								<spring:message code='c-editor.manuscript.tab.1'/>
							</a>
						</li>
						<c:if test="${journal.type == 'A'}">
							<li>
								<a id="tab1" class="tabClick" href="#aeSelection" data-pageType="aeSelection" data-toggle="tab">
									<spring:message code='c-editor.manuscript.tab.2'/>
									<span class="badge badge-important">
									 	${numAeSelection}
									</span>
								</a>
							</li>
							<li>
								<a id="tab2" class="tabClick" href="#revisionSubmitted" data-pageType="revisionSubmitted" data-toggle="tab">
									<spring:message code='c-editor.manuscript.tab.3'/>
								</a>
							</li>
						</c:if>
						<li>
							<a id="tab3" class="tabClick" href="#underReview" data-pageType="underReview" data-toggle="tab">
								<spring:message code='c-editor.manuscript.tab.4'/>
								<span class="badge badge-unimportant">
								 	${numInReview}
								</span>
							</a>
						</li>
						<li>
							<a id="tab4" class="tabClick" href="#finalDecisionRequired" data-pageType="finalDecisionRequired" data-toggle="tab">
								<spring:message code='c-editor.manuscript.tab.5'/>
								<span class="badge badge-important">
								 	${numFinalDecision}
								</span>
							</a>
						</li>
						<li>
							<a id="tab5" class="tabClick" href="#other" data-pageType="other" data-toggle="tab">
								<spring:message code='c-editor.manuscript.tab.6'/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<!-- Submitted -->
						<div class="tab-pane mainTab active" id="submitted">
							<div class="row">
								<div class="col-md-12">
									<div id="submitted-t">
										<table class="table table-bordered" id="submittedTable">
											<thead>
											<tr>
												<th class="cellCenter">
													
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="submitted-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						<c:if test="${journal.type == 'A'}">
						<!-- Required for AE Selection -->
						<div class="tab-pane mainTab" id="aeSelection">
							<div class="row">
								<div class="col-md-12">
									<div id="aeSelection-t">
										<table class="table table-bordered" id="aeSelectionTable">
											<thead>
											<tr>
												<th class="cellCenter">
													 
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_a-editor'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="aeSelection-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						<!-- Revision Submitted -->
						<div class="tab-pane mainTab" id="revisionSubmitted">
							<div class="row">
								<div class="col-md-12">
									<div id="revisionSubmitted-t">
										<table class="table table-bordered" id="revisionSubmittedTable">
											<thead>
											<tr>
												<th class="cellCenter">
													
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_a-editor'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.message'/>
												</th>
												<th class="cellCenter">
													<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="revisionSubmitted-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						</c:if>
						<!-- Under Review -->
						<div class="tab-pane mainTab" id="underReview">
							<div class="row">
								<div class="col-md-12">
									<div id="underReview-t">
										<table class="table table-bordered" id="underReviewTable">
											<thead>
											<tr>
												<th class="cellCenter">
													 
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_a-editor'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.message'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="underReview-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						
						<!-- Required for Decision -->
						<div class="tab-pane mainTab" id="finalDecisionRequired">
							<div class="row">
								<div class="col-md-12">
									<div id="finalDecisionRequired-t">
										<table class="table table-bordered" id="finalDecisionRequiredTable">
											<thead>
											<tr>
												<th class="cellCenter">
													 
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_reviewer'/><br/><spring:message code='system.reviewResult'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_a-editor'/>
												</th>
												<th class="cellCenter">
													<spring:message code='associateEditor.recommendedByAE'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.message'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="finalDecisionRequired-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="other">
							<div class="row">
								<div class="col-md-12">
									<div id="other-t">
										<table class="table table-bordered" id="otherTable">
											<thead>
											<tr>
												<th class="cellCenter">
													 
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='user.role.journal_a-editor'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.message'/>
												</th>
												<th class="cellCenter">
													<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="other-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li>
							<a id="tab0" class="tabClick" href="#submitted" data-toggle="tab">
								<spring:message code='g-editor.manuscript.tab.1'/>
								<span class="badge badge-important">
								 	${numReview}
								</span>
							</a>
						</li>
						<c:if test="${journal.type == 'C' }">
						<li>
							<a id="tab1" class="tabClick" href="#reSubmitted" data-toggle="tab">
								<spring:message code='g-editor.manuscript.tab.2'/>
								<span class="badge badge-important">
								 	${numReReview}
								</span>
							</a>
						</li>
						</c:if>
						<li>
							<a id="tab2" class="tabClick" href="#other" data-toggle="tab">
								<spring:message code='g-editor.manuscript.tab.3'/>
							</a>
						</li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane mainTab active" id="submitted">
							<div class="row">
								<div class="col-md-12">
									<div id="submitted-t">
										<table class="table table-bordered" id="submittedTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='system.message'/>
												</th>
												<th>
													<spring:message code='system.reviewProcess'/>
												</th>
												<th>
													<spring:message code='system.reviewResult'/>
												</th>
												<th>
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="submitted-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						<c:if test="${journal.type == 'C' }">
						<div class="tab-pane mainTab" id="reSubmitted">
							<div class="row">
								<div class="col-md-12">
									<div id="reSubmitted-t">
										<table class="table table-bordered" id="reSubmittedTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='system.message'/>
												</th>
												<th>
													<spring:message code='system.reviewProcess'/>
												</th>
												<th>
													<spring:message code='system.reviewResult'/>
												</th>
												<th>
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="reSubmitted-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						</c:if>
						<div class="tab-pane mainTab" id="other">
							<div class="row">
								<div class="col-md-12">
									<div id="other-t">
										<table class="table table-bordered" id="otherTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='system.message'/>
												</th>
												<th>
													<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="other-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
					</div>
				</div>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/js/roles/common/reviewers/signupReviewer.js"></script>
<c:set var="ajaxRequestUrl" value="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts/getPapers/"/>
<%@ include file="/WEB-INF/views/roles/chiefEditor/manuscripts/chiefEditorTableScripts.jsp" %>
<%@ include file="/WEB-INF/views/roles/common/manuscripts/tableScripts.jsp" %>
<script src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
</footer>
<script>
var errorMessages = new Array();
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
function reject(manuscriptId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts/reject",
		data: "manuscriptId=" + manuscriptId,
		success: function(html){
			$("#forceToRejectDisplay").html(html);
		}
	});	
	$("#forceToRejectDisplay").show();
	$("#forceToRejectDisplay").dialog("open");
}
function assignAE(manuscriptId) {
	$.ajax({
		url: "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts/assignAssociateEditor",
		data: "manuscriptId=" + manuscriptId,
		success: function(html){
			$("#associateEditorEmailRequestDisplay").html(html);
		}
	});	
	$("#associateEditorEmailRequestDisplay").show('normal');
	$("#associateEditorEmailRequestDisplay").dialog("open");
}

function cancelAssignedAE(manuscriptId) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			$.ajax({
				method: "POST",
				url: "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts/cancelAssignedEditor",
				data: "manuscriptId=" + manuscriptId,
				success: function(html){
					location.href = "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts?pageType=aeSelection";
				}
			});	
		}
	});
}

function finalDecision(manuscriptId) {
	var href = location.hash;
	var returnPage = href.replace("#", "");
	var url = "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts/finalDecision";
	var data = "manuscriptId=" + manuscriptId +"&returnPage=" + returnPage;
	$.ajax({
		type:"GET",
		url: url,
		data: data,
		success:function(html){
			$("#finalDecisionDisplay").html(html);
		}
	});
	$("#finalDecisionDisplay").show();
	$("#finalDecisionDisplay").dialog("open");
}

jQuery(document).ready(function() {
	<c:if test="${journal.type == 'A' or journal.type == 'B'}">
	TableAjax.init("${ajaxRequestUrl}", "submitted");
	</c:if>
	$("#associateEditorEmailRequestDisplay").dialog({
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
	
	$("#finalDecisionDisplay").dialog({
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

	$("#forceToRejectDisplay").dialog({
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
});
</script>
</body>
</html>