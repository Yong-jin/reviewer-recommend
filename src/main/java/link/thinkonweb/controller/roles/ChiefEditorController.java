package link.thinkonweb.controller.roles;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.AssociateEditorService;
import link.thinkonweb.service.roles.ChiefEditorService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/journals/{jnid}/chiefEditor/*")
public class ChiefEditorController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ChiefEditorController.class);
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private ChiefEditorService chiefEditorService;
	@Autowired
	private AssociateEditorService aeService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private EmailService emailService;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("manuscripts");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/getPapers/{pageType}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String getPapers(Model model, HttpServletRequest request, Locale locale, 
			@PathVariable(value="pageType") String pageType) {
		
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts");
		int[] iTotalDisplayRecords = new int[1];
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> status = new ArrayList<String>();
		List<Manuscript> manuscripts = null;
		if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB)) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//submission date
			if(pageType.equals("revisionSubmitted") || pageType.equals("underReview") || pageType.equals("finalDecisionRequired"))
				sortableColumnNames.add("REVISION_COUNT");
			
			if(!pageType.equals("submitted"))
				sortableColumnNames.add(null); //associate editor
			
			if(pageType.equals("finalDecisionRequired"))
				sortableColumnNames.add(null);	//recommendation
			
			if(!pageType.equals("aeSelection") && !pageType.equals("submitted"))
				sortableColumnNames.add(null);	//message
			if(!pageType.equals("aeSelection") && !pageType.equals("underReview") && !pageType.equals("finalDecisionRequired"))
				sortableColumnNames.add("STATUS");
			
			if(!pageType.equals("submitted") && !pageType.equals("revisionSubmitted") && !pageType.equals("other"))
				sortableColumnNames.add(null);
			
			if(pageType.equals("submitted"))
				status.add(SystemConstants.statusI);
			else if(pageType.equals("revisionSubmitted"))
				status.add(SystemConstants.statusV);
			else if(pageType.equals("aeSelection"))
				status.add(SystemConstants.statusO);
			else if(pageType.equals("underReview"))
				status.add(SystemConstants.statusR);
			else if(pageType.equals("finalDecisionRequired"))
				status.add(SystemConstants.statusE);
			else {
				if(journal.getType().equals(SystemConstants.journalTypeA))
					status.add(SystemConstants.statusD);
				
				status.add(SystemConstants.statusA);
				status.add(SystemConstants.statusM);
				status.add(SystemConstants.statusG);
				status.add(SystemConstants.statusP);
				status.add(SystemConstants.statusJ);
				status.add(SystemConstants.statusW);
			}
			if(pageType.equals("submitted")) {
				List<String> newSubmittedStatus = new ArrayList<String>();
				newSubmittedStatus.add(SystemConstants.statusI);
				manuscripts = manuscriptService.getSubmittedManuscripts(0, journal.getId(), newSubmittedStatus, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
			} else if(pageType.equals("finalDecisionRequired"))
				manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.VIEW_BUILD);
			else
				manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else {
			if(pageType.equals("submitted")) {
				sortableColumnNames.add(null);
				sortableColumnNames.add("SUBMIT_ID");
				sortableColumnNames.add("TITLE");
				sortableColumnNames.add("EVENT_DATE");
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				status.add(SystemConstants.statusR);
				manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, status, 0, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
			} else if(pageType.equals("reSubmitted")) {
				sortableColumnNames.add(null);
				sortableColumnNames.add("SUBMIT_ID");
				sortableColumnNames.add("TITLE");
				sortableColumnNames.add("EVENT_DATE");
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				sortableColumnNames.add(null);
				
				status.add(SystemConstants.statusR);
				manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, status, Integer.MAX_VALUE, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
			} else if(pageType.equals("other")) {
				sortableColumnNames.add(null);
				sortableColumnNames.add("SUBMIT_ID");
				sortableColumnNames.add("TITLE");
				sortableColumnNames.add("EVENT_DATE");
				sortableColumnNames.add(null);
				sortableColumnNames.add("STATUS");
				
				status.add(SystemConstants.statusE);
				if(journal.getType().equals(SystemConstants.journalTypeC)) {
					status.add(SystemConstants.statusD);
					status.add(SystemConstants.statusV);
				}
				status.add(SystemConstants.statusA);
				status.add(SystemConstants.statusJ);
				status.add(SystemConstants.statusX);
				status.add(SystemConstants.statusW);
				status.add(SystemConstants.statusP);
				manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
			}
		}
			
		
		List<Manuscript> filteredManuscripts = null;
		
		if(pageType.equals("revisionSubmitted")) {
			if(dRequest.getiSortCol()[0] == 3) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusV) != null && o2.getLastEventDateTime(SystemConstants.statusV) != null)
								return o1.getLastEventDateTime(SystemConstants.statusV).compareTo(o2.getLastEventDateTime(SystemConstants.statusV));
							else if(o1.getLastEventDateTime(SystemConstants.statusV) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusV) == null)
								return 1;
							else
								return 0;
	
						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusV) != null && o2.getLastEventDateTime(SystemConstants.statusV) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusV).compareTo(o2.getLastEventDateTime(SystemConstants.statusV));
							else if(o1.getLastEventDateTime(SystemConstants.statusV) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusV) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else {
			if(dRequest.getiSortCol()[0] == 3) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;
	
						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		}
		if(manuscripts.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredManuscripts = manuscripts;
		else
			filteredManuscripts = manuscripts.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > manuscripts.size() 
					? dRequest.getiDisplayStart() + (manuscripts.size() - dRequest.getiDisplayStart())
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredManuscripts.size());
		
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer actionStringBuffer = new StringBuffer();
		String dateString = null;
		
		for (Manuscript m: filteredManuscripts) {
			index = 0;
			dResponse.setAaData(i, index++, Integer.toString(number));
			
			if(m.getSubmitId() != null)
				dResponse.setAaData(i, index++, m.getSubmitId());
			else
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.beingAssigned", null , locale));
			
			if(m.getTitle() == null)
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else {
				String invitedString = "";
				if(m.isInvite())
					invitedString  = "<span class='required'>*</span>(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
				String titleUrl = "<a onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"summary\");'>" + invitedString + m.getTitle() + "</a>";

				dResponse.setAaData(i, index++, titleUrl);
			}
			
			if(pageType.equals("revisionSubmitted")) {
				if(m.getLastEventDateTime(SystemConstants.statusV) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusV).getDate().toString();
			} else {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusI).getDate().toString();
			}
			dResponse.setAaData(i, index++, dateString);
			
			if(pageType.equals("revisionSubmitted") || pageType.equals("underReview") || pageType.equals("finalDecisionRequired")) {
				int revision = m.getRevisionCount();
				String revisionString;
				if(revision == 0)
					revisionString = messageSource.getMessage("system.original", null , locale);
				else
					revisionString = messageSource.getMessage("system.revision", null , locale) + " #" + revision;
				
				dResponse.setAaData(i, index++, revisionString);
			}
			
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB)) {
				
				if(!pageType.equals("submitted") && !pageType.equals("finalDecisionRequired")) {
					if(m.getAssociateEditorUserId() != 0) {
						SystemUser aeUser = userService.getById(m.getAssociateEditorUserId());
						dResponse.setAaData(i, index++, contactService.getFullName(aeUser.getContact(), journal.getLanguageCode()));
					} else
						dResponse.setAaData(i, index++, null);
				}
				
				if(pageType.equals("finalDecisionRequired")) {
					StringBuffer reviewResultStringBuffer = new StringBuffer();
					if(m.getReviewList() != null && m.getReviewList().size() > 0) {
						for(List<Review> reviews : m.getReviewList()) {
							int count = 1;
							for(Review review: reviews) {
								if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerC)) {
									reviewResultStringBuffer.append("#" + count);
									if(review.getOverall() == 5)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.strongAccept", null , locale) + "</b>");
									else if(review.getOverall() == 4)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.accept", null , locale) + "</b>");
									else if(review.getOverall() == 3)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.marginal", null , locale) + "</b>");
									else if(review.getOverall() == 2)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.reject", null , locale) + "</b>");
									else if(review.getOverall() == 1)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.strongReject", null , locale) + "</b>");
									count++;
									reviewResultStringBuffer.append("<br/>");
								}
							}
						}
					}

					dResponse.setAaData(i, index++, reviewResultStringBuffer.toString());
					
					if(m.getAssociateEditorUserId() != 0) {
						SystemUser aeUser = userService.getById(m.getAssociateEditorUserId());
						dResponse.setAaData(i, index++, contactService.getFullName(aeUser.getContact(), journal.getLanguageCode()));
					} else
						dResponse.setAaData(i, index++, null);

					FinalDecision fd = m.getFinalDecision(m.getRevisionCount());
					if(fd != null) {
						String recommend = null;
						switch(fd.getEditorRecommend()) {
							case 1:
								recommend = messageSource.getMessage("reviewResult.strongReject", null , locale);
								break;
							case 2:
								recommend = messageSource.getMessage("reviewResult.reject", null , locale);
								break;
							case 3:
								recommend = messageSource.getMessage("reviewResult.marginal", null , locale);
								break;
							case 4:
								recommend = messageSource.getMessage("reviewResult.accept", null , locale);
								break;
							case 5:
								recommend = messageSource.getMessage("reviewResult.strongAccept", null , locale);
								break;
							default:
								recommend = messageSource.getMessage("system.notAvailable2", null , locale);
						}
						
						
						
						dResponse.setAaData(i, index++, "<b>" + recommend + "</b>");
					} else
						dResponse.setAaData(i, index++, null);
				}
				
				if(!pageType.equals("aeSelection") && !pageType.equals("submitted")) {
					List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleCEditor, false);
					if(comments != null && comments.size() > 0) {
						String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
						dResponse.setAaData(i, index++, commentString);
					} else
						dResponse.setAaData(i, index++, null);
				}
				
				if(!pageType.equals("aeSelection") && !pageType.equals("underReview") && !pageType.equals("finalDecisionRequired"))
					dResponse.setAaData(i, index++, systemUtil.getStatusDatatableLabel(m.getStatus(), locale));
				
				if(pageType.equals("aeSelection")) {
					if(m.getEditorStatus() == null) {
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100 marginBottom10' onClick='assignAE(" + m.getId() + ");'/>" +
			 					messageSource.getMessage("chiefEditor.assignAE", null , locale) + "</button>");
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='reject(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
						dResponse.setAaData(i, index++, actionStringBuffer.toString());
					} else if(m.getEditorStatus().equals(SystemConstants.editorA)) {
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135 marginBottom10' onClick='cancelAssignedAE(" + m.getId() + ");'/>" +
			 					messageSource.getMessage("chiefEditor.cancelAE", null , locale) + "</button>");
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='reject(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
						dResponse.setAaData(i, index++, actionStringBuffer.toString());
					} else if(m.getEditorStatus().equals(SystemConstants.editorD)) {
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100 marginBottom10' onClick='assignAE(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.assignAE", null , locale) + "</button>");
						actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='reject(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
						dResponse.setAaData(i, index++, actionStringBuffer.toString());
					} else if(m.getEditorStatus().equals(SystemConstants.editorT))
						dResponse.setAaData(i, index++, null);
				} else if(pageType.equals("underReview")) {
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='reject(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				} else if(pageType.equals("finalDecisionRequired")) {
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100 marginBottom10' onClick='finalDecision(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.decision", null , locale) + "</button>");
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='reject(" + m.getId() + ");'/>" +
								 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				}
			} else {
				List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleCEditor, false);
				if(comments != null && comments.size() > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
				
				if(pageType.equals("other")) 
					dResponse.setAaData(i, index++, systemUtil.getStatusDatatableLabel(m.getStatus(), locale));
				
				
				if(pageType.equals("submitted") || pageType.equals("reSubmitted")) {
					StringBuffer reviewerCountStringBuffer = new StringBuffer();
					actionStringBuffer = new StringBuffer();
					int assignCount = 0;
					int inviteCount = 0;
					int completeCount = 0;
					if(m.getReviewList() != null && m.getReviewList().size() > 0) {

						for(List<Review> reviews : m.getReviewList()) {
							for(Review review: reviews) {
								if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerA))
									assignCount++;
								if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerI))
									inviteCount++;
								if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerC))
									completeCount++;
							}
						}
					}
					reviewerCountStringBuffer.append(messageSource.getMessage("reviewResult.invited", null , locale) + ": ");
					reviewerCountStringBuffer.append(inviteCount);
					reviewerCountStringBuffer.append("<br/>");
					reviewerCountStringBuffer.append(messageSource.getMessage("reviewResult.assigned", null , locale) + ": ");
					reviewerCountStringBuffer.append(assignCount);
					reviewerCountStringBuffer.append("<br/>");
					reviewerCountStringBuffer.append(messageSource.getMessage("reviewResult.completed", null , locale) + ": ");
					reviewerCountStringBuffer.append(completeCount);
					dResponse.setAaData(i, index++, reviewerCountStringBuffer.toString());
					
					StringBuffer reviewResultStringBuffer = new StringBuffer();
					
					if(m.getReviewList() != null && m.getReviewList().size() > 0) {
						for(List<Review> reviews : m.getReviewList()) {
							int count = 1;
							for(Review review: reviews) {
								if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerC)) {
									reviewResultStringBuffer.append("#" + count);
									if(review.getOverall() == 5)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.strongAccept", null , locale) + "</b>");
									else if(review.getOverall() == 4)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.accept", null , locale) + "</b>");
									else if(review.getOverall() == 3)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.marginal", null , locale) + "</b>");
									else if(review.getOverall() == 2)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.reject", null , locale) + "</b>");
									else if(review.getOverall() == 1)
										reviewResultStringBuffer.append(" <b>" + messageSource.getMessage("reviewResult.strongReject", null , locale) + "</b>");
									count++;
									reviewResultStringBuffer.append("<br/>");
								}
							}
						}
					}

					dResponse.setAaData(i, index++, reviewResultStringBuffer.toString());
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100 marginBottom10' onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"reviewManagement\");'/>" +
											messageSource.getMessage("guestEditor.reviewManage", null, locale) + "</button>");
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100 marginBottom10' onClick='finalDecision(" + m.getId() + ");'/>" +
		 					messageSource.getMessage("chiefEditor.decision", null , locale) + "</button>");
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='reject(" + m.getId() + ");'/>" +
		 					messageSource.getMessage("chiefEditor.forceToReject", null , locale) + "</button>");
					if(journal.isPaid())
						dResponse.setAaData(i, index++, actionStringBuffer.toString());
					else
						dResponse.setAaData(i, index++, null);
				}
			}
			
			actionStringBuffer.delete(0, actionStringBuffer.length());
			i++;
			number++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/getAssociateEditorInfo", method=RequestMethod.GET)
	public @ResponseBody String assignAssociateEditor(HttpServletRequest request, Model model, Locale locale,
			@RequestParam(value="userId", required=true) int userId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		model.addAttribute("jc", jc);
		AssociateEditor ae = aeService.getAssociateEditor(userId, journal.getId());
		StringBuffer aeStringBuffer = new StringBuffer();
		aeStringBuffer.append(ae.getUser().getUsername());
		aeStringBuffer.append(",");
		Contact aeContact = ae.getUser().getContact();
		if(journal.getLanguageCode().equals("ko") && aeContact.getLocalFirstName() != null && !aeContact.getLocalFirstName().equals(""))
			aeStringBuffer.append(aeContact.getLocalFullName());
		else {
			aeStringBuffer.append(messageSource.getMessage("signin.salutationDesignation." + aeContact.getSalutation(), null, locale));
			aeStringBuffer.append(" ");
			aeStringBuffer.append(aeContact.getFirstName());
			aeStringBuffer.append(" ");
			aeStringBuffer.append(aeContact.getLastName());
		}

		return aeStringBuffer.toString().trim();
	}
	
	@RequestMapping(value = "/manuscripts/cancelAssignedEditor", method=RequestMethod.POST)
	public @ResponseBody Boolean cancelAssignedAE(HttpServletRequest request, Model model, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		chiefEditorService.cancelAssignedEditor(manuscript, journal, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/assignAssociateEditor", method=RequestMethod.GET)
	public String emailNotificationWithComments(HttpServletRequest request, Model model, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		model.addAttribute("jc", jc);
		List<AssociateEditor> aeAll = aeService.getAssociateEditorsByJournalId(journal.getId());
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(10, m, journal, null, request, locale);
		model.addAttribute("emailMessage", emailMessage);
		model.addAttribute("manuscript", m);
		model.addAttribute("aeAll", aeAll);
		model.addAttribute("journal", journal);
		model.addAttribute("chief", user);
		return "chiefEditor.manuscripts.assignEditorEmailForm";
	}


	@RequestMapping(value="/manuscripts/assignAssociateEditor", method=RequestMethod.POST)
	public ModelAndView emailNotificationWithComments(HttpServletRequest request, Locale locale,
			@ModelAttribute EmailMessage emailMessage,
			@RequestParam(value="editorUserId", required=true) int userId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="scopeToManager", required=true) int scopeToManager,
			@RequestParam(value="comments", required=true) String comments,
			BindingResult result) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			if(authorityService.hasRole(SystemConstants.roleCEditor)) {
				Journal journal = (Journal)request.getSession().getAttribute("journal");
				String username = authorityService.getUserDetails().getUsername();
				SystemUser chief = userService.getByUsername(username);
				AssociateEditor ae = aeService.getAssociateEditor(userId, journal.getId());
				Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
				chiefEditorService.assignAssociateEditor(emailMessage, ae, m, chief, comments, scopeToManager, journal, request, locale);

				RedirectView rv = new RedirectView("../manuscripts?pageType=aeSelection");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			}
		}
		System.out.println("not authorized");
		mav.setViewName("journal.home.chiefEditor");
		return mav;
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "chiefEditor";
	}
}
