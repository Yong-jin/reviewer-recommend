<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/blueimp-gallery/blueimp-gallery.min.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload.css" rel="stylesheet"/>
<link href="${baseUrl}/assets/plugins/jquery-file-upload/css/jquery.fileupload-ui.css" rel="stylesheet"/>
<html>
<h4 class="marginBottom-30"><spring:message code="reviewer.reviewSheet"/></h4>
<div class="form-section_noborder">
	<form:form method="post" modelAttribute="review" id="reviewSheetForm" enctype="multipart/form-data">
	<div class="row">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<form:hidden path="manuscriptId" id="manuscriptId" value="${manuscript.id }"/>
			<form:hidden path="userId" value="${review.userId }" />
			<form:hidden path="id" id="reviewId" value="${review.id }" />
			<form:hidden path="status" value="${review.status }" />
			<form:hidden path="journalId" value="${review.journalId }" />
			<form:hidden path="revisionCount" id="revisionCount" value="${review.revisionCount }" />
			<form:hidden path="dueDate" value="${review.dueDate }" />
			<form:hidden path="dueTime" value="${review.dueTime }" />
			<form:hidden path="numberOfReviewItems" value="${jc.numberOfReviewItems }" />
			<c:set var="reReview" value="${review.revisionCount + 1 }"/>
			<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
				<c:set var="currentScoreId" value="${jc.getReviewItemId(index) }"/>
				<form:hidden path="reviewItemId${index }" value="${currentScoreId }"/>
				<c:if test="${currentScoreId != 1}">
					<div class="form-group marginBottom30 score${index }Div">
						<label class="control-label fontweight600"><spring:message code="review.item.${currentScoreId }"/></label>
						
							<div class="score${index } row">
								<label class="radio-inline col-md-offset-1 col-md-2">
								<form:radiobutton path="score${index }" value="1" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.poor"/></label>
								<label class="radio-inline col-md-2">
								<form:radiobutton path="score${index }" value="2" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.weak"/></label>
								<label class="radio-inline col-md-2">
								<form:radiobutton path="score${index }" value="3" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.average"/></label>
								<label class="radio-inline col-md-2">
								<form:radiobutton path="score${index }" value="4" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.good"/></label>
								<label class="radio-inline col-md-2">
								<form:radiobutton path="score${index }" value="5" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.excellent"/></label>
							</div>
						<span class="help-block">
						</span>
					</div>
				</c:if>
			</c:forEach>
			<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
				<c:set var="currentScoreId" value="${jc.getReviewItemId(index) }"/>
				<form:hidden path="reviewItemId${index }" value="${currentScoreId }"/>
				<c:if test="${currentScoreId == 1}">
					<div class="form-group marginBottom30 score${index }Div">
						<label class="control-label fontweight600"><spring:message code="review.item.${currentScoreId }"/></label>
						
							<div class="score${index } row">
								<label class="radio-inline col-md-offset-1 col-md-4" style="margin-right:0.8em;">
								<form:radiobutton path="score${index }" value="1" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.low"/></label>
								<label class="radio-inline col-md-4" style="margin-right:0.65em;">
								<form:radiobutton path="score${index }" value="2" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.medium"/></label>
								<label class="radio-inline col-md-2">
								<form:radiobutton path="score${index }" value="3" name="score${index }" class="score${index }Radio"/><spring:message code="reviewResult.high"/></label>
							</div>
						
						<span class="help-block">
						</span>
					</div>
				</c:if>
			</c:forEach>
			<div class="form-group marginBottom30 overallDiv">
				<label class="control-label fontweight600"><strong><spring:message code="reviewResult.overall"/></strong></label>
				<div class="overall row">
					<c:choose>
						<c:when test="${journal.type == 'A' or journal.type == 'C' }">
							<label class="radio-inline col-md-offset-1 col-md-2">
							<form:radiobutton path="overall" value="1" name="overall" class="overallRadio"/><spring:message code="reviewResult.strongReject"/></label>
							<label class="radio-inline col-md-2">
							<form:radiobutton path="overall" value="2" name="overall" class="overallRadio"/><spring:message code="reviewResult.reject"/></label>
							<label class="radio-inline col-md-2">
							<form:radiobutton path="overall" value="3" name="overall" class="overallRadio"/><spring:message code="reviewResult.marginal"/></label>
							<label class="radio-inline col-md-2">
							<form:radiobutton path="overall" value="4" name="overall" class="overallRadio"/><spring:message code="reviewResult.accept"/></label>
							<label class="radio-inline col-md-2">
							<form:radiobutton path="overall" value="5" name="overall" class="overallRadio"/><spring:message code="reviewResult.strongAccept"/></label>
						</c:when>
						<c:when test="${journal.type == 'B' or journal.type == 'D' }">
							<label class="radio-inline col-md-offset-3 col-md-4">
							<form:radiobutton path="overall" value="2" name="overall" class="overallRadio"/><spring:message code="reviewResult.reject"/></label>
							<label class="radio-inline col-md-2">
							<form:radiobutton path="overall" value="4" name="overall" class="overallRadio"/><spring:message code="reviewResult.accept"/></label>
						</c:when>
					</c:choose>
				
				</div>
				<span class="help-block">
				</span>
			</div>
			<c:if test="${journal.type == 'A' or journal.type == 'C' }">
				<div class="form-group marginBottom30 reReviewDiv">
					<label class="control-label fontweight600"><strong><spring:message code="reviewer.reReviewAsk"/></strong></label>
					<div class="overall row">
						<label class="radio-inline col-md-offset-1 col-md-2">
						<form:radiobutton path="reReview" id="reReviewYes" value="${reReview }" class="reReviewRadio"/><spring:message code="system.yes"/></label>
						<label class="radio-inline col-md-2">
						<form:radiobutton path="reReview" id="reReviewNo" value="0" class="reReviewRadio"/><spring:message code="system.no"/></label>
					</div>
					<span class="help-block">
					</span>
				</div>
			</c:if>
		</div>
	</div>
	<div class="row">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<div class="form-group commentAuthorDiv">
				<label class="control-label"><spring:message code="reviewResult.toAuthor2"/><span class="required">*</span></label>
				<div>
					<c:set var="toAuthor" value=""/>
					<c:if test="${commentToAuthor != null}"><c:set var="toAuthor" value="${commentToAuthor.text}"/></c:if>
					
					<form:textarea path="commentToAuthor.text" rows="10" id="commentToAuthor" name="commentToAuthor" type="text" maxlength="10000" class="form-control" value="${toAuthor }"/>
				</div>
				<span class="help-block">
				</span>
			</div>
			<div class="form-group commentEditorDiv">
				<label class="control-label"><spring:message code="reviewResult.toEditors2"/> (<spring:message code="reviewResult.confidentialToAuthors"/>)</label>
				<div>
					<c:set var="toEditor" value=""/>
					<c:if test="${commentToEditor != null}"><c:set var="toEditor" value="${commentToEditor.text}"/></c:if>
					<form:textarea path="commentToEditor.text" rows="10" type="text" maxlength="10000" name="commentToEditor" class="form-control" value="${toEditor }"/>
				</div>
				<span class="help-block">
				</span>
			</div>
			<div class="marginBottom30 checkbox-list pull-right">
				<span><spring:message code="system.commentShownToManager"/> <form:checkbox path="commentToEditor.scopeManager" value="1" checked="checked"/></span>
			</div>

			<div class="reReviewDiv">
			</div>
			<br/><br/>
		</div>
	</div>
	</form:form>
	<div class="row form-group">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<label class="control-label"><spring:message code="reviewResult.additionalFile"/></label>
			<br/><br/>
			<div id="uploadedFileView"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
			<br/><br/>
		</div>
	</div>
	<div class="row form-group fileupload-buttonbar">
		<label class="control-label col-md-2"></label>
		<div class="col-md-9">
			<form id="fileupload" enctype="multipart/form-data">
				<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
				<input type="hidden" name="reviewId" value="${review.id }"/>
				<div class="panel panel-normal">
					<div class="panel-heading">
						<h3 class="panel-title"><spring:message code="reviewer.uploadAdditionalReviewFile"/></h3>
					</div>
					<div class="panel-body">
						<div class="col-md-9">
							<select id="fileDesignationSelect" name="fileDesignationId" class="form-control input-sm select2 fileDesignationSelect">
								<c:forEach var="additionalReviewfileDesignation" items="${additionalReviewfileDesignations}">
									<option value="${additionalReviewfileDesignation.id}" <c:if test="${additionalReviewfileDesignation.id == 0}">selected</c:if>><spring:message code="reviewer.additionalReviewResult.fileDesignation.${additionalReviewfileDesignation.id}"/></option>
								</c:forEach>
							</select>
							<span id="fileDesignationSelect-help-block" class="help-block">
							</span>
						</div>
						<div class="col-md-offset-1 col-md-2">
							<!-- The fileinput-button span is used to style the file input field as button -->
							<span class="btn btn-default fileinput-button marginLeft-19">
								<i class="fa fa-plus"></i>
								<span>
									 <spring:message code="author.newPaperSubmit.addAndUpload"/>
								</span>
								<input type="file" name="files">

							</span>
						</div>
						<br/><br/><br/>
						<ul class="panel-text-ul">
							<li>
								 <spring:message code="system.fileUpload.fileSize"/>: <strong>10 MBytes</strong>
							</li>
							<li>
								 <spring:message code="system.fileUpload.fileType"/>: <strong>PDF, DOC</strong>
							</li>
						</ul>
					</div>
				</div>
			</form>
			<span class="help-block">
			</span>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-5 formRight">
					<button type="submit" id="saveReviewButton" class="btn blue" onClick="saveReview();">
						<i class="fa fa-floppy-o "></i> <spring:message code="system.save"/>
					</button>
				</div>
				<div class="col-md-offset-1 col-md-6 pull-left">
					<button type="submit" id="sendReviewButton" class="btn green">
						<spring:message code="reviewer.confirmAndSubmitReviewResults"/> <i class="m-icon-swapright m-icon-white"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
