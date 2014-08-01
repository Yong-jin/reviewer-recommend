package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.EventDateTime;

import org.springframework.jdbc.core.RowMapper;

public class EventDateTimeRowMapper implements RowMapper<EventDateTime> {

	@Override
	public EventDateTime mapRow(ResultSet rs, int rowNum) throws SQLException {
		EventDateTime eventDate = new EventDateTime();
		eventDate.setId(rs.getInt("ID"));
		eventDate.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		eventDate.setRevisionCount(rs.getInt("REVISION_COUNT"));
		eventDate.setStatus(rs.getString("STATUS"));
		eventDate.setDate(rs.getDate("EVENT_DATE"));
		eventDate.setTime(rs.getTime("EVENT_TIME"));
		return eventDate;

	}
	
	

}
