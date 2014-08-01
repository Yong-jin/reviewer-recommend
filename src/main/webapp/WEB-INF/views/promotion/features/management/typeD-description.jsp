<div class="row">
	<div class="col-md-6 profile-info">
		<h4 id="service-feature-title">1. <spring:message code='system.featureAndSupportTypeD'/></h4>
		<p><spring:message code="system.typeD.introduction"/></p>
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
					<td>&nbsp;</td><td>&nbsp;</td><td><i class='fa fa-check-square-o'></i></td>
				</tr>
			</tbody>
		</table>
		<h5>[<spring:message code="system.support"/>]</h5>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_member"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.author1"/>
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
			<li><spring:message code="system.supportDetails.editor3"/>
			<li><spring:message code="system.supportDetails.editor4-no"/>
			<li><spring:message code="system.supportDetails.editor5"/>
		</ul>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_reviewer"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.reviewer1"/>
		</ul>
		
		<h5>[<spring:message code="system.nosupport"/>]
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_member"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.author2-no"/>
		</ul>					
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_cg-editor"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.editor5-no"/>
			<li><spring:message code="system.supportDetails.editor2-no"/>
		</ul>
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_a-editor"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.a-editor1-no"/>
		</ul>									
		<h5><i class="fa fa-check red"></i> <spring:message code="user.role.journal_reviewer"/></h5>
		<ul>
			<li><spring:message code="system.supportDetails.reviewer1-no"/>
		</ul>
	</div>
	<!--end col-md-6-->
	<div class="col-md-6">
		<div id="manuscriptStatusTitle">
			 <h4>2. <spring:message code="system.manuscriptStatusFlow"/></h4>
		</div>
		<div class="text-center" id="manuscriptStatusImg">
			<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
				<img src="${baseUrl}/images/promotion/manuscriptStatusD.png" border="0" width="95%"/>
			</c:if>
			<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
				<img src="${baseUrl}/images/promotion/manuscriptStatusD-Korean.png" border="0" width="95%"/>
			</c:if>
		</div>
		<br/><br/>
		
		<div id="roles">
			 <h4>3. <spring:message code="system.roleDescription"/></h4>
		</div>
		<div class="text-center" id="roleImg">
			<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
				<img src="${baseUrl}/images/promotion/roleListCD.png" border="0" width="55%"/>
			</c:if>
			<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
				<img src="${baseUrl}/images/promotion/roleListCD-Korean.png" border="0" width="55%"/>
			</c:if>
		</div>
	</div>
	<!--end col-md-6-->
</div>
<!--end row-->

<h4>4. <spring:message code="system.workFlow"/></h4>
<p>
	<spring:message code="system.typeD.workFlow.indtroduction"/>
</p>
<div class="text-center">
	<c:if test="${locale == 'en_US' && (param.lang == null || param.lang == 'en_US')}">
		<img src="${baseUrl}/images/promotion/processTypeD.png" border="0" width="100%"/>
	</c:if>
	<c:if test="${locale == 'ko_KR' || param.lang =='ko_KR'}"> 
		<img src="${baseUrl}/images/promotion/processTypeD-Korean.png" border="0" width="100%"/>
	</c:if>
</div>