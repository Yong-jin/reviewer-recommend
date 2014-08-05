package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.ReviewEventDateTime;

public interface ReviewEventDateTimeDao {
	public void insert(ReviewEventDateTime reviewEventDateTime);
	public void update(ReviewEventDateTime reviewEventDateTime);
	public void delete(ReviewEventDateTime reviewEventDateTime);
	public int findLastReviewEventDateTimeId(int userId, int manuscriptId, String status);
	public ReviewEventDateTime findReviewEventDateTimeById(int id);
	public List<ReviewEventDateTime> findReviewEventDateTimesByManuscriptId(int manuscriptId);
	public List<ReviewEventDateTime> findReviewEventDateTimes(int userId, int manuscriptId, int journalId, int revisionCount);
	public int numReviewsBeforeSpecificDays(int userId, int days);
}
