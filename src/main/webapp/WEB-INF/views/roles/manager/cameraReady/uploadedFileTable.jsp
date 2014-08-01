<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<c:choose>
	<c:when test="${not empty cameraReadyFiles }">
		<c:forEach var="index" items="${revisionIndices}">
			<c:if test="${index < maxRevision}">
				<br/>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-9"><hr class="soften"/></div>
				</div>
			</c:if>
			<h5 class="marginLeft0">
				<c:if test="${index == 0}"><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.original"/></c:if> 
				<c:if test="${index > 0}"><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.revision"/> #${index}</c:if> 
			</h5>
			
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="cellCenter">
							 <spring:message code="system.fileName"/>
						</th>
						<th class="cellCenter">
							 <spring:message code="system.fileDesignation"/>
						</th>
						<th class="cellCenter">
							 <spring:message code="system.uploadDate"/>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="f" items="${cameraReadyFiles}">
						<c:if test="${f.cameraReadyRevision == index}">
							<tr>
								<td class="cellCenter">
									<a href="${baseUrl}/journals/${jnid}/download/${f.id}">${f.originalName}</a>
								</td>
								<td class="cellCenter">
									<c:choose>
										<c:when test="${f.designation == 'cameraReadyPaper'}">
											<spring:message code="cameraReady.fileDesignation.0"/>
										</c:when>
										<c:when test="${f.designation == 'copyright'}">
											<spring:message code="cameraReady.fileDesignation.1"/>
										</c:when>
										<c:when test="${f.designation == 'biography'}">
											<spring:message code="cameraReady.fileDesignation.2"/>
										</c:when>
									</c:choose>
								</td>
								<td class="cellCenter">
								${f.date}
								</td>
							</tr>
						</c:if>
					</c:forEach>
					<c:set var="commentExist" value="false"/>
					<c:if test="${not empty comments}">
						<c:forEach var="comment" items="${comments }">
							<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER' and comment.toRole == 'ROLE_MEMBER' and comment.status == 'M'}">
								<c:set var="commentExist" value="true"/>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${commentExist == true}">
						<tr>
							<td colspan="3">
								<c:if test="${not empty comments}">
									<c:forEach var="comment" items="${comments }">
										<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER' and comment.toRole == 'ROLE_MEMBER' and comment.status == 'M'}">
											${comment.textHtml } <small>(${comment.date} ${comment.time})</small><br/>
										</c:if>
									</c:forEach>
								</c:if>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</c:forEach>
	</c:when>
</c:choose>

