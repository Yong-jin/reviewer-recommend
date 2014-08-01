<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="locale" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="request_uri" value="${requestScope['javax.servlet.forward.request_uri']}" />
<c:set var="query_string" value="${requestScope['javax.servlet.forward.query_string']}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />

<script src="${baseUrl}/js/moment.js"></script>
<br/>
<c:if test="${currentPageRole != 'reviewer' and currentPageRole != 'author'}">
<security:authorize ifAnyGranted="ROLE_C-EDITOR, ROLE_A-EDITOR, ROLE_MANAGER">
	<c:set var="exist" value="false"/>
	<c:forEach var="comment" items="${manuscript.comments}">
		<c:if test="${comment.fromRole == 'ROLE_C-EDITOR' and (comment.toRole == 'ROLE_A-EDITOR' or comment.scopeManager == 1) and comment.status == 'O' and fn:trim(comment.text) != ''}">
			<c:set var="exist" value="true"/>
		</c:if>
	</c:forEach>
	<c:if test="${exist == true}">
		<h4><spring:message code="reviewResult.messagesByEditors"/></h4>
		<div class="form-section_noborder" style="margin-bottom: 0px; padding-bottom: 0px;">
			<div class="form-group">
				<label class="control-label col-md-2"><spring:message code="user.role.journal_c-editor"/> <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_a-editor"/>: </label>
				<div class="col-md-9">
					<p class="form-control-static sentenseJustifyAlign">
						<c:forEach var="comment" items="${manuscript.comments}">
							<c:if test="${comment.fromRole == 'ROLE_C-EDITOR' and (comment.toRole == 'ROLE_A-EDITOR' or comment.scopeManager == 1) and comment.status == 'O' and fn:trim(comment.text) != ''}">
								${comment.textHtml}
								<br/><small id="${pageType}${comment.revisionCount }commentDateSpan"></small>
								<script type="text/javascript">
									document.getElementById("${pageType}${comment.revisionCount }commentDateSpan").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
								</script>
							</c:if>
						</c:forEach>
					</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-9"><hr class="soften"/></div>
		</div>
	</c:if>
</security:authorize>
</c:if>

