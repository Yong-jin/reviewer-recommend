package link.thinkonweb.dao.journal;

import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.journal.SubmittedManuscripts;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

public class JdbcSubmittedManuscriptDao implements SubmittedManuscriptDao {
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert insert;
	private String tableName;
	
	@Override
	public void setDataSource(DataSource dataSource) {
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		tableName = "SUBMITTED_MANUSCRIPTS";
		this.insert = new SimpleJdbcInsert(dataSource).withTableName(tableName);
	}
	@Override
	public void insert(SubmittedManuscripts submittedManuscript) {
		insert.execute(new BeanPropertySqlParameterSource(submittedManuscript));
	}
	@Override
	public void update(SubmittedManuscripts submittedManuscript) {
		simpleJdbcTemplate.update("UPDATE " + tableName + " SET " +
				"MANUSCRIPT_COUNT=:manuscriptCount " +
				"WHERE (JOURNAL_ID=:journalId AND YEAR=:year AND MONTH=:month);", new BeanPropertySqlParameterSource(submittedManuscript));
	}
	@Override
	public SubmittedManuscripts getSubmittedManuscript(int journalId, int year,
			int month) {
		try {
			return simpleJdbcTemplate.queryForObject("SELECT * FROM "+tableName+" WHERE JOURNAL_ID = ? AND YEAR = ? AND MONTH = ?", new BeanPropertyRowMapper<SubmittedManuscripts>(SubmittedManuscripts.class), journalId, year, month);			
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<SubmittedManuscripts> getSubmittedManuscriptByYear(int journalId, int year) {
		List<SubmittedManuscripts> submittedManuscripts = simpleJdbcTemplate.query("SELECT * FROM "+tableName+" WHERE JOURNAL_ID = ? AND YEAR = ? ", new BeanPropertyRowMapper<SubmittedManuscripts>(SubmittedManuscripts.class), journalId, year);
		return submittedManuscripts;
	}

}
