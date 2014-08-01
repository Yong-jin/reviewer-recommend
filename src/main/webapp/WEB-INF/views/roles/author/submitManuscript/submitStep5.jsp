<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<title>Step 5</title>
	<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<link href="${baseUrl}/assets/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
	<link href="${baseUrl}/assets/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css" rel="stylesheet" type="text/css" >
	<link href="${baseUrl}/assets/plugins/typeahead/typeahead.css" rel="stylesheet" type="text/css">
	<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
	<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/headerBar.jsp" %>
<div class="page-container">
<div class="container">
		<div class="row page-boxed">
			<div class="col-md-12">
				<customTagFile:breadcrumb link_1="${baseUrl}/journals/${jnid }" label_1="system.journalHome"
																	link_2="${baseUrl}/journals/${jnid}/author/" label_2="user.role.journal_member"
																	link_3="${baseUrl}/journals/${jnid}/author/submitManuscript/" label_3="author.menu.submitNewManuscript"/>
																	
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#tab_1_1" data-toggle="tab">
								<spring:message code="author.menu.submitNewManuscript"/>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_1_1">
							<div class="portlet" id="form_wizard_1">
								<div class="portlet-body form">
									<div class="form-wizard">
										<form id="submit_form" action="${baseUrl}/journals/${jnid}/author/submitManuscript/step5" method="POST" class="form-horizontal">
											<%@ include file="/WEB-INF/views/roles/author/submitManuscript/formWizardNavigation.jsp" %>
											
											<div class="tab-content">
												<div class="tab-pane active submitManuscriptTab" id="tab5">
													<h3 class="block"><spring:message code="author.newPaperSubmit.tabMenu.5"/></h3>
													<br/>
													<customTagFile:manuscriptSummary locale="${locale}"/>'
													<c:if test="${jc.numberOfConfirms > 0 }">
														<div class="form-section_noborder">
															<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="author.newPaperSubmit.confirmations"/></h5>
															<div class="form-group">
															<label class="control-label col-md-2"></label>
															<div class="col-md-9">
																<div class="radio-list">
																	<c:forEach var="index" begin="1" end="${jc.numberOfConfirms }" step="1">
																		<label>
																		<input type="checkbox" name="confirm${index }" value="confirmed"/> 
																			${jc.getConfirm(index) }
																		</label>
																		<br/>
																	</c:forEach>
																</div>
															</div>
														</div>
													</c:if>
													<br/>
													<br/>
													<div class="row">
														<div class="col-md-offset-2 col-md-10">
															<div class="row">
																<div class="col-md-5 formRight">
																	<div id="way"></div>
																	<a href="#" id="back" class="btn default">
																		<i class="m-icon-swapleft"></i> <spring:message code="system.gotoback2"/>
																	</a>
																</div>
																<div class="col-md-offset-1 col-md-6 pull-left">
																	<a href="#" id="submit" class="btn green">
																		<spring:message code="author.newPaperSubmit.tabMenu.5"/> <i class="m-icon-swapright m-icon-white"></i>
																	</a>
																</div>
															</div>
														</div>
													</div>
													<br/>
													<br/>
												</div>
											</div>
										</form>
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
<script src="${baseUrl}/assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/typeahead/handlebars.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/author/submitFormWizard.js"></script>
</footer>
<script>
function historyView(manuscriptId, type) {
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/${currentPageRole}/manuscripts/viewManuscriptHistory?manuscriptId=${manuscript.id}&type=" + type,
		success: function(html){
			var displayId = "#" + "${pageType }" + type + "historyDisplay";
			var displayViewButtonId = "#" + "${pageType }" + type + "historyViewButton";
			var currentDisplayId = "#" + "${pageType }" + type + "historyCurrentDisplay";
			if($(displayId).css("display") != "none") {
				$(displayId).hide('normal');
				$(currentDisplayId).show('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-down "></i>');
			} else {
				$(displayId).html(html).show('normal');
				$(currentDisplayId).hide('normal');
				$(displayViewButtonId).html('<i class="fa fa-angle-up "></i>');
			}
		}
	});	
}

var errorMessages = new Array();
errorMessages['author.newPaperSubmit.keywordRequired'] = "<spring:message code='author.newPaperSubmit.keywordRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.minLength'] = "<spring:message code='author.newPaperSubmit.minLength' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.divisionRequired'] = "<spring:message code='author.newPaperSubmit.divisionRequired' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.checkConfirmations'] = "<spring:message code='author.newPaperSubmit.checkConfirmations' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.manuscriptSubmitComplete'] = "<spring:message code='author.newPaperSubmit.manuscriptSubmitComplete' javaScriptEscape='true' />";
errorMessages['author.newPaperSubmit.checkFiles'] = "<spring:message code='author.newPaperSubmit.checkFiles' javaScriptEscape='true' />";


jQuery(document).ready(function() {  
	jQuery('.historyView').hide();
	SubmitFormWizard.init("${baseUrl}/journals/${jnid}", "${manuscript.submitStep}", 5);
	
	jQuery("#back").click(function(event) {
		event.preventDefault();
		$('#way').html('<input type="hidden" name="way" value="Back"/>');
		$('#submit_form').submit();
	});

	jQuery("#submit").click(function(event) {
		event.preventDefault();
		
		var numConfirms = Number("${jc.numberOfConfirms}");
		var validation = true;
		if(numConfirms > 0) {
			var confirmValidCount = 0;
			for(var i=1; i<=numConfirms; i++)
				if($("input:checkbox[name='confirm" + i + "']").is(":checked"))
					confirmValidCount++;
			
			if(confirmValidCount != numConfirms) {
				validation = false;
				bootbox.alert(errorMessages['author.newPaperSubmit.checkConfirmations']);
			}
		}
		
		if(validation) {
			var url = "${baseUrl}/journals/${jnid}/author/submitManuscript/validateFileCount";
	 		jQuery.ajax({
				type:"GET",
				url: url,
				success:function(html){
					var fileCountValidate = html;
					if(fileCountValidate == false)
						bootbox.alert(errorMessages['author.newPaperSubmit.checkFiles']);
					else {
						$('#way').html('<input type="hidden" name="way" value="Forward"/>'); 
						App.scrollTo($('.steps'));
						$('#form_wizard_1').find('.progress-bar').css({
							width: '100%'
						});
						jQuery('li', $('#form_wizard_1')).removeClass("active").addClass("done");;
	
						bootbox.alert(errorMessages['author.newPaperSubmit.manuscriptSubmitComplete'], function() {
							$('#submit_form').submit();
						});  
					}
				}
			}); 
		} 
		
	});
	var li_list = $('.centerMenu');
	var index = Number("${menuNumber}");
	jQuery(li_list[index]).addClass("active");
});  
</script>
</body>
</html>