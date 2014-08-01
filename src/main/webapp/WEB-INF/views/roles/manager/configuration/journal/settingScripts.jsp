<script src="${baseUrl}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap/js/bootstrap2-typeahead.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/jquery.validate.js" type="text/javascript" ></script>
<script src="${baseUrl}/assets/plugins/jquery-validation/dist/additional-methods.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/components-form-tools.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/jquery.imgareaselect.pack.js"></script>
<script src="${baseUrl}/js/roles/jquery.fileupload.js"></script>
<script src="${baseUrl}/js/custom_global.js"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-wysihtml5/wysihtml5-0.3.0.js" type="text/javascript"></script>
<script src="${baseUrl}/js/roles/manager/bootstrap-wysihtml5.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/moment.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/jquery.mockjax.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-editable/bootstrap-editable/js/bootstrap-editable.min.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-editable/inputs-ext/address/address.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-editable/inputs-ext/wysihtml5/wysihtml5.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-markdown/js/bootstrap-markdown.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script>
<script src="${baseUrl}/assets/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script>
<script src="${baseUrl}/js/homes/ui-extended-modals.js"></script>
<script>
var errorMessages = new Array();
errorMessages['author.newPaperSubmit.uploadSuccess'] = "<spring:message code='author.newPaperSubmit.uploadSuccess' javaScriptEscape='true' />";
errorMessages['journal.required.journalNameId'] = "<spring:message code='journal.required.journalNameId' javaScriptEscape='true' />";
errorMessages['journal.required.title'] = "<spring:message code='journal.required.title' javaScriptEscape='true' />";
errorMessages['journal.required.shortTitle'] = "<spring:message code='journal.required.shortTitle' javaScriptEscape='true' />";
errorMessages['journal.required.organization'] = "<spring:message code='journal.required.organization' javaScriptEscape='true' />";
errorMessages['journal.required.coverImage'] = "<spring:message code='journal.required.coverImage' javaScriptEscape='true' />";
errorMessages['journal.coverImage.invalidFileType'] = "<spring:message code='journal.coverImage.invalidFileType' javaScriptEscape='true' />";
errorMessages['system.error.minlength'] = "<spring:message code='system.error.minlength' javaScriptEscape='true' />";
errorMessages['system.error.maxlength'] = "<spring:message code='system.error.maxlength' javaScriptEscape='true' />";
errorMessages['journal.coverImage.tooBigSize(2MB)'] = "<spring:message code='journal.coverImage.tooBigSize(2MB)' javaScriptEscape='true' />";
errorMessages['journal.required.language'] = "<spring:message code='journal.required.language' javaScriptEscape='true' />";
errorMessages['journal.required.punlisherCountry'] = "<spring:message code='journal.required.punlisherCountry' javaScriptEscape='true' />";
errorMessages['journal.lowercase.journalNameId'] = "<spring:message code='journal.lowercase.journalNameId' javaScriptEscape='true' />";	
errorMessages['journal.required.homepage'] = "<spring:message code='journal.required.homepage' javaScriptEscape='true' />";	
errorMessages['journal.required.correctURL'] = "<spring:message code='journal.required.correctURL' javaScriptEscape='true' />";
errorMessages['newJournalSubmit.language.help'] = "<spring:message code='newJournalSubmit.language.help' javaScriptEscape='true' />";	
errorMessages['newJournalSubmit.country.help'] = "<spring:message code='newJournalSubmit.country.help' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileSizeExceed'] = "<spring:message code='system.fileUpload.fileSizeExceed' javaScriptEscape='true' />";
errorMessages['system.fileUpload.fileTypeNotAllowed'] = "<spring:message code='system.fileUpload.fileTypeNotAllowed' javaScriptEscape='true' />";
var coverImageUploadSuccess = false;
var journalId = "${journal.id}";
var url = "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration";
var journalInfoUrl = "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveJournalInfo";
var journalCategoryUrl = "submitJournal/getCategories";
var upperCategory = "${upperCategory}";
var numConfirms = "${jc.numberOfConfirms }";
var numReviewItems = "${jc.numberOfReviewItems}";
var error = $('.alert-danger', form);
var success = $('.alert-success', form);
var pageType = "${pageType}";
var setupStep = "${jc.setupStep}";
var currentStep = "${step}";
var form = $('#submit_form');
var validateResult = false;

function preview(img, selection) {
    var scaleX = 150 / (selection.width || 1);
    var scaleY = 210 / (selection.height || 1);
    
    $('img[id="previewImage"]').css({
        width: Math.round(scaleX * img.width) + 'px',
        height: Math.round(scaleY * img.height) + 'px',
        marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
        marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
    });
    
	$('input[name="x1"]').val(selection.x1);
	$('input[name="y1"]').val(selection.y1);
	$('input[name="x2"]').val(selection.x2);
	$('input[name="y2"]').val(selection.y2);
	$('input[name="w"]').val(img.width);
	$('input[name="h"]').val(img.height);
	$('input[name="imgName"]').val(saveFileName);   
};

