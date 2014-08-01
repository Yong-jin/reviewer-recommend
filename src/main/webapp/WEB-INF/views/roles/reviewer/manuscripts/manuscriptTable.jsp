<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code='user.role.journal_reviewer'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<c:set var="firstTabHash" value="#assigned"/>
<c:if test="${pageType != null}"><c:set var="firstTabHash" value="#${pageType }"/></c:if>
<div class="page-container">
     
    <div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_reviewer"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts" label_3="home.review"/>
																	
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#assigned" data-toggle="tab">
								<spring:message code='reviewer.manuscript.tab.1'/>
								<span class="badge badge-important">
								 	${fn:length(reviews)}
								</span>
							</a>
						</li>
						<li>
							<a id="tab1" class="tabClick" href="#completed" data-toggle="tab">
								<spring:message code='reviewer.manuscript.tab.2'/>
							</a>
						</li>
						<li>
							<a id="tab2" class="tabClick" href="#dismissed" data-toggle="tab">
								<spring:message code='reviewer.manuscript.tab.3'/>
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
												<th class="cellCenter">
													
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='reviewer.assignmentDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code='reviewResult.dueDate'/>
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
									<div id="assigned-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						
						<!--completed-->
						<div class="tab-pane mainTab" id="completed">
							<div class="row">
								<div class="col-md-12">
									<div id="completed-t">
										<table class="table table-bordered" id="completedTable">
											<thead>
											<tr>
												<th class="cellCenter">
													
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='reviewer.completeDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code="reviewer.status"/>
												</th>
												<th class="cellCenter">
													<spring:message code="reviewResult.overall2"/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="completed-v"></div>
									<br/>
									<br/>
								</div>
							</div>
						</div>
						
						<!--dismissed-->
						<div class="tab-pane mainTab" id="dismissed">
							<div class="row">
								<div class="col-md-12">
									<div id="dismissed-t">
										<table class="table table-bordered" id="dismissedTable">
											<thead>
											<tr>
												<th class="cellCenter">
													
												</th>
												<th class="cellCenter">
													<spring:message code='system.manuscriptId'/>
												</th>
												<th class="cellCenter">
													<spring:message code='system.version'/>
												</th>
												<th class="cellCenter">
													<spring:message code='manuscript.title'/>
												</th>
												<th class="cellCenter">
													<spring:message code='reviewer.dismissDate'/>
												</th>
												<th class="cellCenter">
													<spring:message code="reviewer.status"/>
												</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div id="dismissed-v"></div>
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
<script src="${baseUrl}/assets/plugins/bootstrap-toastr/toastr.min.js"></script>
<%@ include file="/WEB-INF/views/roles/common/manuscripts/tableScripts.jsp" %>
</footer>
<script>
$(document).ready(function() {
	TableAjax.init("${ajaxRequestUrl}", "assigned");
});
</script>
</body>
</html>