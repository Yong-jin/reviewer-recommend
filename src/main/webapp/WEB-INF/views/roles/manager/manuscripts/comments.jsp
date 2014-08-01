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
				<c:set var="remainingCount" value="${fn:length(comments)}"/>
				<c:set var="count" value="0"/>
				<c:forEach var="index" items="${galleryProofRevisionIndices}">
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER'}">
							<c:choose>
								<c:when test="${comment.toRole == 'ROLE_MANAGER'}">
									<c:set var="count" value="${count+1}"/>
								</c:when>
							</c:choose>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:set var="remainingCount" value="${remainingCount - count}"/>
				<c:if test="${count > 0}">
					<c:forEach var="index" items="${galleryProofRevisionIndices}">
						<c:if test="${index < maxGalleryProofRevision}">
							<hr class="soften"/>
						</c:if>
						<c:if test="${index == 0 }"><h5><spring:message code="galleryProof.title"/> <spring:message code="system.original"/></h5></c:if>
						<c:if test="${index > 0 }"><h5><spring:message code="galleryProof.title"/> <spring:message code="system.revision"/> #${index }</h5></c:if>

						<c:forEach var="comment" items="${comments}">
							<c:if test="${comment.galleryProofRevision == index and comment.fromRole == 'ROLE_MEMBER'}">
								<c:choose>
									<c:when test="${comment.toRole == 'ROLE_MANAGER'}">
										<li class="out">
											<messageCustomTagFile:authorMessageToManagerWhileRetuningGalleryProof comment="${comment}" locale="${locale}"/>
										</li>
									</c:when>
								</c:choose>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
				
				<c:set var="count" value="0"/>
				<c:forEach var="index" items="${cameraReadyRevisionIndices}">
					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER'}">
							<c:choose>
								<c:when test="${comment.toRole == 'ROLE_MEMBER'}">
									<c:set var="count" value="${count+1}"/>
								</c:when>
							</c:choose>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:set var="remainingCount" value="${remainingCount - count}"/>
				<c:if test="${count > 0}">	
					<c:forEach var="index" items="${cameraReadyRevisionIndices}">
						<c:if test="${maxGalleryProofRevision > 0}">
							<hr class="soften"/>
						</c:if>
						<c:if test="${index == 0 }"><h5><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.original"/></h5></c:if>
						<c:if test="${index > 0 }"><h5><spring:message code="cameraReady.shortTitle"/> <spring:message code="system.revision"/> #${index }</h5></c:if>

						<c:forEach var="comment" items="${comments}">
							<c:if test="${comment.cameraReadyRevision == index and comment.fromRole == 'ROLE_MANAGER'}">
								<c:choose>
									<c:when test="${comment.toRole == 'ROLE_MEMBER'}">
										<li class="in">
											<messageCustomTagFile:managerMessageToAuthorWhileRetuningCameraReady comment="${comment}" locale="${locale}"/>
										</li>
									</c:when>
								</c:choose>
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
				<c:if test="${remainingCount > 0}">
				<c:forEach var="index" items="${revisionIndices}">
					<c:if test="${maxGalleryProofRevision > 0 or maxCameraReadyRevision > 0}">
						<hr class="soften"/>
					</c:if>
					<c:if test="${index == 0 }"><h5><spring:message code="system.manuscript"/> <spring:message code="system.original"/></h5></c:if>
					<c:if test="${index > 0 }"><h5><spring:message code="system.manuscript"/> <spring:message code="system.revision"/> #${index }</h5></c:if>

					<c:forEach var="comment" items="${comments}">
						<c:if test="${comment.revisionCount == index}">
							<c:choose>
								<c:when test="${comment.status == 'R'}">
									<c:set var="reviewerCount" value="1"/>
									<c:choose>
										<c:when test="${comment.fromRole == 'ROLE_C-EDITOR' and comment.scopeManager == 1}">
											<li class="out">
												<messageCustomTagFile:chiefEditorMessageToAssociateEditorBeforeReviewProcess comment="${comment}" locale="${locale}"/>
											</li>
										</c:when>
<%-- 										<c:when test="${comment.fromRole == 'ROLE_REVIEWER'}">
											<c:choose>
												<c:when test="${comment.toRole == 'ROLE_A-EDITOR' and comment.scopeManager == 1}">
													<li class="out">
														<messageCustomTagFile:reviewerMessageToEditorialMembers comment="${comment}" reviewerCount="${reviewerCount}" locale="${locale}"/>
													</li>
												</c:when>
											</c:choose>
											<c:set var="reviewerCount" value="${reviewerCount + 1}"/>
										</c:when> --%>
										<c:when test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.scopeManager == 1}">
											<c:choose>
												<c:when test="${comment.toRole == 'ROLE_C-EDITOR'}">
													<li class="out">
														<messageCustomTagFile:associateEditorMessageToChiefEditorWhileSendingResults comment="${comment}" locale="${locale}"/>
													</li>
												</c:when>
											</c:choose>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${comment.status == 'E'}">
									<c:if test="${comment.fromRole == 'ROLE_C-EDITOR'}">
										<c:choose>
											<c:when test="${comment.toRole == 'ROLE_A-EDITOR' and comment.scopeManager == 1}">
												<li class="out">
													<messageCustomTagFile:chiefEditorMessageToAssociateEditorWhileMakingDecision comment="${comment}" locale="${locale}"/>
												</li>
											</c:when>
										</c:choose>
									</c:if>
								</c:when>
							</c:choose>
						</c:if>
					</c:forEach>
				</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
</c:if>