function imgSelInitial() {
	var coords;
	var height = ( this.width / 5 ) * 7;
    if( height <= this.height ){     
		var diff = ( this.height - height ) / 2;
		coords = { x1 : 0 + 10, y1 : diff + 14, x2 : this.width - 10, y2 : height + diff - 14 };
    } else { // if new height out of bounds, scale width instead
		var width = ( this.height / 7 ) * 5; 
		var diff = ( this.width - width ) / 2;
		coords = { x1 : diff + 10, y1 : 0 + 14, x2 : width + diff - 10, y2: this.height - 14 };
    }   
	$( this ).imgAreaSelect(coords);	
	$('input[name="imgName"]').val(saveFileName);
};


function format(state) {
    if (!state.id) return state.text; // optgroup
    return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
}

function setResult(result) {
	validateResult = result;
}

function validateStep(currentStep) {
	if(currentStep == 0) {
		if($('.myLocalAccount-form').valid()) {
			$.ajax({
				type: 'POST',
				url: '${baseUrl}/account/myLocalInfoSave',
				data: $('.myLocalAccount-form').serialize(),
				async: false,
				success: function(response) {
					setResult(true);
				}
			});
		}
	} else if(currentStep == 1) {
		if($('#submit_form').valid())
			setResult(true);
	} else if(currentStep == 2) {
		setResult(true);
	} else if(currentStep == 3) {
		$.ajax({
			type: 'POST',
			url: '${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/reviewItemCheck',
			async: false,
			success: function(response) {
				if(Boolean(response) == false)
					alert("Please check duplicated review items");
				setResult(Boolean(response));
			}
		});
	} else if(currentStep == 4) {
		setResult(true);
	} else if(currentStep == 5) {
		setResult(true);
	}
	return validateResult;
}

function moveTo(step, direction) {
	var currentStep = Number(step);
	if(validateStep(currentStep)) {
		if(direction == 'forward')	{
			var next = currentStep + 1;
			if(next > 6)
				location.href="${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/step/1";
			else if(next == 0) {
				$.ajax({
					type: 'POST',
					url: '${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/completeSubmission',
					success: function(response) {
						alert("Configuration Success");
						location.href="${baseUrl}/journals/${jnid}";
					}
				});
			} else
				location.href="${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/step/" + next;
		} else {
			var previous = currentStep - 1;
			location.href="${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/step/" + previous;
		}
	}
}

