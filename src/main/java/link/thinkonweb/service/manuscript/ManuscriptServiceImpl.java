package link.thinkonweb.service.manuscript;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.manuscript.AbstractDao;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.CoverLetterDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.RunningHeadDao;
import link.thinkonweb.dao.manuscript.TitleDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.ContactDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.CoverLetter;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ManuscriptAbstract;
import link.thinkonweb.domain.manuscript.RunningHead;
import link.thinkonweb.domain.manuscript.Title;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.roles.ManagerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserExpertiseService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

public class ManuscriptServiceImpl implements ManuscriptService {
	@SuppressWarnings("unused")
	private Log log = LogFactory.getLog(ManuscriptServiceImpl.class);
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private FileService fileService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private ManagerService managerService;
	@Autowired
	private UserExpertiseService userExpertiseService;
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private KeywordDao keywordDao;
	@Autowired
	private TitleDao titleDao;
	@Autowired
	private CoverLetterDao coverLetterDao;
	@Autowired
	private RunningHeadDao runningHeadDao;
	@Autowired
	private AbstractDao abstractDao;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private SpecialIssueDao specialIssueDao;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	
	@Override
	public int init(int userId, int journalId) {
		Manuscript manuscript = new Manuscript();
		int manuscriptId = manuscriptDao.insert(manuscript);
		SystemUser user = userService.getById(userId);

		CoAuthor i = new CoAuthor();
		i.setUserId(userId);
		i.setAuthorOrder(1);
		i.setManuscriptId(manuscriptId);
		i.setCorresponding(true);
		i.setUser(user);
		i.setRevisionCount(manuscript.getRevisionCount());
		coAuthorDao.insert(i);
		
		manuscript.setUserId(userId);
		manuscript.setId(manuscriptId);
		manuscript.setJournalId(journalId);
		eventDateTimeDao.insert(generateEventDateTime(manuscript));
		manuscriptDao.update(manuscript);
		
		return manuscriptId;
	}
	
	@Override
	public Manuscript getManuscriptById(int id, int level) {
		Manuscript manuscript =  manuscriptDao.findById(id);
		return manuscriptBuilder.build(manuscript, level);
	}
	
	
	@Override
	public void setStep(Manuscript manuscript, int step) {
		manuscript.setSubmitStep(step);
		this.update(manuscript);
	}
	
	@Override
	public void updateKeyword(Manuscript manuscript) {		
		List<String> keywords = manuscript.getKeyword();
		int manuscriptId = manuscript.getId();
		keywordDao.deleteByManuscriptIdAndRevisionCount(manuscriptId, manuscript.getRevisionCount());
		for (String keyword : keywords) {
			if (!keyword.trim().equals("")) {
				keyword = keyword.trim();
				Keyword manuscriptKeyword = new Keyword();
				manuscriptKeyword.setKeyword(keyword);
				manuscriptKeyword.setManuscriptId(manuscriptId);
				manuscriptKeyword.setJournalId(manuscript.getJournalId());
				manuscriptKeyword.setUserId(manuscript.getUserId());
				manuscriptKeyword.setRevisionCount(manuscript.getRevisionCount());
				if (keywordDao.findKeyword(manuscriptKeyword.getKeyword(), manuscriptKeyword.getManuscriptId(), manuscriptKeyword.getRevisionCount()) == null)
					keywordDao.insert(manuscriptKeyword);
				else
					keywordDao.update(manuscriptKeyword);
			}			
		}
	}
	
	@Override
	public void discardManuscript(int manuscriptId) {
		List<UploadedFile> files = fileService.getFiles(manuscriptId, 0, -1, null);
		for(UploadedFile uf: files)
			fileService.delete(uf.getId(), uf.getDesignation());
		
		manuscriptDao.delete(manuscriptId);
	}
	
	@Override
	public void withdrawManuscript(int manuscriptId) {
		Manuscript m = this.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		m.setStatus(SystemConstants.statusW);
		eventDateTimeDao.insert(this.generateEventDateTime(m));
		this.update(m);
	}
	
	@Override
	public void cameraReadyConfirm(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		manuscript.setStatus(SystemConstants.statusM);
		eventDateTimeDao.insert(this.generateEventDateTime(manuscript));
		this.update(manuscript);
		manuscript = manuscriptBuilder.build(manuscript, SystemConstants.EMAIL_BUILD);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(42, manuscript, journal, manuscript.getSubmitter().getUsername(), request, locale);
		emailService.sendEmailToAuthorsWithMessageModification(42, manuscript, journal, emailMessage, request, locale);
		emailService.sendEmail(43, manuscript, journal, null, request, locale);
	}
	
