package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import link.thinkonweb.domain.manuscript.ReviewerRecommend;

public class ManuscriptReviewerRecommendDaoImpl extends NamedParameterJdbcDaoSupport implements ManuscriptReviewerRecommendDao{
	@Inject
	private ManuscriptReviewerRecommendRowMapper manuscriptReviewerRecommendRowMapper;
	
	@Override
	public void insert(ReviewerRecommend reviewerRecommend) {
		String sql = "INSERT INTO MANUSCRIPTS_REVIEWER_RECOMMEND (REVIEWER_USER_ID, MANUSCRIPT_ID, REVISION_COUNT, RECOMMEND_VALUE, FR_VALUE) " + " VALUES (:reviewer_user_id, :manuscript_id, :revision_count, :recommend_value, :fr_value)";
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(reviewerRecommend);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}

	@Override
	public ReviewerRecommend findById(int id) {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEWER_RECOMMEND WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, manuscriptReviewerRecommendRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<ReviewerRecommend> findByManuscriptId(int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEWER_RECOMMEND WHERE MANUSCRIPT_ID = ?";
		List<ReviewerRecommend> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, manuscriptReviewerRecommendRowMapper);	
		return list;
	}
	
	@Override
	public List<ReviewerRecommend> findAll() {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEWER_RECOMMEND";
		List<ReviewerRecommend> list = this.getJdbcTemplate().query(sql, new Object[] {}, manuscriptReviewerRecommendRowMapper);	
		return list;
	}
	
	@Override
	public void update(ReviewerRecommend reviewerRecommend) {
		String sql = "UPDATE MANUSCRIPTS_REVIEWER_RECOMMEND SET REVIEWER_USER_ID =? , MANUSCRIPT_ID =?, REVISION_COUNT=?, RECOMMEND_VALUE = ?, FR_VALUE = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {reviewerRecommend.getReviewer_user_id() , reviewerRecommend.getManuscript_id() , reviewerRecommend.getRevision_count(), reviewerRecommend.getRecommend_value(), reviewerRecommend.getFr_value(), reviewerRecommend.getId()});
	}

	@Override
	public void delete(int id) {
		String sql = "DELETE FROM MANUSCRIPTS_REVIEWER_RECOMMEND WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {id});		
	}

	@Override
	public void deleteAll() {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM MANUSCRIPTS_REVIEWER_RECOMMEND";
		this.getJdbcTemplate().update(sql);
	}


	


}
