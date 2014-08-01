package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.user.UserExpertise;

import org.springframework.jdbc.core.RowMapper;

public class UserExpertiseRowMapper implements RowMapper<UserExpertise> {
	public UserExpertiseRowMapper() {
	}
	
	@Override
	public UserExpertise mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserExpertise ue = new UserExpertise();
		ue.setId(rs.getInt("ID"));
		ue.setExpertise(rs.getString("EXPERTISE"));
		ue.setUserId(rs.getInt("USER_ID"));
		return ue;
	}
}