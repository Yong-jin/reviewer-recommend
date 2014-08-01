<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code="chiefEditor.forceToReject"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="emailMessage" class="form-horizontal" id="forceToRejectForm">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="manuscript.title"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<span class="textJustify"><b>${manuscript.title}</b></span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input name="subject" class="form-control" value="${emailMessage.subject }" readonly/>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.text"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="15" cols="" id="text" name="body" class="form-control" readonly>${emailMessage.body }</textarea>
					<span class="required">(<spring:message code="system.replaceCommentMessage"/>)</span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="reviewResult.chiefEditorCommentsToAuthor2"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="10" cols="" id="comments" name="comments" class="form-control"></textarea>
					<input type="hidden" name="manuscriptId" value="${manuscript.id }" />
					<input type="hidden" name="journalId" value="${manuscript.journalId }"/>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-5 col-md-7">
				<button id="forceToRejectButton" class="btn red"><i class="fa fa-undo"></i> <spring:message code="chiefEditor.rejectAndSendMail"/></button>
			</div>
		</div>
	</div>
	</form:form>
</div>
<script>
var errorMessages = new Array();
errorMessages['editorCommon.writeReason'] = "<spring:message code='editorCommon.writeReason' javaScriptEscape='true' />";
$("#forceToRejectButton").click(function(event) {
	event.preventDefault();
	var comments = $('#comments').val();
	if(comments.trim() != '')
		$('#forceToRejectForm').submit();
	else
		bootbox.alert(errorMessages['editorCommon.writeReason']);
	
});
</script>