var recirculatoin = false;
<c:if test="${journal.type == 'A' or journal.type == 'C' }">
	recirculatoin = true;
</c:if>
function saveReview() {
	var overall = $('.overallRadio:checked').val();
	if(overall > 3) {
		$('#reReviewNo').attr("checked", true);
		$('#reReviewYes').attr("checked", false);
	}
	var parameter = $("#reviewSheetForm").serialize();
	$.ajax({
		type: 'POST',
		url: url + "/reviewer/reviews/saveReviewSheet",
		data: parameter,
		success: function(){
			toastr.options = {
					  "closeButton": true,
					  "debug": false,
					  "positionClass": "toast-top-right",
					  "onclick": null,
					  "showDuration": "1000",
					  "hideDuration": "1000",
					  "timeOut": "5000",
					  "extendedTimeOut": "1000",
					  "showEasing": "swing",
					  "hideEasing": "linear",
					  "showMethod": "fadeIn",
					  "hideMethod": "fadeOut"
					};

			toastr.success("<i class='fa fa-floppy-o'></i> <spring:message code='reviewer.reviewSheetSaved' javaScriptEscape='true' />");
			clearInterval(timer);
		}
	});
}
var url = "${baseUrl}/journals/${jnid}";
$('.reReviewDiv').hide();
var overall = 0;
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
errorMessages['reviewer.reviewCompleted'] = "<spring:message code='reviewer.reviewCompleted' javaScriptEscape='true' />";
if(reviewSheetView)
	timer = setInterval("saveReview()", 180000);	//3 minutes
