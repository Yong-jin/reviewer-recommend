<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<div id ="modal-header" class="modal-header ">
	<h4 class="modal-title"><spring:message code="manuscript.finalDecisionForCurrentVersion"/></h4>
</div>
<div class="modal-body">
	<form:form modelAttribute="finalDecision" class="form-horizontal" id="finalDecisionForm">
	<form:hidden path="id" value="${finalDecision.id }"/>
	<form:hidden path="userId" value="${finalDecision.userId }"/>
	<form:hidden path="manuscriptId" value="${manuscript.id }"/>
	<form:hidden path="journalId" value="${finalDecision.journalId }"/>
	<form:hidden path="editorRecommend" value="${finalDecision.editorRecommend}"/>
	<form:hidden path="revisionCount" value="${manuscript.revisionCount}"/>
	<form:hidden id = "decision" path="decision" value="0"/>
	<input type="hidden" name="returnPage" value="${returnPage }"/>
 	<c:if test="${manuscript.revisionCount > 0 and not empty manuscript.reviewList}">
		<div class="row">
			<label class="col-md-2 text-right" style="margin-top: 6px;">
				<spring:message code="system.previous"/> <spring:message code="reviewer.reviewResultSummary"/>:
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<c:forEach var="currentRevision" begin="0" end="${manuscript.revisionCount - 1}" step="1">
							<c:forEach var="reviews" varStatus="status" items="${manuscript.reviewList}" >
								<c:set var="reviewCompleted" value="false"/>
								<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
									<c:if test="${review.status == 'C' and review.revisionCount == currentRevision}">
										<c:set var="reviewCompleted" value="true"/>
									</c:if>
								</c:forEach>
								<c:if test="${reviewCompleted == true }">
									
									<h5 style="margin-left: 0px !important; margin-bottom:0px !important; margin-top:10px !important">
										<%-- <spring:message code="system.manuscript"/> <spring:message code="system.version"/> - --%>
										<c:if test="${currentRevision == 0}">
											<spring:message code="system.original"/>
										</c:if>
										<c:if test="${currentRevision > 0}">
											<spring:message code="system.revision"/> #${currentRevision}
										</c:if>
									</h5>
									<p class="form-control-static sentenseJustifyAlign reviewSummary">
										<br/>
										<c:set var="count" value="1" />
										<c:forEach var="review" varStatus="reviewStatus" items="${reviews}">
											<c:if test="${review.status == 'C' and review.revisionCount == currentRevision}">
												<small><b><spring:message code="reviewResult.score.${review.overall }"/></b>
												(
												<spring:message code="user.role.journal_reviewer"/> #${count }, 
												<c:choose>
													<c:when test="${journal.languageCode ==  'ko' and fn:trim(review.user.contact.localFullName) != ''}">
														${review.user.contact.localFullName }
													</c:when>
													<c:otherwise>
														${review.user.contact.firstName } ${review.user.contact.lastName }
													</c:otherwise>
												</c:choose>
												)
												</small>
												<c:set var="count" value="${count+1 }"/>
												<br/>
											</c:if>
										</c:forEach>
									</p>
								</c:if>
							</c:forEach>
							<p class="form-control-static sentenseJustifyAlign reviewSummaryEditor">
								<c:forEach var="fd" items="${manuscript.decisions }">
									<c:if test="${fd.revisionCount == currentRevision }">
										<c:if test="${journal.type == 'A' or journal.type == 'B' }">
											<c:choose>
												<c:when test="${journal.type == 'A'}">
													<c:if test="${fd.editorRecommend == 5}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.strongAccept"/></b></c:if>
													<c:if test="${fd.editorRecommend == 4}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.accept"/></b></c:if>
													<c:if test="${fd.editorRecommend == 3}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.marginal"/></b></c:if>
													<c:if test="${fd.editorRecommend == 2}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.reject"/></b></c:if>
													<c:if test="${fd.editorRecommend == 1}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.strongReject"/></b></c:if>
													<c:if test="${fd.editorRecommend == 0}"><i class="fa fa-briefcase"></i> <b><spring:message code="system.notAvailable2"/></b></c:if>
												</c:when>
												<c:when test="${journal.type == 'B'}">
													<c:if test="${fd.editorRecommend == 4}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.accept"/></b></c:if>
													<c:if test="${fd.editorRecommend == 2}"><i class="fa fa-briefcase"></i> <b><spring:message code="reviewResult.reject"/></b></c:if>
													<c:if test="${fd.editorRecommend == 0}"><i class="fa fa-briefcase"></i> <b><spring:message code="system.notAvailable2"/></b></c:if>
												</c:when>
											</c:choose>
											<small>(<spring:message code="associateEditor.recommendedByAE"/>)</small>
											<br/>
										</c:if>
										<c:choose>
											<c:when test="${journal.type == 'A' or journal.type == 'C' }">
												<c:if test="${fd.decision == 5}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.strongAccept"/></b></c:if>
												<c:if test="${fd.decision == 4}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.accept"/></b></c:if>
												<c:if test="${fd.decision == 3}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.marginal"/></b></c:if>
												<c:if test="${fd.decision == 2}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.reject"/></b></c:if>
												<c:if test="${fd.decision == 1}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.strongReject"/></b></c:if>
												<c:if test="${fd.decision == 0}"><i class="fa fa-gavel"></i> <b><spring:message code="system.notAvailable2"/></b></c:if>
											</c:when>
											<c:when test="${journal.type == 'B' or journal.type == 'D' }">
												<c:if test="${fd.decision == 4}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.accept"/></b></c:if>
												<c:if test="${fd.decision == 2}"><i class="fa fa-gavel"></i> <b><spring:message code="reviewResult.reject"/></b></c:if>
												<c:if test="${fd.decision == 0}"><i class="fa fa-gavel"></i> <b><spring:message code="system.notAvailable2"/></b></c:if>
											</c:when>
										</c:choose>
										<small>(<spring:message code="chiefEditor.finalDecision"/>)</small>
										<br/>
									</c:if>
								</c:forEach>					
							</p>
						</c:forEach>
					</div>
				</fieldset>
			</div>
		</div>
	</c:if>
	<c:if test="${empty reviews}">
		<div class="row">
			<label class="col-md-2">
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<h5 style="margin-left: 0px !important; margin-bottom:0px !important;  margin-top:0px !important">
							<c:if test="${manuscript.revisionCount == 0}">
								<spring:message code="system.original"/>
							</c:if>
							<c:if test="${manuscript.revisionCount > 0}">
								<spring:message code="system.revision"/> #${manuscript.revisionCount}
							</c:if>
						</h5>
					</div>
				</fieldset>
			</div>
		</div>
	</c:if>
	<c:if test="${not empty reviews}">
		<div class="row">
			<label class="col-md-2 text-right" style="margin-top: 4px;">
				<spring:message code="system.reviewResultLast"/>:
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<h5 style="margin-left: 0px !important; margin-top:0px !important">
							<%-- <spring:message code="system.manuscript"/> <spring:message code="system.version"/> - --%> 
							<c:if test="${manuscript.revisionCount == 0}">
								<spring:message code="system.original"/>
							</c:if>
							<c:if test="${manuscript.revisionCount > 0}">
								<spring:message code="system.revision"/> #${manuscript.revisionCount}
							</c:if>
						</h5>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th class="cellCenter height10 fontSize12">
										<spring:message code="user.role.journal_reviewer"/>
									</th>
									<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
										<c:set var="configurationReviewItemId" value="${jc.getReviewItemId(index) }"/>
										<c:if test="${configurationReviewItemId != 1 }">
											<th class="cellCenter height10 fontSize12">
												<spring:message code="review.item.${configurationReviewItemId }"/>
											</th>
										</c:if>
									</c:forEach>
									<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
										<c:set var="configurationReviewItemId" value="${jc.getReviewItemId(index) }"/>
										<c:if test="${configurationReviewItemId == 1 }">
											<th class="cellCenter height10 fontSize12">
												<spring:message code="review.item.${configurationReviewItemId }"/>
											</th>
										</c:if>
									</c:forEach>
									<th class="cellCenter height10 fontSize12">
										<spring:message code="reviewResult.overall"/>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="review" varStatus="varStatus" items="${reviews}">
									<c:set var="reviewerCommentToAuthor">
									<spring:message code='system.notAvailable2'/>
									</c:set>
									<c:set var="reviewerCommentToEditor">
									<spring:message code='system.notAvailable2'/>
									</c:set>
									<c:forEach var="comment" items="${comments }">
										<c:if test="${comment.fromRole == 'ROLE_REVIEWER' and comment.toRole == 'ROLE_MEMBER' and comment.fromUserId == review.userId and comment.revisionCount == review.revisionCount and fn:trim(comment.textHtml) != ''}">
											<c:set var="reviewerCommentToAuthor" value="${comment.textHtml }"/>
										</c:if>
										<c:if test="${comment.fromRole == 'ROLE_REVIEWER' and (comment.toRole == 'ROLE_A-EDITOR' or comment.toRole == 'ROLE_G-EDITOR') and comment.fromUserId == review.userId and comment.revisionCount == review.revisionCount and fn:trim(comment.textHtml) != '' }">
											<c:set var="reviewerCommentToEditor" value="${comment.textHtml }"/>
										</c:if>
									</c:forEach>
									<c:set var="rowSpanSize" value="1"/>
									<c:if test="${reviewerCommentToAuthor != '' }">
										<c:set var="rowSpanSize" value="${rowSpanSize + 1}"/>
									</c:if>
									<c:if test="${reviewerCommentToEditor != '' }">
										<c:set var="rowSpanSize" value="${rowSpanSize + 1}"/>
									</c:if>
									<tr>
										<td rowspan="${rowSpanSize}" class="cellCenter height10 fontSize12">
											#${varStatus.count}<br/>
											<c:set var="reviewerName" value=""/>
											<c:choose>
												<c:when test="${journal.languageCode == 'ko' and fn:trim(review.user.contact.localFullName) != ''}">
													<c:set var="reviewerName" value="${review.user.contact.localFullName}"/>
												</c:when>
												<c:otherwise>
													<c:set var="reviewerName" value="${review.user.contact.firstName}<br/>${review.user.contact.lastName}"/>
												</c:otherwise>
											</c:choose>

											<a class="tooltipAnchor" rel="tooltip" data-html="true" title="${review.reviewerToolTipData }">${reviewerName}</a>
										</td>
										<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
											<c:set var="configurationReviewItemId" value="${jc.getReviewItemId(index) }"/>
											<c:set var="reviewItemMatched" value="false"/>
											<c:if test="${configurationReviewItemId != 1}">
												<td class="cellCenter height10 fontSize12">
													<c:forEach var="index2" begin="1" end="${review.numberOfReviewItems }" step="1">
														<c:set var="currentReviewItemId" value="${review.getReviewItemId(index2) }"/>
														<c:set var="currentScore" value="${review.getScore(index2) }"/>
														<c:if test="${configurationReviewItemId == currentReviewItemId}">
															<c:set var="reviewItemMatched" value="true"/>
															<c:if test="${currentScore == 5 }">(5/5)<br/> <spring:message code="reviewResult.excellent"/></c:if>
															<c:if test="${currentScore == 4 }">(4/5)<br/> <spring:message code="reviewResult.good"/></c:if>
															<c:if test="${currentScore == 3 }">(3/5)<br/> <spring:message code="reviewResult.average"/></c:if>
															<c:if test="${currentScore == 2 }">(2/5)<br/> <spring:message code="reviewResult.weak"/></c:if>
															<c:if test="${currentScore == 1 }">(1/5)<br/> <spring:message code="reviewResult.poor"/></c:if>
														</c:if>
													</c:forEach>
													<c:if test="${reviewItemMatched == false }">
														<spring:message code="review.item.0"/>
													</c:if>
												</td>
											</c:if>
										</c:forEach>
										<c:forEach var="index" begin="1" end="${jc.numberOfReviewItems }" step="1">
											<c:set var="configurationReviewItemId" value="${jc.getReviewItemId(index) }"/>
											<c:set var="reviewItemMatched" value="false"/>
											<c:if test="${configurationReviewItemId == 1}">
												<td class="cellCenter height10 fontSize12">
													<c:forEach var="index2" begin="1" end="${review.numberOfReviewItems }" step="1">
														<c:set var="currentReviewItemId" value="${review.getReviewItemId(index2) }"/>
														<c:set var="currentScore" value="${review.getScore(index2) }"/>
														<c:if test="${configurationReviewItemId == currentReviewItemId}">
															<c:set var="reviewItemMatched" value="true"/>
															<c:if test="${currentScore == 3 }">(3/3)<br/> <spring:message code="reviewResult.high"/></c:if>
															<c:if test="${currentScore == 2 }">(2/3)<br/> <spring:message code="reviewResult.medium"/></c:if>
															<c:if test="${currentScore == 1 }">(1/3)<br/> <spring:message code="reviewResult.low"/></c:if>
														</c:if>
													</c:forEach>
													<c:if test="${reviewItemMatched == false }">
														<spring:message code="review.item.0"/>
													</c:if>
												</td>
											</c:if>
										</c:forEach>
										<td class="cellCenter height10 fontSize12">
											<c:choose>
												<c:when test="${journal.type == 'A' or journal.type == 'C' }">
													<c:if test="${review.overall == 5 }"><b>(5/5)<br/> <spring:message code="reviewResult.strongAccept"/></b></c:if>
													<c:if test="${review.overall == 4 }"><b>(4/5)<br/> <spring:message code="reviewResult.accept"/></b></c:if>
													<c:if test="${review.overall == 3 }"><b>(3/5)<br/> <spring:message code="reviewResult.marginal"/></b></c:if>
													<c:if test="${review.overall == 2 }"><b>(2/5)<br/> <spring:message code="reviewResult.reject"/></b></c:if>
													<c:if test="${review.overall == 1 }"><b>(1/5)<br/> <spring:message code="reviewResult.strongReject"/></b></c:if>
												</c:when>
												<c:when test="${journal.type == 'B' or journal.type == 'D' }">
													<c:if test="${review.overall == 4 }"><b>(4/5)<br/> <spring:message code="reviewResult.accept"/></b></c:if>
													<c:if test="${review.overall == 2 }"><b>(2/5)<br/> <spring:message code="reviewResult.reject"/></b></c:if>
												</c:when>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td colspan="${jc.numberOfReviewItems + 1 }">
											- <spring:message code="reviewResult.toAuthor2"/> -<br/>
											${reviewerCommentToAuthor}
										</td>
									</tr>
									<tr>
										<td colspan="${jc.numberOfReviewItems + 1 }">
											- <spring:message code="reviewResult.toEditors2"/>- <br/>
											${reviewerCommentToEditor}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</fieldset>
			</div>
		</div>
	</c:if>
	<c:if test="${(journal.type == 'A' or journal.type == 'B') and manuscript.manuscriptTrackId == 0 }">
		<div class="row">
			<label class="col-md-2 text-right">
				<spring:message code="associateEditor.recommendedByAE"/>:
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<c:choose>
							<c:when test="${journal.type == 'A' or journal.type == 'C' }">
								<c:if test="${finalDecision.editorRecommend == 5}"><b><spring:message code="reviewResult.strongAccept"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 3}"><b><spring:message code="reviewResult.marginal"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 1}"><b><spring:message code="reviewResult.strongReject"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
							</c:when>
							<c:when test="${journal.type == 'B' or journal.type == 'D' }">
								<c:if test="${finalDecision.editorRecommend == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
								<c:if test="${finalDecision.editorRecommend == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
							</c:when>
						</c:choose>
					</div>
				</fieldset>
			</div>
		</div>
		<c:if test="${journal.type == 'A' or journal.type == 'B' }">
			<c:set var="aeCommentToChief" value=""/>
			<c:forEach var="comment" items="${comments}">
				<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_C-EDITOR' and comment.fromUserId == manuscript.associateEditorUserId and comment.toUserId == manuscript.chiefEditorUserId and comment.revisionCount == manuscript.revisionCount}">
					<c:set var="aeCommentToChief" value="${comment.textHtml}"/>
				</c:if>
			</c:forEach>
			<c:if test="${aeCommentToChief != ''}">
				<div class="row">
					<label class="col-md-2 text-right">
						<spring:message code="reviewResult.associateEditorCommentsToChief"/>
					</label>
					<div class="col-md-10">
						<fieldset class="col-md-11">
							<div class="form-group">
								${aeCommentToChief }
							</div>
						</fieldset>
					</div>
				</div>
			</c:if>
			<c:set var="aeCommentToAuthor" value=""/>
			<c:forEach var="comment" items="${comments}">
				<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_MEMBER' and comment.fromUserId == manuscript.associateEditorUserId and comment.revisionCount == manuscript.revisionCount}">
					<c:set var="aeCommentToAuthor" value="${comment.textHtml}"/>
				</c:if>
			</c:forEach>
			<c:if test="${aeCommentToAuthor != ''}">
				<div class="row">
					<label class="col-md-2 text-right">
						<spring:message code="reviewResult.associateEditorCommentsToAuthor"/>
					</label>
					<div class="col-md-10">
						<fieldset class="col-md-11">
							<div class="form-group">
								${aeCommentToAuthor }
							</div>
						</fieldset>
					</div>
				</div>
			</c:if>
		</c:if>
	</c:if>
	<br/>
	<div class="row">
		<label class="col-md-2 text-right">
			<spring:message code="manuscript.finalDecisionForCurrentVersion"/>:
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<select class="select2 form-control finalDecision">
						<option value=""></option>
						<c:choose>
							<c:when test="${journal.type == 'A' or journal.type == 'C' }">
								<option value="5"><spring:message code="reviewResult.strongAccept"/></option>
								<option value="4"><spring:message code="reviewResult.accept"/></option>
								<option value="3"><spring:message code="reviewResult.marginal"/></option>
								<option value="2"><spring:message code="reviewResult.reject"/></option>
								<option value="1"><spring:message code="reviewResult.strongReject"/></option>
							</c:when>
							<c:when test="${journal.type == 'B' or journal.type == 'D' }">
								<option value="4"><spring:message code="reviewResult.accept"/></option>
								<option value="2"><spring:message code="reviewResult.reject"/></option>
							</c:when>
						</c:choose>
					</select>
				</div>
			</fieldset>
		</div>
	</div>
	<div id="emailForm">
		<div class="row">
			<label class="control-label col-md-2 text-right">
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<input name="subject" id="subject" value="" class="form-control" readonly/>
						<input type="hidden" name="manuscriptId" value="${manuscript.id }"/>
						<input type="hidden" id="acceptEmailSubject" name="acceptEmailSubject" value="${acceptEmailMessage.subject }"/>
						<input type="hidden" id="acceptEmailBody" name="acceptEmailBody" value="${acceptEmailMessage.body }"/>
						<input type="hidden" id="rejectEmailSubject" name="rejectEmailSubject" value="${rejectEmailMessage.subject }"/>
						<input type="hidden" id="rejectEmailBody" name="rejectEmailBody" value="${rejectEmailMessage.body }"/>
						<input type="hidden" id="reReviewEmailSubject" name="reReviewEmailSubject" value="${reReviewEmailMessage.subject }"/>
						<input type="hidden" id="reReviewEmailBody" name="reReviewEmailBody" value="${reReviewEmailMessage.body }"/>
					</div>
				</fieldset>
			</div>
		</div>
		<div class="row">
			<label class="control-label col-md-2 text-right">
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div class="form-group">
						<textarea rows="15" id="body" name="body" class="form-control" readonly></textarea>
						<span class="required">(<spring:message code="system.replaceCommentMessage"/><br/><c:if test="${manuscript.manuscriptTrackId == 0 }"><spring:message code="system.noCommentsByChiefEditor"/></c:if><c:if test="${manuscript.manuscriptTrackId == 1 }"><spring:message code="system.noCommentsByGuestEditor"/></c:if>)</span>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
	<div class="row">
		<label class="col-md-2 text-right">
			<c:if test="${manuscript.manuscriptTrackId == 0 }">
				<spring:message code="chiefEditor.commentToAuthor"/>:
			</c:if>
			<c:if test="${manuscript.manuscriptTrackId == 1 }">
				<spring:message code="guestEditor.commentToAuthor"/>:
			</c:if>
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="15" cols="" id="postCommentToAuthor" name="postCommentToAuthor" class="form-control"></textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<label class="col-md-2 text-right">
			<c:if test="${manuscript.manuscriptTrackId == 0 }">
				<spring:message code="chiefEditor.messageAtDecision"/> (<spring:message code="reviewResult.confidentialToAuthors"/>):
			</c:if>
			<c:if test="${manuscript.manuscriptTrackId == 1 }">
				<spring:message code="guestEditor.messageAtDecision"/> (<spring:message code="reviewResult.confidentialToAuthors"/>):
			</c:if>
		</label>
		<div class="col-md-10">
			<fieldset class="col-md-11">
				<div class="form-group">
					<textarea rows="5" cols="" id="postCommentToEditorAndManager" name="postCommentToEditorAndManager" class="form-control"></textarea>
				</div>
			</fieldset>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-6 col-md-6">
				<button class="btn green confirmButton" data-manuscriptId="${manuscript.id}">
					 <spring:message code="chiefEditor.decision"/> <i class="m-icon-swapright m-icon-white"></i>
				</button>
			</div>
		</div>
	</div>
	</form:form>
