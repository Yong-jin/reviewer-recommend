<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title"><spring:message code="system.decline"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="emailMessage" class="form-horizontal" id="declineEmailForm">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" id="subject" name="subject" value="${emailMessage.subject}" class="form-control">
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
					<textarea rows="15" cols="" id="text" name="body" maxlength="10000" class="form-control" readonly>
${emailMessage.body}
					</textarea>
					<span class="required">(<spring:message code="system.replaceCommentMessage"/>)</span>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2"><spring:message code="system.declineReason"/>:</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<select name="reason" class="select2 form-control reasonSelect">
						<c:forEach var="aeDeclineReason" items="${aeDeclineReasons}">
							<option value="${aeDeclineReason.id }"><spring:message code="associateEditor.decline.reason.${aeDeclineReason.id}"/></option>
						</c:forEach>
					</select>
				</div>
			</fieldset>
		</div>
	</div>
 	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="system.commentToEditorial"/>:
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
			<div class="col-md-offset-5 col-md-7">
				<button type="button" id="decline" class="btn red">
					<i class="fa fa-undo"></i> <spring:message code="mail.sendEmail"/>
				</button>
			</div>
		</div>
	</div>
	</form:form>
</div>
<script>
var changed = false;
var originalTextarea = $('#text').val();
originalTextarea = originalTextarea.replace("[aeName]", "${aeName}");
originalTextarea = originalTextarea.replace("[aeEmail]", "${aeEmail}");
$('#text').val(originalTextarea);
$(".reasonSelect").select2({
	allowClear: true,
	dropdownAutoWidth: true,
	escapeMarkup: function (m) {
		return m;
	},
	containerCssClass: "muted"
});
$('.select2-chosen').css("color", "#000");

$('#text').val(originalTextarea.replace("[decline reason]", $(".reasonSelect").children("option:selected").text()));
    
$(".reasonSelect").change(function(event) {
    var selectedText = $(this).children("option:selected").text();
    var replaced =  originalTextarea.replace("[decline reason]", selectedText);
    $('#text').val(replaced);
});
$("#decline").click(function(event) {
	event.preventDefault();
	$('#declineEmailForm').submit();

}); 
</script>
