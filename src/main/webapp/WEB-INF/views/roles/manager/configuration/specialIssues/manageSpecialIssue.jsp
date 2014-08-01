<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="manager.config.specialIssueManagement"/></title>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/assets/plugins/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div id="editSpecialIssueDisplay" class="modalDialog"></div>
<div class="page-container">
	<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/manager/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/manager/configuration/spcialIssue/manageSpecialIssue" label_3="manager.config.specialIssueManagement"/>
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active" style="margin-bottom: -1px">
							<a id="chiefTab" href="#tab_1_1" data-toggle="tab">
								<spring:message code="manager.config.specialIssueManagement"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="form form-wizard" id="form_wizard_1">
								<div class="form-body">
									<div class="tab-content">
										<div class="tab-pane active" id="tab2">
											<h4><spring:message code="manager.config.createdSpecialIssues"/></h4>
											<div class="row">
												<label class="control-label col-md-2"></label>
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body" >
															<fieldset class="col-md-11">
																<div id="specialIssueDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
															</fieldset>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-2">
												</div>
												<div class="col-md-9 paddingLeft30">
													<hr class="soften"/>
												</div>
											</div>
											<div class="row">
												<label class="control-label col-md-2"><spring:message code="manager.config.createSpecialIssue"/></label>
												<form:form method="post" modelAttribute="specialIssue" id="register-form" class="register-form">
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body" >
														<fieldset class="col-md-11">
														<div class="row">
															<div class="form-group col-md-12">
																<label class="control-label"><spring:message code="manager.config.specialIssueTitle"/></label>
																<div>
																	<form:input path="title" type="text" class="form-control" maxlength="70"/>
																	<form:input path="journalId" type="hidden" value="${journal.id }"/>
																	<span class="help-block">
																	</span>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="form-group col-md-12">
																<label class="control-label"><spring:message code="manager.config.submitDueDate"/></label>
																<div class="form-group">
																	<div class="input-group date date-picker" <c:if test="${journal.languageCode == 'ko' }">data-date-format="yyyy년 mm월 dd일"</c:if> <c:if test="${journal.languageCode != 'ko' }">data-date-format="MM dd, yyyy"</c:if> data-date-start-date="+0d">
																		<input type="text" id="dateString" name="dateString" class="form-control" value="${defaultDueDate }"/>
																		<span class="input-group-btn">
																			<button class="btn default calendarButton" type="button"><i class="fa fa-calendar"></i></button>
																		</span>
																	</div>
																	<span class="help-block">
																		 (<spring:message code="author.dueDateChangeMessage"/>)
																	</span>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="form-group col-md-12">
																<label class="control-label"><spring:message code="system.description"/></label>
																<div>
																	<form:textarea path="description" rows="5" type="text" class="form-control"/>
																	<span class="help-block">
																	</span>
																</div>
															</div>
														</div>
														<div class="row"> 
															<div class="form-group col-md-12">
																<button type="submit" id="register-submit-btn" class="btn green pull-right">
																	<spring:message code="system.createAndSave"/> <i class="m-icon-swapright m-icon-white"></i>
																</button>
															</div>
														</div>
														</fieldset>
														</div>
													</div>
												</div>
												</form:form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/js/roles/datatable.js"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_DT_bootstrap.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/signupSpecialIssue.js"></script>
<script src="${baseUrl}/js/roles/manager/specialIssueTable-ajax.js"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>
</footer>
<script>
function editSpecialIssue(specialIssueId) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manager/configuration/specialIssues/editSpecialIssue",
		data: "specialIssueId=" + specialIssueId,
		success: function(html){
			$("#editSpecialIssueDisplay").html(html);
		}
	});	
	$("#editSpecialIssueDisplay").show();
	$("#editSpecialIssueDisplay").dialog("open");
}
jQuery(document).ready(function() {
	SignupSpecialIssue.init("${baseUrl}/journals/${jnid}");

	$.ajax({
		type: 'GET',
		url: "${baseUrl}/journals/${jnid}/manager/configuration/specialIssues/specialIssueTable",
		success: function(html){
			$("#specialIssueDisplay").html(html).show();
		}
	});
	
	$("#editSpecialIssueDisplay").dialog({
		width: currentWidth * 0.8,
		height: currentHeight * 0.8,
		resizable: true,
		modal:true,
		autoOpen: false,
	 	show: {
			 effect: "slide",
			 duration: 500
		}
	});
	
	$('.date-picker').datepicker({
		autoclose: true
	});
});  
</script>
</body>
</html>