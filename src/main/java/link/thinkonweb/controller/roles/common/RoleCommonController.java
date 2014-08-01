package link.thinkonweb.controller.roles.common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.roles.ChiefEditorService;
import link.thinkonweb.service.roles.GuestEditorService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/journals/{jnid}*")
public class RoleCommonController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(RoleCommonController.class);
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
	private CoAuthorService coAuthorService;
	@Autowired
	private ChiefEditorService chiefEditorService;
	@Autowired
	private GuestEditorService guestEditorService;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private FileService fileService;
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
	
	@RequestMapping(value="/author", method=RequestMethod.GET)
	public ModelAndView author(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/author/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}

	@RequestMapping(value="/reviewer", method=RequestMethod.GET)
	public ModelAndView reviewer(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/reviewer/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/manager", method=RequestMethod.GET)
	public ModelAndView manager(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/manager/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/chiefEditor", method=RequestMethod.GET)
	public ModelAndView chiefEditor(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/chiefEditor/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/guestEditor", method=RequestMethod.GET)
	public ModelAndView guestEditor(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/guestEditor/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/associateEditor", method=RequestMethod.GET)
	public ModelAndView associateEditor(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/associateEditor/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/boardMember", method=RequestMethod.GET)
	public ModelAndView boardMember(Model model, HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../" + jnid + "/boardMember/");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/gatethrough/{role}", method=RequestMethod.GET)
	public ModelAndView journalGatethrough(@PathVariable(value="jnid") String jnid, 
										@PathVariable(value="role") String role, Model model, 
										HttpServletRequest request, HttpServletResponse response, RedirectAttributes ra,
										@RequestParam(value="pageType", required=false) String pageType, 
										@RequestParam(value="manuscriptId", required=false) Integer manuscriptId,
										@RequestParam(value="v", required=false) String v) {
		ModelAndView mav = new ModelAndView();
		Journal journal = this.journalService.getByJournalNameId(jnid);
		request.getSession().setAttribute("journal", journal);
		if(authorityService.getUserDetails() != null) {
			String username = authorityService.getUserDetails().getUsername();
			SystemUser user = userService.getByUsername(username);
			
			List<Authority> authorities = this.authorityService.getAuthorities(user.getId(), journal.getId(), null);
			
			Collections.sort(authorities, new Comparator<Authority>() {
				@Override
				public int compare(Authority a1, Authority a2) {
					if (a1.getRole().equals(SystemConstants.roleManager) && !a2.getRole().equals(SystemConstants.roleManager))
						return -1;
					else 
						return 0;					
				}
			});
			
			List<String> roles = new ArrayList<String>();
			for(Authority a: authorities) {
				roles.add(a.getRole());
			}
			
			
			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			if (journal.getLanguageCode().equals("ko")) {
				localeResolver.setLocale(request, response, new Locale("ko", "KR"));
			} else {
				localeResolver.setLocale(request, response, new Locale("en", "US"));
			}
			
			
			
			request.getSession().setAttribute("roles", roles);
			request.getSession().setAttribute("username", user.getUsername());

			if(pageType != null) {
				RedirectView rv = new RedirectView("../" + role + "/manuscripts?pageType=" + pageType + "&manuscriptId=" + manuscriptId + "&v=" + v);
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			}
			
			RedirectView rv = new RedirectView(servletContext.getContextPath() + "/journals/" + journal.getJournalNameId() + "/" + role + "/");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			RedirectView rv = new RedirectView("../" + journal.getJournalNameId());
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	
	
	/*	Role Common */
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/manuscriptStatusOverview", method=RequestMethod.GET)
	public ModelAndView manuscriptsOverview(Model model, HttpServletRequest request, Locale locale, 
			RedirectAttributes ra,
			@PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		mav.addObject("currentPageRole", role);
		mav.setViewName("common.overview.manuscriptStatusOverview");
		Map<String, Integer> statusMap = new LinkedHashMap<String, Integer>();
		statusMap.put(SystemConstants.statusB, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusB));
		statusMap.put(SystemConstants.statusI, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusI));
		if(journal.getType().equals("A") || journal.getType().equals("B"))
			statusMap.put(SystemConstants.statusO, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusO));
		
		statusMap.put(SystemConstants.statusR, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusR));
		statusMap.put(SystemConstants.statusE, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusE));
		if(journal.getType().equals("A") || journal.getType().equals("C")) {
			statusMap.put(SystemConstants.statusD, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusD));
			statusMap.put(SystemConstants.statusV, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusV));
		}
		statusMap.put(SystemConstants.statusA, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusA));
		statusMap.put(SystemConstants.statusM, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusM));
		statusMap.put(SystemConstants.statusG, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusG));
		statusMap.put(SystemConstants.statusP, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusP));
		statusMap.put(SystemConstants.statusW, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusW));
		statusMap.put(SystemConstants.statusJ, manuscriptService.numSubmittedManuscripts(journal.getId(), SystemConstants.statusJ));
		
		mav.addObject("statusMap", statusMap);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/gateOverView", method=RequestMethod.GET)
	public ModelAndView gateOverView(Model model, @PathVariable(value="jnid") String jnid, 
										@PathVariable(value="role") String role, 
										@RequestParam(value="status", required=false) String status,
										HttpServletRequest request, HttpServletResponse response, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		String pageType = null;
		if(role.equals("manager")) {
			switch(status) {
				case SystemConstants.statusB:
					pageType = "beingSubmitted";
					break;
				case SystemConstants.statusI:
					pageType = "submitted";
					break;
				case SystemConstants.statusV:	
					pageType = "revisionSubmitted";
					break;
				case SystemConstants.statusD:	
					pageType = "revisionRequested";
					break;
				case SystemConstants.statusO:
				case SystemConstants.statusR:
				case SystemConstants.statusE:
					pageType = "underReview";
					break;
				case SystemConstants.statusA:
				case SystemConstants.statusM:
				case SystemConstants.statusG:
					pageType = "accepted";
					break;
				case SystemConstants.statusP:
					pageType = "published";
					break;
				case SystemConstants.statusJ:
				case SystemConstants.statusW:
					pageType = "withdrawn";
					break;
				default:
					pageType = "submitted";
					break;
			}
		} else if(role.equals("chiefEditor")) {
			switch(status) {
				case SystemConstants.statusI:
					pageType = "submitted";
					break;
				case SystemConstants.statusV:	
					pageType = "revisionSubmitted";
					break;
				case SystemConstants.statusO:	
					pageType = "aeSelection";
					break;
				case SystemConstants.statusR:
					pageType = "underReview";
					break;
				case SystemConstants.statusE:
					pageType = "finalDecisionRequired";
					break;
				case SystemConstants.statusD:
				case SystemConstants.statusA:
				case SystemConstants.statusM:
				case SystemConstants.statusG:
				case SystemConstants.statusP:
				case SystemConstants.statusJ:
				case SystemConstants.statusW:
					pageType = "other";
					break;
				default:
					pageType = "submitted";
					break;
			}
		}
		RedirectView rv = new RedirectView("../" + role + "/manuscripts?pageType=" + pageType);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/manuscripts", method=RequestMethod.GET)
	public ModelAndView manuscripts(Model model, HttpServletRequest request, Locale locale, 
			RedirectAttributes ra,
			@PathVariable(value="role") String role,
			@RequestParam(value="pageType", required=false) String pageType, 
			@RequestParam(value="manuscriptId", required=false) Integer manuscriptId,
			@RequestParam(value="v", required=false) String v) {
		ModelAndView mav = new ModelAndView();
		if(pageType != null) {
			RedirectView rv = new RedirectView("manuscripts");
			ra.addFlashAttribute("pageType", pageType);
			if(manuscriptId != null)
				ra.addFlashAttribute("manuscriptId", manuscriptId);
			if(v != null)
				ra.addFlashAttribute("v", v);
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		mav.addObject("currentPageRole", role);
		mav.addObject("statusTooltipData", systemUtil.getStatusTooltipData(locale));
		mav.setViewName(role + ".manuscripts.manuscriptTable");
		
		if(role.equals("author")) {
			List<String> beingSubmittedCoWrittenStatus = new ArrayList<String>();
			beingSubmittedCoWrittenStatus.add(SystemConstants.statusB);
			int numCoWrittenBeingSubmitted = manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), beingSubmittedCoWrittenStatus, true);
			mav.addObject("numCoWrittenBeingSubmitted", numCoWrittenBeingSubmitted);
			
			List<String> submittedCoWrittenStatus = new ArrayList<String>();
			submittedCoWrittenStatus.add(SystemConstants.statusI);
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC))
				submittedCoWrittenStatus.add(SystemConstants.statusO);
			submittedCoWrittenStatus.add(SystemConstants.statusR);
			submittedCoWrittenStatus.add(SystemConstants.statusE);
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC))
				submittedCoWrittenStatus.add(SystemConstants.statusV);
			
			int numCoWrittenSubmitted = manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), submittedCoWrittenStatus, true);
			mav.addObject("numCoWrittenSubmitted", numCoWrittenSubmitted);
			
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC)) {
				List<String> revisionRequestedStatus = new ArrayList<String>();
				revisionRequestedStatus.add(SystemConstants.statusD);
				int numCoWrittenRevisionRequested = manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), revisionRequestedStatus, true);
				mav.addObject("numCoWrittenRevisionRequested", numCoWrittenRevisionRequested);
			}
			
			List<String> acceptedCoWrittenStatus = new ArrayList<String>();
			acceptedCoWrittenStatus.add(SystemConstants.statusA);
			acceptedCoWrittenStatus.add(SystemConstants.statusM);
			acceptedCoWrittenStatus.add(SystemConstants.statusG);
			int numCoWrittenAccepted = manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), acceptedCoWrittenStatus, true);
			mav.addObject("numCoWrittenAccepted", numCoWrittenAccepted);
			
			List<String> publishedCoWrittenStatus = new ArrayList<String>();
			publishedCoWrittenStatus.add(SystemConstants.statusP);
			int numCoWrittenPublished = manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), publishedCoWrittenStatus, true);
			mav.addObject("numCoWrittenPublished", numCoWrittenPublished);
		} else if(role.equals("guestEditor")) {
			List<String> reviewStatus = new ArrayList<String>();
			reviewStatus.add(SystemConstants.statusR);
			GuestEditor ge = geService.getGuestEditor(user.getId(), journal.getId());
			List<GuestEditorSpecialIssue> geSpecialIssues = ge.getGeSpecialIssues();
			List<Integer> specialIssueIds = null;
			if(geSpecialIssues != null) {
				specialIssueIds = new ArrayList<Integer>();
				for(GuestEditorSpecialIssue gs: geSpecialIssues)
					specialIssueIds.add(gs.getSpecialIssueId());
			}

			int numReview = 0;
			numReview = manuscriptService.numManuscriptsByGuestEditorUserId(user.getId(), journal.getId(), specialIssueIds, reviewStatus, 0);
			mav.addObject("numReview", numReview);
			
			int numReReview = 0;
			numReReview = manuscriptService.numManuscriptsByGuestEditorUserId(user.getId(), journal.getId(), specialIssueIds, reviewStatus, Integer.MAX_VALUE);
			mav.addObject("numReReview", numReReview);
		} else if(role.equals("associateEditor")) {
			List<String> assignStatus = new ArrayList<String>();
			assignStatus.add(SystemConstants.statusO);
			int numAssign =  manuscriptService.numManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorA, assignStatus, 0);
			mav.addObject("numAssign", numAssign);
			
			List<String> reviewStatus = new ArrayList<String>();
			reviewStatus.add(SystemConstants.statusR);
			int numReview =  manuscriptService.numManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorT, reviewStatus, 0);
			mav.addObject("numReview", numReview);
			
			int numReReview =  manuscriptService.numManuscriptsByAssociateEditorUserId(user.getId(), journal.getId(), SystemConstants.editorT, reviewStatus, Integer.MAX_VALUE);
			mav.addObject("numReReview", numReReview);
		} else if(role.equals("reviewer")) {
			List<Review> reviews = reviewerService.getReviews(user.getId(), 0, journal.getId(), -1, SystemConstants.reviewerA);
			model.addAttribute("reviews", reviews);
		} else if(role.equals("chiefEditor")) {
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB)) {
				List<String> aeSelectionStatus = new ArrayList<String>();
				aeSelectionStatus.add(SystemConstants.statusO);
				int numAeSelection = manuscriptService.numManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, aeSelectionStatus, 0);
				mav.addObject("numAeSelection", numAeSelection);
				if(journal.getType().equals(SystemConstants.journalTypeA)) {
					List<String> underReviewStatus = new ArrayList<String>();
					underReviewStatus.add(SystemConstants.statusR);
					int numInReview = manuscriptService.numManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, underReviewStatus, -1);
					mav.addObject("numInReview", numInReview);
				}
				List<String> finalDecisionStatus = new ArrayList<String>();
				finalDecisionStatus.add(SystemConstants.statusE);
				int numFinalDecision = manuscriptService.numManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, finalDecisionStatus, -1);
				mav.addObject("numFinalDecision", numFinalDecision);
			} else {
				List<String> reviewStatus = new ArrayList<String>();
				reviewStatus.add(SystemConstants.statusR);
				int numReview =  manuscriptService.numManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, reviewStatus, -1);
				mav.addObject("numReview", numReview);
				if(journal.getType().equals(SystemConstants.journalTypeC)) {
					int numReReview = manuscriptService.numManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleCEditor, reviewStatus, Integer.MAX_VALUE);
					mav.addObject("numReReview", numReReview);
				}
			}
		} else if(role.equals("manager")) {
			List<String> beingSubmittedStatus = new ArrayList<String>();
			beingSubmittedStatus.add(SystemConstants.statusB);
			int numBeingSubmitted = manuscriptService.numSubmittedManuscripts(0, journal.getId(), beingSubmittedStatus);
			mav.addObject("numBeingSubmitted", numBeingSubmitted);
			
			List<String> submittedStatus = new ArrayList<String>();
			submittedStatus.add(SystemConstants.statusI);
			
			int numSubmitted = manuscriptService.numSubmittedManuscripts(0, journal.getId(), submittedStatus);
			mav.addObject("numSubmitted", numSubmitted);
			
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC)) {
				List<String> revisionRequestedStatus = new ArrayList<String>();
				revisionRequestedStatus.add(SystemConstants.statusD);
				int numRevisionRequested = manuscriptService.numSubmittedManuscripts(0, journal.getId(), revisionRequestedStatus);
				mav.addObject("numRevisionRequested", numRevisionRequested);
				
				List<String> revisionSubmittedStatus = new ArrayList<String>();
				revisionSubmittedStatus.add(SystemConstants.statusV);
				int numRevisionSubmitted = manuscriptService.numSubmittedManuscripts(0, journal.getId(), revisionSubmittedStatus);
				mav.addObject("numRevisionSubmitted", numRevisionSubmitted);
			}
			
			List<String> acceptedStatus = new ArrayList<String>();
			acceptedStatus.add(SystemConstants.statusA);
			acceptedStatus.add(SystemConstants.statusM);
			acceptedStatus.add(SystemConstants.statusG);
			int numAccepted = manuscriptService.numSubmittedManuscripts(0, journal.getId(), acceptedStatus);
			mav.addObject("numAccepted", numAccepted);
		} 
		
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/manuscripts/{pageType}/viewManuscript", method=RequestMethod.GET)
	public ModelAndView viewManuscript(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="v", required=true) String v,
			@PathVariable(value="pageType") String pageType,
			@PathVariable(value="role") String role) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(role + ".manuscripts.viewManuscript");
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		List<Integer> confirmIndices = new ArrayList<Integer>();
		for(int i=1; i<=jc.getNumberOfConfirms(); i++)
			confirmIndices.add(i);
		mav.addObject("confirmIndices", confirmIndices);
		if(role.equals("author")) {
			if(pageType.equals("accepted") || pageType.equals("published")) {
				List<String> designations = new ArrayList<String>();
				designations.add(SystemConstants.fileTypeG);
				
				List<UploadedFile> galleryProofFiles = fileService.getFiles(manuscriptId, m.getManagerUserId(), m.getRevisionCount(), designations);
				mav.addObject("galleryProofFiles", galleryProofFiles);
			}
		} else if(role.equals("associateEditor") || role.equals("guestEditor") || role.equals("chiefEditor")) {
			if(pageType.equals("reviewerHistory"))
				mav.setViewName("common.reviewers.viewReviewerHistoryManuscript");
		} else if(role.equals("reviewer")) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Review> reviews = reviewerService.getReviews(user.getId(), manuscriptId, journal.getId(), m.getRevisionCount(), SystemConstants.reviewerA);
			if(reviews != null && reviews.size() > 0)
				mav.addObject("reviewNeeded", new Boolean(true));
			else
				mav.addObject("reviewNeeded", new Boolean(false));
		} else if(role.equals("manager")) {
			if(pageType.equals("manuscriptsList"))
				mav.setViewName("manager.configuration.backup.viewManuscript");
			else {
				if(m.getStatus().equals(SystemConstants.statusI)) {
					if(m.getManuscriptTrackId() == 0) {
						List<ChiefEditor> chiefUsers = chiefEditorService.getChiefEditorsByJournalId(journal.getId());
						mav.addObject("chiefUsers", chiefUsers);
					} else {
						SystemUser editor = null;
						List<GuestEditor> editors = guestEditorService.getGuestEditorsByJournalId(journal.getId());
						for(GuestEditor ge: editors) {
							if(ge.getGeSpecialIssues() != null) {
								List<GuestEditorSpecialIssue> geSpecialIssues = ge.getGeSpecialIssues();
								for(GuestEditorSpecialIssue geSpecialIssue: geSpecialIssues) {
									if(geSpecialIssue.getSpecialIssueId() == m.getSpecialIssueId()) {
										editor = ge.getUser();
										break;
									}
										
								}
							}
						}
						mav.addObject("editor", editor);
					}
				} else if(m.getStatus().equals(SystemConstants.statusV)) {
					if(m.getManuscriptTrackId() == 0) {
						if(m.getAssociateEditor() != null )
							mav.addObject("editor", m.getAssociateEditor());
					} else {
						if(m.getGuestEditor() != null )
							mav.addObject("editor", m.getGuestEditor());
					}
				}
			}
		} 
		List<Comment> comments = commentDao.findByManuscriptId(manuscriptId);
		m.setComments(comments);
		mav.addObject("manuscript", m);
		mav.addObject("pageType", pageType);
		mav.addObject("v", v);
		mav.addObject("currentPageRole", role);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/{role}/manuscripts/comments", method=RequestMethod.GET)
	public String comments(HttpServletRequest request, Model model, @PathVariable(value="role") String role,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		String viewName = role + ".manuscripts.comments";
		model.addAttribute("currentPageRole", role);
		if(role.equals("chiefEditor") || role.equals("associateEditor") || role.equals("guestEditor")) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Comment> comments = null;
			if(role.equals("chiefEditor"))
				comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleCEditor, false);
			else if(role.equals("associateEditor"))
				comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleAEditor, false);
			else
				comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleGEditor, false);
			
			for(Comment comment: comments)
				comment.setFromUser(userService.getById(comment.getFromUserId()));
			
			model.addAttribute("comments", comments);
			int maxRevision = 0;
			for(Comment comment: comments) 
				if(comment.getRevisionCount() > maxRevision)
					maxRevision = comment.getRevisionCount();
			
			List<Integer> revisionIndices = new ArrayList<Integer>();
			for(int i=maxRevision; i>=0; i--)
				revisionIndices.add(i);
			model.addAttribute("revisionIndices", revisionIndices);
			model.addAttribute("maxRevision", maxRevision);
			return viewName;
		} else if(role.equals("author") || role.equals("manager")) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Comment> comments = null;
			if(role.equals("author")) {
				Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
				List<Integer> coAuthorIds = coAuthorService.getCoAuthorIds(manuscriptId, manuscript.getRevisionCount(), 0, false);
				comments = commentDao.findAuthorComments(manuscriptId, coAuthorIds);
			} else
				comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleManager, true);
			for(Comment comment: comments)
				comment.setFromUser(userService.getById(comment.getFromUserId()));
			
			model.addAttribute("comments", comments);
			int maxCameraReadyRevision = 0;
			int maxGalleryProofRevision = 0;
			for(Comment comment: comments) {
				if(comment.getGalleryProofRevision() > maxGalleryProofRevision)
					maxGalleryProofRevision = comment.getGalleryProofRevision();
				
				if(comment.getCameraReadyRevision() > maxCameraReadyRevision)
					maxCameraReadyRevision = comment.getCameraReadyRevision();
			}
			List<Integer> cameraReadyRevisionIndices = new ArrayList<Integer>();
			for(int i=maxCameraReadyRevision; i>=0; i--)
				cameraReadyRevisionIndices.add(i);
			List<Integer> galleryProofRevisionIndices = new ArrayList<Integer>();
			for(int i=maxGalleryProofRevision; i>=0; i--)
				galleryProofRevisionIndices.add(i);
			model.addAttribute("cameraReadyRevisionIndices", cameraReadyRevisionIndices);
			model.addAttribute("galleryProofRevisionIndices", galleryProofRevisionIndices);
			model.addAttribute("maxCameraReadyRevision", maxCameraReadyRevision);
			model.addAttribute("maxGalleryProofRevision", maxGalleryProofRevision);
			
			model.addAttribute("comments", comments);
			return viewName;
		} else 
			return "exception.404";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/viewManuscriptHistory", method=RequestMethod.GET)
	public ModelAndView viewManuscriptHistory(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@RequestParam(value="type", required=true) String type) {
		ModelAndView mav = new ModelAndView();
		Manuscript m = null;
/*		MF: Manuscript Files
		CF: CameraReady Files
		GF: GalleryProof Files
		AF: Additional Files
*/
		if(type.equals("MF") || type.equals("CF") || type.equals("GF") || type.equals("AF"))
			m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.FILE_HISTORY_BUILD);
		else
			m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.HISTORY_BUILD);
		
		mav.addObject("manuscript", m);
		
		List<Integer> revisions = new ArrayList<Integer>();
		if(type.equals("GF")) {
			for(int i=m.getGalleryProofRevision(); i>=0; i--)
				revisions.add(i);
		} else if(type.equals("CF")) {
			for(int i=m.getCameraReadyRevision(); i>=0; i--)
				revisions.add(i);
		} else {
			for(int i=m.getRevisionCount(); i>=0; i--)
				revisions.add(i);
		}
		
		mav.addObject("revisions", revisions);
		mav.addObject("type", type);
		mav.setViewName("manuscripts.viewManuscriptHistory");
		return mav;
	}

	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
}
