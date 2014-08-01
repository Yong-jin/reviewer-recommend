package link.thinkonweb.service.roles;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.email.EmailMessageDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.ReviewEventDateTimeDao;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.ReviewerSuggestDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.constants.AdditionalReviewFileDesignation;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewEventDateTime;
import link.thinkonweb.domain.manuscript.ReviewRequest;
import link.thinkonweb.domain.manuscript.ReviewerSuggest;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserExpertiseService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

public class ReviewerServiceImpl implements ReviewerService {
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private ReviewRequestDao reviewRequestDao;
	@Autowired
	private ReviewEventDateTimeDao reviewEventDateTimeDao;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private KeywordDao keywordDao;
	@Autowired
	private EmailMessageDao emailDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	@Autowired
	private UserService userService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserExpertiseService userExpertiseService;
	@Autowired
	private FileService fileService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private ReviewerSuggestDao reviewerSuggestDao;
	@Autowired
	private UserDao userDao;
	
	@Override
	public void createReviewer(Reviewer reviewer) {
		Journal journal = journalService.getById(reviewer.getJournalId());
		SystemUser user = reviewer.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		if(journalRoleDao.findJournalReviewer(storedUser.getId(), journal.getId()) == null)
			authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleReviewer);
	}
	
	@Override
	public Review getReviewById(int reviewId) {
		Review r = reviewDao.findById(reviewId);
		SystemUser user = userService.getById(r.getUserId());
		r.setUser(user);
		Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
		r.setManuscript(m);
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<AdditionalReviewFileDesignation.values().length; i++)
			designations.add(AdditionalReviewFileDesignation.getType(i).name());
		List<UploadedFile> additionalReviews = fileService.getFiles(m.getId(), r.getUserId(), m.getRevisionCount(), designations);
		r.setAdditionalReviews(additionalReviews);
		List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(r.getUserId(), r.getManuscriptId(), r.getJournalId(), m.getRevisionCount());
		r.setReviewEventDateTimes(redtList);
		return r;
	}
	
	@Override
	public Reviewer getReviewerById(int id) {
		Reviewer reviewer = (Reviewer)journalRoleDao.findSpecificJournalRole(id, SystemConstants.roleReviewer);
		SystemUser user = userService.getById(reviewer.getUserId());
		reviewer.setUser(user);
		return reviewer;
	}
	
	@Override
	public Reviewer getReviewer(int userId, int journalId) {
		Reviewer reviewer = (Reviewer)journalRoleDao.findJournalReviewer(userId, journalId);
		if(reviewer != null) {
			SystemUser user = userService.getById(reviewer.getUserId());
			reviewer.setUser(user);
			return reviewer;
		} else 
			return null;
	}
	
	@Override
	public List<Review> getReviews(int reviewerUserId, int manuscriptId, int journalId, int revisionunt, String status) {
		List<Review> reviews = reviewDao.findReviews(reviewerUserId, manuscriptId, journalId, revisionunt, status);
		if(reviews != null) {
			for (Review r: reviews) {
				SystemUser user = userService.getById(r.getUserId());
				r.setUser(user);
				Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
				r.setManuscript(m);
				
				FinalDecision finalDecision = finalDecisionDao.findByManuscriptIdAndRevisionCount(r.getManuscriptId(), r.getRevisionCount());
				r.setFinalDecision(finalDecision);
				List<String> designations = new ArrayList<String>();
				for(int i=0; i<AdditionalReviewFileDesignation.values().length; i++)
					designations.add(AdditionalReviewFileDesignation.getType(i).name());
				List<UploadedFile> additionalReviews = fileService.getFiles(m.getId(), r.getUserId(), m.getRevisionCount(), designations);
				r.setAdditionalReviews(additionalReviews);
				List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(r.getUserId(), manuscriptId, journalId, revisionunt);
				r.setReviewEventDateTimes(redtList);
			}
		}
		Collections.sort(reviews);
		return reviews;
	}
	
	@Override
	public List<Review> getReviewManuscriptsForMyActivity(int reviewerUserId) {
		List<Review> reviews = reviewDao.findReviewManuscriptsForMyActivity(reviewerUserId);
		if(reviews != null) {
			for (Review r: reviews) {
				SystemUser user = userService.getById(r.getUserId());
				r.setUser(user);
				Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
				r.setManuscript(m);
				
				FinalDecision finalDecision = finalDecisionDao.findByManuscriptIdAndRevisionCount(r.getManuscriptId(), r.getRevisionCount());
				r.setFinalDecision(finalDecision);
				List<String> designations = new ArrayList<String>();
				for(int i=0; i<2; i++)
					designations.add(AdditionalReviewFileDesignation.getType(i).name());
				List<UploadedFile> additionalReviews = fileService.getFiles(m.getId(), r.getUserId(), m.getRevisionCount(), designations);
				r.setAdditionalReviews(additionalReviews);
				List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(r.getUserId(), 0, 0, m.getRevisionCount());
				r.setReviewEventDateTimes(redtList);
			}
		}
		Collections.sort(reviews);
		return reviews;
	}
	
	@Override
	public int numReviewManuscriptsForMyActivity(int reviewerUserId) {
		return reviewDao.numReviewManuscriptsForMyActivity(reviewerUserId);
	}
	
	@Override
	public List<Review> getReviews(int reviewerUserId, int journalId, String status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = reviewDao.findReviews(reviewerUserId, journalId, status, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		for(Review r: reviews) {
			SystemUser user = userService.getById(r.getUserId());
			r.setUser(user);
			Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
			r.setManuscript(m);
			FinalDecision finalDecision = finalDecisionDao.findByManuscriptIdAndRevisionCount(r.getManuscriptId(), r.getRevisionCount());
			r.setFinalDecision(finalDecision);
			List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(reviewerUserId, r.getManuscriptId(), journalId, r.getRevisionCount());
			r.setReviewEventDateTimes(redtList);
		}
		Collections.sort(reviews);
		return reviews;
	}
	
	@Override
	public List<Review> getReviewsFromReviewerHistory(int reviewerUserId, int journalId, String status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = reviewDao.findReviewsFromReviewerHistory(reviewerUserId, journalId, status, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		for(Review r: reviews) {
			SystemUser user = userService.getById(r.getUserId());
			r.setUser(user);
			Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
			r.setManuscript(m);
			FinalDecision finalDecision = finalDecisionDao.findByManuscriptIdAndRevisionCount(r.getManuscriptId(), r.getRevisionCount());
			r.setFinalDecision(finalDecision);
			List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(reviewerUserId, r.getManuscriptId(), journalId, r.getRevisionCount());
			r.setReviewEventDateTimes(redtList);
		}
		Collections.sort(reviews);
		return reviews;
	}
	
	@Override
	public List<Review> getDismissedReviews(int reviewerUserId, int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = reviewDao.findDismissedReviews(reviewerUserId, journalId, dRequest, iTotalDisplayRecordsPlaceHolder, sortableColumnNames);
		for(Review r: reviews) {
			SystemUser user = userService.getById(r.getUserId());
			r.setUser(user);
			Manuscript m = manuscriptService.getManuscriptById(r.getManuscriptId(), SystemConstants.EVENT_DATE_TIME_BUILD);
			r.setManuscript(m);
			FinalDecision finalDecision = finalDecisionDao.findByManuscriptIdAndRevisionCount(r.getManuscriptId(), r.getRevisionCount());
			r.setFinalDecision(finalDecision);
			List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(reviewerUserId, r.getManuscriptId(), journalId, r.getRevisionCount());
			r.setReviewEventDateTimes(redtList);
		}
		Collections.sort(reviews);
		return reviews;
	}
	
	@Override
	public void selectReviewer(int reviewerUserId, int manuscriptId, boolean createdMember, String password) {
		Review review = new Review();
		Manuscript m = manuscriptDao.findById(manuscriptId);
		review.setUserId(reviewerUserId);
		review.setManuscriptId(manuscriptId);
		review.setFirstStatus(SystemConstants.reviewerS);
		review.setStatus(SystemConstants.reviewerS);
		review.setUserId(reviewerUserId);
		review.setRevisionCount(m.getRevisionCount());
		review.setJournalId(m.getJournalId());
		if(createdMember) {
			review.setCreatedMember(true);
			review.setTempPw(password);
		}
		boolean notDuplicated = checkDuplicateReviewer(reviewerUserId, manuscriptId, m.getJournalId(), m.getRevisionCount());
		if (notDuplicated) {
			ReviewEventDateTime selectDate = new ReviewEventDateTime();
			selectDate.setRevisionCount(m.getRevisionCount());
			selectDate.setUserId(reviewerUserId);
			selectDate.setManuscriptId(manuscriptId);
			selectDate.setStatus(SystemConstants.reviewerS);
			selectDate.setJournalId(m.getJournalId());
			reviewEventDateTimeDao.insert(selectDate);
			reviewDao.insert(review);	
		}
	}
	
	@Override
	public void assignReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, String dateString, HttpServletRequest request, Locale locale) {
		try {
			int manuscriptId = manuscript.getId();
			List<Review> reviews = reviewDao.findReviews(reviewerUserId, manuscriptId, manuscript.getJournalId(), manuscript.getRevisionCount(), null);		
			Review review = reviews.get(0);
			review.setJournalId(manuscript.getJournalId());
			review.setConfirm(true);
			review.setRevisionCount(manuscript.getRevisionCount());		

			SimpleDateFormat format = null;
			if(journal.getLanguageCode().equals("ko"))
				format = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				format = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			Date parseDate = format.parse(dateString);
			java.sql.Date dueDate = new java.sql.Date(parseDate.getTime());
			review.setFirstStatus(SystemConstants.reviewerA);
			review.setStatus(SystemConstants.reviewerA);
			ReviewEventDateTime assignDate = new ReviewEventDateTime();
			assignDate.setRevisionCount(manuscript.getRevisionCount());
			assignDate.setUserId(reviewerUserId);
			assignDate.setManuscriptId(manuscriptId);
			assignDate.setStatus(SystemConstants.reviewerA);
			assignDate.setJournalId(manuscript.getJournalId());
			reviewEventDateTimeDao.insert(assignDate);
			review.setDueDate(dueDate);
			reviewDao.update(review);
			
			List<Keyword> keywords = keywordDao.findByManuscriptId(manuscriptId);
			for(Keyword keyword: keywords) {
				if(!userExpertiseService.hasUserExpertise(reviewerUserId, keyword.getKeyword())) {
					UserExpertise ue = new UserExpertise();
					ue.setExpertise(keyword.getKeyword());
					ue.setUserId(reviewerUserId);
					userExpertiseService.insertExpertise(ue);
				}
			}
			
			if(journalRoleDao.findJournalMember(reviewerUserId, manuscript.getJournalId()) == null)
				authorityService.create(reviewerUserId, manuscript.getJournalId(), SystemConstants.roleMember);

			if(journalRoleDao.findJournalReviewer(reviewerUserId, manuscript.getJournalId()) == null)
				authorityService.create(reviewerUserId, manuscript.getJournalId(), SystemConstants.roleReviewer);
			
			Reviewer reviewer = journalRoleDao.findJournalReviewer(reviewerUserId, manuscript.getJournalId());
			int assignedUpToNow = reviewer.getAssignedUpToNow();
			reviewer.setAssignedUpToNow(assignedUpToNow + 1);
			journalRoleDao.update(reviewer);
			SystemUser reviewerUser = userService.getById(reviewerUserId);
			reviewerUser.setEnabled(true);
			userDao.update(reviewerUser);
			
			SystemUser associateEditorUser = userService.getById(manuscript.getAssociateEditorUserId());
			if(review.isCreatedMember()) {
				emailService.sendEmailToReviewerWithMessageModification(19, reviewerUser, manuscript, journal, emailMessage, request, locale);
				emailService.sendEmailAtAccountCreation(53, associateEditorUser, reviewerUser, journal, review.getTempPw(), request, locale);
				review.setTempPw(null);
				review.setCreatedMember(false);
			} else
				emailService.sendEmailToReviewerWithMessageModification(18, reviewerUser, manuscript, journal, emailMessage, request, locale);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void inviteReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, int editorUserId, String randomQuery, HttpServletRequest request, Locale locale) {
		try {
			int manuscriptId = manuscript.getId();
			List<Review> reviews = reviewDao.findReviews(reviewerUserId, manuscriptId, manuscript.getJournalId(), manuscript.getRevisionCount(), null);		
			Review review = reviews.get(0);

			review.setJournalId(manuscript.getJournalId());
			review.setConfirm(false);
			review.setRevisionCount(manuscript.getRevisionCount());		
			
			ReviewEventDateTime inviteDate = new ReviewEventDateTime();
			inviteDate.setRevisionCount(manuscript.getRevisionCount());
			inviteDate.setUserId(reviewerUserId);
			inviteDate.setManuscriptId(manuscriptId);
			inviteDate.setStatus(SystemConstants.reviewerI);
			inviteDate.setJournalId(manuscript.getJournalId());
			reviewEventDateTimeDao.insert(inviteDate);
			JournalConfiguration jc = journalConfigurationService.getByJournalId(manuscript.getJournalId());
			reviewDao.updateInviteExpirationDate(review.getId(), jc.getInviteCancelDuration());
			
			review.setFirstStatus(SystemConstants.reviewerI);
			review.setStatus(SystemConstants.reviewerI);
			reviewDao.update(review);
			inviteRequestRecord(manuscriptId, editorUserId, reviewerUserId, review.getId(), randomQuery);		
			emailService.sendEmailToReviewerWithMessageModification(16, userService.getById(reviewerUserId), manuscript, journal, emailMessage, request, locale);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<SystemUser> getReviewRequestedUsers(int manuscriptId, int editorId, int reviewerId) {
		List<ReviewRequest> rrs = reviewRequestDao.findReviewRequests(manuscriptId, editorId, reviewerId);
		List<SystemUser> users = new ArrayList<SystemUser>();
		for(ReviewRequest rr: rrs) {
			SystemUser user = userService.getById(rr.getReviewerUserId());
			users.add(user);
		}
		return users;
	}
	
	@Override
	public void inviteRequestRecord(int manuscriptId, int editorUserId, int reviewerUserId, int reviewId, String randomQuery) {
		ReviewRequest storedRr = reviewRequestDao.findByReviewId(reviewId);
		if(storedRr == null) {
			ReviewRequest rr = new ReviewRequest();
			rr.setManuscriptId(manuscriptId);
			rr.setEditorUserId(editorUserId);
			rr.setReviewerUserId(reviewerUserId);
			rr.setQuery(randomQuery);
			rr.setReviewId(reviewId);
			reviewRequestDao.insert(rr);
		} else {
			storedRr.setEditorUserId(editorUserId);
			storedRr.setReviewerUserId(reviewerUserId);
			storedRr.setQuery(randomQuery);
			reviewRequestDao.update(storedRr);
		}
	}
	
	@Override
	public String generateRandomQuery() {
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	@Override
	public void removeReviewer(int reviewerUserId, int manuscriptId) {
		Manuscript m = manuscriptDao.findById(manuscriptId);
		List<Review> reviews = reviewDao.findReviews(reviewerUserId, manuscriptId, m.getJournalId(), m.getRevisionCount(), null);
		for(Review r: reviews)
			reviewDao.delete(r.getId());
	}
	
	@Override
	public void cancelReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, int revisionCount) {
		SystemUser reviewerUser = userService.getById(reviewerUserId);
		List<Review> reviews = getReviews(reviewerUserId, manuscript.getId(), manuscript.getJournalId(), revisionCount, null);
		if(reviews != null && reviews.size() > 0) {
			Review review =  reviews.get(0);
			
			ReviewRequest reviewerRequest = reviewRequestDao.findByReviewId(review.getId());
			if(reviewerRequest != null) {
				reviewerRequest.setAvailable(false);
				reviewRequestDao.update(reviewerRequest);
			}
			
			ReviewRequest rr = reviewRequestDao.findByReviewId(review.getId());
			if(rr != null) {
				rr.setAvailable(false);
				reviewRequestDao.update(rr);
			}
			review.setStatus(SystemConstants.reviewerS);
			reviewDao.update(review);
		}
		emailService.sendEmailToReviewerWithMessageModification(23, reviewerUser, manuscript, journal, null, request, locale);
	}
	
	@Override
	public void dismissReviewer(int reviewerUserId,  Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale) {
		int manuscriptId = manuscript.getId();
		SystemUser reviewerUser = userService.getById(reviewerUserId);
		List<Review> reviews = this.getReviews(reviewerUserId, manuscriptId, manuscript.getJournalId(), manuscript.getRevisionCount(), null);
		if(reviews != null && reviews.size() > 0) {
			Review review = reviews.get(0);
			review.setStatus(SystemConstants.reviewerM);
			reviewDao.update(review);
		}
		ReviewEventDateTime dismissDate = new ReviewEventDateTime();
		dismissDate.setRevisionCount(manuscript.getRevisionCount());
		dismissDate.setUserId(reviewerUserId);
		dismissDate.setManuscriptId(manuscriptId);
		dismissDate.setStatus(SystemConstants.reviewerM);
		dismissDate.setJournalId(manuscript.getJournalId());
		reviewEventDateTimeDao.insert(dismissDate);
		emailService.sendEmailToReviewerWithMessageModification(26, reviewerUser, manuscript, journal, null, request, locale);
	}
	
	@Override
	public void automaticDismissReviewer(int reviewerUserId,  Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, int revisionCount) {
		int manuscriptId = manuscript.getId();
		SystemUser reviewerUser = userService.getById(reviewerUserId);
		List<Review> reviews = this.getReviews(reviewerUserId, manuscriptId, manuscript.getJournalId(), revisionCount, null);
		if(reviews != null && reviews.size() > 0) {
			Review review = reviews.get(0);
			review.setStatus(SystemConstants.reviewerT);
			reviewDao.update(review);
		}
		ReviewEventDateTime dismissDate = new ReviewEventDateTime();
		dismissDate.setRevisionCount(manuscript.getRevisionCount());
		dismissDate.setUserId(reviewerUserId);
		dismissDate.setManuscriptId(manuscriptId);
		dismissDate.setStatus(SystemConstants.reviewerT);
		dismissDate.setJournalId(manuscript.getJournalId());
		reviewEventDateTimeDao.insert(dismissDate);
		emailService.sendEmailToReviewerWithMessageModification(26, reviewerUser, manuscript, journal, null, request, locale);
	}
	
	@Override
	public boolean checkDuplicateReviewer(int reviewerUserId, int manuscriptId, int journalId, int revisionCount) {
		List<Review> reviews = reviewDao.findReviews(reviewerUserId, manuscriptId, journalId, revisionCount, null);
		if (reviews != null && reviews.size() > 0 && reviews.get(0).getUserId() == reviewerUserId) 
			return false;
		else 
			return true;
	}
	
	@Override
	public List<Reviewer> getReviewers(int manuscriptId, int journalId) {
		List<Reviewer> reviewers = null;
		if(manuscriptId == 0) {
			reviewers = journalRoleDao.findJournalReviewers(0, journalId);
			for(Reviewer reviewer: reviewers) {
				SystemUser user = userService.getById(reviewer.getUserId());
				reviewer.setUser(user);
			}
		} else {
			Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EVENT_DATE_TIME_BUILD);
			List<Review> reviews = reviewDao.findReviews(0, manuscriptId, m.getJournalId(), m.getRevisionCount(), null);
			reviewers = new ArrayList<Reviewer>();
			for (Review r : reviews) {
				Reviewer reviewer = journalRoleDao.findJournalReviewer(r.getUserId(), journalId);
				SystemUser user = userService.getById(reviewer.getUserId());
				reviewer.setUser(user);
				reviewers.add(reviewer);
			}
		}
		return reviewers;
	}

	@Override
	public void confirmReviewSheet(boolean confirm, Review review, Journal journal, HttpServletRequest request, Locale locale) throws IOException {
		Manuscript manuscript = manuscriptService.getManuscriptById(review.getManuscriptId(), SystemConstants.EMAIL_BUILD);
		try {
			if(confirm) {
				Review currentReview = reviewDao.findById(review.getId());
				if (currentReview.getStatus().equals(SystemConstants.reviewerA)) {
					review.setStatus(SystemConstants.reviewerC);
					
					ReviewEventDateTime completeDate = new ReviewEventDateTime();
					completeDate.setRevisionCount(manuscript.getRevisionCount());
					completeDate.setUserId(review.getUserId());
					completeDate.setManuscriptId(review.getManuscriptId());
					completeDate.setStatus(SystemConstants.reviewerC);
					completeDate.setJournalId(manuscript.getJournalId());
					reviewEventDateTimeDao.insert(completeDate);
					Reviewer reviewer = journalRoleDao.findJournalReviewer(review.getUserId(), manuscript.getJournalId());
					
					int completedUpToNow = reviewer.getCompletedUpToNow();
					reviewer.setCompletedUpToNow(completedUpToNow + 1);
					journalRoleDao.update(reviewer);
					
					SystemUser reviewerUser = userService.getById(review.getUserId());
					emailService.sendEmailToReviewerWithMessageModification(25, reviewerUser, manuscript, journal, null, request, locale);
				}
			}
			
			Comment commentToAuthor = review.getCommentToAuthor();
			if(commentToAuthor != null && commentToAuthor.getText() != null && !commentToAuthor.getText().trim().equals("")) {
				if(commentDao.findComment(commentToAuthor.getFromUserId(), commentToAuthor.getToUserId(), SystemConstants.roleReviewer, SystemConstants.roleMember, commentToAuthor.getManuscriptId(), commentToAuthor.getRevisionCount(), manuscript.getStatus()) == null)
					commentDao.insert(commentToAuthor);
				else
					commentDao.update(commentToAuthor);
			}

			Comment commentToEditor = review.getCommentToEditor();
			if(commentToEditor != null && commentToEditor.getText() != null && !commentToEditor.getText().trim().equals("")) {
				if(commentDao.findComment(commentToEditor.getFromUserId(), commentToEditor.getToUserId(), SystemConstants.roleReviewer, commentToEditor.getToRole(), commentToEditor.getManuscriptId(), commentToEditor.getRevisionCount(), manuscript.getStatus()) == null)
					commentDao.insert(commentToEditor);
				else
					commentDao.update(commentToEditor);
				
				if(journal.getType().equals("A") || journal.getType().equals("B")) {
					Comment commentToAE = review.getCommentToEditor();
					commentToAE.setToUserId(manuscript.getAssociateEditorUserId());
					commentToAE.setToRole(SystemConstants.roleAEditor);
					if(commentDao.findComment(commentToAE.getFromUserId(), commentToAE.getToUserId(), SystemConstants.roleReviewer, commentToAE.getToRole(), commentToAE.getManuscriptId(), commentToAE.getRevisionCount(), manuscript.getStatus()) == null)
						commentDao.insert(commentToAE);
					else
						commentDao.update(commentToAE);
				}
			}
			if(review.getReReview() > review.getRevisionCount()) {
				List<Review> reviews = reviewDao.findReviews(review.getUserId(), review.getManuscriptId(), review.getJournalId(), review.getReReview(), SystemConstants.reviewerS);
				if(reviews == null || reviews.size() == 0) {
					Review reReview = new Review();
					reReview.setUserId(review.getUserId());
					reReview.setJournalId(review.getJournalId());
					reReview.setManuscriptId(review.getManuscriptId());
					reReview.setStatus(SystemConstants.reviewerS);
					reReview.setReReview(review.getReReview());
					reReview.setRevisionCount(review.getReReview());
					reviewDao.insert(reReview);
				}
			} else if(review.getReReview() == 0) {
				List<Review> reviews = reviewDao.findReviews(review.getUserId(), review.getManuscriptId(), review.getJournalId(), -1, SystemConstants.reviewerS);
				if(reviews != null && reviews.size() > 0)
					for(Review r: reviews)
						reviewDao.delete(r.getId());
			}
			reviewDao.update(review);
			
			List<Review> reviews = reviewDao.findReviews(0, manuscript.getId(), journal.getId(), manuscript.getRevisionCount(), SystemConstants.reviewerC);
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			if(reviews != null && reviews.size() == jc.getReviewCompleteCount())
				emailService.sendEmail(29, manuscript, journal, null, request, locale);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int numReviewManuscripts(int userId, int manuscriptId, int journalId, int revisionCount, List<String> status) {
		return reviewDao.numReviews(userId, manuscriptId, journalId, revisionCount, status);
	}
	
	@Override
	public int numReviewFromReviewerHistory(int reviewerUserId, int journalId, String firstStatus) {
		return reviewDao.numReviewsFromReviewerHistory(reviewerUserId, journalId, firstStatus);
	}
	
	@Override
	public void reviewerDecision(ReviewerSuggest rs, String decision, String query, Journal journal, HttpServletRequest request, Locale locale) {
		ReviewRequest rr = reviewRequestDao.findRequestByQuery(query);
		if (rr != null) {
			if (rr.isAvailable()) {
				int manuscriptId = rr.getManuscriptId();
				Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
				int reviewerUserId = rr.getReviewerUserId();
				Review review = reviewDao.findById(rr.getReviewId());
				SystemUser reviewerUser = userService.getById(reviewerUserId);
				if(decision.equals("D")) {	//Decline
					rs.setReviewerUserId(rr.getReviewerUserId());
					rs.setEditorUserId(rr.getEditorUserId());
					ReviewerSuggest storedSuggest = reviewerSuggestDao.findReviewerSuggest(reviewerUserId, manuscriptId, review.getId());
					if(storedSuggest != null) {
						rs.setId(storedSuggest.getId());
						reviewerSuggestDao.update(rs);
					} else
						reviewerSuggestDao.insert(rs);
					
					int reason = rs.getReason();
					EmailMessage emailMessage = emailService.getGeneralEmailMessage(17, manuscript, journal, reviewerUser.getUsername(), request, locale);
					String body = emailMessage.getBody();
					body = body.replace("[reviewInviteRejectReason]", messageSource.getMessage("reviewer.decline.reason." + reason, null, locale));
					emailMessage.setBody(body);
					ReviewEventDateTime declineDate = new ReviewEventDateTime();
					declineDate.setRevisionCount(manuscript.getRevisionCount());
					declineDate.setUserId(reviewerUserId);
					declineDate.setManuscriptId(manuscriptId);
					declineDate.setStatus(SystemConstants.reviewerD);
					declineDate.setJournalId(manuscript.getJournalId());
					reviewEventDateTimeDao.insert(declineDate);
					review.setStatus(SystemConstants.reviewerD);
					review.setConfirm(false);
					emailService.sendEmailToReviewerWithMessageModification(17, reviewerUser, manuscript, journal, emailMessage, request, locale);
				} else if(decision.equals("T")) {	//Take
					review.setStatus(SystemConstants.reviewerA);
					
					reviewerUser.setEnabled(true);
					userDao.update(reviewerUser);
					
					if(journalRoleDao.findJournalMember(reviewerUserId, manuscript.getJournalId()) == null)
						authorityService.create(reviewerUserId, manuscript.getJournalId(), SystemConstants.roleMember);

					if(journalRoleDao.findJournalReviewer(reviewerUserId, manuscript.getJournalId()) == null)
						authorityService.create(reviewerUserId, manuscript.getJournalId(), SystemConstants.roleReviewer);
					
					Reviewer reviewer = journalRoleDao.findJournalReviewer(reviewerUserId, manuscript.getJournalId());
					int invitedUpToNow = reviewer.getInvitedUpToNow();
					reviewer.setInvitedUpToNow(invitedUpToNow + 1);
					journalRoleDao.update(reviewer);
					
					JournalConfiguration jc = journalConfigurationService.getByJournalId(manuscript.getJournalId());
					Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
					dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getReviewDueDuration() * 7);
					java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
					review.setDueDate(dueDate);
					review.setConfirm(true);
					review.setRevisionCount(manuscript.getRevisionCount());
					review.setJournalId(manuscript.getJournalId());
	    			SimpleDateFormat sdf = null;
	    			if(journal.getLanguageCode().equals("ko"))
	    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
	    			else
	    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
					
					EmailMessage emailMessage = null;
					if(review.isCreatedMember())
						 emailMessage = emailService.getGeneralEmailMessage(21, manuscript, journal, reviewerUser.getUsername(), request, locale);
					else
						 emailMessage = emailService.getGeneralEmailMessage(20, manuscript, journal, reviewerUser.getUsername(), request, locale);
					String body = emailMessage.getBody();
					String dateString = sdf.format(dueDate);
					body = body.replace("[dueDate]", dateString);
					emailMessage.setBody(body);
					
					ReviewEventDateTime assignDate = new ReviewEventDateTime();
					assignDate.setRevisionCount(manuscript.getRevisionCount());
					assignDate.setUserId(reviewerUserId);
					assignDate.setManuscriptId(manuscriptId);
					assignDate.setStatus(SystemConstants.reviewerA);
					assignDate.setJournalId(manuscript.getJournalId());
					reviewEventDateTimeDao.insert(assignDate);
					
					if(review.isCreatedMember()) {
						SystemUser associateEditorUser = userService.getById(manuscript.getAssociateEditorUserId());
						emailService.sendEmailToReviewerWithMessageModification(21, reviewerUser, manuscript, journal, emailMessage, request, locale);
						emailService.sendEmailAtAccountCreation(53, associateEditorUser, reviewerUser, journal, review.getTempPw(), request, locale);
						review.setTempPw(null);
						review.setCreatedMember(false);
					} else 
						emailService.sendEmailToReviewerWithMessageModification(20, reviewerUser, manuscript, journal, emailMessage, request, locale);
				}
				reviewDao.update(review);
			}
			rr.setAvailable(false);
			reviewRequestDao.update(rr);
		}
	}

	@Override
	public void checkReviewerDueDate() {
		List<Journal> journals = journalService.getAll();
		for(Journal journal: journals) {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			List<Review> allReviews = reviewDao.findReviews(0, 0, journal.getId(), -1, SystemConstants.reviewerA);
			for (Review review : allReviews) {
				Manuscript manuscript = manuscriptService.getManuscriptById(review.getManuscriptId(), SystemConstants.EMAIL_BUILD);
				if (manuscript.getStatus().equals(SystemConstants.statusR)) {
					Date dueDate = review.getDueDate();
					if (dueDate != null) {
						Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
						dueDateCalendar.setTime(dueDate);
						int dueDateDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
						int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
						int diff = dueDateDayOfYear - todayDayOfYear;
						
						// GENTLE_REMIND_REVIEWER
						if(dueDateCalendar.get(Calendar.YEAR) > todayCalendar.get(Calendar.YEAR)) {
							dueDateDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
							diff = dueDateDayOfYear - todayDayOfYear;
						}
						if(diff > 0 && diff == jc.getGentleRemindReviewer()) {
							SystemUser reviewerUser = userService.getById(review.getUserId());
							
							Locale locale = null;
							if(journal.getLanguageCode().equals("ko"))
								locale = Locale.KOREAN;
							else
								locale = Locale.ENGLISH;
							
							EmailMessage emailMessage = emailService.getGeneralEmailMessage(27, manuscript, journal, reviewerUser.getUsername(), null, locale);
							String body = emailMessage.getBody();
			    			SimpleDateFormat sdf = null;
			    			if(journal.getLanguageCode().equals("ko"))
			    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			    			else
			    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
							String defaultDueDate = sdf.format(dueDate);
							body = body.replace("[dueDate]", defaultDueDate);
							emailMessage.setBody(body);
							emailService.sendEmailToReviewerWithMessageModification(27, reviewerUser, manuscript, journal, emailMessage, null, locale);
						}
						
						// REMIND_REVIEWER
						dueDateDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
						todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
						if(dueDateCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR))
							todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
						
						diff = todayDayOfYear - dueDateDayOfYear;
						if(diff >= jc.getRemindReviewer() &&  diff % jc.getRemindReviewer() == 0) {
							SystemUser reviewerUser = userService.getById(review.getUserId());
							Locale locale = null;
							if(journal.getLanguageCode().equals("ko"))
								locale = Locale.KOREAN;
							else
								locale = Locale.ENGLISH;
							EmailMessage emailMessage = emailService.getGeneralEmailMessage(28, manuscript, journal, reviewerUser.getUsername(), null, locale);
							String body = emailMessage.getBody();
			    			SimpleDateFormat sdf = null;
			    			if(journal.getLanguageCode().equals("ko"))
			    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			    			else
			    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
							String defaultDueDate = sdf.format(dueDate);
							body = body.replace("[dueDate]", defaultDueDate);
							emailMessage.setBody(body);
							emailService.sendEmailToReviewerWithMessageModification(28, reviewerUser, manuscript, journal, emailMessage, null, locale);
						}
					}
				}
			}
		}
	}
	
	@Override
	public void checkInvitedReviewer() {
		List<Journal> journals = journalService.getAll();
		for(Journal journal: journals) {
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
			List<Review> invitedReviews = reviewDao.findReviews(0, 0, journal.getId(), -1, SystemConstants.reviewerI);
			Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			for (Review invitedReview : invitedReviews) {
				Manuscript manuscript = manuscriptService.getManuscriptById(invitedReview.getManuscriptId(), SystemConstants.EMAIL_BUILD);
				if (manuscript.getStatus().equals(SystemConstants.statusR)) {
					int redtId = reviewEventDateTimeDao.findLastReviewEventDateTimeId(invitedReview.getUserId(), manuscript.getId(),SystemConstants.reviewerI);
					if(redtId != 0) {
						ReviewEventDateTime invitedDateTime = reviewEventDateTimeDao.findReviewEventDateTimeById(redtId);
						Calendar inviteCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
						inviteCalendar.setTime(invitedDateTime.getDate());
						
						int inviteDayOfYear = inviteCalendar.get(Calendar.DAY_OF_YEAR);
						int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
						int diff = todayDayOfYear - inviteDayOfYear;
						
						if(inviteCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR)) {
							todayDayOfYear = 365 + todayCalendar.get(Calendar.DAY_OF_YEAR);
							diff = todayDayOfYear - inviteDayOfYear;
						}
						
						//	INVITE_REMIND_DURATION
						if(diff > 0 && diff % jc.getInviteRemindDuration() == 0) {
							SystemUser reviewerUser = userService.getById(invitedReview.getUserId());
							Locale locale = null;
							if(journal.getLanguageCode().equals("ko"))
								locale = Locale.KOREAN;
							else
								locale = Locale.ENGLISH;
							EmailMessage emailMessage = emailService.getGeneralEmailMessage(22, manuscript, journal, reviewerUser.getUsername(), null, locale);
							String body = emailMessage.getBody();
							body = body.replace("[durationReviewByWeeks]", Integer.toString(jc.getReviewDueDuration()));
							ReviewRequest rr = reviewRequestDao.findByReviewId(invitedReview.getId());
							if(rr != null) {
								String query = rr.getQuery();
								String reviewInviteUrl = SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId() + "/reviewInvitation/" + query;
								body = body.replace("[reviewInviteUrl]", reviewInviteUrl);
								emailMessage.setBody(body);
								emailService.sendEmailToReviewerWithMessageModification(22, reviewerUser, manuscript, journal, emailMessage, null, locale);
							}
						}
						
						// INVITE_CANCEL_DURATION
						if(invitedReview.getInviteExpirationDate() != null) {
							Calendar inviteExpirationCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
							inviteExpirationCalendar.setTime(invitedReview.getInviteExpirationDate());
							
							if(inviteExpirationCalendar.get(Calendar.YEAR) == todayCalendar.get(Calendar.YEAR) && 
									inviteExpirationCalendar.get(Calendar.DAY_OF_YEAR) == todayCalendar.get(Calendar.DAY_OF_YEAR)) {
								SystemUser reviewerUser = userService.getById(invitedReview.getUserId());
								ReviewRequest reviewRequest = reviewRequestDao.findByReviewId(invitedReview.getId());
								if(reviewRequest != null) {
									reviewRequest.setAvailable(false);
									reviewRequestDao.update(reviewRequest);
								}
								invitedReview.setStatus(SystemConstants.reviewerT);
								reviewDao.update(invitedReview);
								
								Locale locale = null;
								if(journal.getLanguageCode().equals("ko"))
									locale = Locale.KOREAN;
								else
									locale = Locale.ENGLISH;
								
								EmailMessage emailMessage = emailService.getGeneralEmailMessage(24, manuscript, journal, reviewerUser.getUsername(), null, locale);
								emailService.sendEmailToReviewerWithMessageModification(24, reviewerUser, manuscript, journal, emailMessage, null, locale);
							}
						}

					}
				}
			}
		}
	}
}
