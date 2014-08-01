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
				<c:forEach var="index" items="${revisionIndices}">
					<c:set var="commentExist" value="false"/>
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.revisionCount == index }">
							<c:set var="commentExist" value="true"/>
						</c:if>
					</c:forEach>
					<c:if test="${commentExist == true }">
						<c:if test="${index < maxRevision}">
							<hr class="soften"/>
						</c:if>
						<c:if test="${index == 0 }"><h5><spring:message code="system.original"/></h5></c:if>
						<c:if test="${index > 0 }"><h5><spring:message code="system.revision"/> #${index }</h5></c:if>
					</c:if>
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.revisionCount == index}">
							<c:choose>
								<c:when test="${comment.status == 'R'}">
									<c:set var="reviewerCount" value="1"/>
									<c:choose>
<%-- 										<c:when test="${comment.fromRole == 'ROLE_REVIEWER'}">
											<c:choose>
												<c:when test="${comment.toRole == 'ROLE_G-EDITOR' and comment.toUserId == user.id}">
													<li class="out">
														<messageCustomTagFile:reviewerMessageToEditorialMembers comment="${comment}" reviewerCount="${reviewerCount}" locale="${locale}"/>
													</li>
												</c:when>
											</c:choose>
											<c:set var="reviewerCount" value="${reviewerCount + 1}"/>
										</c:when> --%>
										<c:when test="${comment.fromRole == 'ROLE_G-EDITOR'}">
											<c:choose>
												<c:when test="${comment.toRole == 'ROLE_MANAGER'}">
													<li class="in">
														<messageCustomTagFile:guestEditorMessageToManagerWhileMakingDecision comment="${comment}" locale="${locale}"/>
													</li>
												</c:when>
											</c:choose>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:if>