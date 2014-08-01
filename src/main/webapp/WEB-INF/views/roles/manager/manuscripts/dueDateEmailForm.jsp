<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">
		<spring:message code="author.action.extendDueDate2"/>
	</h4>
</div>
<form:form modelAttribute="emailMessage" id="emailForm" class="uniForm">
<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="system.current"/> <spring:message code="author.dueDate"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					${defaultDueDate }
				</div>
				<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
			</fieldset>
		</div>
	</div>
	<c:if test="${requested == true }">
		<div class="row">
			<label class="control-label col-md-2">
				<spring:message code="system.requested"/> <spring:message code="author.dueDate"/>:
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						${requestedDueDate }
					</div>
				</fieldset>
			</div>
		</div>
	</c:if>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<input type="text" name="subject" value="${emailMessage.subject }" class="form-control" readonly />
				</div>
				<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
				<input type="hidden" id="updatedManuscriptSubmitDate" value="${defaultDueDate }"/>
				<input type="hidden" id="requestedSubmitDate" value="${requestedDueDate }"/>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2">
			<spring:message code="system.permitted"/> <spring:message code="author.dueDate"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<div class="input-group date date-picker"  <c:if test="${journal.languageCode == 'ko' }">data-date-format="yyyy년 mm월 dd일"</c:if> <c:if test="${journal.languageCode != 'ko' }">data-date-format="MM dd, yyyy"</c:if> data-date-start-date="+0d">
						<fmt:setLocale value="en_US" />
						<input type="text" id="dateString" name="dateString" class="form-control" value="${requestedDueDate }"/>
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
		<c:when test="${requested == true }">
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-offset-4 col-md-3">
						<button type="button" id="declineButton" class="btn btn-default">
							<i class="fa fa-undo"></i> <spring:message code="system.decline"/>
						</button>
					</div>
					<div class="col-md-2">
						<button type="button" id="sendButton" class="btn green">
							<spring:message code="manager.action.confirmAndSend"/>  <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>	
		</c:when>
		<c:otherwise>
		 	<div class="row">
				<div class="col-md-12">
					<div class="col-md-offset-5 col-md-7">
						<button type="button" id="sendButton" class="btn green">
							<spring:message code="manager.action.confirmAndSend"/>  <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
</form:form>
<script>
var emailType = "${emailType}";


var originalTextarea = $('#text').val();
var dueDate = $('#dateString').val();
var requestedSubmitDate = $('#requestedSubmitDate').val();
var replaced = originalTextarea.replace("[dueDate]", requestedSubmitDate);
$('#text').val(replaced);

$('#dateString').change(function(event) {
	event.preventDefault();
	dueDate = $('#dateString').val();
	replaced = originalTextarea.replace("[dueDate]", dueDate);
	$('#text').val(replaced);
});


$('#sendButton').click(function(event) {
	event.preventDefault();
	$("#emailForm").submit();
});

$('#declineButton').click(function(event) {
	event.preventDefault();
	var url = "${baseUrl}/journals/${jnid}/manager/manuscripts/declineExtendDueDate";
	$.ajax({
		type:"POST",
		url: url,
		data: "manuscriptId=${manuscript.id}",
		success:function(html) {
			location.href="${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=revisionRequested";
		}
	});
});

$('.date-picker').datepicker({
	language: 'en',
	autoclose: true
});

$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
</script>