<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<div class="dialogContainment">
	<div class="row">
		<div class="form form-horizontal">
			<div class="col-md-2">
				<ul class="ver-inline-menu tabbable margin-bottom-10">
					<li>
						<a class="backToTable">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-chevron-left"></i>
								</span>
								<span class="vertical-menu-info">
									<spring:message code="system.viewManuscriptList"/>
								</span>
							</span>
						</a>
						<span class="after">
						</span>
					</li>
					<li <c:if test="${v == 'summary'}">class="active"</c:if>>
						<a data-toggle="tab" class=""${pageType}basicMenuClick" href="#${pageType }manuscriptSummary">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-list-ul "></i>
								</span>
								<span class="vertical-menu-info">
									<spring:message code="system.viewManuscriptSummary"/>
									<br/>
									<small>- 
										<c:if test="${manuscript.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
										<c:if test="${manuscript.revisionCount > 0 }"><spring:message code="system.revision"/> #${manuscript.revisionCount }</c:if>
									</small>
								</span>
							</span>
						</a>
						<span class="after">
						</span>
					</li>
					<c:if test="${not empty manuscript.decisions }">
						<c:forEach var="fd" varStatus="status" items="${manuscript.decisions}" >
							<c:set var="completed" value="false"/>
							<c:if test="${fd.revisionCount == status.index and fd.decision != 0 }">
								<c:set var="completed" value="true"/>
							</c:if>
							<c:if test="${completed == true}">
								<li>
									<a data-toggle="tab" class="${pageType}basicMenuClick" href="#${pageType }reviewScore${status.index }">
										<span class="vertical-menu">
											<span class="vertical-menu-icon">
												<i class="fa fa-pencil-square-o"></i>
											</span>
											<span class="vertical-menu-info">
												<spring:message code="system.reviewResult"/><br/>
												<small>- 
													<c:if test="${status.index == 0 }"><spring:message code="system.original"/></c:if>
													<c:if test="${status.index > 0 }"><spring:message code="system.revision"/> #${status.index }</c:if>
												</small>
											</span>
										</span>
									</a>
								</li>						
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<div class="col-md-10">
				<div class="tab-content">
					<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }manuscriptSummary">
						<customTagFile:manuscriptSummary locale="${locale}"/>
					</div>
					<c:if test="${not empty manuscript.reviewList }">
						<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
							<c:set var="completed" value="false"/>
							<c:forEach items="${reviews}" var="review">
								<c:if test="${review.finalDecision != null and review.finalDecision.revisionCount == status.index and review.finalDecision.decision != 0}">
									<c:set var="completed" value="true"/>
								</c:if>
							</c:forEach>
							<c:if test="${completed == true}">
								<div class="tab-pane fade" id="${pageType }reviewScore${status.count}">
									<customTagFile:manuscriptSummaryHead />
									<c:set var="count" value="1" />              
									<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
										<c:if test="${review.status == 'C'}">
											<customTagFile:reviewerSummary count="${count}" review="${review}" locale="${locale}"/>
											<customTagFile:reviewSummary review="${review}" locale="${locale}"/>
											<c:set var="count" value="${count+1 }"/>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(reviews) > count }">
										<div class="form-section_noborder">
											<h4><spring:message code="reviewResult.historyByOtherReviewers"/>&nbsp; <a id="${pageType}${status.index}reviewerHistoryButton" onClick="reviewerHistorySummaryView(${status.index });"><i class="fa fa-angle-down "></i></a></h4>
											<div id="${pageType}${status.index}reviewerHistorySummaryView" class="reviewerHistorySummaryView">
												<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
													<customTagFile:reviewerHistorySummary review="${review}" locale="${locale}"/>
												</c:forEach>
											</div>
										</div>
									</c:if>
								</div>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>			
	</div>
</div>
<script src="${baseUrl}/js/roles/jquery-ui.js"></script>
<script>
var pageType = "${pageType}";
var v = "${v}";
var status = "${manuscript.status}";
$('.historyView').hide();
function historyView(manuscriptId, type) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manuscripts/viewManuscriptHistory?manuscriptId=${manuscript.id}&type=" + type,
		success: function(html){
			var displayId = "#" + "${pageType }" + type + "historyDisplay";
			var displayViewButtonId = "#" + "${pageType }" + type + "historyViewButton";
			var currentDisplayId = "#" + "${pageType }" + type + "historyCurrentDisplay";
			if($(displayId).css("display") != "none") {
				$(displayId).hide('normal');
				$(currentDisplayId).show('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-down "></i>');
			} else {
				$(displayId).html(html).show('normal');
				$(currentDisplayId).hide('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-up "></i>');
			}
		}
	});	
}

var minWidth = $('.ver-inline-menu').css("min-width");
minWidth = minWidth.replace('px', '');
if(Number(firstTabWidth) < Number(minWidth))
	$('.ver-inline-menu').css("width", minWidth);
else
	$('.ver-inline-menu').css("width", firstTabWidth);

$('.backToTable').click(function(event) {
	event.preventDefault();
	location.hash = "#" + "${pageType}";
	$('.searchOptionsField').show('normal');
	var currentPageRole = "${currentPageRole}";
	if(currentPageRole == 'associateEditor' && dataChanged)
		location.href="${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts";
	else {
		tableViewId = '#' + "${pageType}" + '-t';
		viewId = '#' + "${pageType}" + '-v';
		$(viewId).hide();
		$(tableViewId).show('normal');
	}
});

function reviewerHistorySummaryView(revisionCount) {
	var summaryViewId = '#' + pageType + revisionCount + 'reviewerHistorySummaryView';
	var summaryViewButtonId = '#' + pageType + revisionCount + 'reviewerHistorySummaryButton';
	if($(summaryViewId).css("display") != "none") {
		$(summaryViewButtonId).html('<i class="fa fa-angle-down "></i>');
		$(summaryViewId).hide('normal');
	} else {
		$(summaryViewButtonId).html('<i class="fa fa-angle-up "></i>');
		$(summaryViewId).show('normal');
	}
}

</script>