<div class="form-section_noborder">
	<h4><spring:message code="system.manuscriptInformation"/></h4>
	<br/>
	<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="system.basicInformation"/> <c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}"> &nbsp; <a id="${pageType }MhistoryViewButton" onClick="historyView(${manuscript.id}, 'M');"><i class="fa fa-angle-down "></i></a></c:if></h5>
	<div class="form-group">
		<label class="control-label col-md-2">
			<c:choose>
				<c:when test="${fn:trim(manuscript.submitId) != '' }">
					<spring:message code="system.manuscriptId"/>:
				</c:when>
				<c:otherwise>
					<spring:message code="system.temporaryId"/>:
				</c:otherwise>
			</c:choose>
		</label>
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
	<div id="${pageType }MhistoryDisplay" class="historyView"></div>
	<div id="${pageType }MhistoryCurrentDisplay" class="historyCurrentView">
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="manuscript.title2"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign">
					<b><c:if test="${manuscript.invite == true}"><span class="required">*</span> (Invited) </c:if>${manuscript.title }</b>
				</p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="manuscript.runningHead"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign">
					<c:choose>
						<c:when test="${manuscript.runningHead != null and fn:trim(manuscript.runningHead) != ''}">
							${manuscript.runningHead }
						</c:when>
						<c:otherwise>
							<spring:message code='system.notAvailable'/>
						</c:otherwise>
					</c:choose>
					
				</p>
			</div>
		</div>
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
		<c:if test="${jc.manageDivision == true and (manuscript.divisionId != 0 and manuscript.division != null)}">
			<div class="form-group marginTop-10">
				<label class="control-label col-md-2"><spring:message code="manuscript.division"/>:</label>
				<div class="col-md-9">
					<p class="form-control-static sentenseJustifyAlign">
						${manuscript.division.symbol}. ${manuscript.division.name}
					</p>
				</div>
			</div>
		</c:if>
		<c:if test="${manuscript.status != 'D' }">
			<c:forEach var="revision" begin="0" end="${manuscript.revisionCount }" step="1">
				<c:if test="${revision == 0 }">
					<c:if test="${manuscript.getLastEventDateTime('I') != null}">
						<c:set var="confirmStatus" value="O"/>
						<c:if test="${journal.type == 'B' or journal.type == 'D'}">
							<c:set var="confirmStatus" value="R"/>
						</c:if>
						<c:if test="${manuscript.getLastEventDateTime(confirmStatus) != null}">
							<script type="text/javascript">
								document.getElementById("${pageType }${revision }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime(confirmStatus).date}", "${manuscript.getLastEventDateTime(confirmStatus).time}", "${locale}");
							</script>
						</c:if>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/>:<br/><small>(<spring:message code="system.original"/>)</small></label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="${pageType }${revision }submitDateSpan"></span> <c:if test="${manuscript.getLastEventDateTime(confirmStatus) != null}"><small>(<spring:message code="manuscript.confirmDate"/> <span id="${pageType }${revision }confirmDateSpan"></span>)</small></c:if>
									<script type="text/javascript">
										document.getElementById("${pageType }${revision }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('I').date}", "${manuscript.getLastEventDateTime('I').time}", "${locale}");
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
								document.getElementById("${pageType }${revision }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime(confirmStatus, revision).date}", "${manuscript.getEventDateTime(confirmStatus, revision).time}", "${locale}");
							</script>
						</c:if>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/>:<br/><small>(<spring:message code="system.revision"/> ${revision })</small></label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="${pageType }${revision }submitDateSpan"></span> <c:if test="${manuscript.getEventDateTime(confirmStatus, revision) != null}"><small>(<spring:message code="manuscript.confirmDate"/> <span id="${pageType }${revision }confirmDateSpan"></span>)</small></c:if>
									<script type="text/javascript">
										document.getElementById("${pageType }${revision }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('V', revision).date}", "${manuscript.getEventDateTime('V', revision).time}", "${locale}");
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
							<span id="${pageType }acceptDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }acceptDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('A').date}", "${manuscript.getLastEventDateTime('A').time}", "${locale}");
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
							<span id="${pageType }rejectDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }rejectDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('J').date}", "${manuscript.getLastEventDateTime('J').time}", "${locale}");
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
							<span id="${pageType }cameraReadySubmitDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }cameraReadySubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('M').date}", "${manuscript.getLastEventDateTime('M').time}", "${locale}");
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
							<span id="${pageType }galleryProofSubmitDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }galleryProofSubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('G').date}", "${manuscript.getLastEventDateTime('G').time}", "${locale}");
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
							<span id="${pageType }withdrawalDateSpan"></span>
							<script type="text/javascript">
								document.getElementById("${pageType }withdrawalDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('W').date}", "${manuscript.getLastEventDateTime('W').time}", "${locale}");
							</script>
						</p>
					</div>
				</div>
			</c:if>
		</c:if>
	</div>
</div>
<%-- 
<security:authorize ifAnyGranted="ROLE_C-EDITOR, ROLE_A-EDITOR, ROLE_MANAGER">
<c:set var="chiefPreComment">
<spring:message code='system.notAvailable'/>
</c:set>
<c:set var="exist" value="false"/>
<c:forEach var="comment" items="${manuscript.comments}">
	<c:if test="${comment.fromRole == 'ROLE_C-EDITOR' and comment.toRole == 'ROLE_A-EDITOR' and comment.status == 'O'}">
		<security:authorize ifAnyGranted="ROLE_C-EDITOR">
			<c:if test="${fromUserId == user.id }">
				<c:set var="exist" value="true"/>
			</c:if>
		</security:authorize>
		<security:authorize ifAnyGranted="ROLE_A-EDITOR">
			<c:if test="${toUserId == user.id }">
				<c:set var="exist" value="true"/>
			</c:if>
		</security:authorize>
		<security:authorize ifAnyGranted="ROLE_MANAGER">
			<c:if test="${comment.scopeManager == 1 }">
				<c:set var="exist" value="true"/>
			</c:if>
		</security:authorize>
	</c:if>
