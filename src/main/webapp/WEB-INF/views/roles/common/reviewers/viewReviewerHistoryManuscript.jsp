<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="customTagFile" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<script src="${baseUrl}/js/moment.js"></script>
<a onClick='backToTable();' style='text-decoration:none'><i class="fa fa-chevron-left"></i> <spring:message code="system.gotoback"/></a><br/><br/>
<div class="row">
	<div class="form form-horizontal">
		<div class="col-md-12">
			<div class="tab-content">
				<div class="tab-pane fade <c:if test="${v == 'summary'}">active</c:if> in" id="reviewerHistorymanuscriptSummary">
					<div class="form-section_noborder">
						<h5 class="marginTop-10"><spring:message code="system.manuscriptInformation"/></h5>
						<div class="form-group">
							<label class="control-label col-md-2">
							<c:choose>
								<c:when test="${fn:trim(manuscript.submitId) != '' }">
									<spring:message code="system.manuscriptId"/>
								</c:when>
								<c:otherwise>
									<spring:message code="system.temporaryId"/>
								</c:otherwise>
							</c:choose>
							:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<c:choose>
										<c:when test="${fn:trim(manuscript.submitId) != '' }">
											${manuscript.submitId}
										</c:when>
										<c:otherwise>
											${manuscript.id }		
										</c:otherwise>
									</c:choose>
									<small> (<spring:message code="system.status"/> ${manuscript.status }: <spring:message code="system.title${manuscript.status }"/>)</small>
								</p>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.title2"/>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<b><c:if test="${manuscript.invite == true}">(Invited) </c:if>${manuscript.title }</b>
								</p>
							</div>
						</div>
						<c:if test="${manuscript.runningHead != null and manuscript.runningHead != ''}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.runningHead"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										${manuscript.runningHead }
									</p>
								</div>
							</div>
						</c:if>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.abstract"/>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
								${manuscript.paperAbstract }
								</p>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.keywords"/>:</label>
							<div class="col-md-9">
								<div class="keywordDiv">
									<p class="form-control-static sentenseJustifyAlign">
										<c:forEach var="k" items="${manuscript.keyword }">
											<span class="tag label label-info">${k}</span>
										</c:forEach>
									</p>
								</div>
							</div>
						</div>
						<c:if test="${manuscript.divisionId != 0}">
							<div class="form-group marginTop-10">
								<label class="control-label col-md-2"><spring:message code="manuscript.division"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										${manuscript.division.symbol}. ${manuscript.division.name}
									</p>
								</div>
							</div>
						</c:if>
						<c:forEach var="revision" begin="0" end="${manuscript.revisionCount }" step="1">
							<c:if test="${revision == 0 }">
								<c:if test="${manuscript.getLastEventDateTime('I') != null}">
									<c:set var="confirmStatus" value="O"/>
									<c:if test="${journal.type == 'B' or journal.type == 'D'}">
										<c:set var="confirmStatus" value="R"/>
									</c:if>
									<c:if test="${manuscript.getLastEventDateTime(confirmStatus) != null}">
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${revision }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime(confirmStatus).date}", "${manuscript.getLastEventDateTime(confirmStatus).time}", "${locale}");
										</script>
									</c:if>
									<div class="form-group">
										<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/> <br/><small>(<spring:message code="system.original"/>)</small>:</label>
										<div class="col-md-9">
											<p class="form-control-static sentenseJustifyAlign">
												<span id="reviewerHistory${pageType }${revision }submitDateSpan"></span> <c:if test="${manuscript.getEventDateTime(confirmStatus, revision) != null}"><small>(<spring:message code="manuscript.confirmDate"/> <span id="reviewerHistory${pageType }${revision }confirmDateSpan"></span>)</small></c:if>
												<script type="text/javascript">
													document.getElementById("reviewerHistory${pageType }${revision }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('I').date}", "${manuscript.getLastEventDateTime('I').time}", "${locale}");
												</script>
											</p>
										</div>
									</div>
								</c:if>
							</c:if>
							<c:if test="${revision > 0 }">
								<c:if test="${manuscript.getEventDateTime('V', revision) != null}">
									<c:set var="confirmStatus" value="R"/>
									<c:if test="${manuscript.getEventDateTime(confirmStatus, revision) != null}">
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${revision }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime(confirmStatus, revision).date}", "${manuscript.getEventDateTime(confirmStatus, revision).time}", "${locale}");
										</script>
									</c:if>
									<div class="form-group">
										<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/>  <br/><small>(<spring:message code="system.revision"/> ${revision })</small>:</label>
										<div class="col-md-9">
											<p class="form-control-static sentenseJustifyAlign">
												<span id="reviewerHistory${pageType }${revision }submitDateSpan"></span> <span id="reviewerHistory${pageType }${revision }confirmDateSpan"></span>
												<script type="text/javascript">
													document.getElementById("reviewerHistory${pageType }${revision }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('V', revision).date}", "${manuscript.getEventDateTime('V', revision).time}", "${locale}");
												</script>
											</p>
										</div>
									</div>
								</c:if>
							</c:if>
						</c:forEach>

						<c:if test="${manuscript.getLastEventDateTime('A') != null}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.acceptDate"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										<span id="reviewerHistory${pageType }${manuscript.revisionCount}acceptDateSpan"></span>
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${manuscript.revisionCount}acceptDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('A').date}", "${manuscript.getLastEventDateTime('A').time}", "${locale}");
										</script>
									</p>
								</div>
							</div>
						</c:if>
						<c:if test="${manuscript.getLastEventDateTime('J') != null}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.rejectDate"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										<span id="reviewerHistory${pageType }${manuscript.revisionCount}rejectDateSpan"></span>
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${manuscript.revisionCount}rejectDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('J').date}", "${manuscript.getLastEventDateTime('J').time}", "${locale}");
										</script>
									</p>
								</div>
							</div>
						</c:if>
						<c:if test="${manuscript.getLastEventDateTime('M') != null}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.cameraReadySubmitDate"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										<span id="reviewerHistory${pageType }${manuscript.revisionCount}cameraReadySubmitDateSpan"></span>
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${manuscript.revisionCount}cameraReadySubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('M').date}", "${manuscript.getLastEventDateTime('M').time}", "${locale}");
										</script>
									</p>
								</div>
							</div>
						</c:if>
						<c:if test="${manuscript.getLastEventDateTime('G') != null}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.galleryProofSubmitDate"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										<span id="reviewerHistory${pageType }${manuscript.revisionCount}galleryProofSubmitDateSpan"></span>
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${manuscript.revisionCount}galleryProofSubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('G').date}", "${manuscript.getLastEventDateTime('G').time}", "${locale}");
										</script>
									</p>
								</div>
							</div>
						</c:if>
						<c:if test="${manuscript.getLastEventDateTime('W') != null}">
							<div class="form-group">
								<label class="control-label col-md-2"><spring:message code="manuscript.withdrawalDate"/>:</label>
								<div class="col-md-9">
									<p class="form-control-static sentenseJustifyAlign">
										<span id="reviewerHistory${pageType }${manuscript.revisionCount}withdrawalDateSpan"></span>
										<script type="text/javascript">
											document.getElementById("reviewerHistory${pageType }${manuscript.revisionCount}withdrawalDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('W').date}", "${manuscript.getLastEventDateTime('W').time}", "${locale}");
										</script>
									</p>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>			
</div>
<script>
function backToTable() {
	$('#reviewerHistory-t').show('normal');
	$('#reviewerHistory').hide();
}
$('.ver-inline-menu').css("width", "50px");
</script>