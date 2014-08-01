<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="currentRevision" type="java.lang.Integer"%>

<h4><spring:message code="system.manuscriptInformation"/></h4>
<div class="row form-group">
	<label class="control-label col-md-2">
	<c:choose>
		<c:when test="${fn:trim(manuscript.submitId) != '' }">
			<spring:message code="system.manuscriptId"/>:
		</c:when>
		<c:otherwise>
			<spring:message code="system.temporaryId"/>:
		</c:otherwise>
	</c:choose>
	</label>
	<div class="col-md-9">
		<p class="form-control-static sentenseJustifyAlign">
			<c:choose>
				<c:when test="${fn:trim(manuscript.submitId) != '' }">
					${manuscript.submitId}
				</c:when>
				<c:otherwise>
					${manuscript.id }		
				</c:otherwise>
			</c:choose>
			<small> (<spring:message code="system.status"/> ${manuscript.status }: <spring:message code="system.title${manuscript.status }"/>)</small>
		</p>
	</div>
</div>
<div class="row form-group">
	<label class="control-label col-md-2"><spring:message code="manuscript.title2"/>:</label>
	<div class="col-md-9">
		<p class="form-control-static sentenseJustifyAlign">
			<b><c:if test="${manuscript.invite == true}"><span class="required">*</span> (Invited) </c:if>${manuscript.title }</b>
		</p>
	</div>
</div>
<c:if test="${currentPageRole != 'reviewer' or (currentPageRole == 'reviewer' and jc.reviewerViewAuthor == true)}">
	<div class="row form-group">
		<label class="control-label col-md-2"><spring:message code="user.role.journal_member2"/>:</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
				<c:choose>
					<c:when test="${fn:length(manuscript.coAuthors) > 0}">
						
						<c:forEach var="coAuthor" varStatus="varStatus" items="${manuscript.coAuthors}">
							${coAuthor.user.contact.firstName} ${coAuthor.user.contact.lastName} <c:if test="${coAuthor.corresponding == true}"><span class="required">*</span></c:if>
							<c:if test="${fn:length(manuscript.coAuthors) >= 2 and varStatus.count != fn:length(manuscript.coAuthors)}">, </c:if>
						</c:forEach>
					</c:when>
				</c:choose>
			</p>
		</div>
	</div>
</c:if>
<c:if test="${not empty manuscript.reviewList }">
	<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
		<c:set var="reviewCompleted" value="false"/>
		<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
			<c:if test="${review.status == 'C' and review.revisionCount == currentRevision}">
				<c:set var="reviewCompleted" value="true"/>
			</c:if>
		</c:forEach>
		<c:if test="${reviewCompleted == true }">
			<div class="row">
				<label class="control-label col-md-2">
					<spring:message code="reviewer.reviewResultSummary"/>:
				</label>
				<div class="col-md-9">
					<div class="form-group">
						<p class="form-control-static sentenseJustifyAlign">
							<c:set var="count" value="1" />              
							<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
								<c:if test="${review.status == 'C' and review.revisionCount == currentRevision}">
									<b><spring:message code="reviewResult.score.${review.overall }"/></b>
									<small>(
									<spring:message code="user.role.journal_reviewer"/> #${count }, 
									<c:choose>
										<c:when test="${journal.languageCode ==  'ko' and fn:trim(review.user.contact.localFullName) != ''}">
											${review.user.contact.localFullName }
										</c:when>
										<c:otherwise>
											${review.user.contact.firstName } ${review.user.contact.lastName }
										</c:otherwise>
									</c:choose>
									)
									</small>
									<c:set var="count" value="${count+1 }"/>
									<br/>
								</c:if>
							</c:forEach>
						</p>
					</div>
				</div>
			</div>
		</c:if>
	</c:forEach>
</c:if>
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-9"><hr class="soften"/></div>
</div>