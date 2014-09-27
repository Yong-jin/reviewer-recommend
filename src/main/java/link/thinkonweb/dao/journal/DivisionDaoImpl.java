package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.Division;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.annotation.Transactional;

public class DivisionDaoImpl extends NamedParameterJdbcDaoSupport implements DivisionDao {
	@Inject
	private DivisionRowMapper divisionRowMapper;
	@Override
	public void setDivisionRowMapper(DivisionRowMapper divisionRowMapper) {
		this.divisionRowMapper = divisionRowMapper;
	}

	@Override
	public int insert(Division division) {
		String sql = "INSERT INTO DIVISIONS (JOURNAL_ID, NAME, SYMBOL, DESCRIPTION) " +
				"VALUES (:journalId, :name, :symbol, :description)";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(division);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public Division findById(int id) {
		String sql = "SELECT * FROM DIVISIONS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, divisionRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(Division division) {
		String sql = "UPDATE DIVISIONS SET ID = ?, JOURNAL_ID = ?, NAME = ?, SYMBOL = ?, DESCRIPTION = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {division.getId(), division.getJournalId(), division.getName(), division.getSymbol(), division.getDescription(), division.getId()});	
		
	}
	
	@Override
	@Transactional
	public void delete(int divisionId) {
		try {
			String sql = "DELETE FROM DIVISIONS WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {divisionId});
		} catch(Exception e) {
			System.out.println("deleting error");
		}
	}
	@Override
	public List<Division> findByJournalId(int journalId) {
		String sql = "SELECT * FROM DIVISIONS WHERE JOURNAL_ID = ?";
		List<Division> list = this.getJdbcTemplate().query(sql, new Object[] {journalId}, divisionRowMapper);	
		return list;
	}

}
