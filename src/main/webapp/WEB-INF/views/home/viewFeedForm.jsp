<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title">
		<spring:message code="signin.email"/>
	</h4>
</div>
<div class="modal-body">
	<div class="row">
		<label class="control-label col-md-1">
			<spring:message code="mail.subject"/>:
		</label>
		<div class="col-md-11">
			<fieldset class="col-md-11">
				<div class="form-group ">
					<p class="form-control-static sentenseJustifyAlign" style="text-align:left;">
						${emailDelivery.emailMessage.subject }
					</p>
				</div>
			</fieldset>
		</div>
	</div>
	<br/>
	<div class="row">
		<label class="control-label col-md-1">
			<spring:message code="mail.text"/>:
		</label>
		<div class="col-md-11">
			<fieldset class="col-md-11">
				<div class="form-group">
					<p class="form-control-static sentenseJustifyAlign" style="text-align:left;">
						${emailDelivery.emailMessage.body }
					</p>
				</div>
			</fieldset>
		</div>
	</div>
</div>
<script>
$('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
</script>