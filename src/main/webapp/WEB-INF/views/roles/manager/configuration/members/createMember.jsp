<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/headerForAjax.jsp" %>

<div class="form form-wizard">
	<div class="form-body">
		<h4 class="block">
			<c:if test="${roleString == 'chiefEditor'}">
				<spring:message code="manager.config.selectedChiefEditor"/>
			</c:if>
			<c:if test="${roleString == 'manager'}">
				<spring:message code="manager.config.selectedManager"/>
			</c:if>
			<c:if test="${roleString == 'associateEditor'}">
				<spring:message code="manager.config.selectedAssociateEditor"/>
			</c:if>
			<c:if test="${roleString == 'guestEditor'}">
				<spring:message code="manager.config.selectedGuestEditor"/>
			</c:if>
			<c:if test="${roleString == 'boardMember'}">
				<spring:message code="manager.config.selectedBoardMember"/>
			</c:if>
		</h4>
		<div class="row form-section_noborder">
			<label class="control-label col-md-2">
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					<div id="${roleString}Display"><div class="loadingCenter"><img src="images/loading.gif"/></div></div>
				</fieldset>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 cellCenter">
			</div>
			<div class="col-md-9 paddingLeft30">
				<hr class="soften"/>
			</div>
		</div>
		<div class="row form-section_noborder">
			<label class="control-label col-md-2">1) 
				<c:if test="${roleString == 'chiefEditor'}">
					<spring:message code="manager.config.selectChiefEditorFromMembers"/>
				</c:if>
				<c:if test="${roleString == 'manager'}">
					<spring:message code="manager.config.selectManagerFromMembers"/>
				</c:if>
				<c:if test="${roleString == 'associateEditor'}">
					<spring:message code="manager.config.selectAssociateEditorFromMembers"/>
				</c:if>
				<c:if test="${roleString == 'guestEditor'}">
					<spring:message code="manager.config.selectGuestEditorFromMembers"/>
				</c:if>
				<c:if test="${roleString == 'boardMember'}">
					<spring:message code="manager.config.selectBoardMemberFromMembers"/>
				</c:if>
			</label>
			<div class="col-md-10">
				<fieldset class="col-md-11">
					
					<div class="table-container">					
						<table class="table table-bordered fixedWidthSize" id="${roleString}Table">
						<thead>
						<tr>
							<th> </th>			
							<th><spring:message code='signin.username'/> (<spring:message code='user.username'/>)</th>
							<th><spring:message code="user.name"/></th>
							<th><spring:message code="user.institution"/></th>
							<th><spring:message code="user.country"/></th>
							<th><spring:message code="user.journalMember"/></th>
							<th><spring:message code="system.action"/></th>
						</tr>
						<tr class="filter">
							<td></td>
							<td>
								<input type="text" class="form-control form-filter${roleString}">
							</td>
							<td>
								<input type="text" class="form-control form-filter${roleString}">
							</td>
							<td>
								<input type="text" class="form-control form-filter${roleString}">
							</td>
							<td>
								<div>
									<select class="select2 countryFilter${roleString} form-control form-filter${roleString}">
										<option value=""></option>
										<%@ include file="/WEB-INF/views/includes/country.jsp" %>
										</select>
								</div>
							</td>
							<td>
								<select class="select2 memberFilter${roleString} form-control form-filter${roleString}">
									<option value="true"><spring:message code="system.member"/></option>
									<option value="false"><spring:message code="system.nonMember"/></option>
								</select>
							</td>
							<td>
							</td>
						</tr>
						</thead>
						<tbody>
						</tbody>
						</table>
					</div>
				</fieldset>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-2 cellCenter">
			<br/><spring:message code="system.or"/>
			</div>
			<div class="col-md-9 paddingLeft30">
				<hr class="soften"/>
			</div>
		</div>
		<div class="row form-section_noborder">
			<label class="control-label col-md-2">2) 
				<c:if test="${roleString == 'chiefEditor'}">
					<spring:message code="manager.config.selectNewChiefEditorAfterCreation"/>
				</c:if>
				<c:if test="${roleString == 'manager'}">
					<spring:message code="manager.config.selectNewManagerAfterCreation"/>
				</c:if>
				<c:if test="${roleString == 'associateEditor'}">
					<spring:message code="manager.config.selectNewAssociateEditorAfterCreation"/>
				</c:if>
				<c:if test="${roleString == 'guestEditor'}">
					<spring:message code="manager.config.selectNewGuestEditorAfterCreation"/>
				</c:if>
				<c:if test="${roleString == 'boardMember'}">
					<spring:message code="manager.config.selectNewBoardMemberAfterCreation"/>
				</c:if>
			</label>
			<form:form method="post" modelAttribute="${roleString}" id="${roleString}RegisterForm">
			<div class="col-md-10">
				<fieldset class="col-md-5">
					<div class="row">
						<div class="form-group col-md-12">
							<label class="control-label"><spring:message code="signup.email"/></label>
							<div>
								<input type="hidden" name="jid" value="${journal.id}"/>
								<form:input path="user.username" type="text" class="form-control" id="${roleString}Email" maxlength="100"/>
								<span class="help-block">
								</span>
							</div>
						</div>
					</div>
					
					<div class="row">
						<c:choose>
							<c:when test="${journal.languageCode == 'ko'}" >
								<div class="form-group col-md-6">
									<label class="control-label"><spring:message code="user.institutionSmallWidth"/></label>
									<div>
										<form:input path="user.contact.localInstitution" type="text" class="form-control" maxlength="70"/>
										<span class="help-block2"><spring:message code="system.korean"/> (<spring:message code="user.institutionSample-korean"/>)
										<br/><br/>
										</span>
									</div>
									<label class="control-label"><spring:message code="user.department"/></label>
									<div>
										<form:input path="user.contact.localDepartment" type="text" class="form-control" maxlength="70"/>
										<span class="help-block2"><spring:message code="system.korean"/> (<spring:message code="user.departmentSample-korean"/>)
										</span>
									</div>
								</div>
								
								<div class="form-group col-md-6">
									<label class="control-label">&nbsp;</label>
									<div>
										<form:input path="user.contact.institution" type="text" class="form-control" maxlength="70"/>
										<span class="help-block2"><spring:message code="system.english"/> (<spring:message code="user.institutionSample-english"/>)
										</span>
									</div>
									<label class="control-label">&nbsp;</label>
									<div>
										<form:input path="user.contact.department" type="text" class="form-control" maxlength="70"/>
										<span class="help-block2"><spring:message code="system.english"/> (<spring:message code="user.departmentSample-english"/>)
										</span>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="form-group col-md-6">
									<label class="control-label"><spring:message code="user.institutionSmallWidth"/></label>
									<div>
										<form:input path="user.contact.institution" type="text" class="form-control" maxlength="70"/>
										<span class="help-block">
										</span>
									</div>
								</div>
								
								<div class="form-group col-md-6">
									<label class="control-label"><spring:message code="user.department"/></label>
									<div>
										<form:input path="user.contact.department" type="text" class="form-control" maxlength="30"/>
										<span class="help-block">
										</span>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					
					<div class="row">
						<div class="form-group country-group col-md-12">
							<label class="control-label"><spring:message code="user.country"/></label>
							<div>
								<form:select path="user.contact.country" id="${roleString}Country" class="select2 select2_country2 form-control">
									<%@ include file="/WEB-INF/views/includes/country.jsp" %>
								</form:select>
								<span class="help-block">
									<spring:message code="signup.countryHelp"/>
								</span>
							</div>
						</div>			
					</div>
				</fieldset>
					
				<fieldset class="col-md-push-1 col-md-5">
					<c:choose>
						<c:when test="${journal.languageCode == 'ko'}" >
							<div class="row">
								<div class="form-group col-md-12">
									<label class="control-label"><spring:message code="user.name"/></label>
									<div>
										<form:input path="user.contact.localFullName" type="text" class="form-control" maxlength="50"/>
										<span class="help-block2"><spring:message code="user.koreanFullName"/> (<spring:message code="user.koreanFullnameSample"/>)
										</span>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-md-6">
									<div>
										<form:input path="user.contact.firstName" type="text" class="form-control" maxlength="40"/>
										<span class="help-block2"><spring:message code="user.firstname2"/> (<spring:message code="user.firstnameSample"/>)
										</span>
									</div>
								</div>	
								<div class="form-group col-md-push-1 col-md-5">
									<div>
										<form:input path="user.contact.lastName" type="text" class="form-control" maxlength="30"/>
										<span class="help-block2"><spring:message code="user.lastname2"/> (<spring:message code="user.lastnameSample"/>)
										</span>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="row">
								<div class="form-group col-md-6">
									<label class="control-label"><spring:message code="user.firstname"/></label>
									<div>
										<form:input path="user.contact.firstName" type="text" class="form-control" maxlength="40"/>
										<span class="help-block">
										</span>
									</div>
								</div>	
								<div class="form-group col-md-push-1 col-md-5">
									<label class="control-label"><spring:message code="user.lastname"/></label>
									<div>
										<form:input path="user.contact.lastName" type="text" class="form-control" maxlength="30"/>
										<span class="help-block">
										</span>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
					
					<div class="form-group chiefDegreeDiv">
						<label class="control-label"><spring:message code="user.degree"/></label>
						<div class="radio-list degreeSmallWidth">
							<c:forEach var="degreeDesignation" items="${degreeDesignations}">
								<label class="radio-inline">
								<form:radiobutton class="chiefDegreeRadio" path="user.contact.degree" value="${degreeDesignation.id}"/> <spring:message code="signin.degreeDesignation.${degreeDesignation.id}"/> </label>
							</c:forEach>				
						</div>
					</div>
					
					<div class="form-group chiefSalutationDiv">
						<label class="control-label"><spring:message code="user.salutation"/></label>
						<div class="radio-list salutation">
							<c:forEach var="salutationDesignation" items="${salutationDesignations}">
								<label class="radio-inline">
								<form:radiobutton class="chiefSalutationRadio" path="user.contact.salutation" value="${salutationDesignation.id}"/> <spring:message code="signin.salutationDesignation.${salutationDesignation.id}"/> </label>
							</c:forEach>
						</div>
					</div>
					
					<c:choose>
						<c:when test="${journal.languageCode == 'ko'|| locale == 'ko_KR'}" >
							<div class="form-group jobTitle-group">
								<label class="control-label"><spring:message code="user.jobTitle"/></label>
								<div>
									<form:select path="user.contact.localJobTitle" id="${roleString }jobTitle" class="select2 form-control">
										<c:forEach var="localJobTitleDesignation" items="${localJobTitleDesignations}">
											<option value="${localJobTitleDesignation.id}" <c:if test="${localJobTitleDesignation.id == contact.localJobTitle}">selected</c:if>><spring:message code="signin.localJobTitleDesignation.${localJobTitleDesignation.id}"/></option>
										</c:forEach>
									</form:select>
									<span class="help-block">
									</span>
								</div>
							</div>
						</c:when>
						</c:choose>
					<div>    
						<button type="submit" id="register-submit-btn${roleString}" class="btn green pull-right">
							<spring:message code="system.createAndSelect"/> <i class="m-icon-swapright m-icon-white"></i>
						</button>
					</div>
				</fieldset>
			</div>
			</form:form>
		</div>
	</div>
</div>
