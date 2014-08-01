<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<div id="declineDisplay" class="modalDialog"></div>
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
				<c:if test="${journal.paid == true and manuscript.status == 'R'}">
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
					<security:authorize ifAnyGranted="ROLE_A-EDITOR">
						<c:if test="${manuscript.status == 'O'}">
							<div class="form-section">
								<h4><spring:message code="system.takeinDecline"/></h4>
								<div class="form-group">
									<label class="control-label col-md-2"></label>
									<div class="col-md-9">
										<p class="form-control-static sentenseJustifyAlign">
											<spring:message code="associateEditor.takeDecline.desc"/>
										</p>
									</div>
								</div>

								<div class="row">
									<div class="col-md-offset-2 col-md-10">
										<div class="row">
											<div class="col-md-4 formRight">
												<button class="btn btn-default" onClick="decision(${manuscript.id}, 'D');"><i class="fa fa-undo"></i> <spring:message code="system.decline"/></button>
											</div>
											<div class="col-md-offset-1 col-md-7 pull-left">
												<button class="btn green" onClick="decision(${manuscript.id}, 'T');"><spring:message code="system.takein"/> <i class="m-icon-swapright m-icon-white"></i></button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</security:authorize>
					<customTagFile:manuscriptSummary locale="${locale}"/>
				</div>
				<c:if test="${journal.paid == true and manuscript.status == 'R'}">
					<div class="tab-pane <c:if test="${v == 'reviewManagement'}">active</c:if> fade in" id="${pageType }reviewerSelection">
						<customTagFile:manuscriptSummaryHead/>
						<div class="form-section_noborder">
							<h4><spring:message code="associateEditor.sendReviewResultToChiefEditor"/> &nbsp;<a id="${pageType }${manuscript.id}recommendButton" onClick="aeRecommendView(${manuscript.id});"><i class="fa fa-angle-down "></i></a></h4>
							<div id="${pageType }${manuscript.id}recommendView" class="${pageType }recommendView">
								<customTagFile:recommendToChief locale="${locale}"/>
							</div>
						</div>
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-9"><hr class="soften"/></div>
						</div>
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
var errorMessages = new Array();
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
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


function aeRecommendView(manuscriptId) {
	var recommendViewId = '#${pageType}' + manuscriptId + 'recommendView';
	var recommendViewButtonId = '#${pageType}' + manuscriptId + 'recommendButton';
	if($(recommendViewId).css("display") != "none") {
		$(recommendViewButtonId).html('<i class="fa fa-angle-down "></i>');
		$(recommendViewId).hide('normal');
	} else {
		$(recommendViewButtonId).html('<i class="fa fa-angle-up "></i>');
		$(recommendViewId).show('normal');
	}
}

function decision(manuscriptId, decision) {
	var data = "manuscriptId=" + manuscriptId;
	if(decision == 'T') {
		bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
			if(result == true) {
				$.ajax({
					type:"POST",
					url: "${baseUrl}/journals/${jnid}/associateEditor/manuscripts/take",
					data: data,
					success:function(html) {
						var revisionCount = "${manuscript.revisionCount}";
						if(Number(revisionCount) == 0)
							location.href = "${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts?pageType=submitted";
						else
							location.href = "${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts?pageType=reSubmitted";
					}
				});
			}
	
		});
	} else if(decision == 'D') {
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/associateEditor/manuscripts/decline",
			data: "manuscriptId=" + manuscriptId,
			success: function(html){
 				$("#declineDisplay").html(html);
			}
		});	
		$("#declineDisplay").show();
		$("#declineDisplay").dialog("open");
	}
}
jQuery(document).ready(function() {
	$('.${pageType }reviewerHistorySummaryView').hide();
	$('#' + "${pageType}${manuscript.id}" + 'recommendView').hide();
	<c:set var="reviewCompleteCount" value="0"/>
	<c:if test="${not empty manuscript.reviewList }">
		<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
			<c:forEach var="review" items="${reviews}">
				<c:if test="${review.status == 'C' and review.revisionCount == manuscript.revisionCount}">
					<c:set var="reviewCompleteCount" value="${reviewCompleteCount + 1}"/>
				</c:if>
			</c:forEach>

		</c:forEach>
	</c:if>
	<c:if test="${reviewCompleteCount >= jc.reviewCompleteCount }">
	$('#' + "${pageType}${manuscript.id}" + 'recommendView').show();
	</c:if>
	
	
	$.ajax({
		type: 'GET',
		url: url + "/associateEditor/reviewers/${pageType}/manageReviewers",
		data: 'manuscriptId=' + '${manuscript.id}',
		success: function(html) {
			$('#' + "${pageType}" + 'reviewerManagementDisplay').html(html).show();
		}
	});

	$("select.aeRecommend").select2({
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$("#declineDisplay").dialog({
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
});
</script>