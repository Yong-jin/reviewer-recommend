<c:forEach var="roleString" items="${roleStrings }">
<script>
$(document).ready(function() {
	$("#" + "${roleString}" + "Table .dataTables_filter input").addClass("form-control input-medium input-inline");
	var tableUrl = "${baseUrl}/journals/${jnid}/manager/configuration/members/${roleString}Table";
	var roleString = "${roleString}";
	var roleStringUpper = roleString.substring(0,1).toUpperCase() + roleString.substring(1,roleString.length);
	var signupUrl = "${baseUrl}/journals/${jnid}/manager/configuration/members/signup" + roleStringUpper;

	$("#register-submit-btn" + "${roleString}").click(function(event) {
		var parameter = $("#" + "${roleString}" + "RegisterForm").serialize();
		$.ajax({
			type: 'POST',
			url: signupUrl,
			data: parameter,
			success: function(html){
				/*
		        $("#" + "${roleString}" + "RegisterForm").each(function() {  
		        	this.reset();  
		        });
				*/
				$.ajax({
					type: 'GET',
					url: tableUrl,
					success: function(html){
						$("#" + "${roleString}" + "Display").html(html).show();
						App.scrollTo($("#" + "${roleString}" + "Display tr:last"));
	
					}
				});
			}
		});
	});
	
	$('.' + '${roleString}' + 'DegreeRadio').click(function() {
		$('.' + '${roleString}' + 'DegreeDiv').css("color", "#37bd4c");
		return true;
	});
	
	$('.' + '${roleString}' + 'SalutationRadio').click(function() {
		$('.' + '${roleString}' + "SalutationDiv").css("color", "#37bd4c");
		return true;
	});
	
	$(".countryFilter" + "${roleString}").select2({
	    allowClear: true,
	    dropdownAutoWidth: true,
	    formatResult: function(state) {
	    	if (!state.id) return state.text;
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png' />&nbsp;" + state.text;
	    },
	    formatSelection: function(state) {
	    	if (!state.id) return state.text;
	        return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;<small>" + state.text + "<small>";
	    },
	    escapeMarkup: function (m) {
	        return m;
	    },
	    containerCssClass: "muted"
	});
	
	$(".memberFilter" + "${roleString}").select2({
	    allowClear: true,
	    dropdownAutoWidth: true,
	    escapeMarkup: function (m) {
	        return m;
	    },
	    containerCssClass: "muted"
	});
});
</script>
</c:forEach>