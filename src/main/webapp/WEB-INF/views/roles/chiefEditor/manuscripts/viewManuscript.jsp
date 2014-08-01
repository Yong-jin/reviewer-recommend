<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
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
				<a data-toggle="tab" class="basicMenuClick" href="#${pageType }manuscriptSummary">
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
			<c:if test="${(journal.type == 'C' or journal.type == 'D') and journal.paid == true and manuscript.status == 'R'}">
				<li <c:if test="${v == 'reviewManagement'}">class="active"</c:if>>
					<a id="${pageType }reviwerManagementView" data-toggle="tab" href="#${pageType }reviewerSelection">
						<span class="vertical-menu">
							<span class="vertical-menu-icon">
								<i class="fa fa-check-square-o "></i> 
							</span>
							<span class="vertical-menu-info">
								<spring:message code="associateEditor.reviewManage"/><br/>
								<small>- 
									<c:if test="${manuscript.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
									<c:if test="${manuscript.revisionCount > 0 }"><spring:message code="system.revision"/> #${manuscript.revisionCount}</c:if>
								</small>
							</span>
						</span>
					</a>
				</li>
			</c:if>
		</ul>
		</div>
		<div class="col-md-10">
			<div class="tab-content">
				<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }manuscriptSummary">
					<customTagFile:manuscriptSummary locale="${locale}"/>
				</div>
				<c:if test="${(journal.type == 'C' or journal.type == 'D') and journal.paid == true and manuscript.status == 'R'}">
					<div class="tab-pane <c:if test="${v == 'reviewManagement'}">active</c:if> fade in" id="${pageType }reviewerSelection">
						<customTagFile:manuscriptSummaryHead/>
						<div id="${pageType }reviewerManagementDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
					</div>
				</c:if>
				<%@ include file="/WEB-INF/views/roles/common/manuscripts/reviewResults.jsp" %>
			</div>
		</div>
	</div>			
</div>

<%@ include file="/WEB-INF/views/roles/common/manuscripts/viewScripts.jsp" %>
<script>
var url = '${baseUrl}/journals/${jnid}';

function reviewerHistorySummaryView(revisionCount) {
	var summaryViewId = '#${pageType}' + revisionCount + 'reviewerHistorySummaryView';
	var summaryViewButtonId = '#${pageType}' + revisionCount + 'reviewerHistorySummaryButton';
	if($(summaryViewId).css("display") != "none") {
		$(summaryViewButtonId).html('<i class="fa fa-angle-down "></i>');
		$(summaryViewId).hide('normal');
	} else {
		$(summaryViewButtonId).html('<i class="fa fa-angle-up "></i>');
		$(summaryViewId).show('normal');
	}
}

jQuery(document).ready(function() {
	$('.${pageType}reviewerHistorySummaryView').hide();
	$.ajax({
		type: 'GET',
		url: url + "/chiefEditor/reviewers/${pageType}/manageReviewers",
		data: 'manuscriptId=' + '${manuscript.id}',
		success: function(html) {
			$('#' + "${pageType}" + 'reviewerManagementDisplay').html(html).show();
		}
	});
});
</script>
