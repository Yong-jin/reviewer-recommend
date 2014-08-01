<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="reviewerCount" type="java.lang.Integer"%>
<%@ attribute name="comment" type="link.thinkonweb.domain.manuscript.form.Comment"%>
<%@ attribute name="locale" %>
<img class="avatar img-responsive" alt="Reviewer" src="images/icons/avatar/reviewer.png"/>
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
		 <spring:message code="user.role.journal_reviewer"/>
		<c:choose>
			<c:when test="${journal.languageCode == 'ko' and fn:trim(comment.fromUser.contact.localFullName) != ''}">
				${comment.fromUser.contact.localFullName}
			</c:when>
			<c:otherwise>
				${comment.fromUser.contact.firstName} ${comment.fromUser.contact.lastName} 
			</c:otherwise>
		</c:choose>
	</span>
	<span class="chatSubject">
		 <spring:message code="associateEditor.commentToEditorialMember"/>
	</span>
	<span class="body">
		${comment.textHtml}
		<small id="commentToEditorialMember${reviewerCount}"></small>
		<script type="text/javascript">
			document.getElementById("commentToEditorialMember${reviewerCount}").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
		</script>
	</span>
</div>