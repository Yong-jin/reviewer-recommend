package link.thinkonweb.service.roles;

import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.UserDivisionDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

public class ChiefEditorServiceImpl implements ChiefEditorService {
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
	@Autowired
	private UserService userService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private ReviewRequestDao reviewRequestDao;
	@Autowired
	private UserDivisionDao userDivisionDao;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private KeywordDao keywordDao;
	@Autowired
	private JournalConfigurationService jcService;
	
	@Override
	
	public void createChiefEditor(ChiefEditor ce) {
		Journal journal = journalService.getById(ce.getJournalId());
		SystemUser user = ce.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleCEditor);
	}

	@Override
	public List<ChiefEditor> getChiefEditorsByJournalId(int journalId) {
		List<ChiefEditor> ceAll = journalRoleDao.findJournalChiefEditors(0, journalId);
		if(ceAll != null && ceAll.size() > 0) {
			for (ChiefEditor ce : ceAll) {
				SystemUser user = userService.getById(ce.getUserId());
				ce.setUser(user);
			}
			return ceAll;
		} else
			return null;
	}
		
	@Override
	public void forceToRejectAction(EmailMessage emailMessage, String comments, SystemUser chiefUser, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		try {
			int manuscriptId = manuscript.getId();
			manuscript.setChiefEditor(chiefUser);
			List<Review> reviews = manuscript.getReviews();
			if(reviews != null) {
				for (Review review : reviews) {
					SystemUser reviewerUser = userService.getById(review.getUserId());
					if (review.getStatus().equals(SystemConstants.reviewerI))
						reviewerService.cancelReviewer(reviewerUser.getId(), manuscript, journal, request, locale, review.getRevisionCount());
					else if (review.getStatus().equals(SystemConstants.reviewerA))
						reviewerService.dismissReviewer(reviewerUser.getId(), manuscript, journal, request, locale);
				}
			}
			
			FinalDecision fd = new FinalDecision();
			fd.setDecision(1);
			fd.setJournalId(manuscript.getJournalId());
			fd.setManuscriptId(manuscriptId);
			fd.setRevisionCount(manuscript.getRevisionCount());
			fd.setUserId(chiefUser.getId());
			finalDecisionDao.insert(fd);
			
			Comment comment = new Comment();
			comment.setFromRole(SystemConstants.roleCEditor);
			comment.setToRole(SystemConstants.roleMember);
			comment.setFromUserId(chiefUser.getId());
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
	public void selectAssociateEditor(int editorUserId, int manuscriptId) {
		Manuscript m = manuscriptDao.findById(manuscriptId);
		m.setAssociateEditorUserId(editorUserId);
		manuscriptDao.update(m);
	}
	
	@Override
	public void cancelAssignedEditor(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		manuscript.setAssociateEditorUserId(0);
		manuscript.setEditorStatus(null);
		emailService.sendEmail(14, manuscript, journal, null, request, locale);
		manuscriptService.update(manuscript);
	}
	
	@Override
	public void selectChiefEditor(int userId, int journalId) {
		authorityService.create(userId, journalId, SystemConstants.roleCEditor);
	}
	
	@Override
	public void deleteChiefEditor(int userId, int journalId) {
		Authority authority = authorityService.getAuthority(userId, journalId, SystemConstants.roleCEditor);
		authorityService.delete(authority);
	}
	
	@Override
	public void assignAssociateEditor(EmailMessage emailMessage, AssociateEditor ae, Manuscript m, SystemUser chief, String comments, int scopeToManager, Journal journal, HttpServletRequest request, Locale locale) {
		if (m.getStatus().equals(SystemConstants.statusO)) {
			m.setAssociateEditorUserId(ae.getUserId());
			m.setAssociateEditor(ae.getUser());
			m.setEditorStatus(SystemConstants.editorA);
			m.setChiefEditorUserId(chief.getId());
			EventDateTime edt = manuscriptService.generateEventDateTime(m);
			m.setAeAssignDate(edt.getDate());
			m.setAeAssignTime(edt.getTime());
			eventDateTimeDao.insert(edt);
			manuscriptDao.update(m);
			
			String body = emailMessage.getBody();
			if (comments != null && !comments.equals("")) {
				comments = comments.trim();
				Comment comment = new Comment();
				comment.setFromUserId(chief.getId());
				comment.setToUserId(ae.getUserId());
				comment.setJournalId(m.getJournalId());
				comment.setManuscriptId(m.getId());
				comment.setRevisionCount(m.getRevisionCount());
				comment.setFromRole(SystemConstants.roleCEditor);
				comment.setToRole(SystemConstants.roleAEditor);
				comment.setStatus(m.getStatus());
				comment.setText(comments);
				comment.setScopeManager(scopeToManager);
				commentDao.insert(comment);
				
				body = body.replace("[comments]", comments);
			} else {
				String additionalMessage = messageSource.getMessage("chiefEditor.additionalMessage", null, locale);
				int startIndex = body.indexOf("[" + additionalMessage + "]");
				int endIndex = body.indexOf("[comments]") + "[comments]".length();
				body = body.substring(0, startIndex) + body.substring(endIndex).replaceFirst(System.getProperty("line.separator"), "").replaceFirst(System.getProperty("line.separator"), "");
			}
			emailMessage.setBody(body);
			emailService.sendEmail(10, m, journal, emailMessage, request, locale);
		}
	}
	
	@Override
	public FinalDecision getFinalDecision(int manuscriptId, int revisionCount) {
		return finalDecisionDao.findByManuscriptIdAndRevisionCount(manuscriptId, revisionCount);
	}
	
	@Override
	public void finalDecisionAction(FinalDecision finalDecision, String postCommentToAuthor, String postCommentToEditorAndManager, EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		if (postCommentToEditorAndManager != null && !postCommentToEditorAndManager.equals("")) {
			Comment commentToEditor = new Comment();
			commentToEditor.setFromUserId(finalDecision.getUserId());
			commentToEditor.setToUserId(manuscript.getAssociateEditorUserId());
			commentToEditor.setJournalId(manuscript.getJournalId());
			commentToEditor.setManuscriptId(manuscript.getId());
			commentToEditor.setRevisionCount(manuscript.getRevisionCount());
			commentToEditor.setFromRole(SystemConstants.roleCEditor);
			commentToEditor.setToRole(SystemConstants.roleAEditor);
			commentToEditor.setScopeManager(1);
			commentToEditor.setStatus(manuscript.getStatus());
			commentToEditor.setText(postCommentToEditorAndManager);
			commentDao.insert(commentToEditor);
		}
		String body = emailMessage.getBody();
		if (postCommentToAuthor != null && !postCommentToAuthor.equals("")) {
			Comment commentToAuthor = new Comment();
			commentToAuthor.setFromUserId(finalDecision.getUserId());
			commentToAuthor.setToUserId(manuscript.getUserId());
			commentToAuthor.setJournalId(manuscript.getJournalId());
			commentToAuthor.setManuscriptId(manuscript.getId());
			commentToAuthor.setRevisionCount(manuscript.getRevisionCount());
			commentToAuthor.setFromRole(SystemConstants.roleCEditor);
			commentToAuthor.setToRole(SystemConstants.roleMember);
			commentToAuthor.setScopeManager(1);
			commentToAuthor.setStatus(manuscript.getStatus());
			commentToAuthor.setText(postCommentToAuthor);
			commentDao.insert(commentToAuthor);
			
			body = body.replace("[comments]", postCommentToAuthor + "\n");
		} else {
			String reviewResultByEditorTitle = "";
			if(manuscript.getManuscriptTrackId() == 0)
				reviewResultByEditorTitle = messageSource.getMessage("email.reviewResultByChiefEditorTitle", null, locale);
			else
				reviewResultByEditorTitle = messageSource.getMessage("email.reviewResultByGuestEditorTitle", null, locale);
			
			int startIndex = body.indexOf(reviewResultByEditorTitle);
			int endIndex = body.indexOf("[comments]") + "[comments]".length();
			body = body.substring(0, startIndex) + body.substring(endIndex).replaceFirst(System.getProperty("line.separator"), "").replaceFirst(System.getProperty("line.separator"), "");
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
			java.sql.Date revisionDueDate =  new java.sql.Date(dueDateCalendar.getTime().getTime());
			manuscript.setRevisionDueDate(revisionDueDate);
    		manuscript.setSubmitStep(1);
			emailService.sendEmailToAuthorsWithMessageModification(32, manuscript, journal, emailMessage, request, locale);
		}
		
		List<Review> allReviews = manuscript.getReviews();
		for (Review review : allReviews) {
			if(review.getRevisionCount() == previousRevision) {
				if (review.getStatus().equals(SystemConstants.reviewerI))
					reviewerService.cancelReviewer(review.getUserId(), manuscript, journal, request, locale, previousRevision);
	
				if (review.getStatus().equals(SystemConstants.reviewerA))
					reviewerService.automaticDismissReviewer(review.getUserId(), manuscript, journal, request, locale, previousRevision);
			}
		}
		eventDateTimeDao.insert(manuscriptService.generateEventDateTime(manuscript));
		manuscriptDao.update(manuscript);
	}
	
	@Override
	public int createFinalDecision(FinalDecision fd) {
		return finalDecisionDao.insertAndReturningKey(fd);
	}
}
