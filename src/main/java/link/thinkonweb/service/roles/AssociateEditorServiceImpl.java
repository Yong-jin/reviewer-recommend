package link.thinkonweb.service.roles;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.UserDivisionDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
public class AssociateEditorServiceImpl implements AssociateEditorService {
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
	private UserDivisionDao userDivisionDao;
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
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private JournalConfigurationService journalConfigurationService;

	@Override
	public void createAssociateEditor(AssociateEditor ae) {
		Journal journal = journalService.getById(ae.getJournalId());
		SystemUser user = ae.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		List<UserDivision> userDivisions = ae.getUserDivisions();
		
		for(UserDivision u: userDivisions) {
			u.setUserId(storedUser.getId());
			userDivisionDao.insert(u);
		}
		authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleAEditor);
	}
	
	@Override
	public AssociateEditor getAssociateEditor(int userId, int journalId) {
		AssociateEditor ae = journalRoleDao.findJournalAssociateEditor(userId, journalId);
		ae.setUser(userService.getById(userId));
		List<UserDivision> userDivisions = userDivisionDao.findUserDivisions(ae.getUserId(), journalId, SystemConstants.roleAEditor);
		if(userDivisions != null)
			Collections.sort(userDivisions);
		ae.setUserDivisions(userDivisions);
		return ae;
	}
	
	@Override
	public void update(AssociateEditor ae) {
		journalRoleDao.update(ae);
	}
	
	@Override
	public List<AssociateEditor> getAssociateEditorsByJournalId(int journalId) {
		List<AssociateEditor> aeList = journalRoleDao.findJournalAssociateEditors(0, journalId);
		if(aeList != null) {
			for(AssociateEditor ae: aeList) {
				int userId = ae.getUserId();
				SystemUser user = userService.getById(userId);
				ae.setUser(user);
				List<UserDivision> userDivisions = userDivisionDao.findUserDivisions(ae.getUserId(), journalId, SystemConstants.roleAEditor);
				if(userDivisions != null)
					Collections.sort(userDivisions);
				ae.setUserDivisions(userDivisions);
			}
		}
		return aeList;
	}
	
	@Override
	public void selectAssociateEditor(int userId, int journalId) {
		authorityService.create(userId, journalId, SystemConstants.roleAEditor);
	}
	
	@Override
	public void deleteAssociateEditor(int userId, int journalId) {
		Authority authority = authorityService.getAuthority(userId, journalId, SystemConstants.roleAEditor);
		authorityService.delete(authority);
	}

	@Override
	public void sendReviewResultToChief(Manuscript manuscript, int recommend, String commentToChief, String commentToAuthor, int scopeToManager, Journal journal, HttpServletRequest request, Locale locale) {
		List<Review> allReviews = manuscript.getReviews();
		for (Review review : allReviews) {
			if(review.getRevisionCount() == manuscript.getRevisionCount()) {
				if (review.getStatus().equals(SystemConstants.reviewerI))
					reviewerService.cancelReviewer(review.getUserId(), manuscript, journal, request, locale, review.getRevisionCount());
	
				if (review.getStatus().equals(SystemConstants.reviewerA))
					reviewerService.automaticDismissReviewer(review.getUserId(), manuscript, journal, request, locale, review.getRevisionCount());
			}
		}
		
		if (manuscript.getStatus().equals(SystemConstants.statusR)) {
			SystemUser chiefEditor = manuscript.getChiefEditor();
			SystemUser associateEditor = manuscript.getAssociateEditor();
			
			FinalDecision fd = new FinalDecision();
			fd.setJournalId(manuscript.getJournalId());
			fd.setManuscriptId(manuscript.getId());
			fd.setUserId(chiefEditor.getId());
			fd.setEditorRecommend(recommend);
			fd.setRevisionCount(manuscript.getRevisionCount());
			finalDecisionDao.insert(fd);
			
			if(commentToChief != null && !commentToChief.trim().equals("")) {
				Comment comment = new Comment();
				comment.setManuscriptId(manuscript.getId());
				comment.setText(commentToChief);
				comment.setFromUserId(associateEditor.getId());
				comment.setToUserId(chiefEditor.getId());
				comment.setJournalId(manuscript.getJournalId());
				comment.setFromRole(SystemConstants.roleAEditor);
				comment.setToRole(SystemConstants.roleCEditor);
				comment.setScopeManager(scopeToManager);
				comment.setRevisionCount(manuscript.getRevisionCount());
				comment.setStatus(manuscript.getStatus());
				commentDao.insert(comment);
			}
			
			if(commentToAuthor != null && !commentToAuthor.trim().equals("")) {
				Comment comment = new Comment();
				comment.setManuscriptId(manuscript.getId());
				comment.setText(commentToAuthor);
				comment.setFromUserId(associateEditor.getId());
				comment.setToUserId(manuscript.getUserId());
				comment.setJournalId(manuscript.getJournalId());
				comment.setFromRole(SystemConstants.roleAEditor);
				comment.setToRole(SystemConstants.roleMember);
				comment.setScopeManager(1);
				comment.setRevisionCount(manuscript.getRevisionCount());
				comment.setStatus(manuscript.getStatus());
				commentDao.insert(comment);
			}
			
			manuscript.setStatus(SystemConstants.statusE);
			eventDateTimeDao.insert(manuscriptService.generateEventDateTime(manuscript));
			manuscriptDao.update(manuscript);
			emailService.sendEmail(30, manuscript, journal, null, request, locale);
		}
	}

	@Override
	public void take(Manuscript manuscript, SystemUser user, Journal journal, HttpServletRequest request, Locale locale) {
		manuscript.setEditorStatus(SystemConstants.editorT);
		manuscript.setAssociateEditor(user);
		manuscript.setAssociateEditorUserId(user.getId());
		manuscript.setStatus(SystemConstants.statusR);
		manuscriptService.update(manuscript);
		emailService.sendEmail(12, manuscript, journal, null, request, locale);
	}

	@Override
	public void decline(Manuscript manuscript, EmailMessage emailMessage, String comments, Journal journal, HttpServletRequest request, Locale locale) {
		String text = emailMessage.getBody();
		if (comments != null && !comments.equals(""))
			text = text.replace("[comments]", comments);
		else {
			int startIndex = text.indexOf("[comments]");
			int endIndex = text.indexOf("[comments]") + "[comments]".length();
			text = text.substring(0, startIndex) + text.substring(endIndex).replaceFirst(System.getProperty("line.separator"), "").replaceFirst(System.getProperty("line.separator"), "");
		}
		emailMessage.setBody(text);
		
		emailService.sendEmail(13, manuscript, journal, emailMessage, request, locale);
		manuscript.setEditorStatus(SystemConstants.editorD);
		manuscript.setAssociateEditorUserId(0);
		manuscript.setStatus(SystemConstants.statusO);
		manuscript.setAeAssignDate(null);
		manuscript.setAeAssignTime(null);
		manuscriptService.update(manuscript);
	}

	@Override
	public void checkAssignedAssociateEditor() {
		List<Journal> journals = journalService.getAll();
		Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		for(Journal journal: journals) {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			List<Manuscript> manuscripts = manuscriptDao.findSubmittedManuscripts(0, journal.getId(), SystemConstants.statusO);
			for(Manuscript manuscript: manuscripts) {
				int aeUserId = manuscript.getAssociateEditorUserId();
				if(aeUserId != 0) {
					Date assignedDate = manuscript.getAeAssignDate();
					Calendar assignedCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
					assignedCalendar.setTime(assignedDate);
					int assignedDayOfYear = assignedCalendar.get(Calendar.DAY_OF_YEAR);
					int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					int diff = todayDayOfYear - assignedDayOfYear;
					if(assignedCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR)) {
						assignedDayOfYear = assignedCalendar.get(Calendar.DAY_OF_YEAR);
						todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
						diff = todayDayOfYear - assignedDayOfYear;
					}
					// ASSIGN_REMIND_DURATION
					if(diff > 0 && diff == jc.getAssignRemindDuration()) {
						SystemUser aeUser = userService.getById(manuscript.getAssociateEditorUserId());
						List<Comment> comments = commentDao.findRelatedComments(manuscript.getId(), aeUser.getId(), SystemConstants.roleAEditor, false);

						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						manuscript = manuscriptService.getManuscriptById(manuscript.getId(), SystemConstants.EMAIL_BUILD);
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(11, manuscript, journal, null, null, locale);
						String chiefComment = "";
						for(Comment comment: comments) {
							if(comment.getManuscriptId() == manuscript.getId() && comment.getStatus().equals(SystemConstants.statusO) && comment.getFromRole().equals(SystemConstants.roleCEditor) && 
									comment.getToRole().equals(SystemConstants.roleAEditor) && comment.getRevisionCount() == manuscript.getRevisionCount()) {
								chiefComment = comment.getText();
							}
						}
						String body = emailMessage.getBody();
						body = body.replace("[comments]", chiefComment);
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						emailMessage.setBody(body);
						emailService.sendEmail(11, manuscript, journal, emailMessage, null, locale);
					}

					assignedDayOfYear = assignedCalendar.get(Calendar.DAY_OF_YEAR);
					todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
					diff = todayDayOfYear - assignedDayOfYear;
					if(assignedCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR)) {
						assignedDayOfYear = assignedCalendar.get(Calendar.DAY_OF_YEAR);
						todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
						diff = todayDayOfYear - assignedDayOfYear;
					}
					
					// ASSIGN_CANCEL_DURATION
					if(diff > 0 && diff == jc.getAssignCancelDuration()) {
						Locale locale = null;
						if(journal.getLanguageCode().equals("ko"))
							locale = Locale.KOREAN;
						else
							locale = Locale.ENGLISH;
						manuscript = manuscriptService.getManuscriptById(manuscript.getId(), SystemConstants.EMAIL_BUILD);
						EmailMessage emailMessage = emailService.getGeneralEmailMessage(15, manuscript, journal, null, null, locale);
						String body = emailMessage.getBody();
		    			SimpleDateFormat sdf = null;
		    			if(journal.getLanguageCode().equals("ko"))
		    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		    			else
		    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
						EventDateTime submitDate = manuscript.getLastEventDateTime(SystemConstants.statusI);
						if(submitDate != null)
							body = body.replace("[submitDate]", sdf.format(submitDate.getDate()));
						emailMessage.setBody(body);
						manuscript.setAssociateEditorUserId(0);
						manuscript.setEditorStatus(null);
						manuscript.setAeAssignDate(null);
						manuscript.setAeAssignTime(null);
						manuscriptService.update(manuscript);
						emailService.sendEmail(15, manuscript, journal, emailMessage, null, locale);
					}
				}
			}
		}
	}

	@Override
	public List<AssociateEditor> getAssociateEditorsAll() {
		List<AssociateEditor> aeAll = journalRoleDao.findJournalAssociateEditors(0, 0);
		for(AssociateEditor ae: aeAll)
			ae.setUser(userService.getById(ae.getUserId()));
		
		return aeAll;
	}
}