else
	clearInterval(timer);

$(".fileDesignationSelect").select2({
	allowClear: true,
	dropdownAutoWidth: true,
	escapeMarkup: function (m) {
		return m;
	},
	containerCssClass: "muted"
});

$('#fileupload').fileupload({
	url : "${baseUrl}/journals/${jnid}/reviewer/reviews/upload.action",
	dataType: 'json',
	//replaceFileInput: false,
	add: function(e, data){
		var isValid = true;
		var uploadFile = data.files[0];
		if (!(/\.(pdf|doc|docx|tar|gzip)$/i).test(uploadFile.name)) {
			alert(errorMessages['system.fileUpload.fileTypeNotAllowed']);
			isValid = false;
		} else if (uploadFile.size > 10000000) { // 5mb
			alert(errorMessages['system.fileUpload.fileSizeExceed']);
			isValid = false;
		} 
		if(isValid)
			data.submit();
	},
	progressall: function(e,data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#uploadProgress .bar').css(
			'width',
			progress + '%'
		);
	},
	done: function (e, data) {
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/reviewer/reviews/uploadedFileTable",
			data: "manuscriptId=${manuscript.id}",
			success:function(html) {
				bootbox.alert(errorMessages['author.newPaperSubmit.uploadSuccess'], function() {
					$("#uploadedFileView").html(html).show();
				}); 
			}
		});
	},
	fail: function(){
		alert("server problem");
	}
});

