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
<title><spring:message code='user.role.journal_a-editor'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body id="body">
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<c:set var="firstTabHash" value="#assigned"/>
<c:if test="${pageType != null}"><c:set var="firstTabHash" value="#${pageType }"/></c:if>
<div id="emailFormDisplay" class="modalDialog"></div>
<div id="commentsDisplay" class="modalDialog"></div>
<div id="reviewResultsDisplay" class="modalDialog"></div>
<div id="reviewerHistoryDisplay" class="modalDialog"></div>
<div id="declineReasonDisplay" class="modalDialog"></div>
<div class="page-container">
    <div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_a-editor"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts" label_3="system.managementReviewProcess"/>
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#assigned" data-toggle="tab">
								<spring:message code='a-editor.manuscript.tab.0'/>
								<span class="badge badge-important">
								 	${numAssign}
								</span>
							</a>
						</li>
						<li>
							<a id="tab1" class="tabClick" href="#submitted" data-toggle="tab">
								<spring:message code='a-editor.manuscript.tab.1'/>
								<span class="badge badge-important">
								 	${numReview}
								</span>
							</a>
						</li>
						<c:if test="${journal.type == 'A' or journal.type == 'B'}">
						<li>
							<a id="tab2" class="tabClick" href="#reSubmitted" data-toggle="tab">
								<spring:message code='a-editor.manuscript.tab.2'/>
								<span class="badge badge-important">
								 	${numReReview}
								</span>
							</a>
						</li>
						</c:if>
						<li>
							<a id="tab3" class="tabClick" href="#other" data-toggle="tab">
								<spring:message code='a-editor.manuscript.tab.3'/>
							</a>
						</li>
					</ul>

					<div class="tab-content">
						<div class="tab-pane mainTab active" id="assigned">
							<div class="row">
								<div class="col-md-12">
									<div id="assigned-t">
										<table class="table table-bordered" id="assignedTable">
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
													<spring:message code='system.action'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="assigned-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="submitted">
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
						<c:if test="${journal.type == 'A' or journal.type == 'B'}">
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
			</div>
		</div>
	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="${baseUrl}/js/roles/common/reviewers/signupReviewer.js"></script>
<%@ include file="/WEB-INF/views/roles/common/manuscripts/tableScripts.jsp" %>
</footer>
<script>
var dataChanged = false;
$(document).ready(function() {
	TableAjax.init("${ajaxRequestUrl}", "assigned");
});
</script>
</body>
</html>