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
						<c:forEach var="revisionCount" begin="0" end="${manuscript.revisionCount }" step="1">
							<c:forEach var="fd" varStatus="status" items="${manuscript.decisions}" >
								<c:if test="${fd.revisionCount == revisionCount and fd.decision != 0}">
									<li>
										<a data-toggle="tab" class="${pageType}basicMenuClick" href="#${pageType }reviewScore${fd.revisionCount }">
											<span class="vertical-menu">
												<span class="vertical-menu-icon">
													<i class="fa fa-pencil-square-o"></i>
												</span>
												<span class="vertical-menu-info">
													<spring:message code="system.reviewResult"/><br/>
													<small>- 
														<c:if test="${fd.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
														<c:if test="${fd.revisionCount > 0 }"><spring:message code="system.revision"/> #${fd.revisionCount }</c:if>
													</small>
												</span>
											</span>
										</a>
									</li>
								</c:if>				
							</c:forEach>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<div class="col-md-10">
				<div class="tab-content">
					<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }manuscriptSummary">
						<customTagFile:manuscriptSummary locale="${locale}"/>
					</div>
					<%@ include file="/WEB-INF/views/roles/common/manuscripts/reviewResults.jsp" %>
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

	tableViewId = '#' + "${pageType}" + '-t';
	viewId = '#' + "${pageType}" + '-v';
	$(viewId).hide();
	$(tableViewId).show('normal');
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