jQuery(document).ready(function() {
	<c:if test="${pageType == 'setup'}">
		$('.stepClick').click(function(event) {
			var h = $(this).attr("href");
			var hs = h.split("_");
			var stepTogo = hs[2];
			var result = validateStep(Number(currentStep));
			if(stepTogo <= setupStep) {
				if(result == true)
					location.href="${baseUrl}/journals/${jnid}/manager/configuration/journal/setup/step/" + stepTogo;
			} else {
				alert("You should complete previous step");
			}
		});
		$('#select2_jobTitle').select2();
	</c:if>
	
	/* Basic Information */
    $('#title').editable({
        url: journalInfoUrl,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'title',
        validate: function (value) {
            if (value == '') return errorMessages['journal.required.title'];
            if(value.length < 2) return errorMessages['system.error.minlength'].replace("{0}", 2);
            if(value.length > 200)	return errorMessages['system.error.maxlength'].replace("{0}", 200);
        },
    });
    
    $('#shortTitle').editable({
        url: journalInfoUrl,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'shortTitle',
        validate: function (value) {
            if (value == '') return errorMessages['journal.required.shortTitle'];
            if(value.length < 2) return errorMessages['system.error.minlength'].replace("{0}", 2);
            if(value.length > 8)	return errorMessages['system.error.maxlength'].replace("{0}", 8);
        },
    });
    
    $('#homepage').editable({
        url: journalInfoUrl,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'homepage',
        validate: function (value) {
            if (value == '') return errorMessages['journal.required.homepage'];
            if(value.indexOf("http://") != -1 || value.indexOf("https://") != -1) {
            	
            } else
            	return errorMessages['journal.required.correctURL'];
        },
    });
    
	$('#organization').editable({
        url: journalInfoUrl,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'organization',
        validate: function (value) {
            if (value == '') return errorMessages['journal.required.organization'];
            if(value.length < 2) return errorMessages['system.error.minlength'].replace("{0}", 2);
            if(value.length > 300)	return errorMessages['system.error.maxlength'].replace("{0}", 300);
        },
    });
	
	$("#select2_country").val("${journal.countryCode}").attr("selected", "selected");
	$("#select2_country").select2({
        allowClear: true,
        formatResult: format,
        formatSelection: format,
        escapeMarkup: function (m) {
            return m;
        }
    });
    $('#select2_country').change(function(event) {
    	var selectedValue = $(this).children("option:selected").val();
		$.ajax({
			type:"POST",
			url: journalInfoUrl,
			data: "name=countryCode&value=" + selectedValue,
			success:function(html) {
				
			}
		});
    });
    
    $("#select2_language").val("${journal.languageCode}").attr("selected", "selected");
	$("#select2_language").select2();
    $('#select2_language').change(function(event) {
   		var selectedValue = $(this).children("option:selected").val();
		$.ajax({
			type:"POST",
			url: journalInfoUrl,
			data: "name=languageCode&value=" + selectedValue,
			success:function(html) {
				
			}
		});
	});
    
    $("#select2_upperCategory").val(upperCategory).attr("selected", "selected");
	$("#select2_upperCategory").select2();
	$.ajax({
		type:"GET",
		url: journalCategoryUrl,
		data: "upperCategory=" + upperCategory + "&journalId=" + journalId,
		success:function(html) {
			$('#lowerCategory').html(html).show();
			var selectedLowerCategories = "";
		    <c:forEach var="journalCategory" items="${journalCategories}">
	    		$("#lowerCategory > option[value='" + "${journalCategory.name}" + "']").attr("selected", true);
	    		selectedLowerCategories += "<spring:message code='journal.category.${journalCategory.name}'/><br/>"
	    	</c:forEach>
	    	$('#currentLowerCategory').html(selectedLowerCategories);
		}
	});
	
    $("#select2_upperCategory").change(function(event) {
   		var selectedValue = $(this).children("option:selected").val();
   		upperCategory = selectedValue;
		$.ajax({
			type:"GET",
			url: journalCategoryUrl,
			data: "upperCategory=" + upperCategory + "&journalId=" + journalId,
			success:function(html) {
				$('#lowerCategory').html(html).show();
				var selectedLowerCategories = "";
		   	    <c:forEach var="journalCategory" items="${journalCategories}">
		   	 	$("#lowerCategory > option[value='" + "${journalCategory.name}" + "']").attr("selected", true);
		   	 	selectedLowerCategories += "<spring:message code='journal.category.${journalCategory.name}'/><br/>"
				</c:forEach>
		   		$('#currentLowerCategory').html(selectedLowerCategories);
			}
		});
	});
    
    $("#lowerCategory").change(function(event) {
		var selectedValue = $("#lowerCategory").val();
		var selectedText = $("#lowerCategory > option:selected");
		var selectedNames = "";
		for(var i=0; i<selectedText.length; i++) {
			selectedNames += selectedText[i].text + "<br/>";
		}
		$.ajax({
			type:"POST",
			url: "submitJournal/saveCategories",
			data: "name=journalCategory&value=" + selectedValue + "&journalId=" + journalId,
			success:function(html) {
				$.ajax({
					type:"GET",
					url: journalCategoryUrl,
					data: "upperCategory=" + upperCategory + "&journalId=" + journalId,
					success:function(html) {
						$('#currentLowerCategory').html(selectedNames);
					}
				});
			}
		});
	});
    
	$("#select2_journalType").val("${journal.type}").attr("selected", "selected");
	$("#select2_journalType").select2();
    $('#select2_journalType').change(function(event) {
   		var selectedValue = $(this).children("option:selected").val();
		$.ajax({
			type:"POST",
			url: journalInfoUrl,
			data: "name=type&value=" + selectedValue,
			success:function(html) {
				
			}
		});
   });
    
	$('.previewDiv').hide();
	$('.cropMessage').hide();

	$.validator.addMethod(
        "filesize", 
        function(value, element) {
        	return file.files[0].size < 2097152;
        },
        errorMessages['journal.coverImage.tooBigSize(2MB)']
	);
	$('.myLocalAccount-form').validate({
	    errorElement: 'span', //default input error message container
	    errorClass: 'help-block', // default input error message class
	    focusInvalid: false, // do not focus the last invalid input
	    rules: {
	        "contact.localFullName": {
	            required: true,
	            minlength: 2,
	            maxlength: 50,
	        },
	        "contact.localInstitution": {
	     	   required: true,
	     	   minlength: 2,
	     	   maxlength: 70,
	        },
	        "contact.localDepartment": {
	     	   required: false,
	     	   minlength: 2,
	     	   maxlength: 70,
	        },
	    },
	    messages: {
	        "contact.localFullName": {
	            required: errorMessages['user.required.fullnameNative'],
	            minlength: jQuery.format(errorMessages['user.required.minlength']),
	            maxlength: jQuery.format(errorMessages['user.required.maxlength'])
	        },
	        "contact.localInstitution": {
	     	   required: errorMessages['user.required.localInstitution'],
	     	   minlength: jQuery.format(errorMessages['user.required.minlength']),
	            maxlength: jQuery.format(errorMessages['user.required.maxlength'])
	        },
	        "contact.localDepartment": {
	     	   required: errorMessages['user.required.localDepartment'],
	     	   minlength: jQuery.format(errorMessages['user.required.minlength']),
	            maxlength: jQuery.format(errorMessages['user.required.maxlength'])
	        },
	    },
	    errorPlacement: function (error, element) { // render error placement for each input type
	    	element.next('span.help-block').replaceWith(error);
	    },
	    invalidHandler: function (event, validator) { //display error alert on form submit   
	    
	    },
	    highlight: function (element) { // hightlight error inputs
	        $(element)
	            .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
	    },
	    unhighlight: function (element) { // revert the change done by hightlight
	        $(element)
	            .closest('.form-group').removeClass('has-error'); // set error class to the control group
	    },
	    success: function (errorLabel, element) { 
	 	   errorLabel.addClass('valid').closest('.form-group').removeClass('has-error').addClass('has-success'); 
	    },
	    submitHandler: function(form) {

	    }
	}); 

    var validator = $('#submit_form').validate({
        doNotHideMessage: true, //this option enables to show the error/success messages on tab switch.
        errorElement: 'span', //default input error message container
        errorClass: 'help-block', // default input error message class
        focusInvalid: false, // do not focus the last invalid input
	    rules: {
    		journalNameId: {
            	required: true,
   				minlength: 2,
   				maxlength: 20,
   				lowercase: true,
	        	remote: function () {
	            	var r = {
	                        url: 'submitJournal/jnidDuplicateCheck?jnid=' + $("#journalNameId").val(),
	                        type: "POST",  
	                        contentType: "application/json; charset=utf-8",  
	                        dataType: "json",  
	                };
	            	return r;
	            },
	        },
	        title: {
	        		required: true,
	    				minlength: 2,
	    				maxlength: 200,
	        },
	        shortTitle: {
	        		required: false,
	    				minlength: 2,
	    				maxlength: 8,
	        },
	        homepage: {
	            required: true,
	            url: true,
	        },
	        organization: {
	        		required: true,
	    				minlength: 2,
	    				maxlength: 300,
	        },
	        coverImage: {
	        	remote: function () {
	            	var r = {
	                        url: '${baseUrl}/journals/${jnid}/manager/configuration/setup/coverImageCheck',
	                        type: "POST",  
	                        contentType: "application/json; charset=utf-8",  
	                        dataType: "json",  
	                };
	            	return r;
	            },
	        },
	    },
	
	    messages: { // custom messages for radio buttons and checkboxes
	    	  journalNameId: {
	            required: errorMessages['journal.required.journalNameId'],
		        		minlength: jQuery.format(errorMessages['system.error.minlength']),
		        		maxlength: jQuery.format(errorMessages['system.error.manlength']),
		        		remote: jQuery.format("{0} is already in use"),
		        		lowercase: errorMessages['journal.lowercase.journalNameId'],
	        },
	        title: {
	            	required: errorMessages['journal.required.title'], 
	        			minlength: jQuery.format(errorMessages['system.error.minlength']),
	        			maxlength: jQuery.format(errorMessages['system.error.manlength']),
	        },
	        shortTitle: {
	        		required: errorMessages['journal.required.shortTitle'],
	    				minlength: jQuery.format(errorMessages['system.error.minlength']),
	    				maxlength: jQuery.format(errorMessages['system.error.manlength']),
	        },
	        homepage: { 
	            required: errorMessages['journal.required.homepage'],
	            url: errorMessages['journal.required.correctURL'],
	        },
	        organization: {
	        		required: errorMessages['journal.required.organization'],
	    				minlength: jQuery.format(errorMessages['system.error.minlength']),
	    				maxlength: jQuery.format(errorMessages['system.error.manlength']),
	        },
	        coverImage: {
	            remote: errorMessages['journal.required.coverImage'],
	        }
	    },

        errorPlacement: function (error, element) { // render error placement for each input type
        	if ($(element).attr("name") == "coverImage") {
        		if (typeof ($("#file"))[0].files[0] == 'undefined') {
               		$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
               		$('#coverImage').html(errorMessages['journal.required.coverImage']);
               		return;
        		}
        		if (!(getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')) {
        			$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
            		$('#coverImage').html(errorMessages['journal.coverImage.invalidFileType']);
            		$('div[class="imgareaselect-handle"]').remove();
                	$('div[class="imgareaselect-outer"]').remove();
                	$('img[id="uploadImage"]').imgAreaSelect({ disable: true });
                	$('.previewDiv').hide();
                	$('#upload').removeClass("uploadImageFrame").addClass("uploadImageFrameBefore");
                	$('#upload').html("<br/><br/><br/><br/><br/>No Uploaded Image !!!<br/><br/><br/><br/><br/>");
                	$('img[id="uploadImage"]').hide().remove();
                	$('.cropMessage').hide();
        		}
        		
        		if (file.files[0].size > 2097152) {
            		$('.form-sub-group-image').removeClass('has-success').addClass('has-error');
            		$('#coverImage').html(errorMessages['journal.coverImage.tooBigSize(2MB)']);
            		$('div[class="imgareaselect-handle"]').remove();
                	$('div[class="imgareaselect-outer"]').remove();
                	$('img[id="uploadImage"]').imgAreaSelect({ disable: true });
                	$('.previewDiv').hide();
                	
                	$('#upload').removeClass("uploadImageFrame").addClass("uploadImageFrameBefore");
                	$('#upload').html("<br/><br/><br/><br/><br/>No Uploaded Image<br/><br/><br/><br/><br/>");
                	$('img[id="uploadImage"]').hide().remove();
                	$('.cropMessage').hide();
        		}
        		
        	} else {
        		element.next('span.help-block').replaceWith(error);
        	}
        },

        invalidHandler: function (event, validator) { //display error alert on form submit   
        },

        highlight: function (element) { // hightlight error inputs
            $(element)
                .closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
        },

        unhighlight: function (element) { // revert the change done by hightlight
            $(element)
                .closest('.form-group').removeClass('has-error'); // set error class to the control group
        },

        success: function (errorLabel, element) {
        	if ($(element).attr("name") == "coverImage") {
        		if (typeof ($("#file"))[0].files[0] == 'undefined'
        			&& (getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')
        			&& file.files[0].size <= 2097152 ) {
		        		$('.form-sub-group-image').removeClass('has-error').addClass('has-success');
        				$('#coverImage').html("success!");
        		}
        	} else if ($(element).attr('id') == "select2_language") {
      			errorLabel
	                .addClass('valid') 
	            		.closest('.form-group').removeClass('has-error').addClass('has-success');	
  			} else if ($(element).attr('id') == "select2_country") {
                errorLabel
	                .addClass('valid') 
	            	.closest('.form-group').removeClass('has-error').addClass('has-success');
            } else { // display success icon for other inputs
                errorLabel
                    .addClass('valid') 
                		.closest('.form-group').removeClass('has-error').addClass('has-success'); 
            }
        },

        submitHandler: function(form) {
        	//$('#submit_form').submit();
            //add here some ajax code to submit your form or just call form.submit() if you want to submit the form without ajax
        }
    });
	$('input[id="file"]').change(function() {
		validator.element( "#file" );
		if (typeof ($("#file"))[0].files[0] == 'undefined') {
			return true;
		}
		if (!(getExtension(file.files[0].name) == 'jpg' || getExtension(file.files[0].name) == 'jpeg' || getExtension(file.files[0].name) == 'gif' || getExtension(file.files[0].name) == 'png')) {
			return true;
		}
		if (file.files[0].size > 2097152) {
			return true;
		}
		$('div[class="imgareaselect-handle"]').remove();
    	$('div[class="imgareaselect-outer"]').remove();
		$('#upload').removeClass("uploadImageFrameBefore").addClass("uploadImageFrame");
		$('.cropMessage').show();
		
	  	var oMyForm = new FormData();
	  	oMyForm.append("file", file.files[0]);
	  	oMyForm.append("journalId", "${journal.id}");
		$.ajax({
			url: 'submitJournal/coverImageUpload',
			data: oMyForm,
		    dataType: 'text',
		    processData: false,
		    contentType: false,
		    type: 'POST',
		    success: function(data){
		    	$('.currentPreviewDiv').hide('normal');
		    	var htmlSource = data.split("-----");
		      	$('div[id="upload"]').html(htmlSource[0]);
		      	$('div[id="preview"]').html(htmlSource[1]);
		      	$('em[id="cropMessage"]').show();
		      	
		      	isCoverImageShown = true;
		      	coverImageHeight = parseInt(300 + 500 * htmlSource[3] / htmlSource[2]);
		      	saveFileName = htmlSource[4];
		    }
		});
		
		$('.previewDiv').show();
		$('.form-sub-group-image').removeClass('has-error').addClass('has-success');
		$('#coverImageSaveButton').show('normal');
		$('img[id="uploadImage"]').imgAreaSelect({hide:true});		
		coverImageUploadSuccess = true;
		return true;
	});
	
	$('#saveImage').click(function(event) {
		if(coverImageUploadSuccess) {
			var data = $('#submit_form').serialize();
			$.ajax({
				url: '${baseUrl}/journals/${jnid}/manager/configuration/journal/saveImage',
				data: data,
			    type: 'POST',
			    success: function(data){
					alert("Success");
			    }
			});
		}else
			alert("You should upload image before save");
	});
	
	/* Submission Management */
	UIExtendedModals.init();
    var handleWysihtml5 = function () {
        if (!jQuery().wysihtml5) {
            return;
        }

        if ($('.wysihtml5').size() > 0) {
            $('.wysihtml5').wysihtml5({
                "stylesheets": ["assets/plugins/bootstrap-wysihtml5/wysiwyg-color.css"]
            });
        }
    }
	
/*     $('#textBasicInfo').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
    	type: 'textBasicInfo',
    });
    $('#editTextBasicInfo').click(function (e) {
        e.stopPropagation();
        e.preventDefault();
        $('#textBasicInfo').editable('toggle');
    }); */
    
    $('#textBasicInfo').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'textBasicInfo',
    });
    
    $('#textCoAuthor').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'textCoAuthor',
    });
    
    $('#textCoverLetter').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'textCoverLetter',
    });
    
    $('#textRp').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'textRp',
    });
    
    $('#textFiles').editable({
    	url: url,
    	inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'textFiles',
    });
    
	$(".allowChange").click(function(){
        var checked = $(this).is(":checked");//.attr('checked');
        var name = $(this).attr("name");
        var selectedValue = 0;
        if(checked) selectedValue = 1;
		$.ajax({
			type:"POST",
			url: url,
			data: "name=" + name + "&value=" + selectedValue,
			success:function(html) {}
		});
    });
	
	var additionalFilesOptions = $('.additionalFilesOption:checked');
	var additionalFilesOptionsAllNo = true;
	for(var i=0; i<additionalFilesOptions.length; i++)
		if(additionalFilesOptions[i].checked == true && additionalFilesOptions[i].value == "1")
			additionalFilesOptionsAllNo = false;
	
	if(additionalFilesOptionsAllNo) {
		$('#requiredAdditionalFiles').attr("checked", false);
		$('#uniform-requiredAdditionalFiles > span').removeClass("checked");
		$('.additionalFilesOptionsView').hide();
		$.ajax({
			type:"POST",
			url: url,
			data: "name=requiredAdditionalFiles&value=0",
			success:function(html) {
			}
		});
	}
	
	if($('#requiredAdditionalFiles').is(":checked") == true)
		$('.additionalFilesOptionsView').show();
	else
		$('.additionalFilesOptionsView').hide();
	$(".requirements").click(function(){
        var checked = $(this).is(":checked");
        var name = $(this).attr("name");
        var selectedValue = 0;
        if(checked) selectedValue = 1;
		$.ajax({
			type:"POST",
			url: url,
			data: "name=" + name + "&value=" + selectedValue,
			success:function(html) {
				if(name == 'requiredAdditionalFiles') {
					if(selectedValue == 1) {
						$('.additionalFilesOptionsView').show('normal');
				    	$.ajax({
				    		type:"GET",
				    		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
				    		data: "designation=frontCover",
				    		success:function(html) {
				    			$("#frontCoverUrl").text(html);
				    			$("#currentfrontCoverUrl").text(html);
				    		}
				    	});
				    	$.ajax({
				    		type:"GET",
				    		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
				    		data: "designation=checkList",
				    		success:function(html) {
				    			$("#checkListUrl").text(html);
				    			$("#currentcheckListUrl").text(html);
				    		}
				    	});
						
						var frontCoverCheckedValue = $('.frontCoverManageOrNot:checked').val();
						if(frontCoverCheckedValue == '1') {
							$.ajax({
								type:"GET",
								url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
								data: "journalId=${journal.id}&designation=frontCover",
								success:function(html) {
									$("#frontCoverUploadedFileView").html(html).show();
								}
							});
							$('#frontCoverManageView').show('normal');
						} else
							$('#frontCoverManageView').hide('normal');
						
						var checkListCheckedValue = $('.checkListManageOrNot:checked').val();
						if(checkListCheckedValue == '1') {
							$.ajax({
								type:"GET",
								url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
								data: "journalId=${journal.id}&designation=checkList",
								success:function(html) {
									$("#checkListUploadedFileView").html(html).show();
								}
							});
							$('#checkListManageView').show('normal');
						} else
							$('#checkListManageView').hide('normal');
					} else {
						$('#frontCoverManageView').hide('normal');
						$.ajax({
							type: 'POST',
							url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
							data: "name=frontCoverManage&value=0",
							success: function(html){}
						});
						$('#checkListManageView').hide('normal');
						$.ajax({
							type: 'POST',
							url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
							data: "name=checkListManage&value=0",
							success: function(html){}
						});
						$('.additionalFilesOptionsView').hide('normal');
						
					}
				}
			}
		});
    });
	
	
	$('.reviewerViewAuthorOrNot').click(function() {
		var selectedValue = $('.reviewerViewAuthorOrNot:checked').val();
		$.ajax({
    		type:"POST",
    		url: url,
    		data: "name=reviewerViewAuthor&value=" + selectedValue,
    		success:function(html) {
    		}
    	});
	});
	
	var frontCoverCheckedValue = $('.frontCoverManageOrNot:checked').val();
	if(frontCoverCheckedValue == '1') {
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
			data: "journalId=${journal.id}&designation=frontCover",
			success:function(html) {
				$("#frontCoverUploadedFileView").html(html).show();
			}
		});
		$('#frontCoverManageView').show('normal');
	} else
		$('#frontCoverManageView').hide('normal');
	
	var checkListCheckedValue = $('.checkListManageOrNot:checked').val();
	if(checkListCheckedValue == '1') {
		$.ajax({
			type:"GET",
			url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
			data: "journalId=${journal.id}&designation=checkList",
			success:function(html) {
				$("#checkListUploadedFileView").html(html).show();
			}
		});
		$('#checkListManageView').show('normal');
	} else
		$('#checkListManageView').hide('normal');
	
	$('.frontCoverManageOrNot').click(function() {
    	$.ajax({
    		type:"GET",
    		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
    		data: "designation=frontCover",
    		success:function(html) {
    			$("#frontCoverUrl").text(html);
    			$("#currentfrontCoverUrl").text(html);
    		}
    	});
		var checkedValue = $('.frontCoverManageOrNot:checked').val();
		if(checkedValue == "1") {
			$.ajax({
				type:"GET",
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
				data: "journalId=${journal.id}&designation=frontCover",
				success:function(html) {
					$("#frontCoverUploadedFileView").html(html).show();
				}
			});
			$('#frontCoverManageView').show('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=frontCoverManage&value=1",
				success: function(html){}
			});
		} else {
			$('#frontCoverManageView').hide('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=frontCoverManage&value=0",
				success: function(html){}
			});
		}
	});
	
	$('.checkListManageOrNot').click(function() {
    	$.ajax({
    		type:"GET",
    		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
    		data: "designation=checkList",
    		success:function(html) {
    			$("#checkListUrl").text(html);
    			$("#currentcheckListUrl").text(html);
    		}
    	});
		var checkedValue = $('.checkListManageOrNot:checked').val();
		if(checkedValue == "1") {
			$.ajax({
				type:"GET",
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
				data: "journalId=${journal.id}&designation=checkList",
				success:function(html) {
					$("#checkListUploadedFileView").html(html).show();
				}
			});
			$('#checkListManageView').show('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=checkListManage&value=1",
				success: function(html){}
			});
		} else {
			$('#checkListManageView').hide('normal');
			$.ajax({
				type: 'POST',
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/saveConfiguration",
				data: "name=checkListManage&value=0",
				success: function(html){}
			});
		}
	});
	
	
    if(Number(numConfirms) == 0)
    	$('.confirmsTr').hide();
    else {
    	for(var i=1; i<=5; i++) {
    		if(i <=numConfirms)
    			$('.confirmShow' + i).show('normal');
    		else
    			$('.confirmShow' + i).hide();
    	}
    }
    
    $('#numberOfConfirms').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'numberOfConfirms',
        validate: function (value) {
            if (Number(value) < 0 || Number(value) > 5) return "You can set value between 0 and 5";
        },
        success: function(response, newValue) {
        	if(response.status == 'error') return response.msg;
        	else {

        		var newNumConfirms = Number(newValue);
        	    if(newNumConfirms == 0)
        	    	$('.confirmsTr').hide('normal');
        	    else {
	        		for(var i=1; i<=5; i++) {
	        			if(i <= newNumConfirms)
	        				$('.confirmShow' + i).show('normal');
	        			else
	        				$('.confirmShow' + i).hide('normal');
	        		}
        	    }
        	    $('#numberOfConfirmsPreview').attr('rowspan', newNumConfirms+1);
        	}
       	}
    });
    <c:forEach var="index" begin="1" end="5" step="1">
	    $('#confirm${index}').editable({
	        url: url,
	        inputclass: 'form-control editable-input-class',
	        type: 'text',
	        pk: 1,
	        name: 'confirm${index}',
	    });
    </c:forEach>

    if(Number(numReviewItems) == 0)
    	$('.reviewItemIdsTr').hide();
    else {
    	for(var i=1; i<=10; i++) {
    		if(i <=numReviewItems)
    			$('.reviewItemShow' + i).show('normal');
    		else
    			$('.reviewItemShow' + i).hide();
    	}
    }
	
    $('#numberOfReviewItems').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'numberOfReviewItems',
        validate: function (value) {
            if (Number(value) < 0 || Number(value) > 10) return "You can set value between 0 and 10";
        },
        success: function(response, newValue) {
        	if(response.status == 'error') return response.msg;
        	else {
        		var newNumReviewItems = Number(newValue);
        	    if(newNumReviewItems == 0)
        	    	$('.reviewItemIdsTr').hide('normal');
        	    else {
	        		for(var i=1; i<=10; i++) {
	        			if(i <= newNumReviewItems)
	        				$('.reviewItemShow' + i).show('normal');
	        			else
	        				$('.reviewItemShow' + i).hide('normal');
	        		}
        	    }
        	}
       	}
    });

	<c:forEach var="index" begin="1" end="10" step="1">
	    var currentReviewItemId = 0;
	   	var index = "${index}";
	   	if(index == 1)
	    	currentReviewItemId = "${jc.reviewItemId1}";
	    else if(index == 2)
	    	currentReviewItemId = "${jc.reviewItemId2}";
	    else if(index == 3)
	    	currentReviewItemId = "${jc.reviewItemId3}";
	    else if(index == 4)
	    	currentReviewItemId = "${jc.reviewItemId4}";
	    else if(index == 5)
	    	currentReviewItemId = "${jc.reviewItemId5}";
	    else if(index == 6)
	    	currentReviewItemId = "${jc.reviewItemId6}";
	    else if(index == 7)
	    	currentReviewItemId = "${jc.reviewItemId7}";
	    else if(index == 8)
	    	currentReviewItemId = "${jc.reviewItemId8}";
	    else if(index == 9)
	    	currentReviewItemId = "${jc.reviewItemId9}";
	    else if(index == 10)
	    	currentReviewItemId = "${jc.reviewItemId10}";
	    
	    $("#reviewItemId${index}").val(currentReviewItemId).attr("selected", "selected");
		$("#reviewItemId${index}").select2();
	    $('#reviewItemId${index}').change(function(event) {
	   		var selectedValue = $(this).children("option:selected").val();
			$.ajax({
				type:"POST",
				url: url,
				data: "name=reviewItemId${index}&value=" + selectedValue,
				success:function(html) {}
			});
		});
	</c:forEach>
    
	/* Count and Duration */
    $('#reviewCompleteCount').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'reviewCompleteCount',
    });
    
    $('#reviewDueDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'reviewDueDuration',
    });
    
    $('#assignRemindDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'assignRemindDuration',
    });
    
    $('#assignCancelDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'assignCancelDuration',
    });
    
    $('#inviteRemindDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'inviteRemindDuration',
    });
    
    $('#inviteCancelDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'inviteCancelDuration',
    });
    
    $('#resubmitDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'resubmitDuration',
    });
    
    $('#cameraSubmitDuration').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'cameraSubmitDuration',
    });
    
    $('#gentleRemindReviewer').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'gentleRemindReviewer',
    });
    
    $('#gentleRemindResubmit').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'gentleRemindResubmit',
    });
    
    $('#gentleRemindCameraSubmit').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'gentleRemindCameraSubmit',
    });
    
    $('#remindReviewer').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'remindReviewer',
    });
    
    $('#remindResubmit').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'remindResubmit',
    });
    
    $('#remindCameraSubmit').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: 'remindCameraSubmit',
    });
	
	/* Files */
    <c:forEach var="fileType" items="${fileTypes}">
    $('#${fileType}Url').editable({
        url: url,
        inputclass: 'form-control editable-input-class',
        type: 'text',
        pk: 1,
        name: '${fileType}Url',
        success: function(response, newValue) {
        	if(response.status == 'error') return response.msg;
        	else {
            	$.ajax({
            		type:"GET",
            		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
            		data: "designation=${fileType}",
            		success:function(html) {
            			$("#${fileType}Url").text(html);
            			$("#current${fileType}Url").text(html);
            		}
            	});
        	}
       	}
    });
    $('#${fileType}PasteView').hide('normal');
    
	$(".${fileType}Radio").click(function(event) {
	    var selectedValue = $(':radio[name="${fileType}Radio"]:checked').val();
        if(selectedValue == 'upload') {
        	$('#${fileType}UploadView').show('normal');
        	$('#${fileType}PasteView').hide('normal');
        	$("#${fileType}UploadedFileView").show('normal');
        } else {
        	$('#${fileType}UploadView').hide('normal');
        	$('#${fileType}PasteView').show('normal');
        	$("#${fileType}UploadedFileView").hide('normal');
        }
    });
	
	$.ajax({
		type:"GET",
		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
		data: "journalId=${journal.id}&designation=${fileType}",
		success:function(html) {
			$("#${fileType}UploadedFileView").html(html).show();
		}
	});
	
    $('#' + '${fileType}' + 'Upload').fileupload({
        url : "${baseUrl}/journals/${jnid}/manager/configuration/journal/upload.action",
        dataType: 'json',
        add: function(e, data){
        	var isValid = true;
            var uploadFile = data.files[0];
            if (!(/\.(pdf|doc|docx|tar|gzip)$/i).test(uploadFile.name)) {
            	alert(errorMessages['system.fileUpload.fileTypeNotAllowed']);
                isValid = false;
            } else if (uploadFile.size > 10000000) { // 10mb
            	alert(errorMessages['system.fileUpload.fileSizeExceed']);
                isValid = false;
            }
            if(isValid)
            	data.submit();
        },
        progressall: function(e,data) {
        },
        done: function (e, data) {
        	$.ajax({
        		type:"GET",
        		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
        		data: "designation=${fileType}",
        		success:function(html) {
        			$("#${fileType}Url").text(html);
        			$("#current${fileType}Url").text(html);
        		}
        	});
        	$.ajax({
        		type:"GET",
        		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
        		data: "journalId=${journal.id}&designation=${fileType}",
        		success:function(html) {
        			$("#${fileType}UploadedFileView").html(html).show();
        		}
        	});
        },
        fail: function(e){
            alert("server problem");
        }
    });
    </c:forEach>
});
</script>