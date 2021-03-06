package link.thinkonweb.service.roles;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import link.thinkonweb.configuration.SystemConstants;
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
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewEventDateTime;
import link.thinkonweb.domain.manuscript.ReviewRequest;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserExpertiseService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import org.springframework.context.MessageSource;

public class ReviewerServiceImpl implements ReviewerService {
	@Inject
	private ManuscriptDao manuscriptDao;
	@Inject
	private ReviewDaoImpl reviewDao;
	@Inject
	private ReviewRequestDao reviewRequestDao;
	@Inject
	private ReviewEventDateTimeDao reviewEventDateTimeDao;
	@Inject
	private UploadedFileDaoImpl uploadedFileDao;
	@Inject
	private JournalRoleDao journalRoleDao;
	@Inject
	private KeywordDao keywordDao;
	@Inject
	private CommentDao commentDao;
	@Inject
	private FinalDecisionDao finalDecisionDao;
	@Inject
	private ManuscriptService manuscriptService;
	@Inject
	private JournalConfigurationService journalConfigurationService;
	@Inject
	private UserService userService;
	@Inject
	private JournalService journalService;
	@Inject
	private AuthorityService authorityService;
	@Inject
	private UserExpertiseService userExpertiseService;
	@Inject
	private MessageSource messageSource;
	@Inject
	private SystemUtil systemUtil;
	@Inject
	private ReviewerSuggestDao reviewerSuggestDao;
	@Inject
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
				List<ReviewEventDateTime> redtList = reviewEventDateTimeDao.findReviewEventDateTimes(r.getUserId(), manuscriptId, journalId, revisionunt);
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
	public int numReviewManuscripts(int userId, int manuscriptId, int journalId, int revisionCount, List<String> status) {
		return reviewDao.numReviews(userId, manuscriptId, journalId, revisionCount, status);
	}
	
	@Override
	public int numReviewFromReviewerHistory(int reviewerUserId, int journalId, String firstStatus) {
		return reviewDao.numReviewsFromReviewerHistory(reviewerUserId, journalId, firstStatus);
	}

}
