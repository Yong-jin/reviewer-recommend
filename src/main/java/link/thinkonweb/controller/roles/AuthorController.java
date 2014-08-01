package link.thinkonweb.controller.roles;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.manuscript.AbstractDao;
import link.thinkonweb.dao.manuscript.CoverLetterDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.RunningHeadDao;
import link.thinkonweb.dao.manuscript.TitleDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.constants.CameraReadyFileDesignation;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.FileDesignation;
import link.thinkonweb.domain.constants.LocalJobTitleDesignation;
import link.thinkonweb.domain.constants.ManuscriptTrack;
import link.thinkonweb.domain.constants.ManuscriptType;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.CoverLetter;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ManuscriptAbstract;
import link.thinkonweb.domain.manuscript.ReviewPreference;
import link.thinkonweb.domain.manuscript.RunningHead;
import link.thinkonweb.domain.manuscript.Title;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/journals/{jnid}/author/*")
public class AuthorController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AuthorController.class);
	
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private  ManuscriptService manuscriptService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private DivisionDao divisionDao;
	@Autowired
	private CountryCodeDao countryCodeDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private EmailService emailService;
	@Autowired
	private TitleDao manuscriptTitleDao;
	@Autowired
	private RunningHeadDao manuscriptRunningHeadDao;
	@Autowired
	private AbstractDao manuscriptAbstractDao;
	@Autowired
	private KeywordDao manuscriptKeywordDao;
	@Autowired
	private CoverLetterDao coverLetterDao;
	@Autowired
	private SpecialIssueDao specialIssueDao;
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
	
	@RequestMapping(value="/submitManuscript", method=RequestMethod.GET)
	public ModelAndView submitManuscript(HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		if(!journal.isPaid()) {
			if(journal.getCreator() != null)
				mav.addObject("creator", journal.getCreator());
			mav.setViewName("exception.unpaid");
			return mav;
		}
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		Manuscript manuscript = null;
		int manuscriptId = manuscriptService.init(user.getId(), journal.getId());
		manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		request.getSession().setAttribute("manuscript", manuscript);
		RedirectView rv = new RedirectView("step1");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/editManuscript", method=RequestMethod.GET)
	public ModelAndView editManuscript(HttpServletRequest request, Model model, 
			@RequestParam(value="manuscriptId") int manuscriptId) {
		ModelAndView mav = new ModelAndView();
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		Manuscript manuscript  = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		RedirectView rv = null;
		if(manuscript != null) {
			Journal journal = journalService.getById(manuscript.getJournalId());
			request.getSession().setAttribute("journal", journal);
			if(coAuthorService.isOneOfAuthor(user.getId(), manuscriptId) && manuscript.getJournalId() == journal.getId()) {
				request.getSession().setAttribute("manuscript",  manuscript);
				rv = new RedirectView("submitManuscript/step1");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			} 
		}
		rv = new RedirectView("../../");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/submitManuscript/step1", method=RequestMethod.GET)
	public ModelAndView step1(HttpServletRequest request, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		if(m == null || m.getJournalId() != journal.getId()) {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} 
		if(jc.isManageDivision()) {
			List<Division> divisions = journalService.getDivisionsById(journal.getId());
			if (divisions != null)
				mav.addObject("divisions", divisions);
		}
		List<ManuscriptType> manuscriptTypes = new LinkedList<ManuscriptType>();
		for(int i=0; i<ManuscriptType.values().length; i++)
			manuscriptTypes.add(ManuscriptType.getType(i));
		mav.addObject("manuscriptTypes", manuscriptTypes);

		List<ManuscriptTrack> manuscriptTracks = new LinkedList<ManuscriptTrack>();
		for(int i=0; i<ManuscriptTrack.values().length; i++)
			manuscriptTracks.add(ManuscriptTrack.getType(i));
		mav.addObject("manuscriptTracks", manuscriptTracks);
		
		List<SpecialIssue> specialIssues = specialIssueDao.findByJournalId(journal.getId());
		mav.addObject("specialIssues", specialIssues);
		
		mav.setViewName("author.submitManuscript.submitStep1");
		return mav;
	}
	
	@RequestMapping(value="/submitManuscript/step1", method=RequestMethod.POST)
	public ModelAndView step1(Model model, HttpServletRequest request,
			@RequestParam(value="manuscriptTypeId", required=true) int manuscriptTypeId,
			@RequestParam(value="manuscriptTrackId", required=true) int manuscriptTrackId,
			@RequestParam(value="specialIssueId", required=false) String specialIssueId,
			@RequestParam(value="title", required=true) String title,
			@RequestParam(value="runningHead", required=false) String runningHead,
			@RequestParam(value="paperAbstract", required=true) String paperAbstract,
			@RequestParam(value="keyword", required=false) String keywordTags,
			@RequestParam(value="invite", required=false) String invite,
			@RequestParam(value="division", required=false) String division) {
		ModelAndView mav = new ModelAndView();
		try {
			Manuscript manuscript = (Manuscript)request.getSession().getAttribute("manuscript");
			if(keywordTags != null) {
				String[] keywordString = keywordTags.trim().split(",");
				List<String> keywords = new ArrayList<String>();
				for (String s: keywordString)
					keywords.add(s);
				manuscript.setKeyword(keywords);
				manuscriptService.updateKeyword(manuscript);
			}
			
			manuscript.setManuscriptTypeId(manuscriptTypeId);
			manuscript.setManuscriptTrackId(manuscriptTrackId);
			manuscript.setTitle(title);
			manuscript.setPaperAbstract(paperAbstract);
			
			if(manuscriptTrackId == 0)
				manuscript.setSpecialIssueId(0);
			else if(manuscriptTrackId != 0 )
				manuscript.setSpecialIssueId(Integer.parseInt(specialIssueId));

			manuscript.setRunningHead(runningHead);
			if(division != null)
				manuscript.setDivisionId(Integer.parseInt(division));
			
			if(invite != null && Integer.parseInt(invite) == 1)
				manuscript.setInvite(true);
			else
				manuscript.setInvite(false);
			
			int manuscriptId = manuscript.getId();
			Title manuscriptTitle = new Title();
			manuscriptTitle.setTitle(manuscript.getTitle());
			manuscriptTitle.setManuscriptId(manuscriptId);
			manuscriptTitle.setRevisionCount(manuscript.getRevisionCount());
			if (manuscriptTitleDao.findByRevisionCountAndManuscriptId(manuscript.getRevisionCount(), manuscriptId) == null)		
				manuscriptTitleDao.insert(manuscriptTitle);
			else	
				manuscriptTitleDao.update(manuscriptTitle);
			
			RunningHead manuscriptRunningHead = new RunningHead();
			manuscriptRunningHead.setRunningHead(manuscript.getRunningHead());
			manuscriptRunningHead.setManuscriptId(manuscriptId);
			manuscriptRunningHead.setRevisionCount(manuscript.getRevisionCount());			
			if (manuscriptRunningHeadDao.findByRevisionCountAndManuscriptId(manuscript.getRevisionCount(), manuscriptId) == null)
				manuscriptRunningHeadDao.insert(manuscriptRunningHead);
			else 		
				manuscriptRunningHeadDao.update(manuscriptRunningHead);
			
			ManuscriptAbstract manuscriptAbstract = new ManuscriptAbstract();
			manuscriptAbstract.setPaperAbstract(manuscript.getPaperAbstract());
			manuscriptAbstract.setManuscriptId(manuscriptId);
			manuscriptAbstract.setRevisionCount(manuscript.getRevisionCount());			
			if (manuscriptAbstractDao.findByRevisionCountAndManuscriptId(manuscript.getRevisionCount(), manuscriptId) == null)			
				manuscriptAbstractDao.insert(manuscriptAbstract);
			else
				manuscriptAbstractDao.update(manuscriptAbstract);
			
			int currentStep = manuscript.getSubmitStep();
			if(currentStep < 1)
				manuscriptService.setStep(manuscript, 1);
			manuscriptService.update(manuscript);
			request.getSession().setAttribute("manuscript",  manuscript);
			
			RedirectView rv = new RedirectView("step2");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} catch(NullPointerException e) {
			e.printStackTrace();
		}
		return null;

	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/step2", method=RequestMethod.GET)
	public ModelAndView step2(HttpServletRequest request, HttpServletResponse response, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		if(m == null || m.getJournalId() != journal.getId()) {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}

		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i=0; i<DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		mav.addObject("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i=0; i<SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		mav.addObject("salutationDesignations", salutationDesignations);		
		
		List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
		for (int i=0; i < LocalJobTitleDesignation.values().length; i++)
			localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
		
		mav.addObject("localJobTitleDesignations", localJobTitleDesignations);
		
		Contact contact = new Contact();
		SystemUser user = new SystemUser();
		user.setContact(contact);
		mav.addObject("user", user);
		mav.setViewName("author.submitManuscript.submitStep2");
		return mav;

	}
	
	@RequestMapping(value = "/submitManuscript/step2", method=RequestMethod.POST)
	public ModelAndView step2(HttpServletRequest request, Model model,
			@RequestParam(value="way", required=false) String way) {
		ModelAndView mav = new ModelAndView();
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");

		String direction;
		if(way.equals("Back")) {
			direction = "step1";
			manuscriptService.update(m);
			request.getSession().setAttribute("manuscript", m);
		} else {
			direction = "step3";
			int currentStep = m.getSubmitStep();
			if(currentStep < 2)
				manuscriptService.setStep(m, 2);
			manuscriptService.update(m);
			request.getSession().setAttribute("manuscript", m);
		}
		RedirectView rv = new RedirectView(direction);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/step3", method=RequestMethod.GET)
	public ModelAndView step3(HttpServletRequest request, HttpServletResponse response, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript manuscript = (Manuscript)request.getSession().getAttribute("manuscript");
		if(manuscript == null || manuscript.getJournalId() != journal.getId()) {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
		
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i=0; i<DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		mav.addObject("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i=0; i<SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		mav.addObject("salutationDesignations", salutationDesignations);		
		ReviewPreference rp = new ReviewPreference();
		mav.addObject("rp", rp);
		mav.setViewName("author.submitManuscript.submitStep3");
		return mav;
	}
	
	@RequestMapping(value = "/submitManuscript/step3", method=RequestMethod.POST)
	public ModelAndView step3(HttpServletRequest request, Model model, 
			@RequestParam(value="way", required=false) String way,
			@RequestParam(value="coverLetter", required=false) String coverLetter) {
		ModelAndView mav = new ModelAndView();
		Manuscript manuscript = (Manuscript)request.getSession().getAttribute("manuscript");
		manuscript.setCoverLetter(coverLetter);
		int manuscriptId = manuscript.getId();
		CoverLetter coverLetterObject = new CoverLetter();
		coverLetterObject.setCoverLetter(manuscript.getCoverLetter());
		coverLetterObject.setManuscriptId(manuscriptId);
		coverLetterObject.setRevisionCount(manuscript.getRevisionCount());			
		if (coverLetterDao.findByRevisionCountAndManuscriptId(manuscript.getRevisionCount(), manuscriptId) == null)			
			coverLetterDao.insert(coverLetterObject);
		else
			coverLetterDao.update(coverLetterObject);

		String direction;
		if(way.equals("Back")) {
			direction = "step2";
			manuscriptService.update(manuscript);
			request.getSession().setAttribute("manuscript", manuscript);
		} else {
			direction = "step4";
			int currentStep = manuscript.getSubmitStep();
			if(currentStep < 3)
				manuscriptService.setStep(manuscript, 3);
			manuscriptService.update(manuscript);
			request.getSession().setAttribute("manuscript", manuscript);
		}
		RedirectView rv = new RedirectView(direction);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/submitManuscript/step4", method=RequestMethod.GET)
	public ModelAndView step4(HttpServletRequest request, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript manuscript = (Manuscript)request.getSession().getAttribute("manuscript");
		if(manuscript == null || manuscript.getJournalId() != journal.getId()) {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
		
		List<FileDesignation> fileDesignations = new LinkedList<FileDesignation>();
		if(manuscript.getRevisionCount() == 0) {
			for(int i=0; i<FileDesignation.values().length; i++)
				if(i != 1) fileDesignations.add(FileDesignation.getType(i));
		} else
			for(int i=0; i<FileDesignation.values().length; i++)
				fileDesignations.add(FileDesignation.getType(i));
		

		mav.addObject("fileDesignations", fileDesignations);
		mav.setViewName("author.submitManuscript.submitStep4");
		return mav;
	}
	
	@RequestMapping(value="/submitManuscript/step4", method=RequestMethod.POST)
	public ModelAndView  step4(Model model, HttpServletRequest request,
			@RequestParam(value="way", required=false) String way) {
		ModelAndView mav = new ModelAndView();
		Manuscript manuscript = (Manuscript)request.getSession().getAttribute("manuscript");
		String direction;
		if(way.equals("Back"))
			direction = "step3";
		else {
			direction = "step5";
			int currentStep = manuscript.getSubmitStep();
			if(currentStep < 4)
				manuscriptService.setStep(manuscript, 4);
			manuscriptService.update(manuscript);
			request.getSession().setAttribute("manuscript", manuscript);
			
		}
		RedirectView rv = new RedirectView(direction);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/submitManuscript/step5", method=RequestMethod.GET)
	public ModelAndView step5(HttpServletRequest request) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		ModelAndView mav = new ModelAndView();
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		if(m == null || m.getJournalId() != journal.getId()) {
			RedirectView rv = new RedirectView("../");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		request.getSession().setAttribute("manuscript", m);
		mav.setViewName("author.submitManuscript.submitStep5");
		return mav;
	}
	
	@RequestMapping(value="/submitManuscript/step5", method=RequestMethod.POST)
	public ModelAndView  step5(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="way", required=false) String way,
			@RequestParam(value="confirm1", required=false) String confirm1,
			@RequestParam(value="confirm2", required=false) String confirm2,
			@RequestParam(value="confirm3", required=false) String confirm3,
			@RequestParam(value="confirm4", required=false) String confirm4,
			@RequestParam(value="confirm5", required=false) String confirm5) {
		ModelAndView mav = new ModelAndView();
		String direction;
		if(way.equals("Back"))
			direction = "step4";
		else  {
			direction = "../"; 
			Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			
			if(confirm1 != null && confirm1.equals("confirmed")) m.setConfirm1(true);
			if(confirm2 != null && confirm2.equals("confirmed")) m.setConfirm2(true);
			if(confirm3 != null && confirm3.equals("confirmed")) m.setConfirm3(true);
			if(confirm4 != null && confirm4.equals("confirmed")) m.setConfirm4(true);
			if(confirm5 != null && confirm5.equals("confirmed")) m.setConfirm5(true);
			
			int currentStep = m.getSubmitStep();
			if(currentStep < 5)
				manuscriptService.setStep(m, 5);
			
			m.setUserId(user.getId());
			manuscriptService.update(m);
			manuscriptService.submitAction(m, (Journal)request.getSession().getAttribute("journal"), request, locale);
			request.getSession().removeAttribute("manuscript");
			
		}
		RedirectView rv = new RedirectView(direction);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value = "/submitManuscript/signupCoAuthor", method=RequestMethod.POST)
	public @ResponseBody Boolean submitUserForm(@ModelAttribute("user") SystemUser user, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model) {
		if (result.hasErrors())
			return false;
		else {
			user.setEnabled(false);
			String pw = userService.generatePassword(8);
			user.setPassword(pw);
			Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
			coAuthorService.createCoAuthor(user, m, false, true, pw);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/coAuthorTable", method=RequestMethod.GET)
	public ModelAndView coAuthorTable(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		List<CoAuthor> coAuthors = coAuthorService.getCoAuthors(m.getId(), m.getRevisionCount(), 0, false);
		mav.addObject("coAuthors", coAuthors);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		mav.setViewName("author.submitManuscript.coAuthorTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/coAuthorCandidateTable", method=RequestMethod.GET)
	public ModelAndView coAuthorCandidateTable(HttpServletRequest request,
			@RequestParam(value="q", required=false) String q) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		Map<String, String> paramValues = null;
		List<String> emailList = null;
		List<SystemUser> candidateUsers = null;
		if(q != null && !q.equals("")) {
			paramValues = new HashMap<String, String>();
			emailList = new ArrayList<String>();

			List<CountryCode> countries = countryCodeDao.findCountriesLikeSpecificName(q);
			for(CountryCode cc: countries)
				paramValues.put("country_code", cc.getAlpha2());

			emailList.add(q);
			paramValues.put("FIRST_NAME", q);
			paramValues.put("LAST_NAME", q);
			paramValues.put("LOCAL_FULL_NAME", q);
			paramValues.put("INSTITUTION", q);
			mav.addObject("q", q);
			candidateUsers = coAuthorService.getCoAuthorCandidateUsers(m, journal.getId(), emailList, paramValues);
		} else
			mav.addObject("q", "");
		
		mav.addObject("candidateUsers", candidateUsers);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		mav.setViewName("author.submitManuscript.coAuthorCandidateTable");
		return mav;
	}
	
	@RequestMapping(value = "/submitManuscript/setAuthorOrder", method=RequestMethod.POST)
	public @ResponseBody Boolean setAuthorOrder(HttpServletRequest request,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		Enumeration<String> eParam = request.getParameterNames();
		while (eParam.hasMoreElements()) {
			String pName = eParam.nextElement();
			if(pName.substring(0, 5).equals("user_")) {
				String userIdString = pName.replace("user_", "");
				int userId = Integer.parseInt(userIdString);
				String pValue = request.getParameter(pName);
				int authorOrder = Integer.parseInt(pValue);
				coAuthorService.setCoAuthorOrder(m, userId, authorOrder);
			} else if(pName.equals("corresponding")) {
				String userIdString = request.getParameter(pName);
				int userId = Integer.parseInt(userIdString);
				coAuthorService.setCorrespondingAuthor(m, userId, true);
			}
		}
		request.getSession().setAttribute("manuscript", m);
		return true;
	}
	
	@RequestMapping(value = "/submitManuscript/selectCoAuthor", method=RequestMethod.POST)
	public @ResponseBody Boolean selectCoAuthor(HttpServletRequest request, Model model, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="userId", required=true) int userId) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		coAuthorService.selectCoAuthor(userId, m);
		
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return true;
	}
	
	@RequestMapping(value = "/submitManuscript/deleteCoAuthor", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteCoAuthor(HttpServletRequest request, Model model, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="userId", required=true) int userId) {
		
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		coAuthorService.deleteCoAuthor(userId, m);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/rpTable", method=RequestMethod.GET)
	public ModelAndView rpTable(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		List<ReviewPreference> rps = rpService.getReviewPreferences(m.getId(), m.getRevisionCount());
		mav.addObject("rps", rps);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		mav.setViewName("author.submitManuscript.rpTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/rpCandidateTable", method=RequestMethod.GET)
	public ModelAndView rpCandidateTable(HttpServletRequest request,
			@RequestParam(value="q", required=false) String q) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		Map<String, String> paramValues = null;
		List<String> emailList = null;
		List<SystemUser> candidateRps = null;
		if(q != null && !q.equals("")) {
			paramValues = new HashMap<String, String>();
			emailList = new ArrayList<String>();

			List<CountryCode> countries = countryCodeDao.findCountriesLikeSpecificName(q);
			for(CountryCode cc: countries)
				paramValues.put("country_code", cc.getAlpha2());

			emailList.add(q);
			paramValues.put("FIRST_NAME", q);
			paramValues.put("LAST_NAME", q);
			paramValues.put("INSTITUTION", q);
			paramValues.put("LOCAL_FULL_NAME", q);
			mav.addObject("q", q);
			candidateRps = rpService.getReviewerCandidateContacts(m.getId(), journal.getId(), emailList, paramValues);
		} else
			mav.addObject("q", "");
		
		mav.addObject("candidateRps", candidateRps);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		mav.setViewName("author.submitManuscript.rpCandidateTable");
		return mav;
	}
	
	@RequestMapping(value = "/submitManuscript/addReviewerPreference", method=RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean addReviewer(@ModelAttribute("Rp") ReviewPreference rp, 
							 	 BindingResult result, 
							 	 HttpServletRequest request) {
		if (result.hasErrors())
			return false;
		else {
			Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
			m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
			List<ReviewPreference> rpList = m.getReviewPreferences();
			if(rpList == null)
				rpList = new ArrayList<ReviewPreference>();
			
			rp.setManuscriptId(m.getId());
			rp.setRevisionCount(m.getRevisionCount());
			rpList.add(rp);
			m.setReviewPreferences(rpList);
			rpService.createReviewPreference(rp);
			manuscriptService.update(m);
			request.getSession().setAttribute("manuscript", m);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/rpCount", method=RequestMethod.GET)
	public @ResponseBody String rpCount(HttpServletRequest request, Model model) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		int rpCount = rpService.numReviewPreferences(m.getId(), m.getRevisionCount());
		model.addAttribute("rpCount", rpCount);
		return Integer.toString(rpCount);
	}
	
	@RequestMapping(value = "/submitManuscript/selectRp", method=RequestMethod.POST)
	public @ResponseBody Boolean selectRp(HttpServletRequest request, Model model, 
			@RequestParam(value="rpUserId", required=true) String rpUserId) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		rpService.selectReviewPreference(Integer.parseInt(rpUserId), m);
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return true;
	}
	
	@RequestMapping(value = "/submitManuscript/deleteRp", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteRp(HttpServletRequest request, Model model, 
			@RequestParam(value="rpId", required=true) String rpId) {
		rpService.deleteReviewPreference(Integer.parseInt(rpId));
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return true;
	}

	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/uploadedFileTable", method=RequestMethod.GET)
	public String uploadedFileTable(HttpServletRequest request) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return "author.submitManuscript.uploadedFileTable";
		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/additionalUploadedFileTable", method=RequestMethod.GET)
	public String additionalUploadedFileTable(HttpServletRequest request, Model model) {
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		m = manuscriptService.getManuscriptById(m.getId(), SystemConstants.VIEW_BUILD);
		request.getSession().setAttribute("manuscript", m);
		return "author.submitManuscript.additionalUploadedFileTable";
		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/submitManuscript/validateFileCount", method=RequestMethod.GET)
	public @ResponseBody Boolean uploadedFileCoun(HttpServletRequest request, Model model) {
		Manuscript m  = (Manuscript)request.getSession().getAttribute("manuscript");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int uploadCount = -1;
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<FileDesignation.values().length; i++)
			designations.add(FileDesignation.getType(i).name());
			
		uploadCount = fileService.numFileUploadedCount(m, designations);
		if(uploadCount == 0)
			return false;
		else {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			if(m.getRevisionCount() == 0 || jc.isChangeAdditionalFiles()) {
				if(jc.getFrontCoverUrl() != null && !jc.getFrontCoverUrl().trim().equals("")) {
					designations = new ArrayList<String>();
					designations.add(SystemConstants.fileTypeFC);
					int additionalUploadCount = fileService.numFileUploadedCount(m, designations);
					if(additionalUploadCount == 0)
						return false;
				} 
				if(jc.getCheckListUrl() != null && !jc.getCheckListUrl().trim().equals("")) {
					designations = new ArrayList<String>();
					designations.add(SystemConstants.fileTypeCHK);
					int additionalUploadCount = fileService.numFileUploadedCount(m, designations);
					if(additionalUploadCount == 0)
						return false;
				}
			}
		}
		return true;
	}
	
	@RequestMapping(value="/submitManuscript/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean upload(HttpServletRequest request, Principal principal, MultipartHttpServletRequest req, 
			@RequestParam(value="fileDesignationId") int fileDesignationId,
			@PathVariable(value="jnid") String jnid) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		String designation = FileDesignation.getType(fileDesignationId).name();
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		try {
			fileService.processManuscriptFile(f, jnid, m, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@RequestMapping(value="/submitManuscript/additionalUpload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean upload(HttpServletRequest request, Principal principal, MultipartHttpServletRequest req, 
			@RequestParam(value="designation") String designation,
			@PathVariable(value="jnid") String jnid) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Manuscript m = (Manuscript)request.getSession().getAttribute("manuscript");
		try {
			fileService.processManuscriptFile(f, jnid, m, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/getPapers/{pageType}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String myPapers(Model model, HttpServletRequest request, Locale locale, 
			@PathVariable(value="pageType") String pageType) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> status = new ArrayList<String>();
		List<Manuscript> manuscripts = null;
		
		if(pageType.equals("beingSubmitted")) {
			status.add(SystemConstants.statusB);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("submitted")) {
			
			status.add(SystemConstants.statusI);
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB))
				status.add(SystemConstants.statusO);
			
			status.add(SystemConstants.statusR);
			status.add(SystemConstants.statusE);
			
			if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeC))
				status.add(SystemConstants.statusV);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("revisionRequested")) {
			status.add(SystemConstants.statusD);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("REVISION_DUE_DATE");
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("accepted")) {
			String[] statusArray = {SystemConstants.statusA, SystemConstants.statusM, SystemConstants.statusG};
			
			for(String s: statusArray)
				status.add(s);
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add(null);
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("published")) {
			String[] statusArray = {SystemConstants.statusP};
			
			for(String s: statusArray)
				status.add(s);
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("withdrawn")) {
			String[] statusArray = {SystemConstants.statusJ, SystemConstants.statusW};
			
			for(String s: statusArray)
				status.add(s);
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("EVENT_DATE");
			sortableColumnNames.add("STATUS");
			
			manuscripts = manuscriptService.getCoWrittenManuscripts(user.getId(), journal.getId(), status, true, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		}

		List<Manuscript> filteredManuscripts = null;
		if(pageType.equals("submitted") || pageType.equals("revisionRequested")) {
			if(dRequest.getiSortCol()[0] == 4) {
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
			
		} else if(pageType.equals("accepted")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;
						}
					}
				});
			} else if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else
								return 0;
						}
					}
				});
				
			}
		} else if(pageType.equals("published")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;
						}
					}
				});
			} else if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusP) != null && o2.getLastEventDateTime(SystemConstants.statusP) != null)
								return o1.getLastEventDateTime(SystemConstants.statusP).compareTo(o2.getLastEventDateTime(SystemConstants.statusP));
							else if(o1.getLastEventDateTime(SystemConstants.statusP) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusP) == null)
								return -1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusP) != null && o2.getLastEventDateTime(SystemConstants.statusP) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusP).compareTo(o2.getLastEventDateTime(SystemConstants.statusP));
							else if(o1.getLastEventDateTime(SystemConstants.statusP) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusP) == null)
								return 1;
							else
								return 0;
						}
					}
				});
			}
		} else if(pageType.equals("withdrawn")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;
						}
					}
				});
			} else 	if(dRequest.getiSortCol()[0] == 5) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						EventDateTime compareDateTime1 = null;
						EventDateTime compareDateTime2 = null;
						if(o1.getStatus().equals(SystemConstants.statusW))
							compareDateTime1 = o1.getLastEventDateTime(SystemConstants.statusW);
						else if(o1.getStatus().equals(SystemConstants.statusJ))
							compareDateTime1 = o1.getLastEventDateTime(SystemConstants.statusJ);
						
						if(o2.getStatus().equals(SystemConstants.statusW))
							compareDateTime2 = o2.getLastEventDateTime(SystemConstants.statusW);
						else if(o2.getStatus().equals(SystemConstants.statusJ))
							compareDateTime2 = o2.getLastEventDateTime(SystemConstants.statusJ);
						if (dRequest.getsSortDir()[0].equals("asc")) {

							if(compareDateTime1 != null && compareDateTime2 != null)
								return compareDateTime1.compareTo(compareDateTime2);
							else if(compareDateTime1 == null)
								return 1;
							else if(compareDateTime2 == null)
								return -1;
							else
								return 0;

						} else {
							if(compareDateTime1 != null && compareDateTime2 != null)
								return -1 * compareDateTime1.compareTo(compareDateTime2);
							else if(compareDateTime1 == null)
								return -1;
							else if(compareDateTime2 == null)
								return 1;
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
		int i = 0, index = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer actionStringBuffer = new StringBuffer();
		
		for (Manuscript m: filteredManuscripts) {
			dResponse.setAaData(i, index++, Integer.toString(number));
			if(pageType.equals("beingSubmitted"))
				dResponse.setAaData(i, index++, Integer.toString(m.getId()));	//TemporaryId
			else {
				if(m.getSubmitId() != null)
					dResponse.setAaData(i, index++, m.getSubmitId());	//SubmitId
				else
					dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.beingAssigned", null , locale));
			}
			SystemUser submitter = userService.getById(m.getUserId());
			String submitterString = null;
			if(journal.getLanguageCode().equals("ko") && submitter.getContact().getLocalFullName() != null && !submitter.getContact().getLocalFullName().equals(""))
				submitterString = submitter.getContact().getLocalFullName();
			else
				submitterString = submitter.getContact().getFirstName() + "<br/>" + submitter.getContact().getLastName();
			dResponse.setAaData(i, index++, submitterString);
			
			if(m.getTitle() == null)
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else {
				String invitedString = "";
				if(m.isInvite())
					invitedString  = "<span class='required'>*</span>(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
				String titleUrl = "<a onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"summary\");'>" + invitedString + m.getTitle() + "</a>";

				dResponse.setAaData(i, index++, titleUrl);
			}
			
			String dateString = null;
			if(pageType.equals("submitted") || pageType.equals("revisionRequested")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusI).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
				
				if(pageType.equals("revisionRequested")) {
					if(m.getRevisionDueDate() != null && m.getRevisionDueTime() != null)
						dResponse.setAaData(i, index++, m.getRevisionDueDate().toString());
					else
						dResponse.setAaData(i, index++, null);
				}
			} else if(pageType.equals("accepted")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusI).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
				
				if(m.getLastEventDateTime(SystemConstants.statusA) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusA).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
			} else if(pageType.equals("published")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusI).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
				
				if(m.getLastEventDateTime(SystemConstants.statusP) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusP).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
			} else  if(pageType.equals("withdrawn")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dateString = m.getLastEventDateTime(SystemConstants.statusI).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
				if(m.getStatus().equals(SystemConstants.statusW)) {
					if(m.getLastEventDateTime(SystemConstants.statusW) != null)
						dateString = m.getLastEventDateTime(SystemConstants.statusW).getDate().toString();
				} else if(m.getStatus().equals(SystemConstants.statusJ)) {
					if(m.getLastEventDateTime(SystemConstants.statusJ) != null)
						dateString = m.getLastEventDateTime(SystemConstants.statusJ).getDate().toString();
				}
				dResponse.setAaData(i, index++, dateString);
				
			}

			if(pageType.equals("accepted") || pageType.equals("published")) {
				List<Integer> coAuthorIds = coAuthorService.getCoAuthorIds(m.getId(), m.getRevisionCount(), 0, false);
				List<Comment> comments = commentDao.findAuthorComments(m.getId(), coAuthorIds);
				int relatedCount = 0;
				for(Comment comment: comments) {
					if(comment.getFromRole().equals(SystemConstants.roleManager) || comment.getToRole().equals(SystemConstants.roleManager))
						relatedCount++;
				}
				
				if(relatedCount > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
			}
			
			if(!pageType.equals("beingSubmitted") && !pageType.equals("published")) {
				String statusString = systemUtil.getStatusDatatableLabel(m.getStatus(), locale);
				dResponse.setAaData(i, index++, statusString);
			}
			if(pageType.equals("beingSubmitted")) {
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135 marginBottom10' onClick='submit(" + m.getId() + ");'/>" + 
											messageSource.getMessage("author.action.composeAndSubmit", null, locale) + "</button>");
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='discard(" + m.getId() + ");'/>" +
											messageSource.getMessage("system.discard", null, locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("submitted")) {
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='withdraw(" + m.getId() + ");'/>" +
												messageSource.getMessage("system.withdraw", null, locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("revisionRequested")) {
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135 marginBottom10' onClick='submit(" + m.getId() + ");'/>" +
											messageSource.getMessage("author.action.composeAndSubmit", null, locale) + "</button>");
				if(!m.isDueDateExtendRequest()) {
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135 marginBottom10' onClick='extendDueDate(" + m.getId() + ");'/>" +
							messageSource.getMessage("author.action.extendDueDate", null, locale) + "</button>");
				}
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='withdraw(" + m.getId() + ");'/>" + 
											messageSource.getMessage("system.withdraw", null, locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("accepted")) {
				if(m.getStatus().equals(SystemConstants.statusA)) {
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135 marginBottom10' onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"cameraReady\");'/>" +
												messageSource.getMessage("author.action.submitCameraReady", null, locale) + "</button>");
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='withdraw(" + m.getId() + ");'/>" + 
												messageSource.getMessage("system.withdraw", null, locale) + "</button>");
				} else if(m.getStatus().equals(SystemConstants.statusG) && !m.isGalleryProofConfirm())
					actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"galleryProof\");'/>" + 
												messageSource.getMessage("author.action.checkGalleryProof", null, locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				else
					dResponse.setAaData(i, index++, null);
			}

			actionStringBuffer.delete(0, actionStringBuffer.length());
			i++;
			number++;
			index = 0;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}

	@RequestMapping(value="/manuscripts/discard", method=RequestMethod.POST)
	public @ResponseBody Boolean discardPaper(HttpServletRequest request, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		manuscriptService.discardManuscript(manuscriptId);
		return true;
	}
	
	@RequestMapping(value="/manuscripts/withdraw", method=RequestMethod.POST)
	public @ResponseBody Boolean withdrawPaper(HttpServletRequest request, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		manuscriptService.withdrawManuscript(manuscriptId);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/cameraReady/cameraReady", method=RequestMethod.GET)
	public String cameraReady(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		model.addAttribute("manuscript", m);
		
		List<CameraReadyFileDesignation> cameraReadyFileDesignations = new LinkedList<CameraReadyFileDesignation>();
		for(int i=0; i<CameraReadyFileDesignation.values().length; i++)
			cameraReadyFileDesignations.add(CameraReadyFileDesignation.getType(i));

		model.addAttribute("fileDesignations", cameraReadyFileDesignations);
		model.addAttribute("pageType", pageType);
		return "author.manuscripts.cameraReady.cameraReady";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/cameraReady/uploadedFileTable", method=RequestMethod.GET)
	public String cameraReadyUploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<CameraReadyFileDesignation.values().length; i++)
			designations.add(CameraReadyFileDesignation.getType(i).name());
		
		List<UploadedFile> cameraReadyFiles = fileService.getFilesUploadedByCoAuthors(manuscriptId, designations);
		int maxRevision = 0;
		for(UploadedFile f: cameraReadyFiles)
			if(f.getCameraReadyRevision() > maxRevision)
				maxRevision = f.getCameraReadyRevision();
		
		List<Integer> revisionIndices = new ArrayList<Integer>();
		for(int i=maxRevision; i>=0; i--)
			revisionIndices.add(i);
		model.addAttribute("revisionIndices", revisionIndices);
		model.addAttribute("maxRevision", maxRevision);
		model.addAttribute("cameraReadyFiles", cameraReadyFiles);
		model.addAttribute("manuscript", m);
		List<Integer> coAuthorIds = coAuthorService.getCoAuthorIds(m.getId(), m.getRevisionCount(), 0, false);
		List<Comment> comments = commentDao.findAuthorComments(m.getId(), coAuthorIds);
		if(comments != null)
			Collections.sort(comments);
		model.addAttribute("comments", comments);
		model.addAttribute("pageType", pageType);
		return "author.manuscripts.cameraReady.uploadedFileTable";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/cameraReady/uploadedFileCount", method=RequestMethod.GET)
	public @ResponseBody String cameraReadyUploadedFileCount(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<3; i++)
			designations.add(CameraReadyFileDesignation.getType(i).name());
		
		int uploadCount = fileService.numCameraReadyFileUploadedCount(m, designations);
		return Integer.toString(uploadCount);
	}
	
	@RequestMapping(value="/manuscripts/cameraReady/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean cameraReadyUpload(HttpServletRequest request, 
			Principal principal, 
			MultipartHttpServletRequest req, 
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="fileDesignationId") int fileDesignationId,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		try {
			String designation = CameraReadyFileDesignation.getType(fileDesignationId).name();
			fileService.processManuscriptFile(f, jnid, m, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@RequestMapping(value="/manuscripts/cameraReady/confirm", method=RequestMethod.POST)
	public @ResponseBody Boolean cameraReadyConfirm(HttpServletRequest request, Locale locale, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		manuscriptService.cameraReadyConfirm(manuscript, journal, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/galleryProof/galleryProof", method=RequestMethod.GET)
	public String galleryProof(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<String> designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeG);
		List<UploadedFile> galleryProofFiles = fileService.getFiles(manuscriptId, m.getManagerUserId(), m.getRevisionCount(), designations);
		int maxRevision = 0;
		for(UploadedFile f: galleryProofFiles)
			if(f.getGalleryProofRevision() > maxRevision)
				maxRevision = f.getGalleryProofRevision();
		List<Integer> revisionIndices = new ArrayList<Integer>();
		for(int i=maxRevision; i>=0; i--)
			revisionIndices.add(i);
		model.addAttribute("revisionIndices", revisionIndices);
		model.addAttribute("maxRevision", maxRevision);
		
		model.addAttribute("galleryProofFiles", galleryProofFiles);
		model.addAttribute("manuscript", m);
		List<Integer> coAuthorIds = coAuthorService.getCoAuthorIds(m.getId(), m.getRevisionCount(), 0, false);
		List<Comment> comments = commentDao.findAuthorComments(m.getId(), coAuthorIds);
		if(comments != null)
			Collections.sort(comments);
		model.addAttribute("comments", comments);
		designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeA);
		List<UploadedFile> galleryProofCorrectionFiles = fileService.getFilesUploadedByCoAuthors(manuscriptId, designations);
		model.addAttribute("galleryProofCorrectionFiles", galleryProofCorrectionFiles);
		model.addAttribute("pageType", pageType);
		return "author.manuscripts.galleryProof.galleryProof";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/additionalCorrection/uploadedFileTable", method=RequestMethod.GET)
	public String galleryProofUploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<String> designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeA);
		List<UploadedFile> additionalCorrectionFiles = fileService.getFilesUploadedByCoAuthors(manuscriptId, designations);
		model.addAttribute("additionalCorrectionFiles", additionalCorrectionFiles);
		model.addAttribute("manuscript", m);
		return "author.manuscripts.galleryProof.uploadedFileTable";
	}
	
	@RequestMapping(value="/manuscripts/additionalCorrection/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean galleryProofUpload(HttpServletRequest request, 
			Principal principal, 
			MultipartHttpServletRequest req, 
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		try {
			fileService.processManuscriptFile(f, jnid, m, SystemConstants.fileTypeA);
			List<String> designations = new ArrayList<String>();
			designations.add(SystemConstants.fileTypeA);
			List<UploadedFile> files = fileService.getFilesUploadedByCoAuthors(m.getId(), designations);
			int fileCount = 1;
			for (UploadedFile file : files) {
				file.setConfirm(true);
				int pos = file.getOriginalName().lastIndexOf( "." );
				String ext = file.getOriginalName().substring(pos + 1);
				
				String prefix = "GalleryProofCorrection-" + fileCount;
				String revision = null;
				if(file.getGalleryProofRevision() == 0)
					revision = "ReplyToGalleryProof-Original";
				else
					revision = "ReplyToGalleryProof-Revision-" + file.getGalleryProofRevision();
				String newName = prefix + "-[" + m.getSubmitId() + "]-" + revision + "." + ext;
				fileService.rename(file, journal.getJournalNameId(), newName, m.getSubmitId());
				fileService.update(file);
				fileCount++;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@RequestMapping(value = "/manuscripts/galleryProof/confirm", method=RequestMethod.POST)
	public @ResponseBody Boolean galleryProofConfirm(HttpServletRequest request, Model model, Locale locale, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		manuscript.setGalleryProofConfirm(true);
		manuscriptService.update(manuscript);
		
		emailService.sendEmail(48, manuscript, journal, null, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/galleryProof/returnBack", method=RequestMethod.GET)
	public String galleryProofReturnBack(HttpServletRequest request, Model model, Locale locale, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		model.addAttribute("manuscript", manuscript);
		Comment comment = new Comment();
		model.addAttribute("comment", comment);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(47, manuscript, journal, null, request, locale);
		model.addAttribute("emailMessage", emailMessage);
		return "author.manuscripts.galleryProof.returnBackEmailForm";
	}
	
	@RequestMapping(value = "/manuscripts/galleryProof/returnBack", method=RequestMethod.POST)
	public @ResponseBody ModelAndView galleryProofReturnBack(@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="subject", required=true) String subject, 
			@RequestParam(value="body", required=true) String body, 
			@ModelAttribute Comment comment, 
			BindingResult result, 
			HttpServletRequest request, Locale locale,
			Model model) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			comment.setJournalId(manuscript.getJournalId());
			comment.setFromRole(SystemConstants.roleMember);
			comment.setToRole(SystemConstants.roleManager);
			comment.setFromUserId(user.getId());
			comment.setToUserId(manuscript.getManagerUserId());
			comment.setRevisionCount(manuscript.getRevisionCount());
			comment.setScopeManager(1);
			comment.setStatus(SystemConstants.statusG);
			comment.setGalleryProofRevision(manuscript.getGalleryProofRevision());
			commentDao.insert(comment);
			manuscript.setStatus(SystemConstants.statusM);
			manuscript.setGalleryProofRevision(manuscript.getGalleryProofRevision() + 1);
			manuscriptService.update(manuscript);
			
			EmailMessage emailMessage = new EmailMessage();
			body = body.replace("[comments]", comment.getText());
			emailMessage.setSubject(subject);
			emailMessage.setBody(body);
			emailService.sendEmail(47, manuscript, journal, emailMessage, request, locale);
			RedirectView rv = new RedirectView("../../manuscripts?pageType=accepted");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/extendDueDate", method=RequestMethod.GET)
	public ModelAndView extendDueDate(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(36, manuscript, journal, null, request, locale);
		mav.addObject("journal", journal);
		mav.addObject("emailMessage", emailMessage);
		SimpleDateFormat sdf = null;
		if(journal.getLanguageCode().equals("ko"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		
		String defaultDueDate = sdf.format(manuscript.getRevisionDueDate());
		
		mav.addObject("defaultDueDate", defaultDueDate);
		mav.setViewName("author.manuscripts.dueDateEmailForm");
		return mav;
	}
	
	@RequestMapping(value="/manuscripts/extendDueDate", method=RequestMethod.POST)
	public @ResponseBody ModelAndView extendDueDate(Model model, HttpServletRequest request, Locale locale,
			@ModelAttribute("emailMessage") EmailMessage emailMessage, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @RequestParam(value="dateString", required=true) String dateString, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			manuscriptService.extendDueDate(emailMessage, manuscript, journal, request, locale, dateString);
			RedirectView rv = new RedirectView("../manuscripts?pageType=revisionRequested");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "author";
	}
}
