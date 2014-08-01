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
<title>
<c:if test="${currentPageRole == 'chiefEditor' }">
	<spring:message code='user.role.journal_c-editor'/>
</c:if>
<c:if test="${currentPageRole == 'manager' }">
	<spring:message code='user.role.journal_manager'/>
</c:if>

</title>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/assets/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/css/style-metronic.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
    <div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<c:set var="label2" value="user.role.journal_manager"/>
				<c:if test="${currentPageRole == 'chiefEditor' }">
					<c:set var="label2" value="user.role.journal_c-editor"/>
				</c:if>
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/${currentPageRole }/" label_2="${label2 }"
																	link_3="${baseUrl}/journals/${jnid}/${currentPageRole }/manuscriptStatusOverview" label_3="system.manuscriptStatusOverview"/>
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a id="tab0" class="tabClick" href="#beingSubmitted" data-toggle="tab">
								<spring:message code='manager.manuscript.tab.1'/>
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<div class="tab-pane mainTab active" id="beingSubmitted">
							<div class="row">
								<div class="col-md-12">
									<div id="overView">
										<h4><spring:message code="system.manuscriptStatusOverview"/></h4>
										<div class="row">
											<label class="control-label col-md-2"></label>
											<div class="col-md-10">
												<div class="portlet">
													<div class="portlet-body" >
														<fieldset class="col-md-7">
															<br/><br/>
															<table class="table table-bordered">
																<tr>
																	<th class="cellCenter"><spring:message code="system.manuscript"/> <spring:message code="system.status"/></th>
																	<th class="cellCenter"><spring:message code="system.description"/> </th>
																	<th class="cellCenter"><spring:message code="system.number"/> </th>
																</tr>
																<c:forEach var="entry" items="${statusMap }">
																	<tr>
																		<td class="cellCenter">
																			<b>${entry.key }</b>
																		</td>
																		<td>
																			<spring:message code="system.title${entry.key}"/>
																			<c:if test="${currentPageRole == 'chiefEditor' and (entry.key == 'O' or entry.key == 'E')}">
																				<span class="required"><small>(<spring:message code="system.actionNeeded"/>)</small></span>
																			</c:if>
																			<c:if test="${currentPageRole == 'manager' and (entry.key == 'I' or entry.key == 'V' or entry.key == 'M' or entry.key == 'G')}">
																				<span class="required"><small>(<spring:message code="system.actionNeeded"/>)</small></span>
																			</c:if>
																		</td>
																		<td class="cellCenter"> 
																			<c:choose>
																				<c:when test="${not (entry.key == 'B' and currentPageRole == 'chiefEditor')}">
																					<a href="${baseUrl}/journals/${jnid}/${currentPageRole}/gateOverView?status=${entry.key }">${entry.value }</a>
																				</c:when>
																				<c:otherwise>
																					${entry.value }
																				</c:otherwise>
																			</c:choose>
																		</td>
																	</tr>
																</c:forEach>
															</table>
														</fieldset>
													</div>
												</div>
											</div>
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
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
</footer>
<script>
jQuery(document).ready(function() {

});  
</script>
</body>
</html>