	@Override
	public void submitAction(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		int journalId = journal.getId();
		SystemUser submitter = userService.getById(manuscript.getUserId());
		List<CoAuthor> coAuthors = manuscript.getCoAuthors();
		for(CoAuthor coAuthor: coAuthors) {
			if(coAuthor.getRevisionCount() == manuscript.getRevisionCount()) {
				SystemUser coAuthorUser = userService.getById(coAuthor.getUserId());
				if(!coAuthorUser.isEnabled()) {
					coAuthorUser.setEnabled(true);
					userDao.update(coAuthorUser);
				}
				if(authorityService.getAuthorities(coAuthor.getUserId(), journalId, SystemConstants.roleMember) == null)
					authorityService.create(coAuthor.getUserId(), journalId, SystemConstants.roleMember);
				
				if(coAuthor.isCreatedMember()) {
					emailService.sendEmailAtAccountCreation(51, submitter, coAuthorUser, journal, coAuthor.getTemporaryPassword(), request, locale);
					coAuthor.setTemporaryPassword(null);
					coAuthor.setCreatedMember(false);
					coAuthorDao.update(coAuthor);
				}
			}
		}
		
		List<String> keywordString = manuscript.getKeyword();
		for(String keyword: keywordString) {
			keyword = systemUtil.capitalize(keyword);
			for(CoAuthor coAuthor: coAuthors) {
				if(!userExpertiseService.hasUserExpertise(coAuthor.getUserId(), keyword)) {
					UserExpertise ue = new UserExpertise();
					ue.setExpertise(keyword);
					ue.setUserId(coAuthor.getUserId());
					userExpertiseService.insertExpertise(ue);
				}
			}
		}
		
		String coverLetterHtml = manuscript.getCoverLetterHtml();
		manuscript.setCoverLetter(coverLetterHtml);
		CoverLetter coverLetterObject = new CoverLetter();
		coverLetterObject.setCoverLetter(coverLetterHtml);
		coverLetterObject.setManuscriptId(manuscript.getId());
		coverLetterObject.setRevisionCount(manuscript.getRevisionCount());			
		if (coverLetterDao.findByRevisionCountAndManuscriptId(manuscript.getRevisionCount(), manuscript.getId()) == null)			
			coverLetterDao.insert(coverLetterObject);
		else
			coverLetterDao.update(coverLetterObject);
		
		if (manuscript.getStatus().equals(SystemConstants.statusB)) {
			manuscript.setStatus(SystemConstants.statusI);
			eventDateTimeDao.insert(generateEventDateTime(manuscript));
			List<EventDateTime> edtList = eventDateTimeDao.findEventDatesByManuscriptId(manuscript.getId());
			manuscript.setEventDateTimes(edtList);
			manuscript.setLastEventDateTimes(edtList);
			emailService.sendEmail(0, manuscript, journal, null, request, locale);
			emailService.sendEmail(1, manuscript, journal, null, request, locale);
		} else if (manuscript.getStatus().equals(SystemConstants.statusD)) {
			manuscript.setStatus(SystemConstants.statusV);
			eventDateTimeDao.insert(generateEventDateTime(manuscript));
			List<EventDateTime> edtList = eventDateTimeDao.findEventDatesByManuscriptId(manuscript.getId());
			manuscript.setEventDateTimes(edtList);
			manuscript.setLastEventDateTimes(edtList);
			emailService.sendEmail(2, manuscript, journal, null, request, locale);
			emailService.sendEmail(3, manuscript, journal, null, request, locale);
		}
		manuscriptDao.update(manuscript);
	}
	
	@Override
	public void publishAction(Manuscript manuscript) {
		manuscript.setStatus(SystemConstants.statusP);
		eventDateTimeDao.insert(generateEventDateTime(manuscript));
		update(manuscript);
	}

	@Override
	public List<Manuscript> getSubmittedManuscripts(int userId, int journalId, String status) {
		List<Manuscript> manuscripts = manuscriptDao.findSubmittedManuscripts(userId, journalId, status);
		return manuscriptBuilder.builds(manuscripts, SystemConstants.VIEW_BUILD);
	}
	
