<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<script src="${baseUrl}/js/moment.js"></script>
<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code='system.reviewResult'/></h4>
</div>
<div class="modal-body">
	<h5><spring:message code='associateEditor.reviewResult.reviewrInfo'/></h5>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.name'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localFullName) != ''}">
						${review.user.contact.localFullName} (<a href="mailto:${review.user.username}">${review.user.username}</a>)
					</c:when>
					<c:otherwise>
						${review.user.contact.firstName} ${review.user.contact.lastName} (<a href="mailto:${review.user.username}">${review.user.username}</a>)
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>	
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.institutionSmallWidth'/>: </label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign fontSize12">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localInstitution) != '' }">
						${review.user.contact.localInstitution }
					</c:when>
					<c:otherwise>
						${review.user.contact.institution}
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<c:if test="${fn:trim(review.user.contact.localDepartment) != '' || fn:trim(review.user.contact.department) != '' }">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code='user.department'/>: </label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<c:choose>
						<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localDepartment) != '' }">
							${review.user.contact.localDepartment }
						</c:when>
						<c:otherwise>
							${review.user.contact.department}
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</c:if>
	<c:if test="${review.getReviewEventDateTime('I', review.revisionCount) != null}">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code="reviewResult.invited"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<span id="reviewResult${pageType}${review.revisionCount}${review.id}invitedDateSpan"></span>
					<script type="text/javascript">
						document.getElementById("reviewResult${pageType}${review.revisionCount}${review.id}invitedDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('I', review.revisionCount).date}", "${review.getReviewEventDateTime('I', review.revisionCount).time}", "${locale}");
					</script>	
					<br/>
				</p>
			</div>
		</div>
	</c:if>
	<c:if test="${review.getReviewEventDateTime('A', review.revisionCount) != null}">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code="reviewResult.assigned"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<span id="reviewResult${pageType}${review.revisionCount}${review.id}assignDateSpan"></span>
					<script type="text/javascript">
						document.getElementById("reviewResult${pageType}${review.revisionCount}${review.id}assignDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('A', review.revisionCount).date}", "${review.getReviewEventDateTime('A', review.revisionCount).time}", "${locale}");
					</script> 
					<br/>
				</p>
			</div>
		</div>
	</c:if>
	<c:if test="${review.getReviewEventDateTime('C', review.revisionCount) != null}">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code="reviewResult.completed"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<span id="reviewResult${pageType}${review.revisionCount}${review.id}completeDateSpan"></span>
					<script type="text/javascript">
						document.getElementById("reviewResult${pageType}${review.revisionCount}${review.id}completeDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('C', review.revisionCount).date}", "${review.getReviewEventDateTime('C', review.revisionCount).time}", "${locale}");
					</script>
					<small>(<spring:message code="reviewResult.dueDate"/> 
					 <span id="reviewResult${pageType}${review.revisionCount}${review.id}dueDateSpan"></span>
					 <script type="text/javascript">
						document.getElementById("reviewResult${pageType}${review.revisionCount}${review.id}dueDateSpan").innerHTML = convertUTCDateToLocalDate("${review.dueDate}", "${review.dueTime}", "${locale}");
					 </script>						 
					)</small>
					<br/>
				</p>
			</div>
		</div>
	</c:if>
	<c:if test="${review.getReviewEventDateTime('D', review.revisionCount) != null}">
		<div class="row">
			<label class="control-label col-md-2 text-right fontSize12"><spring:message code="reviewResult.dismissed"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign fontSize12">
					<span id="reviewResult${pageType}${review.revisionCount}${review.id}declineDateSpan"></span>
					<script type="text/javascript">
						document.getElementById("reviewResult${pageType}${review.revisionCount}${review.id}declineDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('D', review.revisionCount).date}", "${review.getReviewEventDateTime('D', review.revisionCount).time}", "${locale}");
					</script> 
					<br/>
				</p>
			</div>
		</div>
	</c:if>
	<br/>
	<h5><spring:message code="system.reviewResult"/></h5>
	<div class="row">
		<label class="control-label col-md-2 fontSize12"></label>
		<div class="col-md-9">
			<table class="table table-bordered">
				<thead>
					<tr>
						<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
							<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
							<c:if test="${currentReviewItemId != 1 }">
								<th class="cellCenter height10 fontSize12">
									<spring:message code="review.item.${currentReviewItemId }"/>
								</th>
							</c:if>
						</c:forEach>
						<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
							<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
							<c:if test="${currentReviewItemId == 1 }">
								<th class="cellCenter height10 fontSize12">
									<spring:message code="review.item.${currentReviewItemId }"/>
								</th>
							</c:if>
						</c:forEach>
						<th class="cellCenter height10 fontSize12">
							<strong><spring:message code="reviewResult.overall"/></strong>		
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
							<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
							<c:set var="currentScore" value="${review.getScore(index) }"/>
							<c:if test="${currentReviewItemId != 1 }">
								<td class="cellCenter height10 fontSize12">
									<c:if test="${currentScore == 5 }">(5/5)<br/> <spring:message code="reviewResult.excellent"/></c:if>
									<c:if test="${currentScore == 4 }">(4/5)<br/> <spring:message code="reviewResult.good"/></c:if>
									<c:if test="${currentScore == 3 }">(3/5)<br/> <spring:message code="reviewResult.average"/></c:if>
									<c:if test="${currentScore == 2 }">(2/5)<br/> <spring:message code="reviewResult.weak"/></c:if>
									<c:if test="${currentScore == 1 }">(1/5)<br/> <spring:message code="reviewResult.poor"/></c:if>
								</td>
							</c:if>
						</c:forEach>
						<c:forEach var="index" begin="1" end="${review.numberOfReviewItems }" step="1">
							<c:set var="currentReviewItemId" value="${review.getReviewItemId(index) }"/>
							<c:set var="currentScore" value="${review.getScore(index) }"/>
							<c:if test="${currentReviewItemId == 1 }">
								<td class="cellCenter height10 fontSize12">
									<c:if test="${currentScore == 3 }">(3/3)<br/> <spring:message code="reviewResult.high"/></c:if>
									<c:if test="${currentScore == 2 }">(2/3)<br/> <spring:message code="reviewResult.medium"/></c:if>
									<c:if test="${currentScore == 1 }">(1/3)<br/> <spring:message code="reviewResult.low"/></c:if>
								</td>
							</c:if>
						</c:forEach>
						<td class="cellCenter height10 fontSize12">
							<c:if test="${review.overall == 5 }"><b>(5/5)<br/> <spring:message code="reviewResult.strongAccept"/></b></c:if>
							<c:if test="${review.overall == 4 }"><b>(4/5)<br/> <spring:message code="reviewResult.accept"/></b></c:if>
							<c:if test="${review.overall == 3 }"><b>(3/5)<br/> <spring:message code="reviewResult.marginal"/></b></c:if>
							<c:if test="${review.overall == 2 }"><b>(2/5)<br/> <spring:message code="reviewResult.reject"/></b></c:if>
							<c:if test="${review.overall == 1 }"><b>(1/5)<br/> <spring:message code="reviewResult.strongReject"/></b></c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<c:if test="${not empty review.additionalReviews }">
		<br/>
		<h5><spring:message code="reviewResult.additionalFile"/></h5>
		<div class="row">
			<label class="control-label col-md-2 fontSize12"></label>
			<div class="col-md-9">
				<table class="table table-bordered">
					<tr>
						<th class="cellCenter height10 fontSize12">
							<spring:message code="system.fileName"/>
						</th>
						<th class="cellCenter height10 fontSize12">
							<spring:message code="system.fileDesignation"/>
						</th>
						<th class="cellCenter height10 fontSize12">
							<spring:message code="system.uploadDate"/>
						</th>
					</tr>
					<c:forEach var="uploadedFile" items="${review.additionalReviews}">
						<tr>
							<td class="cellCenter height10 fontSize12">
								<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id}/">${uploadedFile.originalName}</a>
							</td>
							<td class="cellCenter height10 fontSize12">
								${uploadedFile.designation } 
							</td>
							<td class="cellCenter height10 fontSize12">
								<span id="uploadDateSpan${uploadedFile.id}"></span>
								<script type="text/javascript">
									document.getElementById("uploadDateSpan${uploadedFile.id}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
								</script>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</c:if>
	<br/>
	<h5><spring:message code="reviewResult.reviewComments"/></h5>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12">
			<spring:message code="reviewResult.toAuthor"/>:
		</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
				<c:set var="commentToAuthorExist" value="false"/>
				<c:set var="commentToAuthor" value=""/>
				<c:forEach var="comment" items="${comments}">
					<c:if test="${comment.fromRole == 'ROLE_REVIEWER' and comment.toRole == 'ROLE_MEMBER' and comment.fromUserId == review.userId and comment.toUserId == manuscript.userId and comment.status == 'R' and fn:trim(comment.textHtml) != ''}">
						<c:set var="commentToAuthorExist" value="true"/>
						<c:set var="commentToAuthor" value="${comment.textHtml }"/>
					</c:if>
				</c:forEach>
				<c:choose>						
					<c:when test="${commentToAuthorExist == false}">
						<spring:message code="system.notAvailable"/>
					</c:when>
					<c:otherwise>
						${commentToAuthor }
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12">
			<spring:message code="reviewResult.toEditors"/>:
			(<spring:message code="reviewResult.confidentialToAuthors"/>)
		</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
				<c:set var="commentToEditorExist" value="false"/>
				<c:set var="commentToEditor" value=""/>
				<c:forEach var="comment" items="${comments}">
					<c:if test="${comment.fromRole == 'ROLE_REVIEWER' and (comment.toRole == 'ROLE_C-EDITOR' or comment.toRole == 'ROLE_A-EDITOR' or comment.toRole == 'ROLE_G-EDITOR') and comment.fromUserId == review.userId and comment.toUserId == user.id and comment.status == 'R' and fn:trim(comment.textHtml) != ''}">
						<c:set var="commentToEditorExist" value="true"/>
						<c:set var="commentToEditor" value="${comment.textHtml}"/>
						${comment.textHtml}
					</c:if>
				</c:forEach>
				<c:choose>						
					<c:when test="${commentToEditorExist == false}">
						<spring:message code="system.notAvailable"/>
					</c:when>
					<c:otherwise>
						${commentToEditor}
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2 text-right fontSize12">
			<spring:message code="reviewer.reReviewOrNot"/>: 
		</label>
		<div class="col-md-9">
			<p class="form-control-static sentenseJustifyAlign">
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