package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.Division;

import org.springframework.jdbc.core.RowMapper;

public class DivisionRowMapper implements RowMapper<Division> {
	
	@Override
	public Division mapRow(ResultSet rs, int rowNum) throws SQLException {
		Division division = new Division();
		division.setId(rs.getInt("ID"));
		division.setJournalId(rs.getInt("JOURNAL_ID"));
		division.setName(rs.getString("NAME"));
		division.setSymbol(rs.getString("SYMBOL"));
		division.setDescription(rs.getString("DESCRIPTION"));
		return division;
	}
}
