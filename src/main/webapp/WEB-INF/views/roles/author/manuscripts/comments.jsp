<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="messageCustomTagFile" tagdir="/WEB-INF/tags/messages" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code="system.messages"/></h4>
</div>
<br/>
<br/>
<c:if test="${not empty comments}">
	<div class="row" id="chats">
		<div class="chatsContainer">
			<ul class="chats">
				<c:set var="count" value="0"/>
				<c:forEach var="index" items="${galleryProofRevisionIndices}">
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.fromUserId == user.id}">
							<c:if test="${comment.toRole == 'ROLE_MANAGER'}">
								<c:set var="count" value="${count+1}"/>
							</c:if>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:if test="${count > 0}">
					<c:forEach var="index" items="${galleryProofRevisionIndices}">
						<c:if test="${index < maxGalleryProofRevision}">
							<hr class="soften"/>
						</c:if>
						<c:if test="${index == 0 }"><h5><spring:message code="galleryProof.title"/> <spring:message code="system.original"/></h5></c:if>
						<c:if test="${index > 0 }"><h5><spring:message code="galleryProof.title"/> <spring:message code="system.revision"/> #${index }</h5></c:if>

						<c:forEach var="comment" items="${comments}">
							<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER' and comment.fromUserId == user.id}">
								<c:if test="${comment.toRole == 'ROLE_MANAGER'}">
									<li class="in">
										<messageCustomTagFile:authorMessageToManagerWhileRetuningGalleryProof comment="${comment}" locale="${locale}"/>
									</li>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
				
				<c:set var="count" value="0"/>
				<c:forEach var="index" items="${cameraReadyRevisionIndices}">
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER' and comment.toUserId == user.id}">
							<c:set var="count" value="${count+1}"/>
						</c:if>
					</c:forEach>
				</c:forEach>

				<c:if test="${count > 0}">
					<c:forEach var="index" items="${cameraReadyRevisionIndices}">
						<c:if test="${maxGalleryProofRevision > 0}">
							<hr class="soften"/>
						</c:if>
						<c:if test="${index == 0 }"><h5><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.original"/></h5></c:if>
						<c:if test="${index > 0 }"><h5><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.revision"/> #${index }</h5></c:if>

						<c:forEach var="comment" items="${comments}">
							<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER' and comment.toUserId == user.id}">
								<li class="out">
									<messageCustomTagFile:managerMessageToAuthorWhileRetuningCameraReady comment="${comment}" locale="${locale}"/>
								</li>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
</c:if>