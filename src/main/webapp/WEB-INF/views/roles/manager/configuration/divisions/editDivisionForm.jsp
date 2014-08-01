<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header">
	<h4 class="modal-title"><spring:message code="manager.config.editDivision"/></h4>
</div>
<div class="modal-body">
	<div class="row form-section_noborder">
		<label class="control-label col-md-1"></label>
		<form:form method="post" modelAttribute="division" id="editForm" class="editForm">
		<div class="col-md-11">
			<div class="portlet">
				<div class="portlet-body" >
					<fieldset class="col-md-11">
					<div class="row">
						<div class="form-group col-md-2">
							<label class="control-label"><spring:message code="system.symbol"/></label>
							<div>
								<form:input path="symbol" type="text" class="form-control" maxlength="5" placeholder="e.g.) A or 1" value="${division.symbol }"/>
								<form:input path="id" type="hidden" value="${division.id }"/>
								<form:input path="journalId" type="hidden" value="${division.journalId }"/>
								<span class="help-block">
								</span>
							</div>
						</div>	
						<div class="form-group col-md-10">
							<label class="control-label"><spring:message code="system.division"/> <spring:message code="user.name"/></label>
							<div>
								<form:input path="name" type="text" class="form-control" maxlength="70" value="${division.name }"/>
								<span class="help-block">
								</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="control-label"><spring:message code="system.description"/></label>
							<div>
								<form:textarea path="description" rows="5" type="text" class="form-control" value="${division.description }"/>
								<span class="help-block">
								</span>
							</div>
						</div>
					</div>
					<div class="row"> 
						<div class="form-group col-md-12">
							<div class="col-md-offset-4 col-md-3">
								 <button id="deleteButton" class="btn btn-default"><i class="fa fa-trash-o"></i> <spring:message code="system.delete"/></button>
							</div>
							<div class="col-md-2">
								<button type="submit" id="register-submit-btn" class="btn green pull-right">
								<i class="fa fa-floppy-o"></i> <spring:message code="system.save"/> 
							</button>
							</div>
						</div>
					</div>
					</fieldset>
				</div>
			</div>
		</div>
		</form:form>
	</div>
</div>
<script>
$('#deleteButton').click(function(event){
	event.preventDefault();
	bootbox.confirm('<spring:message code="system.areYouSure"/>', function(result) {
		if(result == true) {
			$.ajax({
				type:"POST",
				url: "${baseUrl}/journals/${jnid}/manager/configuration/divisions/deleteDivision",
				data: "divisionId=${division.id }",
				success: function(html){
					location.href="${baseUrl}/journals/${jnid}/manager/configuration/divisions/manageDivisions";
				}
			});	
		}
	});
});

var EditDivision = function (baseUrl) {
	var handleRegister = function (baseUrl) {
	
		function format(state) {
	        if (!state.id) return state.text; // optgroup
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
	    }
	
	    $('.editForm').validate({
	        errorElement: 'span', //default input error message container
	        errorClass: 'help-block', // default input error message class
	        focusInvalid: false, // do not focus the last invalid input
	        ignore: "",
	        rules: {
	
	            "symbol": {
	                required: true,
	                maxlength: 3,
	            },
	            "name": {
	                required: true,
	                minlength: 3,
	                maxlength: 70,
	            },
	            "description": {
	                required: false,
	                maxlength: 3000,
	            }
	
	        },
	        
	        messages: {
	
	            "symbol": {
	            	required: "Please enter your division symbol.",
	                maxlength: jQuery.format("Please enter at most {0} characters."),
	            },
	            "name": {
	            	required: "Please enter your division name.",
	                minlength: jQuery.format("Please enter at least {0} characters."),
	                maxlength: jQuery.format("Please enter at most {0} characters."),
	            },
	            "description": {
	            	required: "Please enter your division description.",
	                maxlength: jQuery.format("Please enter at most {0} characters."),
	            }
	        },
	
	        invalidHandler: function (event, validator) { //display error alert on form submit              
	            //success.hide();
	            //error.show();
	            //App.scrollTo(error, -200);
	        },
	
	        errorPlacement: function (error, element) { // render error placement for each input type
	            var icon = $(element).parent('.input-icon').children('i');
	            icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
	            
	            if (element.parent(".input-group").size() > 0) {
	                error.insertAfter(element.parent(".input-group"));
	            } else if (element.attr("data-error-container")) { 
	                error.appendTo(element.attr("data-error-container"));
	            } else if (element.parents('.tncLabel').size() > 0) {
	                error.insertAfter(element.parents('.tncLabel'));
	            } else {
	                error.insertAfter(element); // for other inputs, just perform default behavior
	            }
	        },
	
	        highlight: function (element) { // hightlight error inputs
	            $(element)
	                .closest('.form-group').addClass('has-error'); // set error class to the control group   
	        },
	
	        unhighlight: function (element) { // revert the change done by hightlight
	            
	        },
	
	        success: function (label, element) {
	        	
	            var iconDiv = $(element).parent('.input-icon');
	            iconDiv.addClass("right");
	            var icon = $(element).parent('.input-icon').children('i');
	            $(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
	
	            icon.addClass("fa-check");
	            icon.removeClass("fa-envelope");
	            icon.removeClass("fa-font");
	            icon.removeClass("fa-bold");
	            icon.removeClass("fa-building-o");
	            icon.removeClass("fa-user");
	            icon.removeClass("fa-lock");
	            icon.removeClass("fa-warning");
	        },
	
	        submitHandler: function (form) {
				var parameter = $("#editForm").serialize();
				form.submit();
	        }
	    });
	
		$('.register-form input').keypress(function (e) {
	        if (e.which == 13) {
	            if ($('.register-form').validate().form()) {
	                $('.register-form').submit();
	            }
	            return false;
	        }
	    });
	};
	
	return {
	    //main function to initiate the module
	    init: function (baseUrl) {
	        handleRegister(baseUrl);        	       
	    }
	};
}();
EditDivision.init("${baseUrl}/journals/${jnid}");
</script>