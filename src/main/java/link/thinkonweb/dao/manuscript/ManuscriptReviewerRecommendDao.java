package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.ReviewerRecommend;

public interface ManuscriptReviewerRecommendDao {
	public void 				insert(ReviewerRecommend reviewerRecommend);
	public ReviewerRecommend findById(int id);
	public List<ReviewerRecommend> findByManuscriptId(int manuscriptId);
	public List<ReviewerRecommend> findAll();
	public void 			update(ReviewerRecommend reviewerRecommend);
	public void 			delete(int manuscriptId);
	public void			deleteAll();
}
