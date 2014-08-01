<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="review" type="link.thinkonweb.domain.manuscript.Review"%>
<%@ attribute name="locale" %>
<div id="${manuscript.id }_${review.id}reviewSummaryView">
<div class="form-section_noborder">
	<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="system.reviewResult"/></h5>
	<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
		<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
		<c:set var="currentScore" value="${review.getScore(index) }"/>
		<c:if test="${currentReviewItemId != 1 }">
			<div class="form-group">
				<label class="control-label col-md-2 reviewResultProgress"><spring:message code="review.item.${currentReviewItemId }"/>:</label>
				<div class="col-md-8 reviewResultProgress">
					<div class="progress" role="progressbar">
						<div class="score${currentReviewItemId }${review.id} progress-bar progress-bar-score">
						</div>
					</div>
				</div>
				<div class="col-md-2 reviewResultProgress">
					<p class="form-control-static sentenseJustifyAlign">
						<c:if test="${currentScore == 5 }">(5/5) <spring:message code="reviewResult.excellent"/></c:if>
						<c:if test="${currentScore == 4 }">(4/5) <spring:message code="reviewResult.good"/></c:if>
						<c:if test="${currentScore == 3 }">(3/5) <spring:message code="reviewResult.average"/></c:if>
						<c:if test="${currentScore == 2 }">(2/5) <spring:message code="reviewResult.weak"/></c:if>
						<c:if test="${currentScore == 1 }">(1/5) <spring:message code="reviewResult.poor"/></c:if>
					</p>
				</div>
			</div>
		</c:if>
	</c:forEach>
	<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
		<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
		<c:set var="currentScore" value="${review.getScore(index) }"/>
		<c:if test="${currentReviewItemId == 1 }">
			<div class="form-group">
				<label class="control-label col-md-2 reviewResultProgress"><spring:message code="review.item.${currentReviewItemId }"/>:</label>
				<div class="col-md-8 reviewResultProgress">
					<div class="progress" role="progressbar">
						<div class="score${currentReviewItemId }${review.id} progress-bar progress-bar-score">
						</div>
					</div>
				</div>
				<div class="col-md-2 reviewResultProgress">
					<p class="form-control-static sentenseJustifyAlign">
						<c:if test="${currentScore == 3 }">(3/3) <spring:message code="reviewResult.high"/></c:if>
						<c:if test="${currentScore == 2 }">(2/3) <spring:message code="reviewResult.medium"/></c:if>
						<c:if test="${currentScore == 1 }">(1/3) <spring:message code="reviewResult.low"/></c:if>
					</p>
				</div>
			</div>
		</c:if>
	</c:forEach>
	<div class="form-group">
		<label class="control-label col-md-2"><strong><spring:message code="reviewResult.overall"/></strong>:</label>
		<div class="col-md-8">
			<div class="progress" role="progressbar">
				<c:choose>
					<c:when test="${review.overall == 5 or review.overall == 4}">
						<div class="overall${review.id} progress-bar progress-bar-success">
						</div>
					</c:when>
					<c:otherwise>
						<div class="overall${review.id} progress-bar progress-bar-warning">
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="col-md-2">
			<p class="form-control-static sentenseJustifyAlign">
				<c:if test="${review.overall == 5 }"><b>(5/5) <spring:message code="reviewResult.strongAccept"/></b></c:if>
				<c:if test="${review.overall == 4 }"><b>(4/5) <spring:message code="reviewResult.accept"/></b></c:if>
				<c:if test="${review.overall == 3 }"><b>(3/5) <spring:message code="reviewResult.marginal"/></b></c:if>
				<c:if test="${review.overall == 2 }"><b>(2/5) <spring:message code="reviewResult.reject"/></b></c:if>
				<c:if test="${review.overall == 1 }"><b>(1/5) <spring:message code="reviewResult.strongReject"/></b></c:if>
			</p>
		</div>
	</div>

