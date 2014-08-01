<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<title><spring:message code="manager.config.divisionManagement"/></title>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div id="editDivisionDisplay"></div>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/manager/" label_2="user.role.journal_manager"
																	link_3="${baseUrl}/journals/${jnid}/manager/configuration/divisions/manageDivisions" label_3="manager.config.divisionManagement"/>
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active" style="margin-bottom: -1px">
							<a id="chiefTab" href="#tab_1_1" data-toggle="tab">
								<spring:message code="manager.config.divisionManagement"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="form form-wizard" id="form_wizard_1">
								<div class="form-body">
									<div class="tab-content">
										<div class="tab-pane active" id="tab2">
											<div class="row">
												<label class="control-label col-md-2"></label>
												<div class="col-md-10">
													<div class="portlet">
														<div class="portlet-body" >
															<fieldset class="col-md-11">
																<spring:message code="manager.config.manageDivisionOrNot"/> 
																<c:set var="divisionManaging" value="false"/>
																<c:if test="${not empty divisions }">
																	<c:set var="divisionManaging" value="true"/>
																</c:if>
																<label class="radio-inline">
																	<input type="radio" name="divisionManageOrNot" id="divisionYes" class="divisionManageOrNot" value="1" <c:if test="${jc.manageDivision == true }">checked="checked"</c:if>/><spring:message code="system.yes"/>
																</label>
																<label class="radio-inline">
																	<input type="radio" name="divisionManageOrNot" id="divisionNo" class="divisionManageOrNot" value="0" <c:if test="${jc.manageDivision == false }">checked="checked"</c:if>/><spring:message code="system.no"/>
																</label>
															</fieldset>
														</div>
													</div>
												</div>
											</div>
											<br/><br/>
											<div id="divisionManageView">
												<h4><spring:message code="manager.config.createdDivisions"/></h4>
												<div class="row">
													<label class="control-label col-md-2"></label>
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body" >
																<fieldset class="col-md-11">
																	<div id = "divisionDisplay"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
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
													<label class="control-label col-md-2"><spring:message code="manager.config.createNewDivision"/></label>
													<form:form method="post" modelAttribute="division" id="register-form" class="register-form">
													<div class="col-md-10">
														<div class="portlet">
															<div class="portlet-body" >
															<fieldset class="col-md-11">
															<div class="row">
																<div class="form-group col-md-2">
																	<label class="control-label"><spring:message code="system.symbol"/></label>
																	<div>
																		<form:input path="symbol" type="text" class="form-control" maxlength="5" placeholder="e.g.) A or 1"/>
																		<span class="help-block">
																		</span>
																	</div>
																</div>	
																<div class="form-group col-md-10">
																	<label class="control-label"><spring:message code="system.division"/> <spring:message code="user.name"/></label>
																	<div>
																		<form:input path="name" type="text" class="form-control" maxlength="70"/>
																		<span class="help-block">
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
</div>
<footer>
<%@ include file="/WEB-INF/views/includes/footerBar.jsp" %>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wizard/jquery.bootstrap.wizard.min.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/typeahead.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manuscriptTable_jquery.dataTables.js" type="text/javascript" ></script>

<script src="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/select2/select2.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.pulsate.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/scripts/core/app.js"></script>
<script src="${baseUrl}/js/roles/datatable.js"></script>
<script src="${baseUrl}/js/roles/manager/signupDivision.js"></script>
</footer>
<script>

jQuery(document).ready(function() {
	SignupDivision.init("${baseUrl}/journals/${jnid}");
	var checkedValue = $('.divisionManageOrNot:checked').val();
	if(checkedValue == "1") {
		$.ajax({
			type: 'GET',
			url: "${baseUrl}/journals/${jnid}/manager/configuration/divisions/divisionTable",
			success: function(html){
				$("#divisionDisplay").html(html).show();
			}
		});
		$('#divisionManageView').show();
	} else
		$('#divisionManageView').hide();
		
	$('.divisionManageOrNot').click(function() {
		checkedValue = $('.divisionManageOrNot:checked').val();
		if(checkedValue == "1") {
			$.ajax({
				type: 'GET',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/divisions/divisionTable",
				success: function(html){
					$("#divisionDisplay").html(html).show();
				}
			});
			$('#divisionManageView').show('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=manageDivision&value=1",
				success: function(html){}
			});
		} else {
			$('#divisionManageView').hide('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=manageDivision&value=0",
				success: function(html){}
			});
		}

	});
});  
</script>
</body>
</html>