</c:forEach>
<c:if test="${exist == true}">
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code='chiefEditor.preMessage'/></h5>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="user.role.journal_c-editor"/> <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_a-editor"/>: </label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign" <c:if test="${locale == 'en_US'}">style="margin-top:1.4em"</c:if>>
					<c:forEach var="comment" items="${manuscript.comments}">
						<c:if test="${comment.fromRole == 'ROLE_C-EDITOR' and comment.toRole == 'ROLE_A-EDITOR' and comment.status == 'O'}">
							<security:authorize ifAnyGranted="ROLE_C-EDITOR">
								<c:if test="${fromUserId == user.id }">
									<c:set var="chiefPreComment" value="${comment.textHtml}"/>
								</c:if>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_A-EDITOR">
								<c:if test="${toUserId == user.id }">
									<c:set var="chiefPreComment" value="${comment.textHtml}"/>
								</c:if>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_MANAGER">
								<c:if test="${comment.scopeManager == 1 }">
									<c:set var="chiefPreComment" value="${comment.textHtml}"/>
								</c:if>
							</security:authorize>
						</c:if>
					</c:forEach>
					${chiefPreComment}
				</p>
			</div>
		</div>
	</div>
</c:if>
</security:authorize> --%>
<c:set var="manuscriptFilesExist" value="false"/>
<c:set var="additionalFilesExist" value="false"/>
<c:set var="galleryProofExist" value="false"/>
<c:set var="cameraReadyExist" value="false"/>
<c:forEach var="uploadedFile" items="${manuscript.files}">
	<c:if test="${uploadedFile.revisionCount == manuscript.revisionCount and (uploadedFile.designation == 'mainDocument' or uploadedFile.designation == 'figureImageDocument' or uploadedFile.designation == 'tableDocument' or uploadedFile.designation == 'supplementaryFile' or uploadedFile.designation == 'replayLetter')}">
		<c:set var="manuscriptFilesExist" value="true"/>
	</c:if>
	<c:if test="${uploadedFile.revisionCount == manuscript.revisionCount and (uploadedFile.designation == 'frontCover' or uploadedFile.designation == 'checkList')}">
		<c:set var="additionalFilesExist" value="true"/>
	</c:if>
	<c:if test="${uploadedFile.galleryProofRevision == manuscript.galleryProofRevision and uploadedFile.designation == 'galleryProof'}">
		<c:set var="galleryProofExist" value="true"/>
	</c:if>
	<c:if test="${uploadedFile.cameraReadyRevision == manuscript.cameraReadyRevision and (uploadedFile.designation == 'cameraReadyPaper' or uploadedFile.designation == 'copyright' or uploadedFile.designation == 'biography')}">
		<c:set var="cameraReadyExist" value="true"/>
	</c:if>
</c:forEach>