	@Override
	public List<Manuscript> getSubmittedManuscripts(int userId, int journalId, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findSubmittedManuscripts(userId, journalId, status, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public List<Manuscript> getSubmittedManuscriptsFromManagerConfiguration(Journal journal, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, List<String> indexNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findSubmittedManuscriptsFromManagerConfiguration(journal, status, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames, indexNames);
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public int numSubmittedManuscripts(int userId, int journalId, List<String> status) {
		return manuscriptDao.numSubmittedManuscripts(userId, journalId, status);
	}
	
	@Override
	public int numSubmittedManuscripts(int journalId, String status) {
		return manuscriptDao.numSubmittedManuscripts(journalId, status);
	}
	
	@Override
	public List<Manuscript> getCoWrittenManuscripts(int userId, int journalId, String status, boolean includeWrittenByMe) {
		List<Manuscript> manuscripts = manuscriptDao.findCoWrittenManuscripts(userId, journalId, status, includeWrittenByMe);
		return manuscriptBuilder.builds(manuscripts, SystemConstants.VIEW_BUILD);
	}
	
	@Override
	public List<Manuscript> getCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findCoWrittenManuscripts(userId, journalId, status, includeWrittenByMe, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);	//to do
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public int numCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe) {
		return manuscriptDao.numCoWrittenManuscripts(userId, journalId, status, includeWrittenByMe);
	}
	
	@Override
	public List<Integer> getCoWrittenManuscriptIdsByUserFromMyActivity(int userId, DataTableClientRequest dRequest) {
		return this.coAuthorDao.findManuscriptIdsByUserCoAuthorsFromMyActivity(userId, dRequest);
	}

	@Override
	public EventDateTime generateEventDateTime(Manuscript manuscript) {
		EventDateTime eventDateTime = new EventDateTime();
		eventDateTime.setManuscriptId(manuscript.getId());
		eventDateTime.setRevisionCount(manuscript.getRevisionCount());
		eventDateTime.setStatus(manuscript.getStatus());
		return eventDateTime;
	}
	
	@Override
	public List<Manuscript>	getManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findManuscriptsByRoleUserId(userId, journalId, role, status, revisionCount, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public int numManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount) {
		return manuscriptDao.numManuscriptsByRoleUserId(userId, journalId, role, status, revisionCount);
	}
	
	@Override
	public List<Manuscript>	getManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findManuscriptsByAssociateEditorUserId(editorUserId, journalId, editorStatus, status, revisionCount, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public int numManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount) {
		return manuscriptDao.numManuscriptsByAssociateEditorUserId(editorUserId, journalId, editorStatus, status, revisionCount);
	}
	
	@Override
	public List<Manuscript>	getManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel) {
		List<Manuscript> manuscripts = manuscriptDao.findManuscriptsByGuestEditorUserId(editorUserId, journalId, specialIssueIds, status, revisionCount, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		return manuscriptBuilder.builds(manuscripts, buildLevel);
	}
	
	@Override
	public int numManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount) {
		return manuscriptDao.numManuscriptsByGuestEditorUserId(editorUserId, journalId, specialIssueIds, status, revisionCount);
	}
	
	@Override
	public void update(Manuscript manuscript) {
		manuscriptDao.update(manuscript);
	}

	@Override
	public Manuscript updateRevision(Manuscript manuscript, int nextRevision) {
		int manuscriptId = manuscript.getId();
		int previousRevision = manuscript.getRevisionCount();
		coAuthorService.copyCoAuthorRevisions(manuscript, nextRevision);
		rpService.copyReviewPreferenceRevisions(manuscript, nextRevision);

		List<String> keywords = manuscript.getKeyword();
		for (String keyword : keywords) {
			if (!keyword.trim().equals("")) {
				keyword = keyword.trim();
				Keyword manuscriptKeyword = new Keyword();
				manuscriptKeyword.setKeyword(keyword);
				manuscriptKeyword.setManuscriptId(manuscriptId);
				manuscriptKeyword.setJournalId(manuscript.getJournalId());
				manuscriptKeyword.setUserId(manuscript.getUserId());
				manuscriptKeyword.setRevisionCount(nextRevision);
				if (keywordDao.findKeyword(manuscriptKeyword.getKeyword(), manuscriptKeyword.getManuscriptId(), manuscriptKeyword.getRevisionCount()) == null)
					keywordDao.insert(manuscriptKeyword);
				else
					keywordDao.update(manuscriptKeyword);
			}			
		}
		
		Title title = titleDao.findByRevisionCountAndManuscriptId(previousRevision, manuscriptId);
		title.setRevisionCount(nextRevision);
		title.setId(0);
		if(titleDao.findByRevisionCountAndManuscriptId(nextRevision, manuscriptId) == null)
			titleDao.insert(title);
		
		RunningHead runningHead = runningHeadDao.findByRevisionCountAndManuscriptId(previousRevision, manuscriptId);
		runningHead.setRevisionCount(nextRevision);
		runningHead.setId(0);
		if(runningHeadDao.findByRevisionCountAndManuscriptId(nextRevision, manuscriptId) == null)
			runningHeadDao.insert(runningHead);
		
		ManuscriptAbstract manuscriptAbstract = abstractDao.findByRevisionCountAndManuscriptId(previousRevision, manuscriptId);
		manuscriptAbstract.setRevisionCount(nextRevision);
		manuscriptAbstract.setId(0);
		if(abstractDao.findByRevisionCountAndManuscriptId(nextRevision, manuscriptId) == null)
			abstractDao.insert(manuscriptAbstract);
		
		CoverLetter coverLetter = coverLetterDao.findByRevisionCountAndManuscriptId(previousRevision, manuscriptId);
		coverLetter.setRevisionCount(nextRevision);
		coverLetter.setId(0);
		if(coverLetterDao.findByRevisionCountAndManuscriptId(nextRevision, manuscriptId) == null)
			coverLetterDao.insert(coverLetter);
		
		manuscript.setRevisionCount(nextRevision);
		manuscriptDao.update(manuscript);
		return manuscript;
	}

	@Override
	public void checkResubmitDuration() {
		List<Journal> journals = journalService.getAll();
		for(Journal journal: journals) {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			List<Manuscript> manuscripts = this.getSubmittedManuscripts(0, journal.getId(), SystemConstants.statusD);
			for(Manuscript manuscript: manuscripts) {
				Date dueDate = manuscript.getRevisionDueDate();
				if (dueDate != null) {
					Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
					dueDateCalendar.setTime(dueDate);
					
					int dueDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
					int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					int diff = dueDayOfYear - todayDayOfYear;
					SystemUser submitter = userService.getById(manuscript.getUserId());
					
					if(dueDateCalendar.get(Calendar.YEAR) > todayCalendar.get(Calendar.YEAR)) {
						dueDayOfYear = 365 + dueDateCalendar.get(Calendar.DAY_OF_YEAR);
						diff = dueDayOfYear - todayDayOfYear;
					}
					
					// GENTLE_REMIND_RESUBMIT
					if(diff > 0 && diff == jc.getGentleRemindResubmit()) {
						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(34, manuscript, journal, submitter.getUsername(), null, locale);
						String body = emailMessage.getBody();
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						String defaultDueDate = sdf.format(dueDate);
						body = body.replace("[updatedManuscriptSubmitDate]", defaultDueDate);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						EventDateTime notificationDate = manuscript.getLastEventDateTime(SystemConstants.statusD);
						if(notificationDate != null)
							body = body.replace("[notificationDate]", sdf.format(notificationDate.getDate()));
						
						emailMessage.setBody(body);
						emailService.sendEmailToAuthorsWithMessageModification(34, manuscript, journal, emailMessage, null, locale);
					}
					
					// RESUBMIT_DURATION
					dueDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
					todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					
					if(dueDateCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR))
						todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
					
					diff = todayDayOfYear - dueDayOfYear;
					
					if(diff >= jc.getResubmitDuration() &&  diff % jc.getResubmitDuration() == 0) {
						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(35, manuscript, journal, submitter.getUsername(), null, locale);
						String body = emailMessage.getBody();
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						String defaultDueDate = sdf.format(dueDate);
						body = body.replace("[updatedManuscriptSubmitDate]", defaultDueDate);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						EventDateTime notificationDate = manuscript.getLastEventDateTime(SystemConstants.statusD);
						if(notificationDate != null)
							body = body.replace("[notificationDate]", sdf.format(notificationDate.getDate()));
						
						emailMessage.setBody(body);
						emailService.sendEmailToAuthorsWithMessageModification(35, manuscript, journal, emailMessage, null, locale);
					}
				}
			}
		}
	}

