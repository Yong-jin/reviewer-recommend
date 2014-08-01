<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<html>

<h4 class="marginBottom-30"><spring:message code="cameraReady.shortTitle"/></h4>
<div class="form-section_noborder">
	<div class="row form-group">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<br/><br/>
			<div id="${pageType}cameraReadyUploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
			<br/><br/>
		</div>
	</div>
	<c:if test="${manuscript.status == 'M' and manuscript.cameraReadyConfirm == false}">
		<div class="row form-group">
			<div class="col-md-offset-2 col-md-10">
				<div class="row">
					<div class="col-md-5 formRight">
						<button id="cameraReadyReturnBack" class="btn btn-default"><i class="fa fa-undo"></i> <spring:message code="manager.action.returnBack"/></button>
					</div>
					<div class="col-md-offset-1 col-md-6 pull-left">
						<button type="submit" id="cameraReadyConfirmButton" class="btn green">
							<spring:message code="manager.action.confirmCameraReady"/> <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</div>
<script>
var url = "${baseUrl}/journals/${jnid}";
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
errorMessages['system.areYouSure'] = "<spring:message code='system.areYouSure' javaScriptEscape='true' />";
$.ajax({
	type:"GET",
	url: "${baseUrl}/journals/${jnid}/manager/manuscripts/${pageType}/cameraReady/uploadedFileTable",
	data: "manuscriptId=${manuscript.id}",
	success:function(html) {
		$("#" + "${pageType}" + "cameraReadyUploadedFileView").html(html).show();
	},
	error:function(request, status, error) {
		$("#" + "${pageType}" + "${pageType}cameraReadyUploadedFileView").html(html).show();
	}
});

$("#cameraReadyConfirmButton").click(function(event) {
	bootbox.confirm(errorMessages['system.areYouSure'], function(result) {
		if(result == true) {
			var confirmUrl = "${baseUrl}/journals/${jnid}/manager/manuscripts/cameraReady/confirm";
			var data = "manuscriptId=${manuscript.id}";
			$.ajax({
				type:"POST",
				url: confirmUrl,
				data: data,
				success:function(html){
					location.href= "${baseUrl}/journals/${jnid}/manager/manuscripts?pageType=accepted";
				}
			});
		}
	});
});

var currentWidth = $(window).width();
var currentHeight = $(window).height();
$('#cameraReadyReturnBack').click(function(event){
	event.preventDefault();
	var manuscriptId = "${manuscript.id}";
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manager/manuscripts/cameraReady/returnBack",
		data: "manuscriptId=" + manuscriptId,
		success: function(html){
				$("#cameraReadyReturnBackDisplay").html(html);
		}
	});	
	$("#cameraReadyReturnBackDisplay").show();
	$("#cameraReadyReturnBackDisplay").dialog("open");
});
$("#cameraReadyReturnBackDisplay").dialog({
	width: currentWidth * 0.8,
	height: currentHeight * 0.7,
	resizable: true,
	modal:true,
	autoOpen: false,
 	show: {
		 effect: "slide",
		 duration: 500
	}
});

</script>

</html>