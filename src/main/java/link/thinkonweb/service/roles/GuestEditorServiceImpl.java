package link.thinkonweb.service.roles;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.GuestEditorSpecialIssueDao;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
public class GuestEditorServiceImpl implements GuestEditorService {
	@Autowired
	private DivisionDao divisionDao;
	@Autowired
	private UserService userService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private ReviewRequestDao reviewRequestDao;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private EmailService emailService;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private GuestEditorSpecialIssueDao geSpecialIssueDao;
	@Autowired
	private JournalConfigurationService jcService;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private SpecialIssueDao specialIssueDao;

	@Override
	
	public void createGuestEditor(GuestEditor ge) {
		Journal journal = journalService.getById(ge.getJournalId());
		SystemUser user = ge.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		
		List<GuestEditorSpecialIssue> geSpecialIssuess = ge.getGeSpecialIssues();
		for(GuestEditorSpecialIssue u: geSpecialIssuess) {
			u.setUserId(storedUser.getId());
			geSpecialIssueDao.insert(u);
		}
		authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleGEditor);
	}
	
	@Override
	public GuestEditor getGuestEditor(int userId, int journalId) {
		GuestEditor ge = journalRoleDao.findJournalGuestEditor(userId, journalId);
		ge.setUser(userService.getById(userId));
		List<GuestEditorSpecialIssue> geSpecialIssues = geSpecialIssueDao.findGeSpecialIssue(ge.getUserId(), ge.getJournalId());
		ge.setGeSpecialIssues(geSpecialIssues);
		return ge;
	}
	
	@Override
	public void update(GuestEditor ge) {
		journalRoleDao.update(ge);
	}
	
	@Override
	public List<GuestEditor> getGuestEditorsByJournalId(int journalId) {
		List<GuestEditor> geList = journalRoleDao.findJournalGuestEditors(0, journalId);
		if(geList != null) {
			for(GuestEditor ge: geList) {
				int userId = ge.getUserId();
				SystemUser user = userService.getById(userId);
				ge.setUser(user);
				List<GuestEditorSpecialIssue> geSpecialIssues = geSpecialIssueDao.findGeSpecialIssue(ge.getUserId(), ge.getJournalId());
				ge.setGeSpecialIssues(geSpecialIssues);
			}
		}
		return geList;
	}
	
	@Override
	public void selectGuestEditor(int userId, int journalId) {
		authorityService.create(userId, journalId, SystemConstants.roleGEditor);
	}
	
	@Override
	public void deleteGuestEditor(int userId, int journalId) {
		Authority authority = authorityService.getAuthority(userId, journalId, SystemConstants.roleGEditor);
		authorityService.delete(authority);
	}

	@Override
	public FinalDecision getFinalDecision(int manuscriptId, int revisionCount) {
		return finalDecisionDao.findByManuscriptIdAndRevisionCount(manuscriptId, revisionCount);
	}
	
	@Override
	public void finalDecisionAction(FinalDecision finalDecision, String postCommentToAuthor, String postCommentToManager, EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		String body = emailMessage.getBody();
		if (postCommentToAuthor != null && !postCommentToAuthor.equals("")) {
			Comment commentToAuthor = new Comment();
			commentToAuthor.setFromUserId(finalDecision.getUserId());
			commentToAuthor.setToUserId(manuscript.getUserId());
			commentToAuthor.setJournalId(manuscript.getJournalId());
			commentToAuthor.setManuscriptId(manuscript.getId());
			commentToAuthor.setRevisionCount(manuscript.getRevisionCount());
			commentToAuthor.setFromRole(SystemConstants.roleGEditor);
			commentToAuthor.setToRole(SystemConstants.roleMember);
			commentToAuthor.setScopeManager(1);
			commentToAuthor.setStatus(manuscript.getStatus());
			commentToAuthor.setText(postCommentToAuthor);
			commentDao.insert(commentToAuthor);
			
			body = body.replace("[comments]", postCommentToAuthor + "\n");
		} else	{
			String reviewResultByEditorTitle = "";
			if(manuscript.getManuscriptTrackId() == 0)
				reviewResultByEditorTitle = messageSource.getMessage("email.reviewResultByChiefEditorTitle", null, locale);
			else
				reviewResultByEditorTitle = messageSource.getMessage("email.reviewResultByGuestEditorTitle", null, locale);
			
			int startIndex = body.indexOf(reviewResultByEditorTitle);
			int endIndex = body.indexOf("[comments]") + "[comments]".length();
			body = body.substring(0, startIndex) + body.substring(endIndex).replaceFirst(System.getProperty("line.separator"), "").replaceFirst(System.getProperty("line.separator"), "");
		}
		
		if (postCommentToManager != null && !postCommentToManager.equals("")) {
			Comment commentToManager = new Comment();
			commentToManager.setFromUserId(finalDecision.getUserId());
			commentToManager.setToUserId(manuscript.getAssociateEditorUserId());
			commentToManager.setJournalId(manuscript.getJournalId());
			commentToManager.setManuscriptId(manuscript.getId());
			commentToManager.setRevisionCount(manuscript.getRevisionCount());
			commentToManager.setFromRole(SystemConstants.roleGEditor);
			commentToManager.setToRole(SystemConstants.roleManager);
			commentToManager.setScopeManager(0);
			commentToManager.setStatus(manuscript.getStatus());
			commentToManager.setText(postCommentToManager);
			commentDao.insert(commentToManager);
		}

		emailMessage.setBody(body);
		
		int decision = finalDecision.getDecision();
		int previousRevision = manuscript.getRevisionCount();
		finalDecisionDao.update(finalDecision);
		JournalConfiguration jc = jcService.getByJournalId(journal.getId());
		if (decision >= 4) {
			manuscript.setStatus(SystemConstants.statusA);
			Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getCameraSubmitDuration());
			java.sql.Date cameraDueDate =  new java.sql.Date(dueDateCalendar.getTime().getTime());
			manuscript.setCameraDueDate(cameraDueDate);
			emailService.sendEmailToAuthorsWithMessageModification(31, manuscript, journal, emailMessage, request, locale);
		} else if (decision <= 2) {
			manuscript.setStatus(SystemConstants.statusJ);
			emailService.sendEmailToAuthorsWithMessageModification(33, manuscript, journal, emailMessage, request, locale);
		} else {
			manuscript.setStatus(SystemConstants.statusD);
			manuscript = manuscriptService.updateRevision(manuscript, manuscript.getRevisionCount() + 1);
			
			Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getResubmitDuration());
    		SpecialIssue si = specialIssueDao.findById(manuscript.getSpecialIssueId());
    		Date specialIssueSubmissionDate = si.getSubmissionDueDate();
    		
    		java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
    		if(specialIssueSubmissionDate.before(dueDate))
    			manuscript.setRevisionDueDate(specialIssueSubmissionDate);
    		else {

    			java.sql.Date revisionDueDate =  new java.sql.Date(dueDateCalendar.getTime().getTime());
    			manuscript.setRevisionDueDate(revisionDueDate);
    		}
    		manuscript.setSubmitStep(1);
			emailService.sendEmailToAuthorsWithMessageModification(32, manuscript, journal, emailMessage, request, locale);
		}
		
		List<Review> allReviews = manuscript.getReviews();
		for (Review review : allReviews) {
			if(review.getRevisionCount() == previousRevision) {
				if (review.getStatus().equals(SystemConstants.reviewerI))
					reviewerService.cancelReviewer(review.getUserId(), manuscript, journal, request, locale, previousRevision);
	
				if (review.getStatus().equals(SystemConstants.reviewerA))
					reviewerService.dismissReviewer(review.getUserId(), manuscript, journal, request, locale);
			}
		}
		eventDateTimeDao.insert(manuscriptService.generateEventDateTime(manuscript));
		manuscriptDao.update(manuscript);
	}
	
	@Override
	public void forceToRejectAction(EmailMessage emailMessage, String comments, SystemUser guestEditorUser, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		try {
			int manuscriptId = manuscript.getId();
			manuscript.setGuestEditor(guestEditorUser);
			List<Review> reviews = manuscript.getReviews();
			if(reviews != null) {
				for (Review review : reviews) {
					SystemUser reviewerUser = userService.getById(review.getUserId());
					if (review.getStatus().equals(SystemConstants.reviewerI))
						reviewerService.cancelReviewer(reviewerUser.getId(), manuscript, journal, request, locale, review.getRevisionCount());
					else if (review.getStatus().equals(SystemConstants.reviewerA))
						reviewerService.automaticDismissReviewer(reviewerUser.getId(), manuscript, journal, request, locale, review.getRevisionCount());
				}
			}
			
			FinalDecision fd = new FinalDecision();
			fd.setDecision(1);
			fd.setJournalId(manuscript.getJournalId());
			fd.setManuscriptId(manuscriptId);
			fd.setRevisionCount(manuscript.getRevisionCount());
			fd.setUserId(guestEditorUser.getId());
			finalDecisionDao.insert(fd);
			
			Comment comment = new Comment();
			comment.setFromRole(SystemConstants.roleGEditor);
			comment.setToRole(SystemConstants.roleMember);
			comment.setFromUserId(guestEditorUser.getId());
			comment.setToUserId(manuscript.getUserId());
			comment.setJournalId(manuscript.getJournalId());
			comment.setManuscriptId(manuscriptId);
			comment.setRevisionCount(manuscript.getRevisionCount());
			comment.setScopeManager(1);
			comment.setStatus(SystemConstants.statusR);
			comment.setText(comments);
			commentDao.insert(comment);
			
			emailService.sendEmailToAuthorsWithMessageModification(39, manuscript, journal, emailMessage, request, locale);

			manuscript.setStatus(SystemConstants.statusJ);
			eventDateTimeDao.insert(manuscriptService.generateEventDateTime(manuscript));
			manuscriptService.update(manuscript);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int createFinalDecision(FinalDecision fd) {
		return finalDecisionDao.insertAndReturningKey(fd);
	}
}
