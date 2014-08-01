<%@ tag body-content="empty" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="myfn" uri="http://manuscriptlink.com/customTags"%>
<security:authentication property="authorities" var="authorities" />
<security:authentication property="name" var="username" />
<%@ attribute name="currentRevision" %>
<%@ attribute name="locale" %>

<c:forEach var="fd" items="${manuscript.decisions }">
	<c:if test="${fd.revisionCount == currentRevision }">
		<div class="form-section_noborder">
			<h4>
				<c:set var="fromRole" value="ROLE_C-EDITOR"/>
				<c:set var="fromRoleText">
					<spring:message code="user.role.journal_c-editor"/>
				</c:set>
				<c:choose>
					<c:when test="${manuscript.manuscriptTrackId == 0 }">
						<i class="fa fa-gavel summaryItem"></i> <spring:message code="user.role.journal_c-editor"/>
						<c:set var="fromRole" value="ROLE_C-EDITOR"/>
						<c:set var="fromRoleText">
							<spring:message code="user.role.journal_c-editor"/>
						</c:set>
					</c:when>
					<c:otherwise>
						<i class="fa fa-suitcase summaryItem"></i> <spring:message code="user.role.journal_g-editor"/>
						<c:set var="fromRole" value="ROLE_G-EDITOR"/>
						<c:set var="fromRoleText">
							<spring:message code="user.role.journal_G-editor"/>
						</c:set>
					</c:otherwise>
				</c:choose>
			</h4>
			<div class="form-group">
				<label class="control-label col-md-2 reviewResultItem"><spring:message code="manuscript.finalDecision"/>: </label>
				<div class="col-md-9 reviewResultItem">
					<p class="form-control-static sentenseJustifyAlign">
						<c:choose>
							<c:when test="${journal.type == 'A' or journal.type == 'C' }">
								<c:if test="${fd.decision == 5}"><b><spring:message code="reviewResult.strongAccept"/></b></c:if>
								<c:if test="${fd.decision == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
								<c:if test="${fd.decision == 3}"><b><spring:message code="reviewResult.marginal"/></b></c:if>
								<c:if test="${fd.decision == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
								<c:if test="${fd.decision == 1}"><b><spring:message code="reviewResult.strongReject"/></b></c:if>
								<c:if test="${fd.decision == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
							</c:when>
							<c:when test="${journal.type == 'B' or journal.type == 'D' }">
								<c:if test="${fd.decision == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
								<c:if test="${fd.decision == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
								<c:if test="${fd.decision == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${manuscript.getEventDateTime('E', currentRevision) != null }">
								<small id="${pageType}_${manuscript.id }_${currentRevision }decisionDate"></small>
								<script type="text/javascript">
									document.getElementById("${pageType}_${manuscript.id }_${currentRevision }decisionDate").innerHTML = "(" + convertUTCDateToLocalDate("${manuscript.getEventDateTime('E', currentRevision).date}", "${manuscript.getEventDateTime('E', currentRevision).time}", "${locale}") + ")";
								</script>
							</c:when>
							<c:otherwise>
								<small id="${pageType}_${manuscript.id }_${currentRevision }decisionDate"></small>
								<script type="text/javascript">
									document.getElementById("${pageType}_${manuscript.id }_${currentRevision }decisionDate").innerHTML = "(" + convertUTCDateToLocalDate("${manuscript.getEventDateTime('R', currentRevision).date}", "${manuscript.getEventDateTime('R', currentRevision).time}", "${locale}") + ")";
								</script>
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
		</div>
		<!-- CE or GE -> Author -->
		<c:set var="exist" value="false"/>
		<c:forEach var="comment" items="${manuscript.comments}">
			<c:if test="${comment.fromRole == fromRole and (comment.toRole == 'ROLE_MEMBER') and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
				<c:set var="exist" value="true"/>
			</c:if>
		</c:forEach>
		<c:if test="${exist == true}">
			<div class="form-section_noborder">
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem">${fromRoleText } <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_member"/>: </label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<c:forEach var="comment" items="${manuscript.comments}">
								<c:if test="${comment.fromRole == fromRole and (comment.toRole == 'ROLE_MEMBER') and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
									${comment.textHtml}
									<small id="${pageType}${comment.revisionCount }decisionCommentToAuthor"></small>
									<script type="text/javascript">
										document.getElementById("${pageType}${comment.revisionCount }decisionCommentToAuthor").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
									</script>
								</c:if>
							</c:forEach>
						</p>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${currentPageRole == 'chiefEditor' or currentPageRole == 'associateEditor' or currentPageRole == 'manager'}">
			<c:set var="exist" value="false"/>
			<c:forEach var="comment" items="${manuscript.comments}">
				<c:if test="${comment.fromRole == fromRole and (comment.toRole == 'ROLE_A-EDITOR' or comment.toRole == 'ROLE_MANAGER') and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
					<c:set var="exist" value="true"/>
				</c:if>
			</c:forEach>
			<c:if test="${exist == true}">
				<div class="form-section_noborder">
					<div class="form-group">
						<label class="control-label col-md-2 reviewResultItem">${fromRoleText } <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_editorial"/>: </label>
						<div class="col-md-9 reviewResultItem">
							<p class="form-control-static sentenseJustifyAlign">
								<c:forEach var="comment" items="${manuscript.comments}">
									<c:if test="${comment.fromRole == fromRole and (comment.toRole == 'ROLE_A-EDITOR' or comment.toRole == 'ROLE_MANAGER') and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
										${comment.textHtml}
										<small id="${pageType}${comment.revisionCount }decisionCommentToEditorial"></small>
										<script type="text/javascript">
											document.getElementById("${pageType}${comment.revisionCount }decisionCommentToEditorial").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
										</script>
									</c:if>
								</c:forEach>
							</p>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
		<c:if test="${(journal.type == 'A' or journal.type == 'B') and currentPageRole == 'chiefEditor' or currentPageRole == 'associateEditor' or currentPageRole == 'manager'}">
			<div class="form-section_noborder">
				<h4><i class="fa fa-briefcase summaryItem"></i> <spring:message code="user.role.journal_a-editor"/></h4>
				<div class="form-group">
					<label class="control-label col-md-2 reviewResultItem"><spring:message code="associateEditor.recommend"/>: </label>
					<div class="col-md-9 reviewResultItem">
						<p class="form-control-static sentenseJustifyAlign">
							<c:choose>
								<c:when test="${journal.type == 'A' or journal.type == 'C' }">
									<c:if test="${fd.editorRecommend == 5}"><b><spring:message code="reviewResult.strongAccept"/></b></c:if>
									<c:if test="${fd.editorRecommend == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
									<c:if test="${fd.editorRecommend == 3}"><b><spring:message code="reviewResult.marginal"/></b></c:if>
									<c:if test="${fd.editorRecommend == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
									<c:if test="${fd.editorRecommend == 1}"><b><spring:message code="reviewResult.strongReject"/></b></c:if>
									<c:if test="${fd.editorRecommend == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
								</c:when>
								<c:when test="${journal.type == 'B' or journal.type == 'D' }">
									<c:if test="${fd.editorRecommend == 4}"><b><spring:message code="reviewResult.accept"/></b></c:if>
									<c:if test="${fd.editorRecommend == 2}"><b><spring:message code="reviewResult.reject"/></b></c:if>
									<c:if test="${fd.editorRecommend == 0}"><b><spring:message code="system.notAvailable2"/></b></c:if>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${manuscript.getEventDateTime('R', currentRevision) != null }">
									<small id="${pageType}_${manuscript.id }_${currentRevision }editorRecommendDate"></small>
									<script type="text/javascript">
										document.getElementById("${pageType}_${manuscript.id }_${currentRevision }editorRecommendDate").innerHTML = "(" + convertUTCDateToLocalDate("${manuscript.getEventDateTime('R', currentRevision).date}", "${manuscript.getEventDateTime('R', currentRevision).time}", "${locale}") + ")";
									</script>
								</c:when>
							</c:choose>
						</p>
					</div>
				</div>
			</div>
			<c:set var="exist" value="false"/>
			<c:forEach var="comment" items="${manuscript.comments}">
				<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_MEMBER' and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
					<c:set var="exist" value="true"/>
				</c:if>
			</c:forEach>
			<c:if test="${exist == true}">
				<div class="form-section_noborder">
					<div class="form-group">
						<label class="control-label col-md-2 reviewResultItem"><spring:message code="user.role.journal_a-editor"/> <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_member"/>: </label>
						<div class="col-md-9 reviewResultItem">
							<p class="form-control-static sentenseJustifyAlign">
								<c:forEach var="comment" items="${manuscript.comments}">
									<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_MEMBER' and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
										${comment.textHtml}
										<small id="${pageType}${comment.revisionCount }aeCommentToAuthor"></small>
										<script type="text/javascript">
											document.getElementById("${pageType}${comment.revisionCount }aeCommentToAuthor").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
										</script>
									</c:if>
								</c:forEach>
							</p>
						</div>
					</div>
				</div>
			</c:if>
			<c:set var="exist" value="false"/>
			<c:forEach var="comment" items="${manuscript.comments}">
				<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_C-EDITOR' and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
					<c:set var="exist" value="true"/>
				</c:if>
			</c:forEach>
			<c:if test="${exist == true}">
				<div class="form-section_noborder">
					<div class="form-group">
						<label class="control-label col-md-2 reviewResultItem"><spring:message code="user.role.journal_a-editor"/> <i class="fa fa-arrow-right smallFontAwesome"></i> <spring:message code="user.role.journal_c-editor"/>: </label>
						<div class="col-md-9 reviewResultItem">
							<p class="form-control-static sentenseJustifyAlign">
								<c:forEach var="comment" items="${manuscript.comments}">
									<c:if test="${comment.fromRole == 'ROLE_A-EDITOR' and comment.toRole == 'ROLE_C-EDITOR' and comment.status == 'R' and comment.revisionCount == currentRevision and fn:trim(comment.text) != ''}">
										${comment.textHtml}
										<small id="${pageType}${comment.revisionCount }aeCommentToCE"></small>
										<script type="text/javascript">
											document.getElementById("${pageType}${comment.revisionCount }aeCommentToCE").innerHTML = "(" + convertUTCDateToLocalDate("${comment.date}", "${comment.time}", "${locale}") + ")";
										</script>
									</c:if>
								</c:forEach>
							</p>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
	</c:if>
</c:forEach>
