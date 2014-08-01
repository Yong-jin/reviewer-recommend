<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ page import="org.springframework.context.MessageSource" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code='user.role.journal_member'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/pages/profile.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<c:set var="firstTabHash" value="#beingSubmitted"/>
<c:if test="${numCoWrittenBeingSubmitted == 0}"><c:set var="firstTabHash" value="#submitted"/></c:if>
<c:if test="${pageType != null}"><c:set var="firstTabHash" value="#${pageType }"/></c:if>


<div id="returnBackDisplay" class="modalDialog"></div>
<div id="galleryProofReturnBackDisplay" class="modalDialog"></div>
<div id="commentsDisplay" class="modalDialog"></div>
<div id="dueDateDisplay" class="modalDialog"></div>
<div class="page-container">
    <div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_member"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts" label_3="system.manuscriptManagement"/>

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<c:if test="${numCoWrittenBeingSubmitted > 0}">
							<li class="active">
								<a id="tab0" class="tabClick" href="#beingSubmitted" data-toggle="tab">
									<spring:message code='author.manuscript.tab.1'/>
									<span class="badge badge-important">
									 	${numCoWrittenBeingSubmitted}
									</span>
								</a>
							</li>
						</c:if>
						<li <c:if test="${numCoWrittenBeingSubmitted == 0}">class="active"</c:if>>
							<a id="tab1" class="tabClick" href="#submitted" data-toggle="tab">
								<spring:message code='author.manuscript.tab.2'/>
									<span class="badge badge-unimportant">
									 	${numCoWrittenSubmitted}
									</span>
							</a>
						</li>
						<c:if test="${journal.type == 'A' or journal.type == 'C'}">
						<li>
							<a id="tab2" class="tabClick" href="#revisionRequested" data-toggle="tab">
								<spring:message code='author.manuscript.tab.3'/>
									<span class="badge badge-important">
									 	${numCoWrittenRevisionRequested}
									</span>
							</a>
						</li>
						</c:if>
						<li>
							<a id="tab3" class="tabClick" href="#accepted" data-toggle="tab">
								<spring:message code='author.manuscript.tab.4'/>
									<span class="badge badge-important">
									 	${numCoWrittenAccepted }
									</span>
							</a>
						</li>
						<li>
							<a id="tab4" class="tabClick" href="#published" data-toggle="tab">
								<spring:message code='author.manuscript.tab.5'/>
							</a>
						</li>
						<li>
							<a id="tab5" class="tabClick" href="#withdrawn" data-toggle="tab">
								<spring:message code='author.manuscript.tab.6'/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<c:if test="${numCoWrittenBeingSubmitted > 0}">
							<div class="tab-pane mainTab active" id="beingSubmitted">
								<div class="row">
									<div class="col-md-12">
										<div id="beingSubmitted-t">
											<table class="table table-bordered" id="beingSubmittedTable">
												<thead>
													<tr>
														<th>
															
														</th>
														<th>
															<spring:message code='system.temporaryId'/>
														</th>
														<th>
															<spring:message code='manuscript.submitter'/>
														</th>
														<th>
															<spring:message code='manuscript.title'/>
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
										<div id="beingSubmitted-v"></div>
										<br/>
										<br/>

									</div>
								</div>
							</div>
						</c:if>
						<div class="tab-pane mainTab <c:if test="${numCoWrittenBeingSubmitted == 0}">active</c:if>" id="submitted">
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
														<spring:message code='manuscript.submitter'/>
													</th>
													<th>
														<spring:message code='manuscript.title'/>
													</th>
													<th>
														<spring:message code='manuscript.submitDate'/>
													</th>
													<th>
														<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
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
						<c:if test="${journal.type == 'A' or journal.type == 'C'}">
						<div class="tab-pane mainTab" id="revisionRequested">
							<div class="row">
								<div class="col-md-12">
									<div id="revisionRequested-t">
										<table class="table table-bordered" id="revisionRequestedTable">
											<thead>
												<tr>
													<th>
														
													</th>
													<th>
														<spring:message code='system.manuscriptId'/>
													</th>
													<th>
														<spring:message code='manuscript.submitter'/>
													</th>
													<th>
														<spring:message code='manuscript.title'/>
													</th>
													<th>
														<spring:message code='manuscript.submitDate'/>
													</th>
													<th>
														<spring:message code='author.dueDate'/>
													</th>
													<th>
														<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
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
									<div id="revisionRequested-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
						</c:if>
						<div class="tab-pane mainTab" id="accepted">
							<div class="row">
								<div class="col-md-12">
									<div id="accepted-t">
										<table class="table table-bordered" id="acceptedTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.submitter'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='manuscript.acceptDate'/>
												</th>
												<th>
													<spring:message code='system.message'/>
												</th>
												<th>
													<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${statusTooltipData }"><spring:message code='manuscript.status'/></a>
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
									<div id="accepted-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="published">
							<div class="row">
								<div class="col-md-12">
									<div id="published-t">
										<table class="table table-bordered" id="publishedTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.submitter'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='manuscript.changeToPubDate'/>
												</th>
												<th>
													<spring:message code='system.message'/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="published-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="withdrawn">
							<div class="row">
								<div class="col-md-12">
									<div id="withdrawn-t">
										<table class="table table-bordered" id="withdrawnTable">
											<thead>
											<tr>
												<th>
													
												</th>
												<th>
													<spring:message code='system.manuscriptId'/>
												</th>
												<th>
													<spring:message code='manuscript.submitter'/>
												</th>
												<th>
													<spring:message code='manuscript.title'/>
												</th>
												<th>
													<spring:message code='manuscript.submitDate'/>
												</th>
												<th>
													<spring:message code='manuscript.rejectWithdrawalDate'/>
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
									<div id="withdrawn-v"></div>
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
<%@ include file="/WEB-INF/views/roles/common/manuscripts/tableScripts.jsp" %>
</footer>
<script>
var errorMessages = new Array();
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
function submit(manuscriptId) {
	var url = "${baseUrl}/journals/${jnid}/author/editManuscript?manuscriptId=" + manuscriptId;
	location.href = url;
}

function discard(manuscriptId) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/author/manuscripts/discard";
			var postString = "manuscriptId=" + manuscriptId;
			jQuery.ajax({
				type:"POST",
				url: url,
				data: postString,
				success:function(result){
					var h = location.hash.replace("#", "");
					location.href= "${baseUrl}/journals/${jnid}/author/manuscripts?pageType=" + h;
				}
			});
		}
	}); 
}

function extendDueDate(manuscriptId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/author/manuscripts/extendDueDate",
		data: "manuscriptId=" + manuscriptId,
		success: function(html){
			$("#dueDateDisplay").html(html);
		}
	});	
	$("#dueDateDisplay").show();
	$("#dueDateDisplay").dialog("open");
}

function withdraw(manuscriptId) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var url = "${baseUrl}/journals/${jnid}/author/manuscripts/withdraw";
			var postString = "manuscriptId=" + manuscriptId;
			jQuery.ajax({
				type:"POST",
				url: url,
				data: postString,
				success:function(result){
					var h = location.hash.replace("#", "");
					location.href= "${baseUrl}/journals/${jnid}/author/manuscripts?pageType=" + h;
				}
			});
		}
	}); 
}

jQuery(document).ready(function() {
	TableAjax.init("${ajaxRequestUrl}", "beingSubmitted");
	TableAjax.init("${ajaxRequestUrl}", "submitted");
	
	$("#dueDateDisplay").dialog({
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