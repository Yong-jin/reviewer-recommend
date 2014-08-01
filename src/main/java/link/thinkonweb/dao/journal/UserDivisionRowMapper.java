package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.UserDivision;

import org.springframework.jdbc.core.RowMapper;

public class UserDivisionRowMapper implements RowMapper<UserDivision> {
	
	@Override
	public UserDivision mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserDivision userDivision = new UserDivision();
		userDivision.setId(rs.getInt("ID"));
		userDivision.setJournalId(rs.getInt("JOURNAL_ID"));
		userDivision.setUserId(rs.getInt("USER_ID"));
		userDivision.setDivisionId(rs.getInt("DIVISION_ID"));
		userDivision.setRole(rs.getString("ROLE"));
		return userDivision;
	}
}
