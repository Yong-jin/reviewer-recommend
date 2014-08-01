package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.RunningHead;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;


public class JdbcRunningHeadDao implements RunningHeadDao {
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert insert;
	private String tableName;
	@Override
	public void setDataSource(DataSource dataSource) {
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		tableName = "manuscripts_runninghead";
		this.insert = new SimpleJdbcInsert(dataSource).withTableName(tableName);
	}
	@Override
	public void insert(RunningHead manuscriptRunningHead) {
		insert.execute(new BeanPropertySqlParameterSource(manuscriptRunningHead));

	}
	
	@Override
	public RunningHead findById(int id) {
		try {
			RunningHead result = simpleJdbcTemplate.queryForObject("SELECT * FROM "+tableName+" WHERE ID = ?", new BeanPropertyRowMapper<RunningHead>(RunningHead.class), id);
			return result;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public RunningHead findByRevisionCountAndManuscriptId(
			int revisionCount, int manuscriptId) {
		try {
			RunningHead result = simpleJdbcTemplate.queryForObject("SELECT * FROM "+tableName+" WHERE REVISION_COUNT = ? AND MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<RunningHead>(RunningHead.class), revisionCount, manuscriptId);
			return result;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<RunningHead> findByManuscriptId(int manuscriptId) {
		try {
			List<RunningHead> result = simpleJdbcTemplate.query("SELECT * FROM "+tableName+" WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<RunningHead>(RunningHead.class), manuscriptId);
			return result;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(RunningHead manuscriptRunningHead) {
		simpleJdbcTemplate.update("UPDATE "+tableName+" SET " +
				"RUNNINGHEAD=:runningHead " +
				"WHERE (MANUSCRIPT_ID=:manuscriptId and REVISION_COUNT=:revisionCount);", new BeanPropertySqlParameterSource(manuscriptRunningHead));
	}

	@Override
	public void delete(RunningHead manuscriptRunningHead) {
		simpleJdbcTemplate.update("DELETE FROM "+tableName+" WHERE ID = ?", manuscriptRunningHead.getId());

	}

}
