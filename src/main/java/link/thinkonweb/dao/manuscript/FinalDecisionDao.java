package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.FinalDecision;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;


public class FinalDecisionDao {	
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert maInsert;
	public void setDataSource(DataSource dataSource) {
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		this.maInsert = new SimpleJdbcInsert(dataSource).withTableName("MANUSCRIPTS_FINAL_DECISION").usingGeneratedKeyColumns("no");
	}
	
	public void insert(FinalDecision fd) {
		maInsert.execute(new BeanPropertySqlParameterSource(fd));
	}
	
	public int insertAndReturningKey(FinalDecision fd) {
		int key = maInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(fd)).intValue();
		return key;
	}

	public List<FinalDecision> findAll() {
		List<FinalDecision> ma = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_FINAL_DECISION", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class));
		
		return ma;		
	}
	public int findAllCount() {
		List<FinalDecision> ma = simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_FINAL_DECISION", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class));
		int id = 0;
		for (FinalDecision m : ma) {
			id = m.getId();
		}
		return id;		
	}
	
	public FinalDecision findByManuscriptIdAndRevisionCount(int id, int revisionCount) {
		try{
			return simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_FINAL_DECISION WHERE MANUSCRIPT_ID = ? and REVISION_COUNT = ?", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class), id, revisionCount);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		} catch(Exception e) {
			return null;
		}
	}
	
	public FinalDecision findById(int id) {
		return simpleJdbcTemplate.queryForObject("SELECT * FROM MANUSCRIPTS_FINAL_DECISION WHERE id = ?", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class), id);	
	}
	public List<FinalDecision> findByManuscriptId(int manuscriptId) {
		try{
			return simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_FINAL_DECISION WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class), manuscriptId);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
			
	}
	public List<FinalDecision> findsByManuscriptId(int manuscriptId) {
		try{
			return simpleJdbcTemplate.query("SELECT * FROM MANUSCRIPTS_FINAL_DECISION WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<FinalDecision>(FinalDecision.class), manuscriptId);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	public void update(FinalDecision fd) {
		simpleJdbcTemplate.update("UPDATE MANUSCRIPTS_FINAL_DECISION SET " +
				"MANUSCRIPT_ID=:manuscriptId," +
				"USER_ID=:userId," +
				"JOURNAL_ID=:journalId," +
				"DECISION=:decision," +
				"EDITOR_RECOMMEND=:editorRecommend," +
				"REVISION_COUNT=:revisionCount " +
				"WHERE (ID=:id);", new BeanPropertySqlParameterSource(fd));
		
	}
	public void delete(int id) {
		simpleJdbcTemplate.update("DELETE FROM MANUSCRIPTS_FINAL_DECISION WHERE id = ?", id);
	}
}
