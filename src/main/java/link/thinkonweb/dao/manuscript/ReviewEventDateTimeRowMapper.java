package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.ReviewEventDateTime;

import org.springframework.jdbc.core.RowMapper;

public class ReviewEventDateTimeRowMapper implements RowMapper<ReviewEventDateTime> {

	@Override
	public ReviewEventDateTime mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewEventDateTime reviewEventDateTime = new ReviewEventDateTime();
		reviewEventDateTime.setId(rs.getInt("ID"));
		reviewEventDateTime.setUserId(rs.getInt("USER_ID"));
		reviewEventDateTime.setJournalId(rs.getInt("JOURNAL_ID"));
		reviewEventDateTime.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		reviewEventDateTime.setRevisionCount(rs.getInt("REVISION_COUNT"));
		reviewEventDateTime.setStatus(rs.getString("STATUS"));
		reviewEventDateTime.setDate(rs.getDate("EVENT_DATE"));
		reviewEventDateTime.setTime(rs.getTime("EVENT_TIME"));
		return reviewEventDateTime;

	}
	
	

}
