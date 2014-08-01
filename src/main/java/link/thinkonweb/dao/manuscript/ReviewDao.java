package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.util.DataTableClientRequest;

public interface ReviewDao {
	public int insert(Review review);
	public Review findById(int id);
	public int numReviews(int userId, int manuscriptId, int journalId, int revisionCount, List<String> status);
	public List<Review> findReviews(int userId, int manuscriptId, int journalId, int revisionCount, String status);
	public List<Review> findReviewManuscriptsForMyActivity(int userId);
	public List<Review> findAll(int journalId);
	public int numReviewManuscriptsForMyActivity(int userId);
	public List<Review> findReviews(int userId, int journalId, String status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<Review> findReviewsFromReviewerHistory(int userId, int journalId, String firstStatus, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int numReviewsFromReviewerHistory(int userId, int journalId, String firstStatus);
	public List<Review> findDismissedReviews(int userId, int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public void update(Review review);
	public void delete(int id);
	public void updateInviteExpirationDate(int reviewId, int day);
}
