package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ReviewManuscriptRowMapper implements RowMapper<Integer> {
	
	@Override
	public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
		return rs.getInt("MR.MANUSCRIPT_ID");
	}
}
