<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">
		<c:choose>
			<c:when test="${emailType == 'assignReviewer'}">
				<spring:message code="associateEditor.assignReviewerFormTitle"/>
			</c:when>
			<c:when test="${emailType == 'inviteReviewer'}">
				<spring:message code="associateEditor.inviteReviewerFormTitle"/>
			</c:when>
		</c:choose>
	</h4>
</div>
<form:form modelAttribute="emailMessage" id="emailForm" class="uniForm">

<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" name="subject" value="<c:if test="${manuscript.invite }">[<spring:message code="manuscript.inviteManuscript"/>] </c:if>${emailMessage.subject }" class="form-control" readonly />
				</div>
				<c:choose>
					<c:when test="${emailType == 'assignReviewer'}">
						<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
						<input type="hidden" name="reviewerUserId" value="${reviewer.id }"/>
					</c:when>
					<c:when test="${emailType == 'inviteReviewer'}">
						<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
						<input type="hidden" name="reviewerUserId" value="${reviewer.id }"/>
						<input type="hidden" name="randomQuery" value="${randomQuery }"/>
					</c:when>
				</c:choose>
			</fieldset>
		</div>
	</div>
	<c:if test="${emailType == 'assignReviewer'}">
		<div class="row">
			<label class="control-label col-md-2">
				<spring:message code="reviewResult.dueDate"/>:
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<div class="input-group date date-picker" <c:if test="${journal.languageCode == 'ko' }">data-date-format="yyyy년 mm월 dd일"</c:if> <c:if test="${journal.languageCode != 'ko' }">data-date-format="MM dd, yyyy"</c:if> data-date-start-date="+0d">
							<input type="text" id="dateString" name="dateString" class="form-control" value="${defaultDueDate }"/>
							<span class="input-group-btn">
								<button class="btn default calendarButton" type="button"><i class="fa fa-calendar"></i></button>
							</span>
						</div>
						<span class="help-block">
							 (<spring:message code="associateEditor.dueDateChangeMessage"/>)
						</span>
					</div>
				</fieldset>
			</div>
		</div>
	</c:if>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.text"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="15" cols="" id="text" name="body" class="form-control" readonly>${emailMessage.body }</textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<c:choose>
		<c:when test="${emailType == 'assignReviewer'}">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-offset-5 col-md-7">
						<button type="button" id="sendButton" class="btn green">
							<spring:message code="mail.assignAndsend"/>  <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>	
		</c:when>
		<c:when test="${emailType == 'inviteReviewer'}">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-offset-5 col-md-7">
						<button type="button" id="sendButton" class="btn green">
							<spring:message code="mail.inviteAndsend"/>  <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>
</div>
</form:form>
<script>
var emailType = "${emailType}";

if(emailType == 'assignReviewer') {
	var originalTextarea = $('#text').val();
	var dueDate = $('#dateString').val();
	var replaced = originalTextarea.replace("[dueDate]", dueDate);
	$('#text').val(replaced);
	
	$('#dateString').change(function(event) {
		event.preventDefault();
		dueDate = $('#dateString').val();
		replaced = originalTextarea.replace("[dueDate]", dueDate);
		$('#text').val(replaced);
	});
} else if(emailType == 'inviteReviewer') {
	var originalTextarea = $('#text').val();
	var replaced = originalTextarea.replace("[reviewInviteUrl]", "${homeUrl}/journals/${jnid}/reviewInvitation/${randomQuery}");
	replaced = replaced.replace("[durationReviewByWeeks]", "${durationReviewByWeeks}");
	$('#text').val(replaced);
}

$('#sendButton').click(function(event) {
	event.preventDefault();
	if(emailType == 'assignReviewer') {
		var parameter = $("#emailForm").serialize();
		$.ajax({
			type: 'POST',
			url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/assignReviewer",
			data: parameter,
			success: function(html){
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/reviewerTable",
					data: "manuscriptId=" + "${manuscript.id}", 
					success: function(html){
						$("#" + "${pageType}" + "reviewersDisplay").html(html).show();
						oTable1.fnDraw();
						oTable2.fnDraw();
					}
				});
				$("#emailFormDisplay").dialog("close");
			}
		});
	} else if(emailType == 'inviteReviewer') {
		var parameter = $("#emailForm").serialize();
		$.ajax({
			type: 'POST',
			url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/inviteReviewer",
			data: parameter,
			success: function(html){
				$.ajax({
					type: 'GET',
					url: "${baseUrl}/journals/${jnid}/${currentPageRole }/reviewers/${pageType}/reviewerTable",
					data: "manuscriptId=" + "${manuscript.id}", 
					success: function(html){
						$("#" + "${pageType}" + "reviewersDisplay").html(html).show();
						oTable1.fnDraw();
						oTable2.fnDraw();
					}
				});
				$("#emailFormDisplay").dialog("close");
			}
		});
	}
});

$('.date-picker').datepicker({
	autoclose: true
});

$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
</script>