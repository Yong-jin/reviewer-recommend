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
<title><spring:message code='user.role.journal_b-member'/></title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<c:set var="firstTabHash" value="#accepted"/>
<c:if test="${pageType != null}"><c:set var="firstTabHash" value="#${pageType }"/></c:if>
<div class="page-container">
	 
	<div class="container">
		
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="user.role.journal_b-member"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts" label_3="system.manuscriptManagement"/>
				
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#accepted" data-toggle="tab">
								<spring:message code='b-member.manuscript.tab.1'/>
							</a>
						</li>
						<li>
							<a id="tab1" class="tabClick" href="#rejected" data-toggle="tab">
								<spring:message code='b-member.manuscript.tab.2'/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane mainTab active" id="accepted">
							<div class="row">
								<div class="col-md-12">
									<div id="accepted-t">
										<table class="table table-bordered" id="acceptedTable">
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
									<div id="accepted-v"></div>
									<br/>
									<br/>

								</div>
							</div>
						</div>
						<div class="tab-pane mainTab" id="rejected">
							<div class="row">
								<div class="col-md-12">
									<div id="rejected-t">
										<table class="table table-bordered" id="rejectedTable">
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
									<div id="rejected-v"></div>
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
<%@ include file="/WEB-INF/views/roles/common/manuscripts/tableScripts.jsp" %>
</footer>
<script>
jQuery(document).ready(function() {
	TableAjax.init("${ajaxRequestUrl}", 'accepted');
});
</script>
</body>
</html>