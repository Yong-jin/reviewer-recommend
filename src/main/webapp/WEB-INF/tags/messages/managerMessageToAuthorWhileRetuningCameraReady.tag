<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="comment" type="link.thinkonweb.domain.manuscript.form.Comment"%>
<%@ attribute name="locale" %>
<img class="avatar img-responsive" alt="manager" src="images/icons/avatar/manager.png"/>
<div class="message">
	<span class="arrow">
	</span>
	<span class="name">
		<c:choose>
			<c:when test="${journal.languageCode ==  'ko' and fn:trim(comment.fromUser.contact.localFullName) != ''}">, 
				${comment.fromUser.contact.localFullName }
			</c:when>
			<c:otherwise>
				<c:if test="${comment.fromUser.contact.salutation != '-1'}"><spring:message code="signin.salutationDesignation.${comment.fromUser.contact.salutation}"/></c:if> ${comment.fromUser.contact.firstName } ${comment.fromUser.contact.lastName }, 
			</c:otherwise>
		</c:choose>
		<spring:message code="user.role.journal_manager"/>
	</span>
	<span class="chatSubject">
	 	<spring:message code="messages.managerToAuthorWhileRetuningCameraReady"/>
	 	<c:if test="${comment.cameraReadyRevision == 0}">
	 		(<spring:message code="system.original"/>)
	 	</c:if>
	 	<c:if test="${comment.cameraReadyRevision > 0}">
	 		(<spring:message code="system.revision"/> #${comment.cameraReadyRevision})
	 	</c:if>
	</span>
	<span class="body">
		${comment.textHtml}
		<small id="managerToAuthorWhileRetuningCameraReady${comment.cameraReadyRevision}"></small>
		<script type="text/javascript">
			document.getElementById("managerToAuthorWhileRetuningCameraReady${comment.cameraReadyRevision}").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
		</script>
	</span>
</div>