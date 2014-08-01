<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>

<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code="reviewer.reviewerHistory"/></h4>
</div>
<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-2"><spring:message code="user.name"/>: </label>
		<div class="col-md-10">
			<p class="form-control-static sentenseJustifyAlign" style="font-size: 12px">
				<c:choose>
					<c:when test="${journal.languageCode ==  'ko' and fn:trim(reviewerUser.contact.localFullName) != ''}">
						${reviewerUser.contact.localFullName }
					</c:when>
					<c:otherwise>
						${reviewerUser.contact.firstName } ${reviewerUser.contact.lastName }
					</c:otherwise>
				</c:choose>
				 (<a href="mailto:${reviewerUser.username }">${reviewerUser.username }</a>)
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2"><spring:message code="user.degree"/>: </label>
		<div class="col-md-10">
			<p class="form-control-static sentenseJustifyAlign" style="font-size: 12px">
				<spring:message code="signin.degreeDesignation.${reviewerUser.contact.degree }"/>
			</p>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2"><spring:message code="user.institutionSmallWidth"/>: </label>
		<div class="col-md-10">
			<p class="form-control-static sentenseJustifyAlign" style="font-size: 12px">
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(reviewerUser.contact.localInstitution) != '' }">
						${reviewerUser.contact.localInstitution }
					</c:when>
					<c:otherwise>
						${reviewerUser.contact.institution }
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${journal.languageCode == 'ko' and fn:trim(reviewerUser.contact.localDepartment) != '' }">
						, ${reviewerUser.contact.localDepartment }
					</c:when>
					<c:otherwise>
						<c:if test="${fn:trim(reviewerUser.contact.department) != '' }">
						, ${reviewerUser.contact.department }
						</c:if>
					</c:otherwise>
				</c:choose>
			</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<hr class="soften"/>
		</div>
	</div>
	<div class="statistics">
		<div class="row">
			<label class="control-label"></label>
			<div class="col-md-12">
				<table class="table">
					<tr>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.invitedAtThisTimeInThisJournal"/>
						</th>
						<th style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.invitedUpToNowInThisJournal"/>
						</th>
						<th class="borderTop0 width70" style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.invitedAtThisTime"/>
						</th>
						<th style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.invitedUpToNow"/>
						</th>
					</tr>
					<tr>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "I", "true", "true");'><h4 class="margin0 fontWeight600">${invitedAtThisTimeInJournal }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "I", "false", "true");'><h4 class="margin0 fontWeight600">${invitedUpToNowInJournal }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "I", "true", "false");'><h4 class="margin0 fontWeight600">${invitedAtThisTime }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "I", "false", "false");'><h4 class="margin0 fontWeight600">${invitedUpToNow }</h4></a></td>
					</tr>
				</table>
				<br/>
				<table class="table">
					<tr>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.assignedAtThisTimeInThisJournal"/>
						</th>
						<th style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.assignedUpToNowInThisJournal"/>
						</th>
						<th class="borderTop0 width70" style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.assignedAtThisTime"/>
						</th>
						<th style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.assignedUpToNow"/>
						</th>

					</tr>
					<tr>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "A", "true", "true");'><h4 class="margin0 fontWeight600">${assignedAtThisTimeInJournal }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "A", "false", "true");'><h4 class="margin0 fontWeight600">${assignedUpToNowInJournal }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "A", "true", "false");'><h4 class="margin0 fontWeight600">${assignedAtThisTime }</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "A", "false", "false");'><h4 class="margin0 fontWeight600">${assignedUpToNow }</h4></a></td>
					</tr>
				</table>
				<br/>
				<table class="table">
					<tr>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.completedUpToNowInThisJournal"/>
						</th>
						<th class="width70 borderTop0" style="border-top: 1px solid #fff !important; border-bottom: 1px solid #fff !important;"></th>
						<th class="cellCenter borderTop0">
							<spring:message code="reviewer.completedUpToNow"/>
						</th>

					</tr>
					<tr>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "C", "false", "true");'><h4 class="margin0 fontWeight600">${completedUpToNowInJournal}</h4></a></td>
						<td class="cellCenter borderTop0"></td>
						<td class="cellCenter borderTop0"><a onClick='manuscriptTable("${reviewerUserId }", "C", "false", "false");'><h4 class="margin0 fontWeight600">${completedUpToNow}</h4></a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="manuscriptInfo">
		<div id="reviewerHistory-t"></div>
		<div id="reviewerHistory"></div>
	</div>
</div>

<script src="${baseUrl}/js/roles/common/reviewers/reviewerHistoryTable-ajax.js"></script>
<script>
$('#manuscriptInfo').hide();
function backToStatistics() {
	$('#manuscriptInfo').hide();
	$('#reviewerHistory-t').hide();
	$('#reviewerHistory').hide();
	$('.statistics').show('normal');
}

function manuscriptTable(reviewerUserId, status, t, j) {
	$('.statistics').hide('normal');
	$('#manuscriptInfo').show();
	$('#reviewerHistory-t').html('<div class="loadingCenter"><img src="images/loading.gif"/></div>').show();	
	var url = "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/reviewerHistoryTable?reviewerUserId=" + reviewerUserId + "&status=" + status + "&t=" + t + "&j=" + j;
	jQuery.ajax({
		type:"GET",
		url: url,
		success:function(html){
			$('#reviewerHistory-t').html(html).show('normal');
		}
	});
}

function viewManuscript(manuscriptId) {
	$('#reviewerHistory-t').hide();
	$('#reviewerHistory').html('<div class="loadingCenter"><img src="images/loading.gif"/></div>').show();	
	var url = "${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts/reviewerHistory/viewManuscript?manuscriptId=" + manuscriptId + "&v=summary";
	jQuery.ajax({
		type:"GET",
		url: url,
		success:function(html){
			$('#reviewerHistory').hide();
			$('#reviewerHistory').html(html).show('normal');
		}
	});
}

$(document).ready(function() {
	$(".form-filter").on("keyup change", function () {
		oTable.fnFilter( this.value, $(".form-filter").index(this) );
	});
});
</script>