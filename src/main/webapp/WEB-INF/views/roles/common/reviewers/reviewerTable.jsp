<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<script src="${baseUrl}/js/moment.js"></script>
<table class="table table-bordered" id="${pageType }selectedReviewers">
	<thead>
	<tr>
		<th class="cellCenter" style="width: 100px">
			<spring:message code="user.username"/>
		</th>
		<th class="cellCenter" style="width: 100px">
			<spring:message code="user.name"/>
		</th>
		<th class="cellCenter">
			<spring:message code="user.institutionSmallWidth"/>
		</th>
		<th class="cellCenter" style="width: 100px">
			<spring:message code="reviewer.status"/>
		</th>
		<th class="cellCenter" style="width: 100px">
			<spring:message code="system.reviewResult"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.action"/>
		</th>
	</tr>
	</thead>
	<tbody>
	<c:choose>
		<c:when test="${not empty reviews}">
			<c:forEach var="review" items="${reviews}">
				<tr class="pulsate-target">
					<td class="cellCenter reviewerEmail">
					<a onClick="reviewerHistory(${review.user.id });">${review.user.username}</a>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localFullName) != ''}">
								${review.user.contact.localFullName}
							</c:when>
							<c:otherwise>
								${review.user.contact.firstName } ${review.user.contact.lastName } 
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localInstitution) != '' }">
								${review.user.contact.localInstitution }
							</c:when>
							<c:otherwise>
								${review.user.contact.institution }
							</c:otherwise>
						</c:choose>
					</td>
					<td class="cellCenter">
						<c:choose>
							<c:when test="${review.status == 'S'}">
							</c:when>
							<c:when test="${review.status == 'D'}">
								<a onClick='declinedReviewer(${review.userId}, ${review.id});'><spring:message code="reviewResult.declined"/></a><br/>
								<c:if test="${review.getReviewEventDateTime('D') != null }">
									<small id="declinedSpan${review.userId}${review.revisionCount}"></small>
									<script type="text/javascript">
										document.getElementById("declinedSpan${review.userId}${review.revisionCount}").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('D').date}", "${review.getReviewEventDateTime('D').time}", "${locale}");
									</script>
								</c:if>			
							</c:when>
							<c:when test="${review.status == 'I'}">
								<spring:message code="reviewResult.invited"/><br/>
								<c:if test="${review.getReviewEventDateTime('I') != null }">
									<small id="invitedSpan${review.userId}${review.revisionCount}"></small>
									<script type="text/javascript">
										document.getElementById("invitedSpan${review.userId}${review.revisionCount}").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('I').date}", "${review.getReviewEventDateTime('I').time}", "${locale}");
									</script>
								</c:if>								
							</c:when>
							<c:when test="${review.status == 'A'}">
								<spring:message code="reviewResult.assigned"/><br/>
								<c:if test="${review.getReviewEventDateTime('A') != null }">
									<small id="assignedSpan${review.userId}${review.revisionCount}"></small>
									<script type="text/javascript">
										document.getElementById("assignedSpan${review.userId}${review.revisionCount}").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('A').date}", "${review.getReviewEventDateTime('A').time}", "${locale}");
									</script>
								</c:if>							
							</c:when>
							<c:when test="${review.status == 'M'}">
								<spring:message code="reviewResult.dismissed"/><br/>
								<c:if test="${review.getReviewEventDateTime('M') != null }">
									<small id="dismissedSpan${review.userId}${review.revisionCount}"></small>
									<script type="text/javascript">
										document.getElementById("dismissedSpan${review.userId}${review.revisionCount}").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('M').date}", "${review.getReviewEventDateTime('M').time}", "${locale}");
									</script>
								</c:if>
							</c:when>
							<c:when test="${review.status == 'C'}">
								<spring:message code="reviewResult.completed"/><br/>
								<c:if test="${review.getReviewEventDateTime('C') != null }">
									<small id="completedSpan${review.userId}${review.revisionCount}"></small>
									<script type="text/javascript">
										document.getElementById("completedSpan${review.userId}${review.revisionCount}").innerHTML = convertUTCDateToLocalDate("${review.getReviewEventDateTime('C').date}", "${review.getReviewEventDateTime('C').time}", "${locale}");
									</script>
								</c:if>
							</c:when>
						</c:choose>
					
					</td>
					<td class="cellCenter">
						<c:if test="${review.status == 'C'}">
							<c:if test="${review.overall == 5 }"><b><spring:message code="reviewResult.strongAccept"/></b></c:if>
							<c:if test="${review.overall == 4 }"><b><spring:message code="reviewResult.accept"/></b></c:if>
							<c:if test="${review.overall == 3 }"><b><spring:message code="reviewResult.marginal"/></b></c:if>
							<c:if test="${review.overall == 2 }"><b><spring:message code="reviewResult.reject"/></b></c:if>
							<c:if test="${review.overall == 1 }"><b><spring:message code="reviewResult.strongReject"/></b></c:if>
						</c:if>
					</td>
					<td class="cellCenter reviewerAction">
						<input type="hidden" value="${review.user.id}"/>
						<c:choose>
							<c:when test="${review.status == 'S'}">
								<button type="button" class="btn btn-default btn-xs actionButton width100" <c:if test="${review.getReviewEventDateTime('A') == null}">onClick='inviteReviewer(${review.userId});'</c:if><c:if test="${review.getReviewEventDateTime('A') != null}">disabled</c:if>>
									<spring:message code="associateEditor.action.invite"/>
								</button>
								
								<button type="button" class="btn btn-default btn-xs actionButton width100" onClick='assignReviewer(${review.userId});'>
									<spring:message code="associateEditor.action.assign"/>
								</button>
								
								<button type="button" class="btn btn-default btn-xs actionButton width100" onClick='removeReviewer(${review.userId});'>
									<spring:message code="associateEditor.action.remove"/>
								</button>
							</c:when>
							<c:when test="${review.status == 'I'}">
								<button type="button" class="btn btn-default btn-xs actionButton width100" onClick='cancelReviewer(${review.userId});'>
									<spring:message code="associateEditor.action.cancel"/>
								</button>
							</c:when>
							<c:when test="${review.status == 'A'}">
								<button type="button" class="btn btn-default btn-xs actionButton width100" onClick='dismissReviewer(${review.userId});'>
									<spring:message code="associateEditor.action.dismiss"/>
								</button>
							</c:when>
							<c:when test="${review.status == 'M'}">
							</c:when>
							<c:when test="${review.status == 'C'}">
								<button type="button" class="btn btn-default btn-xs actionButton width100" onClick='reviewResult(${review.userId});'>
									<spring:message code="associateEditor.action.viewResult"/>
								</button>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="6" class="cellCenter">
					<spring:message code="system.noDataInTable"/>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>


