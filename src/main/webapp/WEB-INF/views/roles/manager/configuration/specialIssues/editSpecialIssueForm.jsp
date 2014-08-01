<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">
		<spring:message code="manager.config.specialIssueManagement"/>
	</h4>
</div>
<form:form modelAttribute="specialIssue" id="specialIssueForm" class="uniForm">
<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="manager.config.specialIssueTitle"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" name="title" value="${specialIssue.title }" class="form-control"/>
					<input type="hidden" name="id" value="${specialIssue.id }" class="form-control"/>
					<input type="hidden" name="journalId" value="${specialIssue.journalId }" class="form-control"/>
					<input type="hidden" name="guestEditorUserId" value="${specialIssue.guestEditorUserId }" class="form-control"/>
					<input type="hidden" name="submissionDueTime" value="${specialIssue.submissionDueTime }" class="form-control"/>
					<input type="hidden" name="creationDate" value="${specialIssue.creationDate }" class="form-control"/>
					<input type="hidden" name="creationTime" value="${specialIssue.creationTime }" class="form-control"/>
					<input type="hidden" name="status" value="${specialIssue.status }" class="form-control"/>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="manager.config.submitDueDate"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<div class="input-group date date-picker" <c:if test="${journal.languageCode == 'ko' }">data-date-format="yyyy년 mm월 dd일"</c:if> <c:if test="${journal.languageCode != 'ko' }">data-date-format="MM dd, yyyy"</c:if> data-date-start-date="+0d">
						<input type="text" id="dateString" name="dateString" class="form-control" value="${submissionDueDate }"/>
						<span class="input-group-btn">
							<button class="btn default calendarButton" type="button"><i class="fa fa-calendar"></i></button>
						</span>
					</div>
					<span class="help-block">
						 (<spring:message code="author.dueDateChangeMessage"/>)
					</span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="system.description"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="10" cols="" id="text" name="description" class="form-control">${specialIssue.description }</textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-5 col-md-2">
				<button type="button" id="deleteButton" class="btn btn-default">
					<i class="fa fa-trash-o"></i> <spring:message code="system.delete"/>
				</button>
			</div>
			<div class="col-md-2">
				<button type="button" id="sendButton" class="btn green">
					<i class="fa fa-floppy-o"></i> <spring:message code="system.save"/>
				</button>
			</div>
		</div>
	</div>	
</div>
</form:form>
<script>
$('#sendButton').click(function(event) {
	event.preventDefault();
	$("#specialIssueForm").submit();
});

$('#deleteButton').click(function(event) {
	event.preventDefault();
	bootbox.confirm('<spring:message code="system.areYouSure"/>', function(result) {
		if(result == true) {
			$.ajax({
				type:"POST",
				url: "${baseUrl}/journals/${jnid}/manager/configuration/specialIssues/deleteSpecialIssue",
				data: "specialIssueId=${specialIssue.id}",
				success:function(html) {
					location.href="${baseUrl}/journals/${jnid}/manager/configuration/specialIssues/manageSpecialIssue";
				}
			});
		}
	});

});


$('.date-picker').datepicker({
	autoclose: true
});

$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
</script>