$.ajax({
	type:"GET",
	url: "${baseUrl}/journals/${jnid}/reviewer/reviews/uploadedFileTable",
	data: "manuscriptId=${manuscript.id}",
	success:function(html) {
		$("#uploadedFileView").html(html).show();
	},
	error:function(request, status, error) {
		$("#uploadedFileView").html(html).show();
	}
});

$("#sendReviewButton").click(function(event) {
	var valid = true;
	var commentToAuthor = $('#commentToAuthor').val();
	if(commentToAuthor.trim() == '') {
		valid = false;
		bootbox.alert("Please leave a comment to author.");
		
	}
	
	<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
	if($(':radio[name="score${index }"]:checked').length < 1){
		valid = false;
		var item = "<spring:message code='review.item.${jc.getReviewItemId(index)}'/>";
		bootbox.alert("Please select " + item);
	}
	</c:forEach>
	if($(':radio[name="overall"]:checked').length < 1){
		valid = false;
		var item = "<spring:message code='reviewResult.overall'/>";
		bootbox.alert("Please select " + item);
	}
	
	if(valid) {
		bootbox.confirm("<spring:message code='system.areYouSure' javaScriptEscape='true' />", function(result) {
			if(result == true) {
				url = "${baseUrl}/journals/${jnid}";
				overall = $('.overallRadio:checked').val();
				if(overall > 3) {
					$('#reReviewNo').attr("checked", true);
					$('#reReviewYes').attr("checked", false);
				}
 				var parameter = $("#reviewSheetForm").serialize();
				$.ajax({
					type: 'POST',
					url: url + "/reviewer/reviews/confirmReviewSheet",
					data: parameter,
					success: function() {
						bootbox.alert(errorMessages['reviewer.reviewCompleted'], function() {
							location.href = "${baseUrl}/journals/${jnid}/reviewer/manuscripts";
						}); 
					}
				});
			}
		});
	}
});
<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
	$('.score${index}Radio').click(function() {
		$(".score${index}Div").css("color", "#1C853B");
		return true;
	});
</c:forEach>

$('.overallRadio').click(function() {
	$(".overallDiv").css("color", "#1C853B");
	overall = $('.overallRadio:checked').val();
	if(recirculatoin == true) {
		if(overall <= 3)
			$('.reReviewDiv').show('normal');
		else
			$('.reReviewDiv').hide('normal');
	}
});
</script>
</html>