<script>
var currentWidth = $(window).width();
var currentHeight = $(window).height();

function inviteReviewer(reviewerUserId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/inviteReviewer",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
		success: function(html) {
			$("#emailFormDisplay").html(html);
			dataChanged = true;
		}
	});				
	$("#emailFormDisplay").dialog("open");
}

function assignReviewer(reviewerUserId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/assignReviewer",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
		success: function(html) {
			$("#emailFormDisplay").html(html);
			dataChanged = true;
		}
	});				
	$("#emailFormDisplay").dialog("open");
}

function removeReviewer(reviewerUserId) {
	$.ajax({
		type:"POST",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/removeReviewer",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
		success: function(html) {
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/reviewerTable",
				data: "manuscriptId=" + "${manuscript.id}", 
				success: function(html) {
					$("#" + "${pageType}" + "reviewersDisplay").html(html).show();
					oTable1.fnDraw();
					oTable2.fnDraw();
					dataChanged = true;
				}
			});
		}
	});	
}

function cancelReviewer(reviewerUserId) {
	bootbox.confirm("<spring:message code='system.areYouSure' javaScriptEscape='true' />", function(result) {
		if(result == true) {
			$.ajax({
				type:"POST",
				url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/cancelReviewer",
				data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
				success: function(html) {
					$.ajax({
						type: 'GET',
						url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/reviewerTable",
						data: "manuscriptId=" + "${manuscript.id}", 
						success: function(html) {
							$("#" + "${pageType}" + "reviewersDisplay").html(html).show();
							oTable1.fnDraw();
							oTable2.fnDraw();
							dataChanged = true;
						}
					});
				}
			});	
		}
	});
}

function dismissReviewer(reviewerUserId) {
	bootbox.confirm("<spring:message code='system.areYouSure' javaScriptEscape='true' />", function(result) {
		if(result == true) {
			$.ajax({
				type:"POST",
				url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/dismissReviewer",
				data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
				success: function(html) {
					$.ajax({
						type: 'GET',
						url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/reviewerTable",
						data: "manuscriptId=" + "${manuscript.id}", 
						success: function(html) {
							$("#" + "${pageType}" + "reviewersDisplay").html(html).show();

						}
					});
				}
			});		
		}
	});
}

function reviewResult(reviewerUserId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/reviewResult",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=" + "${manuscript.id}",
		success: function(html) {
			$("#reviewResultsDisplay").html(html);
		}
	});				
	$("#reviewResultsDisplay").dialog("open");
}

function declinedReviewer(reviewerUserId, reviewId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/reviewers/${pageType}/declineReason",
		data: "reviewerUserId=" + reviewerUserId + "&manuscriptId=${manuscript.id}" + "&reviewId=" + reviewId,
		success: function(html) {
			$("#declineReasonDisplay").html(html);
		}
	});				
	$("#declineReasonDisplay").dialog("open");
}

$("#emailFormDisplay").dialog({
	width: currentWidth * 0.8,
	height: currentHeight * 0.8,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
});
	

$("#reviewResultsDisplay").dialog({
	width: currentWidth * 0.7,
	height: currentHeight * 0.8,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
});

$("#declineReasonDisplay").dialog({
	width: currentWidth * 0.6,
	height: currentHeight * 0.75,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
});

</script>