<c:if test="${galleryProofExist == true}">
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="galleryProof.title"/><c:if test="${manuscript.galleryProofRevision > 0 }">&nbsp; <a id="${pageType }GFhistoryViewButton" onClick="historyView(${manuscript.id}, 'GF');"><i class="fa fa-angle-down "></i></a></c:if></h5>
		<div id="${pageType }GFhistoryDisplay" class="historyView"></div>
		<div id="${pageType }GFhistoryCurrentDisplay" class="form-group historyCurrentView">
			<div class="form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<table class="table table-bordered">
						<tr>
							<th class="cellCenter">
								
							</th>
							<th class="cellCenter">
								<spring:message code="system.version"/>
							</th>
							<th class="cellCenter">
								<spring:message code="system.fileName"/>
							</th>
							<th class="cellCenter">
								<spring:message code="system.uploadDate"/>
							</th>
						</tr>
						<c:set var="count" value="1"/>
						<c:forEach var="uploadedFile" items="${manuscript.files}">
							<c:if test="${uploadedFile.galleryProofRevision == manuscript.galleryProofRevision and uploadedFile.designation == 'galleryProof'}">
								<tr>
									<td class="cellCenter">
										${count}
									</td>
									<td class="cellCenter">
										<c:if test="${uploadedFile.galleryProofRevision == 0}">
											<spring:message code="system.original"/>
										</c:if>
										<c:if test="${uploadedFile.galleryProofRevision > 0}">
											<spring:message code="system.revision"/> #${uploadedFile.galleryProofRevision}
										</c:if>
									</td>
									<td class="cellCenter">
										<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id }/">${uploadedFile.originalName }</a>
									</td>
									<td class="cellCenter" id="${pageType }galleryProofFileDate${revisionCount}${count}">
										<script type="text/javascript">
											document.getElementById("${pageType }galleryProofFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
										</script>
									</td>
								</tr>
								<c:set var="count" value="${count + 1 }"/>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${cameraReadyExist == true}">
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="cameraReady.title"/><c:if test="${manuscript.cameraReadyRevision > 0 }">&nbsp; <a id="${pageType }CFhistoryViewButton" onClick="historyView(${manuscript.id}, 'CF');"><i class="fa fa-angle-down "></i></a></c:if></h5>
		<div id="${pageType }CFhistoryDisplay" class="historyView"></div>
		<div id="${pageType }CFhistoryCurrentDisplay" class="form-group historyCurrentView">
			<div class="form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<table class="table table-bordered">
						<tr>
							<td class="cellCenter">
										
							</td>
							<th class="cellCenter">
								<spring:message code="system.version"/>
							</th>
							<th class="cellCenter">
								<spring:message code="system.fileName"/>
							</th>
							<th class="cellCenter">
								<spring:message code="system.fileDesignation"/>
							</th>
							<th class="cellCenter">
								<spring:message code="system.uploadDate"/>
							</th>
						</tr>
						<c:set var="count" value="1"/>
						<c:forEach var="uploadedFile" items="${manuscript.files}">
							<c:if test="${uploadedFile.cameraReadyRevision == manuscript.cameraReadyRevision and (uploadedFile.designation == 'cameraReadyPaper' or uploadedFile.designation == 'copyright' or uploadedFile.designation == 'biography')}">
								<tr>
									<td class="cellCenter">
										${count}
									</td>
									<td class="cellCenter">
										<c:if test="${uploadedFile.cameraReadyRevision == 0}">
											<spring:message code="system.original"/>
										</c:if>
										<c:if test="${uploadedFile.cameraReadyRevision > 0}">
											<spring:message code="system.revision"/> #${uploadedFile.cameraReadyRevision}
										</c:if>
									</td>
									<td class="cellCenter">
										<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id }/">${uploadedFile.originalName }</a>
									</td>
									<td class="cellCenter">
										<c:choose>
											<c:when test="${uploadedFile.designation == 'cameraReadyPaper'}">
												<spring:message code="cameraReady.fileDesignation.0"/>
											</c:when>
											<c:when test="${uploadedFile.designation == 'copyright'}">
												<spring:message code="cameraReady.fileDesignation.1"/>
											</c:when>
											<c:when test="${uploadedFile.designation == 'biography'}">
												<spring:message code="cameraReady.fileDesignation.2"/>
											</c:when>
										</c:choose>
									</td>
									<td class="cellCenter" id="${pageType }cameraReadyPaperDate${revisionCount}${count}">
										<script type="text/javascript">
											document.getElementById("${pageType }cameraReadyPaperDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
										</script>
									</td>
								</tr>
								<c:set var="count" value="${count + 1 }"/>
							</c:if>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</c:if>

<!-- Submitted Manuscript Files -->
<div class="form-section_noborder">
	<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="manuscript.submittedFiles"/><c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}">&nbsp; <a id="${pageType }MFhistoryViewButton" onClick="historyView(${manuscript.id}, 'MF');"><i class="fa fa-angle-down "></i></a></c:if></h5>
	<div id="${pageType }MFhistoryDisplay" class="historyView"></div>
	<div id="${pageType }MFhistoryCurrentDisplay" class="historyCurrentView">
		<div class="form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-9">
				<c:choose>
					<c:when test="${manuscriptFilesExist == true}">
						<table class="table table-bordered">
							<tr>
								<th class="cellCenter">
		
								</th>
								<th class="cellCenter">
									<spring:message code="system.fileName"/>
								</th>
								<th class="cellCenter">
									<spring:message code="system.fileDesignation"/>
								</th>
								<th class="cellCenter">
									<spring:message code="system.uploadDate"/>
								</th>
							</tr>
							<c:set var="count" value="1"/>
							<c:forEach var="uploadedFile" items="${manuscript.files}">
								<c:if test="${uploadedFile.revisionCount == manuscript.revisionCount and (uploadedFile.designation == 'mainDocument' or uploadedFile.designation == 'figureImageDocument' or uploadedFile.designation == 'tableDocument' or uploadedFile.designation == 'supplementaryFile')}">
									<tr>
										<td class="cellCenter">
											${count}
										</td>
										<td class="cellCenter">
											<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id }/">${uploadedFile.originalName }</a>
										</td>
										<td class="cellCenter">
											<c:choose>
												<c:when test="${uploadedFile.designation == 'mainDocument'}">
													<spring:message code="author.newPaperSubmit.fileDesignation.0"/>
												</c:when>
												<c:when test="${uploadedFile.designation == 'replayLetter'}">
													<spring:message code="author.newPaperSubmit.fileDesignation.1"/>
												</c:when>
												<c:when test="${uploadedFile.designation == 'figureImageDocument'}">
													<spring:message code="author.newPaperSubmit.fileDesignation.2"/>
												</c:when>
												<c:when test="${uploadedFile.designation == 'tableDocument'}">
													<spring:message code="author.newPaperSubmit.fileDesignation.3"/>
												</c:when>
												<c:when test="${uploadedFile.designation == 'supplementaryFile'}">
													<spring:message code="author.newPaperSubmit.fileDesignation.4"/>
												</c:when>
											</c:choose>
										</td>
										<td class="cellCenter" id="${pageType }submittedFileDate${revisionCount}${count}">
										<script type="text/javascript">
											document.getElementById("${pageType }submittedFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
										</script>
										</td>
									</tr>
									<c:set var="count" value="${count + 1 }"/>
								</c:if>
							</c:forEach>
						</table>
					</c:when>
					<c:otherwise>
						<p class="form-control-static sentenseJustifyAlign">
							<spring:message code="system.notAvailable"/>
						</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<c:if test="${currentPageRole != 'reviewer' }">
	<c:if test="${(jc.frontCoverUrl != null and fn:trim(jc.frontCoverUrl) != '') or (jc.checkListUrl != null and fn:trim(jc.checkListUrl) != '')}">
	<!-- Additional Files -->
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="manuscript.additionalFiles"/><c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}"><c:if test="${jc.changeAdditionalFiles == true }">&nbsp; <a id="${pageType }AFhistoryViewButton" onClick="historyView(${manuscript.id}, 'AF');"><i class="fa fa-angle-down "></i></a></c:if></c:if></h5>
		<div id="${pageType }AFhistoryDisplay" class="historyView"></div>
		<div id="${pageType }AFhistoryCurrentDisplay" class="historyCurrentView">
			<div class="form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<c:choose>
						<c:when test="${additionalFilesExist == true}">
							<table class="table table-bordered">
								<tr>
									<th class="cellCenter">
			
									</th>
									<th class="cellCenter">
										<spring:message code="system.fileName"/>
									</th>
									<th class="cellCenter">
										<spring:message code="system.fileDesignation"/>
									</th>
									<th class="cellCenter">
										<spring:message code="system.uploadDate"/>
									</th>
								</tr>
								<c:set var="count" value="1"/>
								<c:forEach var="uploadedFile" items="${manuscript.files}">
									<c:if test="${uploadedFile.revisionCount == manuscript.revisionCount and (uploadedFile.designation == 'frontCover' or uploadedFile.designation == 'checkList')}">
										<tr>
											<td class="cellCenter">
												${count}
											</td>
											<td class="cellCenter">
												<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id }/">${uploadedFile.originalName }</a>
											</td>
											<td class="cellCenter">
												<c:choose>
													<c:when test="${uploadedFile.designation == 'frontCover'}">
														<spring:message code="author.newPaperSubmit.additionalFileDesignation.0"/>
													</c:when>
													<c:when test="${uploadedFile.designation == 'checkList'}">
														<spring:message code="author.newPaperSubmit.additionalFileDesignation.1"/>
													</c:when>
												</c:choose>
											</td>
											<td class="cellCenter" id="${pageType }additionalFileDate${revisionCount}${count}">
											<script type="text/javascript">
												document.getElementById("${pageType }additionalFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
											</script>
											</td>
										</tr>
										<c:set var="count" value="${count + 1 }"/>
									</c:if>
								</c:forEach>
							</table>
						</c:when>
						<c:otherwise>
							<p class="form-control-static sentenseJustifyAlign">
								<spring:message code="system.notAvailable"/>
							</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	</c:if>
</c:if>

<!-- Author Information -->
<c:if test="${currentPageRole != 'reviewer' or (currentPageRole == 'reviewer' and jc.reviewerViewAuthor == true)}">
<div class="form-section_noborder">
	<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="author.newPaperSubmit.tabMenu.2"/><c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}"> <c:if test="${jc.changeAuthor == true }"><a id="${pageType }AhistoryViewButton" onClick="historyView(${manuscript.id}, 'A');"><i class="fa fa-angle-down "></i></a> </c:if></c:if></h5>
	<div id="${pageType }AhistoryDisplay" class="historyView"></div>
	<div id="${pageType }AhistoryCurrentDisplay" class="historyCurrentView">
		<div class="form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-9">
				<table class="table table-bordered">
					<tr>
						<th class="cellCenter">
							<spring:message code="manuscript.authorsOrder2"/>
						</th>
						<th class="cellCenter">
							<spring:message code="user.degree"/>
						</th>
						<th class="cellCenter">
							<spring:message code="user.name"/>
						</th>
						<th class="cellCenter">
							<spring:message code="signin.email"/>
						</th>
						<th class="cellCenter">
							<spring:message code="user.institution"/>
						</th>
						<th class="cellCenter">
							<spring:message code="manuscript.correspondingAuthor"/>
						</th>
					</tr>
					<c:forEach var="coAuthor" items="${manuscript.coAuthors}">
						<tr>
							<td class="cellCenter">
								${coAuthor.authorOrder}
							</td>
							<td class="cellCenter">
								<spring:message code="signin.degreeDesignation.${coAuthor.user.contact.degree }"/>
							</td>
							<td class="cellCenter">
								<c:choose>
									<c:when test="${journal.languageCode ==  'ko' and fn:trim(coAuthor.user.contact.localFullName) != ''}">
										${coAuthor.user.contact.localFullName }
									</c:when>
									<c:otherwise>
										${coAuthor.user.contact.firstName } ${coAuthor.user.contact.lastName }
									</c:otherwise>
								</c:choose>
							</td>
							<td class="cellCenter">
								${coAuthor.user.username}
							</td>
							<td class="cellCenter">
								<c:choose>
									<c:when test="${journal.languageCode == 'ko' and fn:trim(coAuthor.user.contact.localInstitution) != '' }">
										${coAuthor.user.contact.localInstitution }
									</c:when>
									<c:otherwise>
										${coAuthor.user.contact.institution }
									</c:otherwise>
								</c:choose>
							</td>
							<td class="cellCenter">
								<c:if test="${coAuthor.corresponding == true}"><span class="required">*</span></c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>
