package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.ReviewerRecommend;

import org.springframework.jdbc.core.RowMapper;

public class ManuscriptReviewerRecommendRowMapper implements RowMapper<ReviewerRecommend>{

	@Override
	public ReviewerRecommend mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		ReviewerRecommend reviewerRecommend = new ReviewerRecommend();
		
		reviewerRecommend.setId(rs.getInt("ID"));
		reviewerRecommend.setReviewer_user_id(rs.getInt("REVIEWER_USER_ID"));
		reviewerRecommend.setManuscript_id(rs.getInt("MANUSCRIPT_ID"));
		reviewerRecommend.setRevision_count(rs.getInt("REVISION_COUNT"));
		reviewerRecommend.setRecommend_value(rs.getDouble("RECOMMEND_VALUE"));
		reviewerRecommend.setFr_value(rs.getDouble("FR_VALUE"));
		
		return reviewerRecommend;
	}

}
