<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<script>
function fileDelete(fileId, designation) {
	var url = "${baseUrl}/journals/${jnid}/delete/journal/" + designation + "/" + fileId;
	$.ajax({
		type:"POST",
		url: url,
		success:function(html1) {
			document.getElementById(designation + "UploadedFileView").innerHTML = "";
			$.ajax({
				type:"GET",
				url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/numFiles",
				data: "designation=" + designation,
				success:function(html2) {
					var count = Number(html2);	
					
					$.ajax({
						type:"GET",
						url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/uploadedFileTable",
						data: "journalId=${journal.id}&designation=" + designation,
						success:function(html3) {
							$("#" + designation + "UploadedFileView").html(html3).show();
							
							if(count == 0) {
					        	$.ajax({
					        		type:"GET",
					        		url: "${baseUrl}/journals/${jnid}/manager/configuration/journal/getUrl",
					        		data: "designation=" + designation,
					        		success:function(html4) {
					        			$("#" + designation + "Url").text(html4);
					        			$("#current" + designation + "Url").text(html4);
					        		}
					        	});
							}
						}
					});
				}
			});
		}
	});
}

</script>
<c:choose>
	<c:when test="${not empty files }">
		<c:forEach var="f" items="${files}">
			<c:if test="${designation == f.designation}">
				<a href="${baseUrl}/journals/${jnid}/download/template/${f.designation}">${f.originalName}</a> (<a onClick="fileDelete(${f.id}, '${f.designation }')"><spring:message code="system.delete"/></a>)
				<br/>
			</c:if>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<spring:message code="system.notAvailable2"/></div><br/><br/>
	</c:otherwise>
</c:choose>

