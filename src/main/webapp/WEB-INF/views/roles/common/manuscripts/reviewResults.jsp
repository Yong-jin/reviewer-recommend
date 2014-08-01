<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<c:if test="${not empty manuscript.decisions }">
	<c:forEach var="fd" varStatus="status" items="${manuscript.decisions}" >
		<div class="tab-pane fade" id="${pageType }reviewScore${fd.revisionCount}">
			<customTagFile:manuscriptSummaryHead currentRevision="${fd.revisionCount }"/>
			<customTagFile:decisionSummary currentRevision="${fd.revisionCount}" locale="${locale}" />
			<c:forEach var="reviews" items="${manuscript.reviewList}" >
				<c:set var="reviewExist" value="false"/>
				<c:set var="count" value="1" />     
				<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
					<c:if test="${review.revisionCount == fd.revisionCount and review.status == 'C'}">
						<c:set var="reviewExist" value="true"/>
						<customTagFile:reviewerSummary count="${count}" review="${review}" locale="${locale}"/>
						<customTagFile:reviewSummary review="${review}" locale="${locale}"/>
						<c:set var="count" value="${count+1 }"/>
					</c:if>
				</c:forEach>
				<c:if test="${currentPageRole == 'chiefEditor' or currentPageRole == 'guestEditor' or currentPageRole == 'associateEditor' or currentPageRole == 'manager'}">
					<c:if test="${reviewExist == true and fn:length(reviews) > count }">
						<div class="form-section_noborder">
							<h4><spring:message code="reviewResult.historyByOtherReviewers"/>&nbsp; <a id="${pageType}${fd.revisionCount}reviewerHistoryButton" onClick="reviewerHistorySummaryView(${fd.revisionCount });"><i class="fa fa-angle-down "></i></a></h4>
							<div id="${pageType}${fd.revisionCount}reviewerHistorySummaryView" class="${pageType}reviewerHistorySummaryView">
								<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
									<customTagFile:reviewerHistorySummary review="${review}" locale="${locale}" reviewerCount="${count }"/>
									<c:if test="${review.status != 'C' }"><c:set var="count" value="${count+1 }"/></c:if>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</c:forEach>
</c:if>