<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title"><spring:message code="messages.managerToAuthorWhileRetuningCameraReady"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="comment" class="form-horizontal" id="commentForm">
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
			<spring:message code="messages.managerToAuthorWhileRetuningCameraReady"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="7" cols="" id="text" name="text" class="form-control"></textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-5 col-md-7">
				<button id="returnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="manager.action.returnBack"/></button>
			</div>
		</div>
	</div>
	</form:form>
</div>
<script>
var errorMessages = new Array();
errorMessages['manager.action.writeReason'] = "<spring:message code='manager.action.writeReason' javaScriptEscape='true' />";
$("#returnBack").click(function(event) {
	event.preventDefault();
	var text = $('#text').val();
	if(text.trim() == '')
		alert(errorMessages['manager.action.writeReason']);
	else
		$('#commentForm').submit();
}); 
</script>
