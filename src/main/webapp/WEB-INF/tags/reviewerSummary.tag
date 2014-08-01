<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="count" type="java.lang.Integer"%>
<%@ attribute name="review" type="link.thinkonweb.domain.manuscript.Review"%>
<%@ attribute name="locale" %>

<div class="form-section_noborder">
	<h4><i class="fa fa-pencil-square  summaryItem"></i> <spring:message code="user.role.journal_reviewer"/> <c:if test="${currentPageRole != 'reviewer' }">#${count }&nbsp; <a id="${manuscript.id }_${review.id}reviewerSummaryButton" onClick="reviewerSummaryView(${manuscript.id}, ${review.id });"><i class="fa fa-angle-down "></i></a></c:if></h4>
	<div id="${manuscript.id }_${review.id}reviewerSummaryView">
		<c:if test="${currentPageRole != author }">
			<div class="form-group">
				<label class="control-label col-md-2 reviewResultItem"><spring:message code="user.name"/>: </label>
				<div class="col-md-9 reviewResultItem">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${journal.languageCode ==  'ko' and fn:trim(review.user.contact.localFullName) != ''}">
								${review.user.contact.localFullName }
							</c:when>
							<c:otherwise>
								${review.user.contact.firstName } ${review.user.contact.lastName }
							</c:otherwise>
						</c:choose>
						 (<a href="mailto:${review.user.username }">${review.user.username }</a>)
					</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2 reviewResultItem"><spring:message code="user.institutionSmallWidth"/>: </label>
				<div class="col-md-9 reviewResultItem">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localInstitution) != '' }">
								${review.user.contact.localInstitution }
							</c:when>
							<c:otherwise>
								${review.user.contact.institution }
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localDepartment) != '' }">, ${review.user.contact.localDepartment }</c:when>
							<c:otherwise><c:if test="${fn:trim(review.user.contact.department) != '' }">, ${review.user.contact.department }</c:if>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
			<c:if test="${review.getReviewEventDateTime('I', review.revisionCount) != null}">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="reviewResult.invited"/>:</label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<span id="${pageType}${review.revisionCount}${review.id}invitedDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}invitedDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('I', review.revisionCount).date}", "${review.getReviewEventDateTime('I', review.revisionCount).time}", "${locale}");
							</script>	
							<br/>
						</p>
					</div>
				</div>
			</c:if>
			<c:if test="${review.getReviewEventDateTime('A', review.revisionCount) != null}">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="reviewResult.assigned"/>:</label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<span id="${pageType}${review.revisionCount}${review.id}assignDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}assignDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('A', review.revisionCount).date}", "${review.getReviewEventDateTime('A', review.revisionCount).time}", "${locale}");
							</script> 
							<br/>
						</p>
					</div>
				</div>
			</c:if>
			<c:if test="${review.getReviewEventDateTime('C', review.revisionCount) != null}">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="reviewResult.completed"/>:</label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<span id="${pageType}${review.revisionCount}${review.id}completeDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}completeDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('C', review.revisionCount).date}", "${review.getReviewEventDateTime('C', review.revisionCount).time}", "${locale}");
							</script>
							<small>(<spring:message code="reviewResult.dueDate"/> 
							 <span id="${pageType}${review.revisionCount}${review.id}dueDateSpan"></span>
							 <script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}dueDateSpan").innerHTML = convertUTCDateToLocalDate("${review.dueDate}", "${review.dueTime}", "${locale}");
							 </script>						 
							)</small>
							<br/>
						</p>
					</div>
				</div>
			</c:if>
			<c:if test="${review.getReviewEventDateTime('M', review.revisionCount) != null}">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="system.review.titleM"/>:</label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<span id="${pageType}${review.revisionCount}${review.id}dismissDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}dismissDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('M', review.revisionCount).date}", "${review.getReviewEventDateTime('M', review.revisionCount).time}", "${locale}");
							</script>
							<br/>
						</p>
					</div>
				</div>
			</c:if>
			<c:if test="${review.getReviewEventDateTime('T', review.revisionCount) != null}">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="system.review.titleT"/>:</label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<span id="${pageType}${review.revisionCount}${review.id}dismissAutomaticDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType}${review.revisionCount}${review.id}dismissAutomaticDateSpan").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('T', review.revisionCount).date}", "${review.getReviewEventDateTime('T', review.revisionCount).time}", "${locale}");
							</script>
						</p>
					</div>
				</div>
			</c:if>
		</c:if>
	</div>
</div>
