<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>


<div class="row">
	<div id="submit_form" class="form form-horizontal">
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
					<a data-toggle="tab" class="basicMenuClick" href="#${pageType }manuscriptSummary">
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
				
				<c:set var="version" value="0"/>
				<c:choose>
					<c:when test="${not empty manuscript.reviewList }">
						<c:forEach items="${manuscript.reviewList}" var="reviews" varStatus="status">
							<c:set var="completed" value="false"/>
							<c:forEach items="${reviews}" var="review">
								<c:if test="${pageType == 'assigned'}">
									<c:if test="${review.revisionCount == status.index and review.status == 'C' and user.id == review.userId}">
										<c:set var="completed" value="true"/>
									</c:if>
								</c:if>
								<c:if test="${pageType != 'assigned'}">
									<c:if test="${review.revisionCount == status.index and user.id == review.userId}">
										<c:set var="completed" value="true"/>
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test="${completed == true}">
								<li>
									<a data-toggle="tab" class="basicMenuClick" href="#${pageType }reviewScore${status.index }">
										<span class="vertical-menu">
											<span class="vertical-menu-icon">
												<i class="fa fa-pencil-square-o"></i>
											</span>
											<span class="vertical-menu-info">
												<spring:message code="system.reviewResult"/><br/>
												<small>- 
													<c:if test="${status.index == 0 }"><spring:message code="system.original"/></c:if>
													<c:if test="${status.index > 0 }"><spring:message code="system.revision"/> #${status.index }</c:if>
													<c:set var="version" value="${status.index}"/>
												</small>
											</span>
										</span>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:when>
				</c:choose>
				<c:if test="${pageType == 'assigned' and journal.paid == true and reviewNeeded == true}">
					<li <c:if test="${v == 'reviewSheet' }">class="active"</c:if>>
						<a data-toggle="tab" id="reviewSheetClick" href="#reviewSheetTab">
							<span class="vertical-menu">
								<span class="vertical-menu-icon">
									<i class="fa fa-pencil"></i>
								</span>
								<span class="vertical-menu-info">
									<spring:message code="reviewer.fillReviewSheet"/><br/>
									<small>- 
										<c:if test="${version == 0 }"><spring:message code="system.original"/></c:if>
										<c:if test="${version > 0 }"><spring:message code="system.revision"/> #${version}</c:if>
									</small>
								</span>
							</span>
						</a>
					</li>
				</c:if>
			</ul>
		</div>
		<div class="col-md-10">
			<div class="tab-content">
				<div class="tab-pane fade <c:if test="${v == 'summary' }">active</c:if> in" id="${pageType }manuscriptSummary">
					<customTagFile:manuscriptSummary locale="${locale}"/>
				</div>
				<c:choose>
					<c:when test="${not empty manuscript.reviewList }">
						<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
							<c:choose>
								<c:when test="${pageType == 'assigned'}">
									<c:forEach items="${reviews}" var="review">
										<c:if test="${review.revisionCount == status.index and review.status == 'C' and user.id == review.userId}">
											<div class="tab-pane fade" id="${pageType }reviewScore${status.index}">
												<customTagFile:manuscriptSummaryHead/>
												<c:set var="count" value="1" />
												<customTagFile:reviewerSummary count="${count}" review="${review}" locale="${locale}"/>
												<customTagFile:reviewSummary review="${review}" locale="${locale}"/>
												<c:set var="count" value="${count+1 }"/>
											</div>
										</c:if>
									</c:forEach>
								</c:when>
								<c:when test="${pageType == 'completed'}">
									<c:forEach items="${reviews}" var="review">
										<c:if test="${review.revisionCount == status.index and review.status == 'C' and user.id == review.userId}">
											<div class="tab-pane fade" id="${pageType }reviewScore${status.index}">
												<customTagFile:manuscriptSummaryHead/>
												<c:set var="count" value="1" />
												<customTagFile:reviewerSummary count="${count}" review="${review}" locale="${locale}"/>
												<customTagFile:reviewSummary review="${review}" locale="${locale}"/>
												<c:set var="count" value="${count+1 }"/>
											</div>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:set var="completed" value="false"/>
									<c:forEach items="${reviews}" var="review">
										<c:if test="${review.revisionCount == status.index and user.id == review.userId}">
											<c:set var="completed" value="true"/>
										</c:if>
									</c:forEach>
									<c:if test="${completed == true}">
										<div class="tab-pane fade" id="${pageType }reviewScore${status.index}">
											<customTagFile:manuscriptSummaryHead/>
											<c:set var="count" value="1" />              
											<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
												<c:if test="${review.revisionCount == status.index and user.id == review.userId}">
													<customTagFile:reviewerSummary count="${count}" review="${review}" locale="${locale}"/>
													<c:set var="count" value="${count+1 }"/>
												</c:if>
											</c:forEach>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
				<c:if test="${pageType == 'assigned' and journal.paid == true and reviewNeeded == true }">
					<div class="tab-pane fade <c:if test="${v == 'reviewSheet' }">active</c:if> in" id="reviewSheetTab">
						<customTagFile:manuscriptSummaryHead/>
						<div id="reviewSheet"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
					</div>
				</c:if>
			</div>
		</div>
	</div>			
</div>
<%@ include file="/WEB-INF/views/roles/common/manuscripts/viewScripts.jsp" %>
<script>
var reviewSheetView = false;
var timer;
$(document).ready(function() {
	if(v == 'reviewSheet') {
		var url = "${baseUrl}/journals/${jnid}/reviewer/reviews/reviewSheet";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html){
				reviewSheetView = true;
				$('#reviewSheet').html(html).show('normal');
			}
		});
	}
	$('.basicMenuClick').click(function(event) {
		reviewSheetView = false;
		clearInterval(timer);
	});
	
	$('#reviewSheetClick').click(function(event) {
		var url = "${baseUrl}/journals/${jnid}/reviewer/reviews/reviewSheet";
		var data = "manuscriptId=${manuscript.id}";
		$.ajax({
			type:"GET",
			url: url,
			data: data,
			success:function(html){
				reviewSheetView = true;
				$('#reviewSheet').html(html).show('normal');
			}
		});
		reviewSheetView = true;
		timer = setInterval("saveReview()", 180000);
	});
});  
</script>
