 <div class="row">
	 <div class="col-md-6 profile-info">
		<h4 id="service-feature-title">1. <spring:message code='system.featureAndSupportTypeA'/></h4>
		<p><spring:message code="system.typeA.introduction"/></p>
		<table class="table table-bordered">
			<thead>
				<tr class="text-center">
					<td><spring:message code="system.serviceFeature.aesupport"/></td>
					<td><spring:message code="system.serviceFeature.recirculation"/></td>
					<td><spring:message code="system.serviceFeature.si"/></td>
				</tr>
			</thead>
			<tbody>
				<tr class="text-center" id="service-feature-table-tbody">
					<td><i class='fa fa-check-square-o'></i></td><td><i class='fa fa-check-square-o'></i></td><td><i class='fa fa-check-square-o'></i></td>
				</tr>
			</tbody>
		</table>
		<h5>[<spring:message code="system.support"/>]</h5>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_member"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.author1"/>
			<li><spring:message code="system.supportDetails.author2"/>
			<li><spring:message code="system.supportDetails.author3"/>
			<li><spring:message code="system.supportDetails.author4"/>										
		</ul>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_manager"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.manager1"/>
			<li><spring:message code="system.supportDetails.manager2"/> 
			<li><spring:message code="system.supportDetails.manager3"/>
			<li><spring:message code="system.supportDetails.manager4"/>
			<li><spring:message code="system.supportDetails.manager5"/>
			<li><spring:message code="system.supportDetails.manager6"/>
		</ul>									
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_cg-editor"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.editor1"/>
			<li><spring:message code="system.supportDetails.editor2"/>
			<li><spring:message code="system.supportDetails.editor3"/>
			<li><spring:message code="system.supportDetails.editor4"/>
			<li><spring:message code="system.supportDetails.editor5"/>
		</ul>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_a-editor"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.a-editor1"/>
			<li><spring:message code="system.supportDetails.a-editor2"/>
			<li><spring:message code="system.supportDetails.a-editor3"/>
		</ul>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_reviewer"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.reviewer1"/>
			<li><spring:message code="system.supportDetails.reviewer2"/>
		</ul>
		<!--
		<h4>No Support</h4>
		<ul>
			<li>No associate editor
			<li>No recirculation process (no support for conditional accept)
		</ul>
		-->
	</div>
	<!--end col-md-6-->
	<div class="col-md-6">
		<div id="manuscriptStatusTitle">
			 <h4>2. <spring:message code="system.manuscriptStatusFlow"/></h4>
		</div>
		<div class="text-center" id="manuscriptStatusImg">
			<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
				<img src="${baseUrl}/images/promotion/manuscriptStatusA.png" border="0" width="100%"/>
			</c:if>
			<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
				<img src="${baseUrl}/images/promotion/manuscriptStatusA-Korean.png" border="0" width="100%"/>
			</c:if>
		</div>
		<br/><br/>
		
		<div id="roles">
			 <h4>3. <spring:message code="system.roleDescription"/></h4>
		</div>
		<div class="text-center" id="roleImg">
			<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
				<img src="${baseUrl}/images/promotion/roleListAB.png" border="0" width="55%"/>
			</c:if>
			<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
				<img src="${baseUrl}/images/promotion/roleListAB-Korean.png" border="0" width="55%"/>
			</c:if>
		</div>
	</div>
	<!--end col-md-6-->
</div>
<!--end row-->

<h4>4. <spring:message code="system.workFlow"/></h4>
<p>
	<spring:message code="system.typeA.workFlow.indtroduction"/>
</p>
<div class="text-center">
	<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
	<img src="${baseUrl}/images/promotion/processTypeA.png" border="0" width="100%"/>
</c:if>
<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
	<img src="${baseUrl}/images/promotion/processTypeA-Korean.png" border="0" width="100%"/>
	</c:if>
</div>