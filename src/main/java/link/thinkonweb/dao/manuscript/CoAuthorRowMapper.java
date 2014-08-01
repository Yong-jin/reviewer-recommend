package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.CoAuthor;

import org.springframework.jdbc.core.RowMapper;

public class CoAuthorRowMapper implements RowMapper<CoAuthor> {
	
	@Override
	public CoAuthor mapRow(ResultSet rs, int rowNum) throws SQLException {
		CoAuthor coAuthor = new CoAuthor();
		coAuthor.setUserId(rs.getInt("USER_ID"));
		coAuthor.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		coAuthor.setCorresponding(rs.getBoolean("CORRESPONDING"));
		coAuthor.setAuthorOrder(rs.getInt("AUTHOR_ORDER"));
		coAuthor.setRevisionCount(rs.getInt("REVISION_COUNT"));
		coAuthor.setCreatedMember(rs.getBoolean("CREATED_MEMBER"));
		coAuthor.setTemporaryPassword(rs.getString("TEMP_PW"));
		return coAuthor;
	}
}
