package link.thinkonweb.service.roles;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewerSuggest;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;

public interface ReviewerService {
	public void createReviewer(Reviewer reviewer);
	public void selectReviewer(int reviewerUserId, int manuscriptId, boolean createdMember, String password);
	public void inviteReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, int editorUserId, String randomQuery, HttpServletRequest request, Locale locale);
	public void assignReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, String dateString, HttpServletRequest request, Locale locale);
	public void cancelReviewer(int reviewerUserId, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, int revisionCount);
	public void automaticDismissReviewer(int reviewerUserId,  Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, int revisionCount);
	public void dismissReviewer(int reviewerUserId,  Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void removeReviewer(int reviewerUserId, int manuscriptId);
	public void confirmReviewSheet( boolean confirm, Review review, Journal journal, HttpServletRequest request, Locale locale) throws IOException;
	public void inviteRequestRecord(int manuscriptId, int editorUserId, int reviewerId, int reviewId, String randomQuery);
	public void reviewerDecision(ReviewerSuggest rs, String decision, String randomQuery, Journal journal, HttpServletRequest request, Locale locale);
	public Review getReviewById(int reviewId);
	public Reviewer getReviewer(int userId, int journalId);
	public Reviewer getReviewerById(int id);
	public List<Review> getReviews(int userId, int manuscriptId, int journalId, int revisionCount, String status);
	public List<Review> getReviews(int reviewerUserId, int journalId, String status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<Review> getReviewsFromReviewerHistory(int reviewerUserId, int journalId, String firstStatus, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<Review> getDismissedReviews(int reviewerUserId, int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<Review> getReviewManuscriptsForMyActivity(int reviewerUserId);
	public List<Reviewer> getReviewers(int manuscriptId, int journalId);
	public boolean checkDuplicateReviewer(int reviewerUserId, int manuscriptId, int journalId, int revisionCount);
	public List<SystemUser> getReviewRequestedUsers(int manuscriptId, int editorId, int reviewerUserId);
	public String generateRandomQuery();
	public int numReviewFromReviewerHistory(int reviewerUserId, int journalId, String firstStatus);
	public int numReviewManuscripts(int userId, int manuscriptId, int journalId, int revisionCount, List<String> status);
	public int numReviewManuscriptsForMyActivity(int reviewerUserId);
	public void checkReviewerDueDate();
	public void checkInvitedReviewer();
}
