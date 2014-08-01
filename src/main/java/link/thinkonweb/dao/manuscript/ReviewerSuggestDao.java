package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.ReviewerSuggest;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;



public class ReviewerSuggestDao {	
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert rpInsert;
	public void setDataSource(DataSource dataSource) {	
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		this.rpInsert = new SimpleJdbcInsert(dataSource).withTableName("MANUSCRIPTS_REVIEW_DECLINE_SUGGEST").usingGeneratedKeyColumns("ID");
	}
	public int insert(ReviewerSuggest rs) {
		int key = rpInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(rs)).intValue();
		return key;
	}
	public ReviewerSuggest findById(int id) {
		try{
			ReviewerSuggest rs = simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_DECLINE_SUGGEST WHERE ID = ?", new BeanPropertyRowMapper<ReviewerSuggest>(ReviewerSuggest.class), id);
			return rs;	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	} 
	public List<ReviewerSuggest> findReviewerSuggests(int userId, int manuscriptId) {
		try {
			List<ReviewerSuggest> rs = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_DECLINE_SUGGEST WHERE MANUSCRIPT_ID = ? AND REVIEWER_USER_ID = ?", new BeanPropertyRowMapper<ReviewerSuggest>(ReviewerSuggest.class), manuscriptId, userId);		
			return rs;		
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public ReviewerSuggest findReviewerSuggest(int userId, int manuscriptId, int reviewId) {
		try {
			ReviewerSuggest rs = simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_DECLINE_SUGGEST WHERE MANUSCRIPT_ID = ? AND REVIEWER_USER_ID = ? AND REVIEW_ID = ?", new BeanPropertyRowMapper<ReviewerSuggest>(ReviewerSuggest.class), manuscriptId, userId, reviewId);		
			return rs;		
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	public void update(ReviewerSuggest rs) {
		simpleJdbcTemplate.update("UPDATE MANUSCRIPTS_REVIEW_DECLINE_SUGGEST SET FIRST_NAME=:firstName," +
				"LAST_NAME=:lastName," +
				"REVIEWER_USER_ID=:reviewerUserId," +
				"REVIEW_ID=:reviewId," +
				"EDITOR_USER_ID=:editorUserId," +
				"EMAIL=:email," +
				"INSTITUTION=:institution," +
				"MANUSCRIPT_Id=:manuscriptId," +
				"DEGREE=:degree," +
				"SALUTATION=:salutatioin," +
				"COUNTRY=:countryCode," +
				"DEPARTMENT=:department," +
				"LOCAL_DEPARTMENT=:localDepartment," +
				"LOCAL_INSTITUTION=:localInstitution," +
				"LOCAL_FULL_NAME=:localFullName," +
				"COMMENT=:comment," +
				"REASON=:reason," +
				"USER_ID=:userId " +
				"WHERE (ID=:id);", new BeanPropertySqlParameterSource(rs));
		
	}
	public void delete(int id) {
		simpleJdbcTemplate.update("DELETE FROM MANUSCRIPTS_REVIEW_DECLINE_SUGGEST WHERE ID = ?", id);
	}
}