</div>
<script>
var errorMessages = new Array();
errorMessages['editorCommon.sendFinalDecisionConfirm'] = "<spring:message code='editorCommon.sendFinalDecisionConfirm' javaScriptEscape='true' />";
errorMessages['editorCommon.selectDecision'] = "<spring:message code='editorCommon.selectDecision' javaScriptEscape='true' />";
errorMessages['editorCommon.writeComments'] = "<spring:message code='editorCommon.selectDecision' javaScriptEscape='true' />";

	
$(document).ready(function() {
	var reviewResultExist = "${reviewResultsExist}";
	var acceptEmailSubject = $('#acceptEmailSubject').val();
	var acceptEmailBody =$('#acceptEmailBody').val();
	var reReviewEmailSubject = $('#reReviewEmailSubject').val();
	var reReviewEmailBody =$('#reReviewEmailBody').val();
	var rejectEmailSubject = $('#rejectEmailSubject').val();
	var rejectEmailBody = $('#rejectEmailBody').val();
	var changed = false;
	var manuscriptTrackId = "${manuscript.manuscriptTrackId}";
	$("a[rel='tooltip']").tooltip({
		'z-index': '3000',
	});	

	$('#emailForm').hide();
	$("select.finalDecision").select2({
		placeholder: '<i class="fa fa-group-o "></i>&nbsp;<spring:message code="manuscript.finalDecision"/>',
		allowClear: true,
		dropdownAutoWidth: true,
		escapeMarkup: function (m) {
			return m;
		},
		containerCssClass: "muted"
	});
	
	$('.select2-chosen').css("color", "#000");
	
	$(".finalDecision").change(function(event) {
	    var selectedDecision = $(this).children("option:selected").val();
	    if(selectedDecision != "") {
	    	changed = true;
	    	$('#emailForm').show('normal');
	    	var decision;
	    	var replaced;
	    	if(selectedDecision == '1' || selectedDecision == '2') {
	    		$('#subject').val(rejectEmailSubject);
	    		if(selectedDecision == '1')
	    			decision = "<spring:message code='reviewResult.strongReject'/>";
	    		else if(selectedDecision == '2')
	    			decision = "<spring:message code='reviewResult.reject'/>";
	    		replaced = rejectEmailBody.replace("[reviewDecision]", decision);
	    	} else if(selectedDecision == '4' || selectedDecision == '5') {
	    		$('#subject').val(acceptEmailSubject);
	    		if(selectedDecision == '4')
	    			decision = "<spring:message code='reviewResult.accept'/>";
	    		else if(selectedDecision == '5')
	    			decision = "<spring:message code='reviewResult.strongAccept'/>";
	    			
	    		replaced = acceptEmailBody.replace("[reviewDecision]", decision);
	    		replaced = replaced.replace("[cameraReadySubmitDate]", "${cameraReadySubmitDate}");
	    	} else {
	    		$('#subject').val(reReviewEmailSubject);
	    		decision = "<spring:message code='reviewResult.marginal'/>";
	    		replaced = reReviewEmailBody.replace("[reviewDecision]", decision);
	    	}
	    	$('#body').val(replaced);
	    } else 
	    	changed = false;
	});

	
	$(".confirmButton").click(function(event) {
		event.preventDefault();
		if(changed) {
			var decision = $('.finalDecision').children("option:selected").val();
			$('#decision').val(decision);

					if(reviewResultExist == false)
						bootbox.alert(errorMessages['editorCommon.writeComments']);
					else {
 						var url = "${baseUrl}/journals/${jnid}/${currentPageRole }/manuscripts/finalDecision";
						var data = $('#finalDecisionForm').serialize();
						$.ajax({
							type:"POST",
							url: url,
							data: data,
							success:function(html) {
								if(manuscriptTrackId == 0)
									location.href="${baseUrl}/journals/${jnid}/chiefEditor/manuscripts?pageType=${returnPage}";
								else if(manuscriptTrackId == 1)
									location.href="${baseUrl}/journals/${jnid}/guestEditor/manuscripts?pageType=${returnPage}";
							}
						});
					}


		} else
			bootbox.alert(errorMessages['editorCommon.selectDecision']);
	});
});
</script>