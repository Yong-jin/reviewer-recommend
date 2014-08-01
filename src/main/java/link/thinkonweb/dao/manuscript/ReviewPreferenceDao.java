package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.ReviewPreference;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;



public class ReviewPreferenceDao {	
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert rpInsert;
	public void setDataSource(DataSource dataSource) {	
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		this.rpInsert = new SimpleJdbcInsert(dataSource).withTableName("MANUSCRIPTS_REVIEW_PREFERENCES").usingGeneratedKeyColumns("ID");
	}
	public int insert(ReviewPreference rp) {
		int key = rpInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(rp)).intValue();
		return key;
	}
	public ReviewPreference getReviewPreferenceById(int rpID) {
		ReviewPreference rp = simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE ID = ?", new BeanPropertyRowMapper<ReviewPreference>(ReviewPreference.class), rpID);
		
		return rp;		
	} 
	public List<ReviewPreference> findReviewPreferences(int manuscriptId, int revisionCount) {
		if(revisionCount == -1) {
			List<ReviewPreference> rpList = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<ReviewPreference>(ReviewPreference.class), manuscriptId);		
			return rpList;	
		} else {
			List<ReviewPreference> rpList = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?", new BeanPropertyRowMapper<ReviewPreference>(ReviewPreference.class), manuscriptId, revisionCount);		
			return rpList;	
		}
	
	}
	
	public ReviewPreference findReviewPreference(int manuscriptId, int revisionCount, String email) {
		try {
			return simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ? AND EMAIL = ?", new BeanPropertyRowMapper<ReviewPreference>(ReviewPreference.class), manuscriptId, revisionCount, email);
		} catch(Exception e) {
			return null;
		}
	}
	
	public int numReviewPreferences(int manuscriptId, int revisionCount) {
		String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
		int count;
		try {
			count = simpleJdbcTemplate.queryForInt(sql, manuscriptId, revisionCount);
			return count;
		} catch(Exception e) {
			return 0;
		}
	}

	public void update(ReviewPreference rp) {
		simpleJdbcTemplate.update("UPDATE MANUSCRIPTS_REVIEW_PREFERENCES SET FIRST_NAME=:firstName," +
				"LAST_NAME=:lastName," +
				"EMAIL=:email," +
				"INSTITUTION=:institution," +
				"MANUSCRIPT_Id=:manuscriptId," +
				"DEGREE=:degree," +
				"SALUTATION=:salutation," +
				"COUNTRY_CODE=:countryCode," +
				"DEPARTMENT=:department," +
				"LOCAL_DEPARTMENT=:localDepartment," +
				"LOCAL_INSTITUTION=:localInstitution," +
				"LOCAL_FULL_NAME=:localFullName," +
				"REVISION_COUNT=:revisionCount," +
				"USER_ID=:userId " +
				"WHERE (id=:id);", new BeanPropertySqlParameterSource(rp));
		
	}
	public void delete(int id) {
		simpleJdbcTemplate.update("DELETE FROM MANUSCRIPTS_REVIEW_PREFERENCES WHERE ID = ?", id);
	}
}
