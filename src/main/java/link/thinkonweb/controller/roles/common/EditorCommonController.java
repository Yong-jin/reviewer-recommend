package link.thinkonweb.controller.roles.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.ReviewerSuggestDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.ReviewerDeclineReason;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewPreference;
import link.thinkonweb.domain.manuscript.ReviewRequest;
import link.thinkonweb.domain.manuscript.ReviewerSuggest;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.BoardMember;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.BoardMemberService;
import link.thinkonweb.service.roles.ChiefEditorService;
import link.thinkonweb.service.roles.GuestEditorService;
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
@RequestMapping("/journals/{jnid}*")
public class EditorCommonController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(EditorCommonController.class);
	@Autowired
	private JournalService journalService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserService userService;
	@Autowired
    private ServletContext servletContext;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ReviewRequestDao reviewRequestDao;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private ChiefEditorService chiefEditorService;
	@Autowired
	private GuestEditorService guestEditorService;
	@Autowired
	private BoardMemberService boardMemberService;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private FileService fileService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private GuestEditorService geService;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private ReviewerSuggestDao reviewerSuggestDao;
	@Autowired
	private CountryCodeDao countryCodeDao;
	
	/*	AssociateEditor, Guest Editor Common */
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/reviewers/{pageType}/manageReviewers", method=RequestMethod.GET)
	public ModelAndView manageReviewers(Model model, HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role,
			@PathVariable(value="pageType") String pageType, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		mav.addObject("manuscript", m);
		mav.addObject("pageType", pageType);
		Reviewer reviewer = new Reviewer();
		SystemUser user = new SystemUser();
		Contact contact = new Contact();
		user.setContact(contact);
		reviewer.setUser(user);
		mav.addObject("reviewer", reviewer);
		
		List<Division> divisions = journalService.getDivisionsById(journal.getId());
		mav.addObject("divisions", divisions);
		
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i = 0; i < DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		mav.addObject("degreeDesignations", degreeDesignations);		
		mav.addObject("degreeDesignations", degreeDesignations);		

		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i = 0; i < SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		mav.addObject("salutationDesignations", salutationDesignations);
		mav.addObject("currentPageRole", role);
		mav.setViewName("common.reviewers.manageReviewers");
		return mav;
	}
	
	@RequestMapping(value="/{role}/reviewers/reviewerHistory", method=RequestMethod.GET)
	@Transactional(readOnly = true)
	public ModelAndView reviewerHistory(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable(value="role") String role,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		//Reviewer reviewer = reviewerService.getReviewer(reviewerUserId, journal.getId());
		SystemUser reviewerUser = userService.getById(reviewerUserId);
		mav.addObject("reviewerUser", reviewerUser);
		int assignedUpToNowInJournal = 0;
		int invitedUpToNowInJournal = 0;
		int completedUpToNowInJournal = 0;
		List<String> assignStatus = new ArrayList<String>();
		assignStatus.add(SystemConstants.reviewerA);
		List<String> inviteStatus = new ArrayList<String>();
		inviteStatus.add(SystemConstants.reviewerI);
		List<String> completeStatus = new ArrayList<String>();
		completeStatus.add(SystemConstants.reviewerC);
		if(reviewerUser != null) {
			assignedUpToNowInJournal = reviewerService.numReviewFromReviewerHistory(reviewerUserId, journal.getId(), SystemConstants.reviewerA);
			invitedUpToNowInJournal = reviewerService.numReviewFromReviewerHistory(reviewerUserId, journal.getId(), SystemConstants.reviewerI);
			completedUpToNowInJournal = reviewerService.numReviewFromReviewerHistory(reviewerUserId, journal.getId(), SystemConstants.reviewerC);
		}

		int invitedAtThisTime = reviewerService.numReviewManuscripts(reviewerUserId, 0, 0, -1, inviteStatus);
		int invitedAtThisTimeInJournal = reviewerService.numReviewManuscripts(reviewerUserId, 0, journal.getId(), -1, inviteStatus);
		int assignedAtThisTime = reviewerService.numReviewManuscripts(reviewerUserId, 0, 0, -1, assignStatus);
		int assignedAtThisTimeInJournal = reviewerService.numReviewManuscripts(reviewerUserId, 0, journal.getId(), -1, assignStatus);
		int invitedUpToNow = reviewerService.numReviewFromReviewerHistory(reviewerUserId, 0, SystemConstants.reviewerI);
		int assignedUpToNow = reviewerService.numReviewFromReviewerHistory(reviewerUserId, 0, SystemConstants.reviewerA);
		int completedUpToNow = reviewerService.numReviewFromReviewerHistory(reviewerUserId, 0, SystemConstants.reviewerC);
		
		mav.addObject("invitedAtThisTime", invitedAtThisTime);
		mav.addObject("invitedAtThisTimeInJournal", invitedAtThisTimeInJournal);
		mav.addObject("assignedAtThisTime", assignedAtThisTime);
		mav.addObject("assignedAtThisTimeInJournal", assignedAtThisTimeInJournal);
		mav.addObject("invitedUpToNow", invitedUpToNow);
		mav.addObject("assignedUpToNow", assignedUpToNow);
		mav.addObject("completedUpToNow", completedUpToNow);
		
		mav.addObject("assignedUpToNowInJournal", assignedUpToNowInJournal);
		mav.addObject("invitedUpToNowInJournal", invitedUpToNowInJournal);
		mav.addObject("completedUpToNowInJournal", completedUpToNowInJournal);
		mav.addObject("reviewerUserId", reviewerUserId);
		mav.addObject("currentPageRole", role);
		mav.setViewName("common.reviewers.reviewerHistory");
		return mav;
	}
	
	@RequestMapping(value="/{role}/reviewers/{pageType}/declineReason", method=RequestMethod.GET)
	@Transactional(readOnly = true)
	public ModelAndView declineReason(Model model, HttpServletRequest request, HttpServletResponse response, 
			@PathVariable(value="role") String role,
			@PathVariable(value="pageType") String pageType,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="reviewId", required=true) int reviewId) {
		ModelAndView mav = new ModelAndView();
		Review review = reviewerService.getReviewById(reviewId);
		mav.addObject("review", review);
		ReviewerSuggest rs = reviewerSuggestDao.findReviewerSuggest(reviewerUserId, manuscriptId, reviewId);
		mav.addObject("rs", rs);
		if(rs.getCountryCode() != null) {
			CountryCode countryCode = countryCodeDao.findByAlpha2(rs.getCountryCode());
			if(countryCode != null)
				mav.addObject("country", countryCode.getName());
		}
		mav.setViewName("common.reviewers.declineReason");
		return mav;
	}
	
	@RequestMapping(value="/{role}/reviewers/reviewerHistoryTable", method=RequestMethod.GET)
	@Transactional(readOnly = true)
	public ModelAndView reviewerHistoryTable(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId, @PathVariable(value="role") String role,
			@RequestParam(value="status", required=true) String status,
			@RequestParam(value="j", required=true) String j,
			@RequestParam(value="t", required=true) String t) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("reviewerUserId", reviewerUserId);
		mav.addObject("status", status);
		mav.addObject("j", j);
		mav.addObject("t", t);
		mav.addObject("currentPageRole", role);
		mav.setViewName("common.reviewers.reviewerHistoryManuscriptTable");
		return mav;
	}
	
	@RequestMapping(value="/{role}/reviewers/getReviewerHistoryPapers",  method = {RequestMethod.GET, RequestMethod.POST})
	@Transactional(readOnly = true)
	public @ResponseBody String getReviewerHistoryPapers(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId, @PathVariable(value="role") String role,
			@RequestParam(value="status", required=true) String status,
			@RequestParam(value="j", required=true) String j,
			@RequestParam(value="t", required=true) String t) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int journalId = 0;
		boolean inThisTime = false;
		if(j.equals("true")) journalId = journal.getId();
		if(t.equals("true")) inThisTime = true;

		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts_review");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<Review> reviews = null;
		sortableColumnNames.add(null);
		sortableColumnNames.add("M.SUBMIT_ID");
		sortableColumnNames.add("MR.REVISION_COUNT");
		sortableColumnNames.add("M.TITLE");
		sortableColumnNames.add("MR.EVENT_DATE");
		sortableColumnNames.add("MR.EVENT_DATE");
		
		if(inThisTime)
			reviews = reviewerService.getReviews(reviewerUserId, journalId, status, dRequest, iTotalDisplayRecords, sortableColumnNames);
		else
			reviews = reviewerService.getReviewsFromReviewerHistory(reviewerUserId, journalId, status, dRequest, iTotalDisplayRecords, sortableColumnNames);
			
		List<Review> filteredReviews = null;
		if(dRequest.getiSortCol()[0] == 4) {
			Collections.sort(reviews, new Comparator<Review>() {
				@Override
				public int compare(Review o1, Review o2) {
					if (dRequest.getsSortDir()[0].equals("asc")) {
						if(o1.getManuscript().getLastEventDateTime(SystemConstants.statusI) != null && o2.getManuscript().getLastEventDateTime(SystemConstants.statusI) != null)
							return o1.getManuscript().getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getManuscript().getLastEventDateTime(SystemConstants.statusI));
						else if(o1.getManuscript().getLastEventDateTime(SystemConstants.statusI) == null)
							return -1;
						else if(o2.getManuscript().getLastEventDateTime(SystemConstants.statusI) == null)
							return 1;
						else
							return 0;

					} else {
						if(o1.getManuscript().getLastEventDateTime(SystemConstants.statusI) != null && o2.getManuscript().getLastEventDateTime(SystemConstants.statusI) != null)
							return -1 * o1.getManuscript().getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getManuscript().getLastEventDateTime(SystemConstants.statusI));
						else if(o1.getManuscript().getLastEventDateTime(SystemConstants.statusI) == null)
							return 1;
						else if(o2.getManuscript().getLastEventDateTime(SystemConstants.statusI) == null)
							return -1;
						else
							return 0;
					}
				}
			});
		}
		
		if(status.equals(SystemConstants.reviewerI)) {
			if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerI) != null && o2.getReviewEventDateTime(SystemConstants.reviewerI) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerI).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerI));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerI) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerI) == null)
								return 1;
							else
								return 0;
	
						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerI) != null && o2.getReviewEventDateTime(SystemConstants.reviewerI) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerI).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerI));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerI) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else if(status.equals(SystemConstants.reviewerA)) {
			if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerA) != null && o2.getReviewEventDateTime(SystemConstants.reviewerA) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerA).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerA));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return 1;
							else
								return 0;
	
						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerA) != null && o2.getReviewEventDateTime(SystemConstants.reviewerA) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerA).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerA));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else if(status.equals(SystemConstants.reviewerC)) {
			if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else
								return 0;
	
						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		}
		
		if(reviews.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredReviews = reviews;
		else
			filteredReviews = reviews.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > reviews.size() 
					? dRequest.getiDisplayStart() + (reviews.size() - dRequest.getiDisplayStart())
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredReviews.size());
		
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		for (Review r: filteredReviews) {
			index = 0;
			
			String dateString = null;
			String submitDateString = null;
			dResponse.setAaData(i, index++, Integer.toString(number));
			if(r.getManuscript().getSubmitId() != null)
				dResponse.setAaData(i, index++, r.getManuscript().getSubmitId());
			
			int revision = r.getRevisionCount();
			String revisionString;
			if(revision == 0)
				revisionString = messageSource.getMessage("system.original", null , locale);
			else
				revisionString = messageSource.getMessage("system.revision", null , locale) + " #" + revision;
			
			dResponse.setAaData(i, index++, revisionString);
			
			String titleUrl = "<a onClick='viewManuscript(" + r.getManuscriptId() + ");'>" + r.getManuscript().getTitle() + "</a>";
			dResponse.setAaData(i, index++, titleUrl);
			
			if(r.getManuscript().getLastEventDateTime(SystemConstants.statusI) != null)
				submitDateString = r.getManuscript().getLastEventDateTime(SystemConstants.statusI).getDate().toString();
			dResponse.setAaData(i, index++, submitDateString);
			
			if(status.equals(SystemConstants.reviewerI)) {
				if(r.getReviewEventDateTime(SystemConstants.reviewerI) != null)
					dateString = r.getReviewEventDateTime(SystemConstants.reviewerI).getDate().toString();
			} else if(status.equals(SystemConstants.reviewerA)) { 
				if(r.getReviewEventDateTime(SystemConstants.reviewerA) != null)
					dateString = r.getReviewEventDateTime(SystemConstants.reviewerA).getDate().toString();
			} else if(status.equals(SystemConstants.reviewerC)) {
				if(r.getReviewEventDateTime(SystemConstants.reviewerC) != null)
					dateString = r.getReviewEventDateTime(SystemConstants.reviewerC).getDate().toString();
			}
			dResponse.setAaData(i, index++, dateString);

			i++;
			number++;
			index = 0;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@RequestMapping(value = "/{role}/reviewers/signupReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean reviewerSubmitUserForm(@ModelAttribute("reviewer") Reviewer reviewer, 
							 	BindingResult result, 
							 	HttpServletRequest request,
							 	Model model, @PathVariable(value="role") String role,
							 	@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser reviewerUser = reviewer.getUser();
			
			if (userService.isUniqueUsername(reviewerUser.getUsername())) {
				reviewerUser.setEnabled(false);
				String password = userService.generatePassword(8);
				reviewerUser.setPassword(password);
				reviewer.setUser(reviewerUser);
				reviewer.setJournalId(journal.getId());
				reviewerService.createReviewer(reviewer);
				reviewerService.selectReviewer(reviewerUser.getId(), manuscriptId, true, password);
			} else {
				SystemUser storedUser = userService.getByUsername(reviewerUser.getUsername());
				reviewerService.selectReviewer(storedUser.getId(), manuscriptId, false, null);
			}
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/{role}/reviewers/{pageType}/reviewerTable", method=RequestMethod.GET)
	public ModelAndView reviewerTable(HttpServletRequest request, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType, @PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<Review> reviews = reviewerService.getReviews(0, manuscriptId, m.getJournalId(), m.getRevisionCount(), null);
		if(reviews != null)
			Collections.sort(reviews);
		
		mav.addObject("reviews", reviews);
		mav.addObject("manuscript", m);
		mav.addObject("pageType", pageType);
		mav.addObject("currentPageRole", role);
		mav.setViewName("common.reviewers.reviewerTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/reviewers/{pageType}/inviteReviewer", method=RequestMethod.GET)
	public ModelAndView inviteReviewer(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType, @PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor) || authorityService.hasRole(SystemConstants.roleAEditor)) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			SystemUser reviewerUser = userService.getById(reviewerUserId);
			String randomQuery = reviewerService.generateRandomQuery();
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			EmailMessage emailMessage = emailService.getGeneralEmailMessage(16, manuscript, journal, reviewerUser.getUsername(), request, locale);
			mav.addObject("emailMessage", emailMessage);
			mav.addObject("manuscript", manuscript);
			mav.addObject("randomQuery", randomQuery);
			mav.addObject("reviewer", reviewerUser);
			mav.addObject("journal", journal);
			mav.addObject("pageType", pageType);
			mav.addObject("durationReviewByWeeks", jc.getReviewDueDuration());
			mav.addObject("emailType", "inviteReviewer");
			mav.addObject("homeUrl", SystemConstants.baseUrl);
			mav.addObject("currentPageRole", role);
			mav.setViewName("common.reviewers.reviewerEmailForm");
			return mav;
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}
	
	@RequestMapping(value = "/{role}/reviewers/{pageType}/inviteReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean inviteReviewer(@ModelAttribute("emailForm") EmailMessage emailMessage, 
							 	BindingResult result, HttpServletRequest request, Model model, Locale locale,
							 	@RequestParam(value="manuscriptId", required=true) int manuscriptId,
							 	@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
							 	@RequestParam(value="randomQuery", required=true) String randomQuery,
							 	@PathVariable(value="pageType") String pageType,
							 	@PathVariable(value="role") String role) {
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			reviewerService.inviteReviewer(reviewerUserId, manuscript, journal, emailMessage, user.getId(), randomQuery, request, locale);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/reviewers/{pageType}/assignReviewer", method=RequestMethod.GET)
	public ModelAndView assignReviewer(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType, @PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor) || authorityService.hasRole(SystemConstants.roleAEditor)) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser reviewerUser = userService.getById(reviewerUserId);
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			EmailMessage emailMessage = null;
			
			model.addAttribute("manuscript", manuscript);
			List<Review> reviews = reviewerService.getReviews(reviewerUserId, manuscriptId, manuscript.getJournalId(), manuscript.getRevisionCount(), SystemConstants.reviewerS);
			
			Review review = reviews.get(0);
			if(review.isCreatedMember())
				emailMessage = emailService.getGeneralEmailMessage(19, manuscript, journal, reviewerUser.getUsername(), request, locale);
			else
				emailMessage = emailService.getGeneralEmailMessage(18, manuscript, journal, reviewerUser.getUsername(), request, locale);
			
			mav.addObject("journal", journal);
			mav.addObject("reviewer", reviewerUser);
			mav.addObject("pageType", pageType);
			mav.addObject("emailMessage", emailMessage);
			mav.addObject("emailType", "assignReviewer");
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getReviewDueDuration() * 7);
			java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
			SimpleDateFormat sdf = null;
			if(journal.getLanguageCode().equals("ko"))
				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			
			String defaultDueDate = sdf.format(dueDate);
			
			mav.addObject("defaultDueDate", defaultDueDate);
			mav.addObject("currentPageRole", role);
			mav.setViewName("common.reviewers.reviewerEmailForm");
			return mav;
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}
	
	@RequestMapping(value = "/{role}/reviewers/{pageType}/assignReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean assignReviewer(@ModelAttribute("emailForm") EmailMessage emailMessage, 
							 	BindingResult result, 
							 	HttpServletRequest request, Locale locale, Model model, 
							 	@RequestParam(value="manuscriptId", required=true) int manuscriptId,
							 	@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
							 	@RequestParam(value="dateString", required=true) String dateString,
							 	@PathVariable(value="pageType") String pageType,
							 	@PathVariable(value="role") String role) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			reviewerService.assignReviewer(reviewerUserId, manuscript, journal, emailMessage, dateString, request, locale);
			return true;
		}
	}
	
	@RequestMapping(value = "/{role}/reviewers/selectReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean selectReviewer(HttpServletRequest request, 
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role) {
		reviewerService.selectReviewer(reviewerUserId, manuscriptId, false, null);
		return true;
	}
	
	@RequestMapping(value = "/{role}/reviewers/cancelReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean cancelReviewer(HttpServletRequest request, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		reviewerService.cancelReviewer(reviewerUserId, manuscript, journal, request, locale, manuscript.getRevisionCount());
		return true;
	}
	
	@RequestMapping(value = "/{role}/reviewers/removeReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean removeReviewer(HttpServletRequest request, 
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role) {
		
		reviewerService.removeReviewer(reviewerUserId, manuscriptId);
		return true;
	}
	
	@RequestMapping(value = "/{role}/reviewers/dismissReviewer", method=RequestMethod.POST)
	public @ResponseBody Boolean dismissReviewer(HttpServletRequest request, Locale locale,
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role) {
		
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		reviewerService.dismissReviewer(reviewerUserId, manuscript, journal, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/reviewers/{pageType}/reviewResult", method=RequestMethod.GET)
	public ModelAndView reviewResult(Model model, HttpServletRequest request, 
			@RequestParam(value="reviewerUserId", required=true) int reviewerUserId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType, @PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor) || authorityService.hasRole(SystemConstants.roleAEditor)) {
			List<Comment> comments = commentDao.findByManuscriptId(manuscriptId);
			Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			model.addAttribute("manuscript", m);
			List<Review> reviews = reviewerService.getReviews(reviewerUserId, manuscriptId, m.getJournalId(), m.getRevisionCount(), SystemConstants.reviewerC);
			mav.addObject("comments", comments);
			mav.addObject("review", reviews.get(0));
			mav.addObject("pageType", pageType);
			mav.addObject("currentPageRole", role);
			mav.setViewName("common.reviewers.reviewResult");
			return mav;
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}
	
	private int numMatchingDivision(String[] divisions1, String[] divisions2) {
		int matchingCount = 0;
		for(int i=0; i<divisions1.length; i++) {
			for(int j=0; j<divisions2.length; j++) {
				if(divisions1[i].equals(divisions2[j]))
					matchingCount++;
			}
		}
		return matchingCount;

	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/{role}/reviewers/reviewerCandidateTable/{member}",  method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String reviewerCandidateTableFromBoardMembers(HttpServletRequest request, Locale locale, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="role") String role,
			@PathVariable(value="member") String member) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		final Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		int memberNumber = 0;
		if(member.equals("boardMember"))
			memberNumber = 1;
		else if(member.equals("member"))
			memberNumber = 2;
		else if(member.equals("nonMember"))
			memberNumber = 3;
		else if(member.equals("rp"))
			memberNumber = 4;
		
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "users");
		int[] iTotalDisplayRecords = new int[1];
		Set<String> preventEmailSet = new HashSet<String>();
		List<String> preventEmailList = new ArrayList<String>();
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<Review> reviews = reviewerService.getReviews(0, manuscriptId, m.getJournalId(), m.getRevisionCount(), null);
		List<ReviewPreference> rps = rpService.getReviewPreferences(manuscriptId, m.getRevisionCount());
		List<ReviewPreference> nonUserRps = new ArrayList<ReviewPreference>();
		if(member.equals("rp")) {
			for(ReviewPreference rp: rps) {
				if(rp.getUserId() == 0)
					nonUserRps.add(rp);
			}
		} else
			for(ReviewPreference rp: rps)
				preventEmailSet.add(rp.getEmail());
			
		for(Review r: reviews)
			preventEmailSet.add(r.getUser().getUsername());
	
		AssociateEditor editor = journalRoleDao.findJournalAssociateEditor(user.getId(), journal.getId());
		List<SystemUser> requestedUsers = reviewerService.getReviewRequestedUsers(manuscriptId, editor.getId(), 0);
		for(SystemUser u: requestedUsers)
			preventEmailSet.add(u.getUsername());
		
		if(member.equals("member")) {
			List<BoardMember> boardMembers = boardMemberService.getBoardMembersByJournalId(journal.getId());
			for(BoardMember bm: boardMembers)
				preventEmailSet.add(bm.getUser().getUsername());
		}
		
		List<CoAuthor> coAuthors = coAuthorService.getCoAuthors(manuscriptId, -1, 0, false);
		for(CoAuthor coAuthor: coAuthors) {
			SystemUser coAuthorUser = coAuthor.getUser();
			preventEmailSet.add(coAuthorUser.getUsername());
		}
		
		for(String email: preventEmailSet)
			preventEmailList.add(email);
		
		List<SystemUser> users = userService.getReviewerCandidateUsers(dRequest, iTotalDisplayRecords, locale, journal.getId(), memberNumber, manuscriptId, preventEmailList);
		boolean isDivisionFilterNeededUsers = false;
		List<SystemUser> filteredUsers = null;
		List<SystemUser> divisionFilteringNeededUsers = null;
		if(member.equals("boardMember")) {
			List<Division> divisions = journalService.getDivisionsById(journal.getId());
			if(divisions != null && divisions.size() > 0) {
				if(!dRequest.getsSearch()[0].equals("")) {
					String searchQuery = dRequest.getsSearch()[0];
					final String[] divisionStrings = searchQuery.split(",");
					isDivisionFilterNeededUsers = true;
					divisionFilteringNeededUsers = new ArrayList<SystemUser>();
					for(SystemUser u: users) {
						String comparableDivisionString = boardMemberService.getDivisionString(u.getId(), journal.getId());
						if(comparableDivisionString != null) {
							String[] comparableDivisionStrings = comparableDivisionString.split(",");
							int matchingCount = numMatchingDivision(divisionStrings, comparableDivisionStrings);
							if(matchingCount >= divisionStrings.length)
								divisionFilteringNeededUsers.add(u);
						}
					}
				}
			}
		}
		
		DataTableServerResponse dResponse = null;
		if(member.equals("rp")) {
			iTotalDisplayRecords[0] += nonUserRps.size();
			if(users.size() + nonUserRps.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
				filteredUsers = users;
			else
				filteredUsers = users.subList(dRequest.getiDisplayStart(), 
						dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > users.size()
						? dRequest.getiDisplayStart() + (users.size() - dRequest.getiDisplayStart())
						: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
			
			dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredUsers.size() + nonUserRps.size());
		} else if(isDivisionFilterNeededUsers) {
			if(divisionFilteringNeededUsers.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
				filteredUsers = divisionFilteringNeededUsers;
			else
				filteredUsers = divisionFilteringNeededUsers.subList(dRequest.getiDisplayStart(), 
						dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > divisionFilteringNeededUsers.size() 
						? dRequest.getiDisplayStart() + (divisionFilteringNeededUsers.size() - dRequest.getiDisplayStart())
						: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
			
			dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredUsers.size());
		} else {
			if(users.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
				filteredUsers = users;
			else
				filteredUsers = users.subList(dRequest.getiDisplayStart(), 
						dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > users.size() 
						? dRequest.getiDisplayStart() + (users.size() - dRequest.getiDisplayStart())
						: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
			
			dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredUsers.size());
		}
		int i = 0;
		int index = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		
		for (SystemUser u : filteredUsers) {
			sb.append("<button type='button' class='btn btn-default btn-xs width60' onClick='selectReviewer(" + u.getId() + ", " + manuscriptId + ");'/>" +
						messageSource.getMessage("system.select", null , locale) + "</button>");
			dResponse.setAaData(i, index++, Integer.toString(number));
			String reviewerHistoryString = "<a onClick='reviewerHistory(" + u.getId() + ");'>" + u.getUsername() + "</a>";
			dResponse.setAaData(i, index++, reviewerHistoryString);
			dResponse.setAaData(i, index++, contactService.getFullName(u.getContact(), journal.getLanguageCode()));
			dResponse.setAaData(i, index++, u.getContact().getInstitution(journal.getLanguageCode()));
			if(member.equals("boardMember") && jc.isManageDivision())
				dResponse.setAaData(i, index++, boardMemberService.getDivisionString(u.getId(), journal.getId()));
			
			List<String> assignStatus = new ArrayList<String>();
			assignStatus.add(SystemConstants.reviewerA);
			List<String> inviteStatus = new ArrayList<String>();
			inviteStatus.add(SystemConstants.reviewerI);
			int invitedAtThisTime = reviewerService.numReviewManuscripts(u.getId(), 0, 0, -1, inviteStatus);
			int assignedAtThisTime = reviewerService.numReviewManuscripts(u.getId(), 0, 0, -1, assignStatus);
			dResponse.setAaData(i, index++, Integer.toString(invitedAtThisTime));
			dResponse.setAaData(i, index++, Integer.toString(assignedAtThisTime));
			dResponse.setAaData(i, index++, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
			index = 0;
		}
		
		StringBuffer rpStringBuffer = new StringBuffer();
		if(member.equals("rp")) {
			index = 0;
			for (ReviewPreference rp : nonUserRps) {
				rpStringBuffer.append(rp.getId());
				rpStringBuffer.append("--");
				rpStringBuffer.append(rp.getEmail());
				rpStringBuffer.append("--");
				if(rp.getInstitution() != null) rpStringBuffer.append(rp.getInstitution());
				else rpStringBuffer.append("");
				rpStringBuffer.append("--");
				if(rp.getDepartment() != null) rpStringBuffer.append(rp.getDepartment());
				else rpStringBuffer.append("");
				rpStringBuffer.append("--");
				if(rp.getFirstName() != null) rpStringBuffer.append(rp.getFirstName());
				else rpStringBuffer.append("");
				rpStringBuffer.append("--");
				if(rp.getLastName() != null) rpStringBuffer.append(rp.getLastName());
				else rpStringBuffer.append("");
				rpStringBuffer.append("--");
				rpStringBuffer.append(rp.getCountryCode());
				rpStringBuffer.append("--");
				rpStringBuffer.append(rp.getDegree());
				rpStringBuffer.append("--");
				rpStringBuffer.append(rp.getSalutation());
				rpStringBuffer.append("--");
				if(rp.getLocalFullName() != null) rpStringBuffer.append(rp.getLocalFullName());
				else rpStringBuffer.append("");
				rpStringBuffer.append("--");
				if(rp.getLocalInstitution() != null) rpStringBuffer.append(rp.getLocalInstitution());
				else rpStringBuffer.append("");
				sb.append("<button type='button' class='btn btn-default btn-xs width60' onClick='selectReviewerPreference(\"" + rpStringBuffer.toString() + "\", " + manuscriptId + ");'/>" +
							messageSource.getMessage("system.select", null , locale) + "</button>");
				dResponse.setAaData(i, index++, Integer.toString(number));
				String reviewerHistoryString = rp.getEmail();
				dResponse.setAaData(i, index++, reviewerHistoryString);
				
				String fullName = null;
				if(journal.getLanguageCode().equals(SystemConstants.koreanLanguageCode)) {
					if(rp.getLocalFullName() != null)
						fullName = rp.getLocalFullName();
					else
						fullName = rp.getFirstName() + " " + rp.getLastName();
				} else
					fullName = rp.getFirstName() + " " + rp.getLastName();
				
				dResponse.setAaData(i, index++, fullName);
				dResponse.setAaData(i, index++, rp.getInstitution(journal.getLanguageCode()));
				String rpCountry = null;
				try {
					CountryCode countryCode = countryCodeDao.findByAlpha2(rp.getCountryCode());
					rpCountry = countryCode.getName();
				} catch(NullPointerException e) {
					e.printStackTrace();
				}
				
				dResponse.setAaData(i, index++, rpCountry);
				dResponse.setAaData(i, index++, messageSource.getMessage("signin.degreeDesignation." + rp.getDegree(), null , locale));
				dResponse.setAaData(i, index++, sb.toString());
				sb.delete(0, sb.length());
				rpStringBuffer.delete(0, rpStringBuffer.length());
				i++;
				number++;
				index = 0;
			}
		}
		
		return DataTableServerResponse.toJSONString(dResponse);	
	}
	

	@RequestMapping(value = "/{role}/manuscripts/finalDecision", method=RequestMethod.GET)
	public String finalDecision(HttpServletRequest request, Model model, Locale locale, @PathVariable(value="role") String role,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="returnPage", required=false) String returnPage) {
		if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor)) {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId,  SystemConstants.VIEW_BUILD);
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			model.addAttribute("jc", jc);
			FinalDecision fd = null;
			if(role.equals("chiefEditor")) {
				model.addAttribute("returnPage", returnPage);
				fd = chiefEditorService.getFinalDecision(manuscriptId, manuscript.getRevisionCount());
				if(fd == null) {
					fd = new FinalDecision();
					fd.setJournalId(journal.getId());
					fd.setManuscriptId(manuscriptId);
					fd.setUserId(user.getId());
					fd.setRevisionCount(manuscript.getRevisionCount());
					int fdId = chiefEditorService.createFinalDecision(fd);
					fd.setId(fdId);
				}
			} else if(role.equals("guestEditor")) {
				model.addAttribute("returnPage", returnPage);
				fd = guestEditorService.getFinalDecision(manuscriptId, manuscript.getRevisionCount());
				if(fd == null) {
					fd = new FinalDecision();
					fd.setJournalId(journal.getId());
					fd.setManuscriptId(manuscriptId);
					fd.setUserId(user.getId());
					fd.setRevisionCount(manuscript.getRevisionCount());
					int fdId = guestEditorService.createFinalDecision(fd);
					fd.setId(fdId);
				}
			}
			model.addAttribute("finalDecision", fd);
			model.addAttribute("manuscript", manuscript);
			List<Comment> comments = commentDao.findByManuscriptId(manuscriptId);
			List<Review> reviews = reviewerService.getReviews(0, manuscriptId, manuscript.getJournalId(), manuscript.getRevisionCount(), SystemConstants.reviewerC);
			for(Review review: reviews)
				review.setReviewerToolTipData(systemUtil.getReviewerToolTipData(review, journal, locale));
			
			
			model.addAttribute("comments", comments);
			model.addAttribute("reviews", reviews);
	
			EmailMessage acceptEmailMessage = emailService.getGeneralEmailMessage(31, manuscript, journal, null, request, locale);
			String body = acceptEmailMessage.getBody();
			String cameraReadyTemplateUrl = jc.getCameraReadyTemplateUrl();
			if(cameraReadyTemplateUrl == null)
				cameraReadyTemplateUrl = messageSource.getMessage("system.notAvailable2", null, locale);
			String copyrightFormUrl = jc.getCopyrightFormUrl();
			if(copyrightFormUrl == null)
				copyrightFormUrl = messageSource.getMessage("system.notAvailable2", null, locale);
			body = body.replace("[cameraReadyTemplateUrl]", cameraReadyTemplateUrl);
			body = body.replace("[copyrightUrl]", copyrightFormUrl);
			acceptEmailMessage.setBody(body);
			model.addAttribute("acceptEmailMessage", acceptEmailMessage);
			EmailMessage reReviewEmailMessage = emailService.getGeneralEmailMessage(32, manuscript, journal, null, request, locale);
			model.addAttribute("reReviewEmailMessage", reReviewEmailMessage);
			EmailMessage rejectEmailMessage = emailService.getGeneralEmailMessage(33, manuscript, journal, null, request, locale);
			model.addAttribute("rejectEmailMessage", rejectEmailMessage);
			
			if(!acceptEmailMessage.getBody().contains("[reviewResultByAssociateEditorTitle]") && !acceptEmailMessage.getBody().contains("[reviewResultByReviewersTitle]"))
				model.addAttribute("reviewResultsExist", false);
			else
				model.addAttribute("reviewResultsExist", true);
			Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getCameraSubmitDuration());
			java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
			SimpleDateFormat sdf = null;
			if(journal.getLanguageCode().equals("ko"))
				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			
			String dateString = sdf.format(dueDate);
			model.addAttribute("cameraReadySubmitDate", dateString);
			model.addAttribute("currentPageRole", role);
			
			return "common.manuscripts.finalDecisionForm";
		} else
			return "exception.404";
	}

	@RequestMapping(value = "/{role}/manuscripts/finalDecision", method=RequestMethod.POST)
	public @ResponseBody Boolean finalDecision(@ModelAttribute FinalDecision fd, BindingResult result, @PathVariable(value="role") String role,
			HttpServletRequest request, Model model, Locale locale,
			@RequestParam(value="postCommentToAuthor", required=false) String postCommentToAuthor,
			@RequestParam(value="postCommentToEditorAndManager", required=false) String postCommentToEditorAndManager,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="subject", required=true) String subject,
			@RequestParam(value="body", required=true) String body) {
		if(result.hasErrors())
			System.out.println("binding error");
		else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId,  SystemConstants.VIEW_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			EmailMessage emailMessage = new EmailMessage();
			emailMessage.setSubject(subject);
			emailMessage.setBody(body);
			if(role.equals("chiefEditor"))
				chiefEditorService.finalDecisionAction(fd, postCommentToAuthor, postCommentToEditorAndManager, emailMessage, manuscript, journal, request, locale);
			else if(role.equals("guestEditor"))
				geService.finalDecisionAction(fd, postCommentToAuthor, postCommentToEditorAndManager, emailMessage, manuscript, journal, request, locale);
		}
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/manuscripts/reject", method=RequestMethod.GET)
	public String forceToReject(HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @PathVariable(value="role") String role,
			Model model) {
		if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor)) {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			model.addAttribute("manuscript", manuscript);
			EmailMessage emailMessage = emailService.getGeneralEmailMessage(39, manuscript, journal, null, request, locale);
			model.addAttribute("emailMessage", emailMessage);
			model.addAttribute("currentPageRole", role);
			return "common.manuscripts.forceToRejectForm";
		} else
			return "exception.404";
	}
	
	@RequestMapping(value="/{role}/manuscripts/reject", method=RequestMethod.POST)
	public ModelAndView forceToReject(HttpServletRequest request, Locale locale, @ModelAttribute EmailMessage emailMessage,
			BindingResult result, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="comments", required=true) String comments,  
			@PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("currentPageRole", role);
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			if(authorityService.hasRole(SystemConstants.roleCEditor) || authorityService.hasRole(SystemConstants.roleGEditor)) {
				Journal journal = (Journal)request.getSession().getAttribute("journal");
				Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
				SystemUser user = (SystemUser)request.getSession().getAttribute("user");
				chiefEditorService.forceToRejectAction(emailMessage, comments, user, manuscript, journal, request, locale);
				RedirectView rv = new RedirectView("../manuscripts");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			}
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}
	
	/*	Review Invitation */
	@Transactional(readOnly = true)
	@RequestMapping(value="/reviewInvitation/{query}", method=RequestMethod.GET)
	public ModelAndView request(@PathVariable("query") String query, @PathVariable(value="jnid") String jnid,
								Model model, Locale locale) {
		ModelAndView mav = new ModelAndView();
		ReviewRequest r = reviewRequestDao.findRequestByQuery(query);
		Journal journal = this.journalService.getByJournalNameId(jnid);
		if (r != null) {
			mav.setViewName("reviewer.reviews.reviewInvitation");
			int manuscriptId = r.getManuscriptId();
			int reviewerUserId = r.getReviewerUserId();			
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			SystemUser reviewer = userService.getById(reviewerUserId);
			mav.addObject("reviewer", reviewer);
			mav.addObject("reviewerName", contactService.getFullName(reviewer.getContact(), journal.getLanguageCode()));
			mav.addObject("journal", journal);
			mav.addObject("manuscript", manuscript);
			mav.addObject("query", query);
			ReviewerSuggest rs = new ReviewerSuggest();
			rs.setReviewerUserId(reviewer.getId());
			mav.addObject("rs", rs);
			mav.addObject("reviewRequest", r);
			List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
			for(int i=0; i<DegreeDesignation.values().length; i++)
				degreeDesignations.add(DegreeDesignation.getType(i));
			
			mav.addObject("degreeDesignations", degreeDesignations);		
			
			List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
			for(int i=0; i<SalutationDesignation.values().length; i++)
				salutationDesignations.add(SalutationDesignation.getType(i));
			
			mav.addObject("salutationDesignations", salutationDesignations);	
			
			List<ReviewerDeclineReason> reviewerDeclineReasons = new LinkedList<ReviewerDeclineReason>();
			for(int i=0; i<ReviewerDeclineReason.values().length; i++)
				reviewerDeclineReasons.add(ReviewerDeclineReason.getType(i));
			
			mav.addObject("reviewerDeclineReasons", reviewerDeclineReasons);	
			
		} else {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
		}
		return mav;
	}
	
	@RequestMapping(value="/reviewInvitation/{query}", method=RequestMethod.POST)
	public ModelAndView request(HttpServletRequest request, Locale locale, @ModelAttribute ReviewerSuggest rs, 
			@PathVariable("query") String query, @PathVariable(value="jnid") String jnid, 
			@RequestParam(value="decision", required=true) String decision) {
		ModelAndView mav = new ModelAndView();
		Journal journal = journalService.getByJournalNameId(jnid);
		reviewerService.reviewerDecision(rs, decision, query, journal, request, locale);
		RedirectView rv = new RedirectView("../");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
}