</div>
<c:if test="${not empty review.additionalReviews}">
<div class="form-section_noborder">
	<h5 class="reviewResult2"><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="reviewResult.uploadedFiles"/></h5>
	<div class="form-group">
		<label class="control-label col-md-2"><spring:message code="reviewResult.additionalFile"/>:</label>
		<div class="col-md-9">
			<table class="table table-bordered">
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
				<c:forEach var="uploadedFile" items="${review.additionalReviews}">
					<tr>
						<td class="cellCenter">
							<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id}/">${uploadedFile.originalName}</a>
						</td>
						<td class="cellCenter">
							${uploadedFile.designation } 
						</td>
						<td class="cellCenter">
							<span id="${pageType }uploadDateSpan${uploadedFile.id}"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }uploadDateSpan${uploadedFile.id}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
							</script>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</c:if>

<div class="form-section_noborder">
	<h5 class="reviewResult3"><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="reviewResult.reviewComments"/></h5>
	<div class="form-group">
		<label class="control-label col-md-2"><spring:message code="reviewResult.toAuthor"/>:</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
				<c:set var="commentToAuthor">
					<spring:message code="system.notAvailable"/>
				</c:set>
				<c:forEach var="comment" items="${manuscript.comments}">
					<c:if test="${comment.revisionCount == review.revisionCount and comment.fromRole == 'ROLE_REVIEWER' and comment.toRole == 'ROLE_MEMBER' and comment.fromUserId == review.userId and comment.status == 'R' and fn:trim(comment.textHtml) != ''}">
						<c:set var="commentToAuthor" value="${comment.textHtml}"/>
					</c:if>
				</c:forEach>
				${commentToAuthor}
			</p>
		</div>
	</div>
	<security:authorize ifAnyGranted="ROLE_A-EDITOR, ROLE_C-EDITOR, ROLE_G-EDITOR, ROLE_MANAGER, ROLE_REVIEWER">
		<div class="form-group">
			<div class="col-md-2 text-right">
				<label class="control-label text-right">
					<spring:message code="reviewResult.toEditors"/>:
				</label>
				<br/>
				<label class="control-label">
					<small>(<spring:message code="reviewResult.confidentialToAuthors"/>)</small>
				</label>
			</div>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign">
					<c:set var="commentToEditor">
						<spring:message code="system.notAvailable"/>
					</c:set>
					<c:forEach var="comment" items="${manuscript.comments}">
						<c:if test="${comment.revisionCount == review.revisionCount and comment.fromRole == 'ROLE_REVIEWER' and comment.toRole == 'ROLE_A-EDITOR' and comment.fromUserId == review.userId and comment.toUserId == manuscript.associateEditorUserId and comment.status == 'R' and fn:trim(comment.textHtml) != ''}">
							<c:set var="commentToEditor" value="${comment.textHtml}"/>
						</c:if>
					</c:forEach>
					${commentToEditor}
				</p>
			</div>
		</div>
	</security:authorize>
	<div class="form-group">
		<label class="control-label col-md-2"><spring:message code="reviewer.reReviewOrNot"/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
				<c:if test="${journal.languageCode != 'ko' && locale != 'ko_KR'}"><br/></c:if>
				<c:choose>
					<c:when test="${review.reReview == -1 }">
						<spring:message code="system.notAvailable"/>
					</c:when>
					<c:when test="${review.reReview == review.revisionCount + 1 }">
						<spring:message code="system.yes"/>
					</c:when>
					<c:when test="${review.reReview != review.revisionCount + 1 }">
						<spring:message code="system.no"/>
					</c:when>
				</c:choose>
			</p>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-9"><hr class="soften"/></div>
</div>
</div>
<script>
	var overall = "${review.overall}";
    $('.progress').css({
        "margin-top": '13px'
    });
	<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
		<c:set var="currentScore" value="${review.getScore(index) }"/>
		<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
		<c:choose>
			<c:when test="${currentReviewItemId == 1}">
			    $('.score${currentReviewItemId}${review.id}').css({
			    	
			        "width": (Number("${currentScore}")/ 3) * 100 + '%'
			    });
			</c:when>
			<c:otherwise>
			    $('.score${currentReviewItemId}${review.id}').css({
			    	
			        "width": (Number("${currentScore}")/ 5) * 100 + '%'
			    });
			</c:otherwise>
		</c:choose>
	</c:forEach>

	$('.overall${review.id}').css({
        "width": (Number(overall)/ 5) * 100 + '%'
    });
</script>