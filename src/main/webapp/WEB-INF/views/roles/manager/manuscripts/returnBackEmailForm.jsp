<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title"><spring:message code="manager.action.returnBack"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="emailMessage" class="form-horizontal" id="returnBackEmailForm">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" id="subject" name="subject" value="${emailMessage.subject}" class="form-control" readonly>
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
					<textarea rows="15" cols="" id="body" name="body" class="form-control" readonly>
${emailMessage.body}
					</textarea>
					<span class="required">(<spring:message code="system.replaceCommentMessage"/>)</span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="manager.action.returnReason"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="5" cols="" id="comments" name="comments" class="form-control"></textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-6 col-md-6">
				<button type="button" id="returnBackButton" class="btn red">
					<i class="fa fa-undo"></i> <spring:message code="mail.sendEmail"/>
				</button>
			</div>
		</div>
	</div>
	</form:form>
</div>
<script>

$("#returnBackButton").click(function(event) {
	event.preventDefault();
	
	var comments = $('#comments').val();
	if(comments.trim() != '')
		$('#returnBackEmailForm').submit();
	else
		alert(errorMessages['manager.action.writeReason']);
}); 
</script>
