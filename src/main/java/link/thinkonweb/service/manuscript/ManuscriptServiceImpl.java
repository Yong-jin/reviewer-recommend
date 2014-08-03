package link.thinkonweb.service.manuscript;

import java.util.List;
import java.util.Locale;

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
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
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
	public void cameraReadyConfirm(Manuscript manuscript, Journal journal,
			HttpServletRequest request, Locale locale) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void submitAction(Manuscript manuscript, Journal journal,
			HttpServletRequest request, Locale locale) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setCurrentDate(Manuscript manuscript, String dateColumnName,
			String timeColumnName) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDate(Manuscript manuscript, String dateColumnName,
			String timeColumnName, int addedDate) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkResubmitDuration() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkCameraReadyDuration() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void extendDueDate(EmailMessage emailMessage, Manuscript manuscript,
			Journal journal, HttpServletRequest request, Locale locale,
			String dateString) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<FinalDecision> getFinalDecisionsByManuscriptId(int manuscriptId) {
		// TODO Auto-generated method stub
		return null;
	}

}
