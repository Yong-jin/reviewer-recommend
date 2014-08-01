package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.user.Authority;

import org.springframework.jdbc.core.RowMapper;

public class AuthorityRowMapper implements RowMapper<Authority> {

	public AuthorityRowMapper() {
	}
	
	@Override
	public Authority mapRow(ResultSet rs, int rowNum) throws SQLException {
		Authority authority = new Authority();
		authority.setId(rs.getInt("ID"));
		authority.setUserId(rs.getInt("USER_ID"));
		authority.setJournalId(rs.getInt("JOURNAL_ID"));
		authority.setRole(rs.getString("ROLE"));		
		return authority;
	}
}
