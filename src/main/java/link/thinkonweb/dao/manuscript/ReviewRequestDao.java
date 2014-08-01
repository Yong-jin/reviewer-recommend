package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.ReviewRequest;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;



public class ReviewRequestDao {	
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert rrInsert;
	public void setDataSource(DataSource dataSource) {
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		this.rrInsert = new SimpleJdbcInsert(dataSource).withTableName("MANUSCRIPTS_REVIEW_REQUEST").usingGeneratedKeyColumns("ID");
	}
	public int insert(ReviewRequest rr) {
		int key = rrInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(rr)).intValue();
		return key;
	}
	
	public List<ReviewRequest> findRequestAll() {
		List<ReviewRequest> rr = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class));
		
		return rr;		
	}
	public int numRequestAll() {
		List<ReviewRequest> rr = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class));
		int id = 0;
		for (ReviewRequest m : rr) {
			id = m.getId();
		}
		return id;		
	}
	
	public ReviewRequest findById(int id) {
		try {
			return simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE ID = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), id);	
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public ReviewRequest findByReviewId(int reviewId) {
		try {
			return simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE REVIEW_ID = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), reviewId);	
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<ReviewRequest> findByManuscriptId(int manuscriptId) {
		try {
			return simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), manuscriptId);	
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<ReviewRequest> findReviewRequests(int manuscriptId, int editorUserId, int reviewerUserId) {
		if(reviewerUserId == 0)
			return simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE MANUSCRIPT_ID = ? AND EDITOR_USER_ID = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), manuscriptId, editorUserId);
		else
			return simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE MANUSCRIPT_ID = ? AND EDITOR_USER_ID = ? AND REVIEWER_USER_ID = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), manuscriptId, editorUserId, reviewerUserId);	
	}
	
	public ReviewRequest findRequestByQuery(String query) {
		ReviewRequest r = null;
		r = simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_REQUEST WHERE query = ?", new BeanPropertyRowMapper<ReviewRequest>(ReviewRequest.class), query);
		return 	r;
	}

	public void update(ReviewRequest rr) {
		simpleJdbcTemplate.update("UPDATE MANUSCRIPTS_REVIEW_REQUEST SET " +
				"QUERY=:query," +
				"EDITOR_USER_ID=:editorUserId," +
				"REVIEWER_USER_ID=:reviewerUserId," +
				"REVIEW_ID=:reviewId," +
				"AVAILABLE=:available," +
				"MANUSCRIPT_ID=:manuscriptId " +
				"WHERE (id=:id);", new BeanPropertySqlParameterSource(rr));
	}
	
	public void delete(int id) {
		simpleJdbcTemplate.update("DELETE FROM MANUSCRIPTS_REVIEW_REQUEST WHERE ID = ?", id);
	}
}
