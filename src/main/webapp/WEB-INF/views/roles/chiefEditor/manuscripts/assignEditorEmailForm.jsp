<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code="chiefEditor.assignAE"/></h4>
</div>
<div class="modal-body">
	<form:form commandName="emailMessage" class="form-horizontal" id="notifyEmailForm">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="user.role2.AE"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<select class="select2 form-control assignAE">
						<option value=""></option>
						<c:if test="${jc.manageDivision == true}">
							<c:forEach var="ae" items="${aeAll }">
								<c:set var="sameDivision" value="false"/>
								<c:if test="${not empty ae.userDivisions}">
									<c:forEach var="aeDivision" varStatus="varStatus" items="${ae.userDivisions }">
										<c:if test="${aeDivision.division.id == manuscript.divisionId }">
											<c:set var="sameDivision" value="true"/>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${sameDivision == true }">
									<option value="${ae.userId }">
										${ae.user.contact.firstName } ${ae.user.contact.lastName } 
										<c:if test="${not empty ae.userDivisions}">
											&nbsp;&nbsp;&nbsp; ( <spring:message code="manuscript.division"/> 
											<c:forEach var="aeDivision" varStatus="varStatus" items="${ae.userDivisions }">
												${aeDivision.division.symbol }
												<c:if test="${varStatus.count < fn:length(ae.userDivisions) }">
												,
												</c:if>
											</c:forEach>
											)
										</c:if>
									</option>
								</c:if>
							</c:forEach>
							<c:forEach var="ae" items="${aeAll }">
								<c:set var="sameDivision" value="false"/>
								<c:if test="${not empty ae.userDivisions}">
									<c:forEach var="aeDivision" varStatus="varStatus" items="${ae.userDivisions }">
										<c:if test="${aeDivision.division.id == manuscript.divisionId }">
											<c:set var="sameDivision" value="true"/>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${sameDivision == false }">
									<option value="${ae.userId }">
										${ae.user.contact.firstName } ${ae.user.contact.lastName } 
										<c:if test="${not empty ae.userDivisions}">
											&nbsp;&nbsp;&nbsp; ( <spring:message code="manuscript.division"/> 
											<c:forEach var="aeDivision" varStatus="varStatus" items="${ae.userDivisions }">
												${aeDivision.division.symbol }
												<c:if test="${varStatus.count < fn:length(ae.userDivisions) }">
												,
												</c:if>
											</c:forEach>
											)
										</c:if>
									</option>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${jc.manageDivision == false}">
							<c:forEach var="ae" items="${aeAll }">
								<option value="${ae.userId }">
									${ae.user.contact.firstName } ${ae.user.contact.lastName } 
								</option>
							</c:forEach>
						</c:if>
					</select>
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
					<input type="text" id="subject" name="subject" value="${emailMessage.subject }" class="form-control">
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
					<textarea rows="20" cols="" id="text" name="body" class="form-control" readonly>${emailMessage.body }</textarea>
					<span class="required">(<spring:message code="system.replaceCommentMessage"/>)</span>		

				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="messages.chiefEditorToAssociateEditorBeforeReviewProcess"/>:
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
		<label class="control-label col-md-2"></label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<div class="checkbox-list pull-right">
						<span><spring:message code="system.commentShownToManager"/>. <input type="checkbox" name="scopeToManager" value="1" checked></span>
					</div>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-5 col-md-7">
				<button type="button" id="notify" class="btn green">
					<spring:message code="chiefEditor.assignAndSendMail"/> <i class="m-icon-swapright m-icon-white"></i>
				</button>
			</div>
		</div>
	</div>
	<div id="userIdDiv"></div>
	</form:form>
</div>
<script>
var changed = false;
var originalTextarea = $('#text').val();
originalTextarea = originalTextarea.replace("Additional message from the chief editor", "<spring:message code='chiefEditor.additionalMessage' javaScriptEscape='true' />");
$('#text').val(originalTextarea);
var journalAddress = "/journals/" + "${jnid}";
$(".assignAE").select2({
	placeholder: "<i class='fa fa-group-o '></i>&nbsp;<spring:message code='associateEditor.selectAE' javaScriptEscape='true' />",
	allowClear: true,
	dropdownAutoWidth: true,
	escapeMarkup: function (m) {
		return m;
	},
	containerCssClass: "muted"
});
$('.select2-chosen').css("color", "#000");

$(".assignAE").change(function(event) {
    var selectedUserId = $(this).children("option:selected").val();
    if(selectedUserId != "") changed = true;
    else changed = false;
    
	$.ajax({
		type: 'GET',
		url: "${baseUrl}/journals/${jnid}/chiefEditor/manuscripts/getAssociateEditorInfo",
		data: "userId=" + selectedUserId,
		success: function(text){
			var dataString = text.split(",");
			var aeUsername = dataString[0];
			var replaced =  originalTextarea.replace("[AssociateEditor]", dataString[1]);
			replaced = replaced.replace(journalAddress, journalAddress + "?id=" + dataString[0]);
			$('#text').val(replaced);
			var hiddenText = '<input type="hidden" name="editorUserId" value="' + selectedUserId + '"/>';
			$('#userIdDiv').html(hiddenText);
		}
	});
});

$("#notify").click(function(event) {
	event.preventDefault();
	if(changed) {
		$('#notifyEmailForm').submit();
	} else
		bootbox.alert("You should select an associate editor");
});
</script>