package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.journal.Division;

import org.springframework.jdbc.core.RowMapper;

public class UserDivisionDivisionRowMapper implements RowMapper<UserDivision> {
	
	@Override
	public UserDivision mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserDivision userDivision = new UserDivision();
		userDivision.setId(rs.getInt("UD.ID"));
		userDivision.setJournalId(rs.getInt("UD.JOURNAL_ID"));
		userDivision.setUserId(rs.getInt("UD.USER_ID"));
		userDivision.setDivisionId(rs.getInt("UD.DIVISION_ID"));
		userDivision.setRole(rs.getString("UD.ROLE"));
		
		Division division = new Division();
		division.setId(rs.getInt("D.ID"));
		division.setSymbol(rs.getString("D.SYMBOL"));
		division.setDescription(rs.getString("D.DESCRIPTION"));
		division.setName(rs.getString("D.NAME"));
		division.setJournalId(rs.getInt("D.JOURNAL_ID"));
		userDivision.setDivision(division);
		
		return userDivision;
	}
}
