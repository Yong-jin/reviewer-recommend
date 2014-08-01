package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.user.SystemUser;

import org.springframework.jdbc.core.RowMapper;

public class UserRowMapper implements RowMapper<SystemUser> {
	public UserRowMapper() {
	}
	
	@Override
	public SystemUser mapRow(ResultSet rs, int rowNum) throws SQLException {
		SystemUser user = new SystemUser();
		user.setId(rs.getInt("ID"));
		user.setUsername(rs.getString("USERNAME"));
		user.setPassword(rs.getString("PASSWORD"));
		user.setSignupDate(rs.getDate("SIGNUP_DATE"));
		user.setSignupTime(rs.getTime("SIGNUP_TIME"));
		user.setEnabled(rs.getBoolean("ENABLED"));
		return user;
	}
}