	@Override
	public void checkCameraReadyDuration() {
		List<Journal> journals = journalService.getAll();
		for(Journal journal: journals) {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			List<Manuscript> manuscripts = this.getSubmittedManuscripts(0, journal.getId(), SystemConstants.statusA);
			for(Manuscript manuscript: manuscripts) {
				Date dueDate = manuscript.getCameraDueDate();
				if (dueDate != null) {
					Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
					dueDateCalendar.setTime(dueDate);
					
					int dueDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
					int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					int diff = dueDayOfYear - todayDayOfYear;
					
					SystemUser submitter = userService.getById(manuscript.getUserId());
					if(dueDateCalendar.get(Calendar.YEAR) > todayCalendar.get(Calendar.YEAR)) {
						dueDayOfYear = 365 + dueDateCalendar.get(Calendar.DAY_OF_YEAR);
						diff = dueDayOfYear - todayDayOfYear;
					}
					// GENTLE_REMIND_RESUBMIT
					if(diff > 0 && diff == jc.getGentleRemindCameraSubmit()) {
						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(40, manuscript, journal, submitter.getUsername(), null, locale);
						String body = emailMessage.getBody();
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						String defaultDueDate = sdf.format(dueDate);
						body = body.replace("[cameraReadySubmitDate]", defaultDueDate);
						String cameraReadyTemplateUrl = jc.getCameraReadyTemplateUrl();
						if(cameraReadyTemplateUrl == null)
							cameraReadyTemplateUrl = messageSource.getMessage("system.notAvailable2", null, locale);
						String copyrightFormUrl = jc.getCopyrightFormUrl();
						if(copyrightFormUrl == null)
							copyrightFormUrl = messageSource.getMessage("system.notAvailable2", null, locale);
						body = body.replace("[cameraReadyTemplateUrl]", cameraReadyTemplateUrl);
						body = body.replace("[copyrightUrl]", copyrightFormUrl);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						EventDateTime notificationDate = manuscript.getLastEventDateTime(SystemConstants.statusA);
						if(notificationDate != null)
							body = body.replace("[notificationDate]", sdf.format(notificationDate.getDate()));
						
						emailMessage.setBody(body);
						emailService.sendEmailToAuthorsWithMessageModification(40, manuscript, journal, emailMessage, null, locale);
					}

					// CAMERA_SUBMIT_DURATION
					dueDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
					todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					
					if(dueDateCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR))
						todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
					
					diff = todayDayOfYear - dueDayOfYear;
					
					if(diff >= jc.getCameraSubmitDuration() &&  diff % jc.getCameraSubmitDuration() == 0) {
						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(41, manuscript, journal, submitter.getUsername(), null, locale);
						String body = emailMessage.getBody();
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						String defaultDueDate = sdf.format(dueDate);
						body = body.replace("[cameraReadySubmitDate]", defaultDueDate);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						EventDateTime notificationDate = manuscript.getLastEventDateTime(SystemConstants.statusA);
						if(notificationDate != null)
							body = body.replace("[notificationDate]", sdf.format(notificationDate.getDate()));
						
						emailMessage.setBody(body);
						emailService.sendEmailToAuthorsWithMessageModification(41, manuscript, journal, emailMessage, null, locale);
					}
				}
			}
		}
	}

	@Override
	public void extendDueDate(EmailMessage emailMessage, Manuscript manuscript, Journal journal,
			HttpServletRequest request, Locale locale, String dateString) {
		try {
			manuscript.setDueDateExtendRequest(true);
			SimpleDateFormat format = null;
			if(journal.getLanguageCode().equals("ko"))
				format = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				format = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			
			Date parseDate = format.parse(dateString);
			java.sql.Date requestedDueDate = new java.sql.Date(parseDate.getTime());
			manuscript.setRevisionDueDate(requestedDueDate);
			emailService.sendEmail(36, manuscript, journal, emailMessage, request, locale);
			this.update(manuscript);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void setCurrentDate(Manuscript manuscript, String dateColumnName, String timeColumnName) {
		manuscriptDao.setCurrentDate(manuscript, dateColumnName, timeColumnName);		
	}
	
	@Override
	public void updateDate(Manuscript manuscript, String dateColumnName, String timeColumnName, int addedDate) {
		manuscriptDao.updateDate(manuscript, dateColumnName, timeColumnName, addedDate);		
	}

	@Override
	public List<FinalDecision> getFinalDecisionsByManuscriptId(int manuscriptId) {
		return finalDecisionDao.findByManuscriptId(manuscriptId);
	}
}
