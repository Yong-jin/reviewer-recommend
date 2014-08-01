<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="link.thinkonweb.configuration.SystemConstants" %>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>
<link href="${baseUrl}/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="${baseUrl}/css/custom.css" rel="stylesheet" type="text/css"/>
<script src="${baseUrl}/js/moment.js"></script>
<c:choose>
	<c:when test="${type == 'M'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<div class="form-section_noborder">
				<div class="form-group">
					<label class="control-label col-md-2"><spring:message code="manuscript.title2"/>:</label>
					<div class="col-md-9">
						<p class="form-control-static sentenseJustifyAlign">
							<c:set var="titleExist" value="false"/>
							<c:forEach var="title" items="${manuscript.titles }">
								<c:if test="${title.revisionCount == revisionCount }">
									<c:set var="titleExist" value="true"/>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${titleExist }">
									<b>
									<c:if test="${manuscript.invite == true}">(Invited) </c:if>
									<c:forEach var="title" items="${manuscript.titles }">
										<c:if test="${title.revisionCount == revisionCount }">
											${title.title }
										</c:if>
									</c:forEach>
									</b>			
								</c:when>
								<c:otherwise>
									<spring:message code="system.notAvailable"/>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<c:if test="${not empty manuscript.runningHeads}">
					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="manuscript.runningHead"/>:</label>
						<div class="col-md-9">
							<p class="form-control-static sentenseJustifyAlign">
								<c:set var="runningHeadExist" value="false"/>
								<c:forEach var="runningHead" items="${manuscript.runningHeads }">
									<c:if test="${runningHead.revisionCount == revisionCount and runningHead.runningHead != null and fn:trim(runningHead.runningHead) != ''}">
										<c:set var="runningHeadExist" value="true"/>
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${runningHeadExist == true }">
										<c:forEach var="runningHead" items="${manuscript.runningHeads }">
											<c:if test="${runningHead.revisionCount == revisionCount }">
												${runningHead.runningHead }
											</c:if>
										</c:forEach>
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
					<label class="control-label col-md-2"><spring:message code="manuscript.abstract"/>:</label>
					<div class="col-md-9">
						<p class="form-control-static sentenseJustifyAlign">
							<c:set var="abstractExist" value="false"/>
							<c:forEach var="paperAbstract" items="${manuscript.abstracts }">
								<c:if test="${paperAbstract.revisionCount == revisionCount }">
									<c:set var="abstractExist" value="true"/>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${abstractExist == true }">
									<c:forEach var="paperAbstract" items="${manuscript.abstracts }">
										<c:if test="${paperAbstract.revisionCount == revisionCount }">
											${paperAbstract.paperAbstract }
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<spring:message code="system.notAvailable"/>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-2"><spring:message code="manuscript.keywords"/>:</label>
					<div class="col-md-9">
						<div class="keywordDiv">
							<p class="form-control-static sentenseJustifyAlign">
								<c:choose>
									<c:when test="${jc.changeKeyword == true }">
										<c:set var="keywordExist" value="false"/>
										<c:forEach var="keyword" items="${manuscript.keywords }">
											<c:if test="${keyword.revisionCount == revisionCount }">
												<c:set var="keywordExist" value="true"/>
											</c:if>
										</c:forEach>
										<c:choose>
											<c:when test="${keywordExist == true }">
												<c:forEach var="keyword" items="${manuscript.keywords }">
													<c:if test="${keyword.revisionCount == revisionCount }">
														<span class="tag label label-info">${keyword.keyword }</span> 
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<spring:message code="system.notAvailable"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:forEach var="keyword" items="${manuscript.keywords }">
											<c:if test="${keyword.revisionCount == manuscript.revisionCount }">
												<span class="tag label label-info">${keyword.keyword }</span> 
											</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
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
				<c:if test="${revisionCount == 0 }">
					<c:if test="${manuscript.getEventDateTime('I', revisionCount) != null}">
						<c:set var="confirmStatus" value="O"/>
						<c:if test="${journal.type == 'B' or journal.type == 'D'}">
							<c:set var="confirmStatus" value="R"/>
						</c:if>
						<c:if test="${manuscript.getEventDateTime(confirmStatus, revisionCount) != null}">
							<script type="text/javascript">
								document.getElementById("history${pageType }${revisionCount }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime(confirmStatus, revisionCount).date}", "${manuscript.getEventDateTime(confirmStatus, revisionCount).time}", "${locale}");
							</script>
						</c:if>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/> <br/><small>(<spring:message code="system.original"/>)</small>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="history${pageType }${revisionCount }submitDateSpan"></span> <c:if test="${manuscript.getEventDateTime(confirmStatus, revisionCount) != null}"><small>(<spring:message code="manuscript.confirmDate"/> <span id="history${pageType }${revisionCount }confirmDateSpan"></span>)</small></c:if>
									<script type="text/javascript">
										document.getElementById("history${pageType }${revisionCount }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('I', revisionCount).date}", "${manuscript.getEventDateTime('I', revisionCount).time}", "${locale}");
									</script>
								</p>
							</div>
						</div>
					</c:if>
				</c:if>
				<c:if test="${revisionCount > 0 }">
					<c:if test="${manuscript.getEventDateTime('V', revisionCount) != null}">
						<c:set var="confirmStatus" value="R"/>
						<c:if test="${manuscript.getEventDateTime(confirmStatus, revisionCount) != null}">
							<script type="text/javascript">
								document.getElementById("history${pageType }${revisionCount }confirmDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime(confirmStatus, revisionCount).date}", "${manuscript.getEventDateTime(confirmStatus, revisionCount).time}", "${locale}");
							</script>
						</c:if>
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.submitDate"/>  <br/><small>(<spring:message code="system.revision"/> ${revisionCount })</small>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="history${pageType }${revisionCount }submitDateSpan"></span> <c:if test="${manuscript.getEventDateTime(confirmStatus, revisionCount) != null}"><small>(<spring:message code="manuscript.confirmDate"/> <span id="history${pageType }${revisionCount }confirmDateSpan"></span>)</small></c:if>
									<script type="text/javascript">
										document.getElementById("history${pageType }${revisionCount }submitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('V', revisionCount).date}", "${manuscript.getEventDateTime('V', revisionCount).time}", "${locale}");
									</script>
								</p>
							</div>
						</div>
					</c:if>
				</c:if>
				<c:if test="${manuscript.revisionCount == revisionCount }">
					<c:if test="${manuscript.getEventDateTime('A', revisionCount) != null}">
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.acceptDate"/>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="history${pageType }acceptDateSpan"></span>
									<script type="text/javascript">
										document.getElementById("history${pageType }acceptDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('A', revisionCount).date}", "${manuscript.getEventDateTime('A', revisionCount).time}", "${locale}");
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
									<span id="history${pageType }cameraReadySubmitDateSpan"></span>
									<script type="text/javascript">
										document.getElementById("history${pageType }cameraReadySubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('M').date}", "${manuscript.getLastEventDateTime('M').time}", "${locale}");
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
									<span id="history${pageType }galleryProofSubmitDateSpan"></span>
									<script type="text/javascript">
										document.getElementById("history${pageType }galleryProofSubmitDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getLastEventDateTime('G').date}", "${manuscript.getLastEventDateTime('G').time}", "${locale}");
									</script>
								</p>
							</div>
						</div>
					</c:if>
					<c:if test="${manuscript.getEventDateTime('J', revisionCount) != null}">
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.rejectDate"/>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="history${pageType }rejectDateSpan"></span>
									<script type="text/javascript">
										document.getElementById("history${pageType }rejectDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('J', revisionCount).date}", "${manuscript.getEventDateTime('J', revisionCount).time}", "${locale}");
									</script>
								</p>
							</div>
						</div>
					</c:if>
					<c:if test="${manuscript.getEventDateTime('W', revisionCount) != null}">
						<div class="form-group">
							<label class="control-label col-md-2"><spring:message code="manuscript.withdrawalDate"/>:</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<span id="history${pageType }withdrawalDateSpan"></span>
									<script type="text/javascript">
										document.getElementById("history${pageType }withdrawalDateSpan").innerHTML = convertUTCDateToLocalDate("${manuscript.getEventDateTime('W', revisionCount).date}", "${manuscript.getEventDateTime('W', revisionCount).time}", "${locale}");
									</script>
								</p>
							</div>
						</div>
					</c:if>
				</c:if>
				<div class="form-group" style="margin-bottom: 0px !important">
					<div class="col-md-2">
					</div>
					<div class="col-md-9">
						<hr class="soften"/>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'A'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<!-- Author Information -->
			<div class="form-section_noborder">
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
								<c:if test="${coAuthor.revisionCount == revisionCount}">
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
								</c:if>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="form-group" style="margin-bottom: 0px !important">
					<div class="col-md-2">
					</div>
					<div class="col-md-9">
						<hr class="soften"/>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'C'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<!-- Cover Letter -->
			<div class="form-section_noborder">
				<div class="form-group">
					<label class="control-label col-md-2"></label>
					<div class="col-md-9">
						<c:choose>
							<c:when test="${not empty manuscript.coverLetters}">
								<c:set var="coverLetterExist" value="false"/>
								<c:forEach var="coverLetter" items="${manuscript.coverLetters}">
									<c:if test="${coverLetter.revisionCount == revisionCount}">
										<c:set var="coverLetterExist" value="true"/>
									</c:if>
								</c:forEach>
								<c:if test="${coverLetterExist == true}">
									<c:forEach var="coverLetter" items="${manuscript.coverLetters}">
										<c:if test="${coverLetter.revisionCount == revisionCount}">
											<c:choose>
												<c:when test="${coverLetter.coverLetter != null and fn:trim(coverLetter.coverLetter) !=  ''}">
													<p class="form-control-static sentenseJustifyAlign">
														${coverLetter.coverLetter }
													</p>
												</c:when>
												<c:otherwise>
													<p class="form-control-static sentenseJustifyAlign">
														<spring:message code="system.notAvailable"/>
													</p>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${coverLetterExist == false}">
									<p class="form-control-static sentenseJustifyAlign">
										<spring:message code="system.notAvailable"/>
									</p>
								</c:if>
								
							</c:when>
							<c:otherwise>
								<p class="form-control-static sentenseJustifyAlign">
									<spring:message code="system.notAvailable"/>
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="form-group" style="margin-bottom: 0px !important">
					<div class="col-md-2">
					</div>
					<div class="col-md-9">
						<hr class="soften"/>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'R'}">
		<!-- Reviewer Preference -->
		<c:if test="${currentPageRole != 'reviewer' }">
			<c:forEach var="revisionCount" items="${revisions }">
				<h6 style="margin-left: 60px !important;">
					<c:if test="${revisionCount == 0}">
						<spring:message code="system.original"/>
					</c:if>
					<c:if test="${revisionCount > 0}">
						<spring:message code="system.revision"/> #${revisionCount}
					</c:if>
				</h6>
				<div class="form-section_noborder">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-9">
							<c:choose>
								<c:when test="${not empty manuscript.reviewPreferences}">
									<c:set var="rpExist" value="false"/>
									<c:forEach var="rp" items="${manuscript.reviewPreferences}">
										<c:if test="${rp.revisionCount == revisionCount}">
											<c:set var="rpExist" value="true"/>
										</c:if>
									</c:forEach>
									<c:if test="${rpExist == true}">
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
												<c:if test="${rp.revisionCount == revisionCount}">
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
												</c:if>
											</c:forEach>
										</table>
									</c:if>
									<c:if test="${rpExist == false}">
										<p class="form-control-static sentenseJustifyAlign">
											<spring:message code="system.notAvailable"/>
										</p>
									</c:if>
								</c:when>
								<c:otherwise>
									<p class="form-control-static sentenseJustifyAlign">
										<spring:message code="system.notAvailable"/>
									</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 0px !important">
						<div class="col-md-2">
						</div>
						<div class="col-md-9">
							<hr class="soften"/>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</c:when>
	<c:when test="${type == 'MF'}">
		<!-- Submitted Manuscript Files -->
		<c:forEach var="revisionCount" items = "${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<div class="form-section_noborder">
				<div class="form-group">
					<label class="control-label col-md-2"></label>
					<div class="col-md-9">
						<c:set var="manuscriptFilesExist" value="false"/>
						<c:forEach var="uploadedFile" items="${manuscript.files}">
							<c:if test="${uploadedFile.revisionCount == revisionCount and (uploadedFile.designation == 'mainDocument' or uploadedFile.designation == 'figureImageDocument' or uploadedFile.designation == 'tableDocument' or uploadedFile.designation == 'supplementaryFile' or uploadedFile.designation == 'replayLetter')}">
								<c:set var="manuscriptFilesExist" value="true"/>
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${manuscriptFilesExist == true }">
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
										<c:if test="${uploadedFile.revisionCount == revisionCount and (uploadedFile.designation == 'mainDocument' or uploadedFile.designation == 'figureImageDocument' or uploadedFile.designation == 'tableDocument' or uploadedFile.designation == 'supplementaryFile')}">
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
												<td class="cellCenter" id="history${pageType }submittedFileDate${revisionCount}${count}">
												<script type="text/javascript">
													document.getElementById("history${pageType }submittedFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
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
				<div class="form-group" style="margin-bottom: 0px !important">
					<div class="col-md-2">
					</div>
					<div class="col-md-9">
						<hr class="soften"/>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'CF'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="cameraReady.shortTitle"/> <spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="cameraReady.shortTitle"/> <spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<c:set var="cameraReadyExist" value="false"/>
			<c:forEach var="uploadedFile" items="${manuscript.files}">
				<c:if test="${uploadedFile.cameraReadyRevision == revisionCount and (uploadedFile.designation == 'cameraReadyPaper' or uploadedFile.designation == 'copyright' or uploadedFile.designation == 'biography')}">
					<c:set var="cameraReadyExist" value="true"/>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${cameraReadyExist == true }">
					<div class="form-section_noborder">
						<div class="form-group">
							<label class="control-label col-md-2">									
		
							</label>
							<div class="col-md-9">
								<table class="table table-bordered">
									<tr>
										<td class="cellCenter">
													
										</td>
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
									<c:forEach var="uploadedFile" items="${manuscript.files}" varStatus="status">
										<c:if test="${uploadedFile.cameraReadyRevision == revisionCount and (uploadedFile.designation == 'cameraReadyPaper' or uploadedFile.designation == 'copyright' or uploadedFile.designation == 'biography')}">
											<tr>
												<td class="cellCenter">
													${count}
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
												<td class="cellCenter" id="history${pageType }cameraReadyPaperDate${revisionCount}${count}">
													<script type="text/javascript">
														document.getElementById("history${pageType }cameraReadyPaperDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
													</script>
												</td>
											</tr>
											<c:set var="count" value="${count + 1 }"/>
										</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px !important">
							<div class="col-md-2">
							</div>
							<div class="col-md-9">
								<hr class="soften"/>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-section_noborder">
						<div class="form-group">
							<label class="control-label col-md-2">
							</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<spring:message code="system.notAvailable"/>
								</p>
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px !important">
							<div class="col-md-2">
							</div>
							<div class="col-md-9">
								<hr class="soften"/>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'GF'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="galleryProof.title"/> <spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="galleryProof.title"/> <spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<c:set var="galleryProofExist" value="false"/>
			<c:forEach var="uploadedFile" items="${manuscript.files}">
				<c:if test="${uploadedFile.galleryProofRevision == revisionCount and uploadedFile.designation == 'galleryProof'}">
					<c:set var="galleryProofExist" value="true"/>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${galleryProofExist == true }">
				<div class="form-section_noborder">
					<div class="form-group">
						<label class="control-label col-md-2">
						</label>
						<div class="col-md-9">
							<table class="table table-bordered">
								<tr>
									<th class="cellCenter">
										
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
									<c:if test="${uploadedFile.galleryProofRevision == revisionCount and uploadedFile.designation == 'galleryProof'}">
										<tr>
											<td class="cellCenter">
												${count}
											</td>
											<td class="cellCenter">
												<a href="${baseUrl}/journals/${jnid}/download/${uploadedFile.id }/">${uploadedFile.originalName }</a>
											</td>
											<td class="cellCenter" id="history${pageType }galleryProofFileDate${revisionCount}${count}">
												<script type="text/javascript">
													document.getElementById("history${pageType }galleryProofFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
												</script>
											</td>
										</tr>
										<c:set var="count" value="${count + 1 }"/>
									</c:if>
								</c:forEach>
							</table>
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 0px !important">
						<div class="col-md-2">
						</div>
						<div class="col-md-9">
							<hr class="soften"/>
						</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>
					<div class="form-section_noborder">
						<div class="form-group">
							<label class="control-label col-md-2">
							</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<spring:message code="system.notAvailable"/>
								</p>
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px !important">
							<div class="col-md-2">
							</div>
							<div class="col-md-9">
								<hr class="soften"/>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
	<c:when test="${type == 'AF'}">
		<c:forEach var="revisionCount" items="${revisions }">
			<h6 style="margin-left: 60px !important;">
				<c:if test="${revisionCount == 0}">
					<spring:message code="manuscript.additionalFiles"/> <spring:message code="system.original"/>
				</c:if>
				<c:if test="${revisionCount > 0}">
					<spring:message code="manuscript.additionalFiles"/> <spring:message code="system.revision"/> #${revisionCount}
				</c:if>
			</h6>
			<c:set var="additionalFileExist" value="false"/>
			<c:forEach var="uploadedFile" items="${manuscript.files}">
				<c:if test="${uploadedFile.revisionCount == revisionCount and (uploadedFile.designation == 'frontCover' or uploadedFile.designation == 'checkList') }">
					<c:set var="additionalFileExist" value="true"/>
				</c:if>
			</c:forEach>
			
			<c:choose>
				<c:when test="${additionalFileExist == true }">
					<div class="form-section_noborder">
						<div class="form-group">
							<label class="control-label col-md-2">
							</label>
							<div class="col-md-9">
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
										<c:if test="${uploadedFile.revisionCount == revisionCount and (uploadedFile.designation == 'frontCover' or uploadedFile.designation == 'checkList') }">
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
															<spring:message code="author.newPaperSubmit.additionalFileDesignation.0"/> (<spring:message code="system.optional"/>)
														</c:when>
														<c:when test="${uploadedFile.designation == 'checkList'}">
															<spring:message code="author.newPaperSubmit.additionalFileDesignation.1"/> (<spring:message code="system.optional"/>)
														</c:when>
													</c:choose>
												</td>
												<td class="cellCenter" id="history${pageType }additionalFileDate${revisionCount}${count}">
													<script type="text/javascript">
														document.getElementById("history${pageType }additionalFileDate${revisionCount}${count}").innerHTML = convertUTCDateToLocalDate("${uploadedFile.date}", "${uploadedFile.time}", "${locale}");
													</script>
												</td>
											</tr>
											<c:set var="count" value="${count + 1 }"/>
										</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px !important">
							<div class="col-md-2">
							</div>
							<div class="col-md-9">
								<hr class="soften"/>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-section_noborder">
						<div class="form-group">
							<label class="control-label col-md-2">
							</label>
							<div class="col-md-9">
								<p class="form-control-static sentenseJustifyAlign">
									<spring:message code="system.notAvailable"/>
								</p>
							</div>
						</div>
						<div class="form-group" style="margin-bottom: 0px !important">
							<div class="col-md-2">
							</div>
							<div class="col-md-9">
								<hr class="soften"/>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
</c:choose>