</c:if>
<c:if test="${currentPageRole != 'reviewer' }">
	<!-- Cover Letter -->
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="author.newPaperSubmit.coverLetter"/><c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}"> <a id="${pageType }ChistoryViewButton" onClick="historyView(${manuscript.id}, 'C');"><i class="fa fa-angle-down "></i></a></c:if></h5>
		<div id="${pageType }ChistoryDisplay" class="historyView"></div>
		<div id="${pageType }ChistoryCurrentDisplay" class="historyCurrentView">
			<div class="form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
				<c:choose>
					<c:when test="${manuscript.coverLetter != null and manuscript.coverLetter !=  ''}">
						<p class="form-control-static sentenseJustifyAlign">
						${manuscript.coverLetter }
						</p>
					</c:when>
					<c:otherwise>
						<p class="form-control-static sentenseJustifyAlign">
							<spring:message code="system.notAvailable"/>
						</p>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
	</div>

	<!-- Reviewer Preference -->
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="manuscript.reviewerPreference"/><c:if test="${manuscript.revisionCount > 0 and manuscript.status != 'D'}"> <c:if test="${jc.changeRp == true }"><a id="${pageType }RhistoryViewButton" onClick="historyView(${manuscript.id}, 'R');"><i class="fa fa-angle-down "></i></a></c:if></c:if></h5>
		<div id="${pageType }RhistoryDisplay" class="historyView"></div>
		<div id="${pageType }RhistoryCurrentDisplay" class="historyCurrentView">
			<div class="form-group">
				<label class="control-label col-md-2"></label>
				<div class="col-md-9">
					<c:choose>
						<c:when test="${not empty manuscript.reviewPreferences}">
							<table class="table table-bordered">
								<tr>
									<th class="cellCenter">
										<spring:message code="user.degree"/>
									</th>
									<th class="cellCenter">
										<spring:message code="user.name"/>
									</th>
									<th class="cellCenter">
										<spring:message code="user.institutionSmallWidth"/>
									</th>
									<th class="cellCenter">
										<spring:message code="user.username"/>
									</th>
								</tr>
								<c:forEach var="rp" items="${manuscript.reviewPreferences}">
									<tr>
										<td class="cellCenter">
											<spring:message code="signin.degreeDesignation.${rp.degree }"/>
										</td>
										<td class="cellCenter">
											<c:choose>
												<c:when test="${journal.languageCode ==  'ko'}">
													<c:if test="${fn:trim(rp.localFullName) != '' }">${rp.localFullName }</c:if>
													 <c:if test="${fn:trim(rp.localFullName) == '' }">${rp.firstName } ${rp.lastName }</c:if>
												</c:when>
												<c:otherwise>
													${rp.firstName } ${rp.lastName }
												</c:otherwise>
											</c:choose>
										</td>
										<td class="cellCenter">
											<c:choose>
												<c:when test="${journal.languageCode == 'ko' and fn:trim(rp.localInstitution) != '' }">
													${rp.localInstitution }
												</c:when>
												<c:otherwise>
													${rp.institution }
												</c:otherwise>
											</c:choose>
										</td>
										<td class="cellCenter">
											${rp.email } 	
										</td>
									</tr>
								</c:forEach>
							</table>
						</c:when>
						<c:otherwise>
							<p class="form-control-static sentenseJustifyAlign">
								<spring:message code="system.notAvailable"/>
							</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${manuscript.status != 'B' and manuscript.status != 'I'}">
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="system.personsInCharge"/></h5>
		<c:if test="${manuscript.manuscriptTrackId == 0 }">
			<div class="form-group">
				<label class="control-label col-md-2"><spring:message code="user.role.journal_c-editor"/>:</label>
				<div class="col-md-9">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${manuscript.chiefEditor != null}">
								<c:choose>
									<c:when test="${journal.languageCode == 'ko' and fn:trim(manuscript.chiefEditor.contact.localFullName) != ''}">
										${manuscript.chiefEditor.contact.localFullName}
									</c:when>
									<c:otherwise>
										${manuscript.chiefEditor.contact.firstName} ${manuscript.chiefEditor.contact.lastName} 
									</c:otherwise>
								</c:choose>
								(<a href="mailto:${manuscript.chiefEditor.username}">${manuscript.chiefEditor.username}</a>)
							</c:when>
							<c:otherwise>
								<spring:message code="system.notAvailable"/>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-2"><spring:message code="user.role.journal_a-editor"/>:</label>
				<div class="col-md-9">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${manuscript.associateEditor != null}">
								
								<c:choose>
									<c:when test="${journal.languageCode == 'ko' and fn:trim(manuscript.chiefEditor.contact.localFullName) != ''}">
										${manuscript.associateEditor.contact.localFullName}
									</c:when>
									<c:otherwise>
										${manuscript.associateEditor.contact.firstName} ${manuscript.associateEditor.contact.lastName} 
									</c:otherwise>
								</c:choose>
								(<a href="mailto:${manuscript.associateEditor.username}">${manuscript.associateEditor.username}</a>)
							</c:when>
							<c:otherwise>
								<spring:message code="system.notAvailable"/>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
		</c:if>
		<c:if test="${manuscript.manuscriptTrackId == 1 }">
			<div class="form-group">
				<label class="control-label col-md-2"><spring:message code="user.role.journal_g-editor"/>:</label>
				<div class="col-md-9">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${manuscript.guestEditor != null}">
								<c:choose>
									<c:when test="${journal.languageCode == 'ko' and fn:trim(manuscript.guestEditor.contact.localFullName) != ''}">
										${manuscript.guestEditor.contact.localFullName}
									</c:when>
									<c:otherwise>
										${manuscript.guestEditor.contact.firstName} ${manuscript.guestEditor.contact.lastName} 
									</c:otherwise>
								</c:choose>
								(<a href="mailto:${manuscript.guestEditor.username}">${manuscript.guestEditor.username}</a>)
							</c:when>
							<c:otherwise>
								<spring:message code="system.notAvailable"/>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
		</c:if>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="user.role.journal_manager"/>:</label>
			<div class="col-md-9">
				<p class="form-control-static sentenseJustifyAlign">
					<c:choose>
						<c:when test="${manuscript.manager != null}">
								<c:choose>
									<c:when test="${journal.languageCode == 'ko' and fn:trim(manuscript.chiefEditor.contact.localFullName) != ''}">
										${manuscript.manager.contact.localFullName}
									</c:when>
									<c:otherwise>
										${manuscript.manager.contact.firstName} ${manuscript.manager.contact.lastName} 
									</c:otherwise>
								</c:choose>
								(<a href="mailto:${manuscript.manager.username}">${manuscript.manager.username}</a>)
						</c:when>
						<c:otherwise>
							<spring:message code="system.notAvailable"/>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		
	</div>
</c:if>

<c:if test="${jc.numberOfConfirms > 0 and currentPageRole != 'reviewer' and (manuscript.status != 'B' and manuscript.status != 'D')}">
	<div class="form-section_noborder">
		<h5><i class="fa fa-check-circle-o summaryItem"></i> <spring:message code="author.newPaperSubmit.confirmations"/></h5>
		<div class="form-group">
			<label class="control-label col-md-2"></label>
			<div class="col-md-9">
				<div class="radio-list">
					<c:forEach var="index" begin="1" end="${jc.numberOfConfirms }" step="1">
						<i class="fa fa-check "></i>
							${jc.getConfirm(index) }
						<br/><br/>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</c:if>