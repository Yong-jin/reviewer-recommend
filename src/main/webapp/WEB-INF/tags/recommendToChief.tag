<%@ tag body-content="empty" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="review" type="link.thinkonweb.domain.manuscript.Review"%>
<%@ attribute name="locale" %>
<br/>
<c:if test="${not empty manuscript.reviewList }">
	<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
		<c:set var="reviewCompleted" value="false"/>
		<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
			<c:if test="${review.status == 'C' and review.revisionCount == manuscript.revisionCount}">
				<c:set var="reviewCompleted" value="true"/>
			</c:if>
		</c:forEach>
	</c:forEach>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="reviewer.reviewResultSummary"/>:
		</label>
		<div class="col-md-9">
			<div class="form-group">
				<p class="form-control-static sentenseJustifyAlign">
					<c:choose>
						<c:when test="${reviewCompleted == true }">
							<c:set var="count" value="1" />          
							<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >    
								<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
									<c:if test="${review.status == 'C' and review.revisionCount == manuscript.revisionCount}">
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
							</c:forEach>
						</c:when>
						<c:otherwise>
							<spring:message code="system.notAvailable"/>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</div>
</c:if>
<br/>
<div class="row">
	<label class="control-label col-md-2">
		<spring:message code="associateEditor.recommend"/>:
	</label>
	<div class="col-md-9">
		<div class="form-group">
			<select id = "${pageType }aeRecommend" class="select2 form-control aeRecommend">
				<c:choose>
					<c:when test="${journal.type == 'A' or journal.type == 'C' }">
						<option value="5"><spring:message code="reviewResult.strongAccept"/></option>
						<option value="4"><spring:message code="reviewResult.accept"/></option>
						<option value="3"><spring:message code="reviewResult.marginal"/></option>
						<option value="2"><spring:message code="reviewResult.reject"/></option>
						<option value="1"><spring:message code="reviewResult.strongReject"/></option>
					</c:when>
					<c:when test="${journal.type == 'B' or journal.type == 'D' }">
						<option value="4"><spring:message code="reviewResult.accept"/></option>
						<option value="2"><spring:message code="reviewResult.reject"/></option>
					</c:when>
				</c:choose>
			</select>
		</div>
	</div>
</div>
<div class="row">
	<label class="control-label col-md-2">
		<spring:message code="associateEditor.commentToAuthor"/>:
	</label>
	<div class="col-md-9">
		<div class="form-group">
			<textarea rows="10" id="${pageType}commentToAuthor" name="commentToAuthor" class="form-control"></textarea>
		</div>
	</div>
</div>
<div class="row">
	<label class="control-label col-md-2">
		<spring:message code="associateEditor.commentToChiefEditor"/>:
	</label>
	<div class="col-md-9">
		<div class="form-group">
			<textarea rows="10" id="${pageType}commentToChief" name="commentToChief" class="form-control"></textarea>
		</div>
	</div>
</div>
<div class="row">
	<label class="control-label col-md-2"></label>
	<div class="col-md-9">
		<div class="form-group">
			<div class="checkbox-list pull-right">
				<span><spring:message code="system.commentShownToManager"/> <input type="checkbox" id="${pageType }scopeToManager" name="scopeToManager" value="1" checked></span>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="col-md-offset-5 col-md-7">
			<button id = "${pageType }confirmButton" class="btn green" data-manuscriptId="${manuscript.id}">
				<spring:message code="associateEditor.submitToChiefEditor"/> <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
	</div>
</div>
