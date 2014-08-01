<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<div class="row">
	<div class="form form-horizontal">
		<div class="col-md-2">
			<ul class="ver-inline-menu tabbable margin-bottom-10">
				<li>
					<a class="backToTable">
						<span class="vertical-menu">
							<span class="vertical-menu-icon">
								<i class="fa fa-chevron-left"></i>
							</span>
							<span class="vertical-menu-info">
								<spring:message code="system.viewManuscriptList"/>
							</span>
						</span>
					</a>
					<span class="after">
					</span>
				</li>
				<li <c:if test="${v == 'summary'}">class="active"</c:if>>
					<a data-toggle="tab" class="${pageType }basicMenuClick" href="#${pageType }manuscriptSummary">
						<span class="vertical-menu">
							<span class="vertical-menu-icon">
								<i class="fa fa-list-ul "></i>
							</span>
							<span class="vertical-menu-info">
								<spring:message code="system.viewManuscriptSummary"/>
								<br/>
								<small>- 
									<c:if test="${manuscript.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
									<c:if test="${manuscript.revisionCount > 0 }"><spring:message code="system.revision"/> #${manuscript.revisionCount }</c:if>
								</small>
							</span>
						</span>
					</a>
					<span class="after">
					</span>
				</li>
				<c:if test="${not empty manuscript.decisions }">
					<c:forEach var="revisionCount" begin="0" end="${manuscript.revisionCount }" step="1">
						<c:forEach var="fd" varStatus="status" items="${manuscript.decisions}" >
							<c:if test="${fd.revisionCount == revisionCount and fd.decision != 0}">
								<li>
									<a data-toggle="tab" class="${pageType}basicMenuClick" href="#${pageType }reviewScore${fd.revisionCount }">
										<span class="vertical-menu">
											<span class="vertical-menu-icon">
												<i class="fa fa-pencil-square-o"></i>
											</span>
											<span class="vertical-menu-info">
												<spring:message code="system.reviewResult"/><br/>
												<small>- 
													<c:if test="${fd.revisionCount == 0 }"><spring:message code="system.original"/></c:if>
													<c:if test="${fd.revisionCount > 0 }"><spring:message code="system.revision"/> #${fd.revisionCount }</c:if>
												</small>
											</span>
										</span>
									</a>
								</li>
							</c:if>				
						</c:forEach>
					</c:forEach>
				</c:if>
				<c:if test="${journal.paid == true and (pageType == 'accepted' or pageType == 'published')}">
					<li <c:if test="${v == 'cameraReady'}">class="active"</c:if>>
						<a data-toggle="tab" href="#${pageType }cameraReady" id="${pageType }cameraReadyClick">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-upload "></i>
								</span>
								<span class="vertical-menu-info">
									<c:if test="${manuscript.status == 'A' }">
										<spring:message code="author.action.submitCameraReady.long"/>
									</c:if>
									<c:if test="${manuscript.status != 'A' }">
										<spring:message code="author.action.viewCameraReady"/>
									</c:if>
								</span>
							</span>
						</a>
						<span class="after">
						</span>
					</li>
					<c:if test="${not empty galleryProofFiles}">
						<li <c:if test="${v == 'galleryProof'}">class="active"</c:if>>
							<a data-toggle="tab" href="#${pageType }galleryProof" id="${pageType }galleryProofClick">
								<span class="vertical-menu">
									<span class="vertical-menu-icon">
										<i class="fa fa-check-square-o"></i>
									</span>
									<span class="vertical-menu-info">
										<c:choose>
											<c:when test="${manuscript.status == 'G' and  manuscript.galleryProofConfirm == false}">
												<spring:message code="author.action.confirmGalleryProof"/>
											</c:when>
											<c:otherwise>
												<spring:message code="author.action.viewGalleryProof"/>
											</c:otherwise>
										</c:choose>
									</span>
								</span>
							</a>
							<span class="after">
							</span>
						</li>
					</c:if>
				</c:if>
			</ul>
		</div>
		<div class="col-md-10">
			<div class="tab-content">
				<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }manuscriptSummary">
					<customTagFile:manuscriptSummary locale="${locale}"/>
				</div>
				<%@ include file="/WEB-INF/views/roles/common/manuscripts/reviewResults.jsp" %>
				<c:if test="${journal.paid == true and (pageType == 'accepted' or pageType == 'published')}">
					<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="${pageType }cameraReady">
						<div class="loadingCenter"><img src="images/loading.gif"/></div>
					</div>
					<c:if test="${not empty galleryProofFiles}">
						<div class="tab-pane fade <c:if test="${v == 'galleryProof'}">active</c:if> in" id="${pageType }galleryProof">
							<div class="loadingCenter"><img src="images/loading.gif"/></div>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>			
</div>
<!-- END PAGE CONTENT-->
<%@ include file="/WEB-INF/views/roles/common/manuscripts/viewScripts.jsp" %>
<script>
$(document).ready(function() {
	$('.' + "${pageType}" + 'basicMenuClick').click(function(event) {
		$('#' + "${pageType}" + 'galleryProof').hide();
		$('#' + "${pageType}" + 'cameraReady').hide();
	});
	
	if(v == 'summary') {
		$('#' + "${pageType}" + 'galleryProof').hide();
		$('#' + "${pageType}" + 'cameraReady').hide();
	} else if(v == 'cameraReady') {
		var url = "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType }/cameraReady/cameraReady";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'cameraReady').html(html).show('normal');
				$('#' + "${pageType}" + 'galleryProof').hide();
			}
		});
	} else if(v == 'galleryProof') {
		var url = "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType }/galleryProof/galleryProof";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'galleryProof').html(html).show('normal');
				$('#' + "${pageType}" + 'cameraReady').hide();
			}
		});
	}
	
	$('#' + "${pageType}" + 'cameraReadyClick').click(function(event) {
		var url = "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType }/cameraReady/cameraReady";
		var data = "manuscriptId=${manuscript.id}";
		
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'cameraReady').html(html).show('normal');
				$('#' + "${pageType}" + 'galleryProof').hide();
			}
		});
	});
	
	$('#' + "${pageType}" + 'galleryProofClick').click(function(event) {
		var url = "${baseUrl}/journals/${jnid}/author/manuscripts/${pageType }/galleryProof/galleryProof";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html) {
				$('#' + "${pageType}" + 'galleryProof').html(html).show('normal');
				$('#' + "${pageType}" + 'cameraReady').hide();
			}
		});
	});
});
</script>