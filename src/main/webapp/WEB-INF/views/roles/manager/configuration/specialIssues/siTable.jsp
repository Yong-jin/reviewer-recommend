<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/assets/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<script>
TableAjax.init("${baseUrl}/journals/${jnid}/manager/configuration/specialIssues/getSpecialIssues");
</script>

<table class="table table-bordered" id="specialIssueTable">
	<thead>
	<tr>
		<th class="cellCenter">
		</th>
		<th class="cellCenter">
			 <spring:message code="manuscript.title2"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="user.role.journal_g-editor"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="manager.config.submitDueDate"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="manager.config.creationDate"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.status"/>
		</th>
		<th class="cellCenter">
			 <spring:message code="system.action"/>
		</th>
	</tr>
	</thead>
	<tbody>
	</tbody>
</table>