package link.thinkonweb.controller.roles;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.constants.AssociateEditorDeclineReason;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.AssociateEditorService;
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
@RequestMapping("/journals/{jnid}/associateEditor/*")
public class AssociateEditorController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AssociateEditorController.class);
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserService userService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private FileService fileService;
	@Autowired
	private AssociateEditorService aeService;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
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
	public @ResponseBody String getPapers(Model model, HttpServletRequest request, Locale locale, @PathVariable(value="pageType") String pageType) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> status = new ArrayList<String>();
		List<Manuscript> manuscripts = null;
		if(pageType.equals("assigned")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add(null);
			sortableColumnNames.add(null);
			status.add(SystemConstants.statusO);
			manuscripts = manuscriptService.getManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorA, status, 0, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("submitted")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add(null);
			sortableColumnNames.add(null);
			sortableColumnNames.add(null);
			sortableColumnNames.add(null);
			status.add(SystemConstants.statusR);
			manuscripts = manuscriptService.getManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorT, status, 0, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
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
			manuscripts = manuscriptService.getManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorT, status, Integer.MAX_VALUE, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("other")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add(null);
			sortableColumnNames.add("STATUS");
			
			status.add(SystemConstants.statusE);
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC)) {
				status.add(SystemConstants.statusD);
				status.add(SystemConstants.statusV);
			}
			status.add(SystemConstants.statusA);
			status.add(SystemConstants.statusJ);
			status.add(SystemConstants.statusX);
			status.add(SystemConstants.statusW);
			status.add(SystemConstants.statusP);
			manuscripts = manuscriptService.getManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorT, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		}

		List<Manuscript> filteredManuscripts = null;
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
			

			if(m.getLastEventDateTime(SystemConstants.statusI) != null)
				dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());
			else
				dResponse.setAaData(i, index++, null);
			
			List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleAEditor, false);
			if(comments != null && comments.size() > 0) {
				String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
				dResponse.setAaData(i, index++, commentString);
			} else
				dResponse.setAaData(i, index++, null);
			
			if(pageType.equals("other")) 
				dResponse.setAaData(i, index++, systemUtil.getStatusDatatableLabel(m.getStatus(), locale));
			
			
			if(pageType.equals("submitted") || pageType.equals("reSubmitted")) {
				StringBuffer reviewerCountStringBuffer = new StringBuffer();
				
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
				String actionString = "<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"reviewManagement\");'/>" +
										messageSource.getMessage("associateEditor.reviewManage", null, locale) + "</button>";
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionString);
				else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("assigned")) {
				String actionString = "<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"summary\");'/>" +
									  messageSource.getMessage("system.takeinDecline", null, locale) + "</button>";
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionString);
				else
					dResponse.setAaData(i, index++, null);
			}
			
			i++;
			number++;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@RequestMapping(value="/manuscripts/take", method=RequestMethod.POST)
	public @ResponseBody Boolean decision(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		aeService.take(manuscript, user, journal, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/decline", method=RequestMethod.GET)
	public ModelAndView decline(Model model, HttpServletRequest request,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleAEditor)) {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<AssociateEditorDeclineReason> aeDeclineReasons = new LinkedList<AssociateEditorDeclineReason>();
			for(int i=0; i<AssociateEditorDeclineReason.values().length; i++)
				aeDeclineReasons.add(AssociateEditorDeclineReason.getType(i));
			mav.addObject("aeDeclineReasons", aeDeclineReasons);
			EmailMessage emailMessage = emailService.getGeneralEmailMessage(13, manuscript, journal, null, request, locale);
			
			System.out.println(emailMessage);
			mav.addObject("emailMessage", emailMessage);
			mav.addObject("aeName", contactService.getFullName(user.getContact(), journal.getLanguageCode()));
			mav.addObject("aeEmail", user.getUsername());
			mav.setViewName("associateEditor.manuscripts.declineEmailForm");
			return mav;
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}

	@RequestMapping(value="/manuscripts/decline", method=RequestMethod.POST)
	public @ResponseBody ModelAndView decline(Model model, HttpServletRequest request, Locale locale,
			@ModelAttribute("emailMessage") EmailMessage emailMessage, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @RequestParam(value="comments", required=true) String comments, 
			@RequestParam(value="reason", required=true) String reason, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			aeService.decline(manuscript, emailMessage, comments, journal, request, locale);
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@RequestMapping(value="/manuscripts/confirmManuscript", method=RequestMethod.POST)
	public @ResponseBody Boolean confirmManuscript(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="recommend", required=true) int recommend,
			@RequestParam(value="scopeToManager", required=true) int scopeToManager,
			@RequestParam(value="commentToAuthor", required=false) String commentToAuthor,
			@RequestParam(value="commentToChief", required=false) String commentToChief) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		aeService.sendReviewResultToChief(manuscript, recommend, commentToChief, commentToAuthor, scopeToManager, journal, request, locale);
		return true;
	}

	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "associateEditor";
	}

}
