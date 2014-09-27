package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.EventDateTime;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class EventDateTimeDaoImpl extends NamedParameterJdbcDaoSupport implements EventDateTimeDao {
	@Inject
	private EventDateTimeRowMapper eventDateRowMapper;

	public void setEventDateRowMapper(EventDateTimeRowMapper eventDateRowMapper) {
		this.eventDateRowMapper = eventDateRowMapper;
	}

	@Override
	public void insert(EventDateTime eventDate) {
		String sql = "INSERT INTO MANUSCRIPTS_EVENT_DATE (MANUSCRIPT_ID, REVISION_COUNT, STATUS, EVENT_DATE, EVENT_TIME) " +
				 "VALUES (:manuscriptId, :revisionCount, :status, UTC_DATE(), UTC_TIME())";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(eventDate);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
		
	}
	
	@Override
	public EventDateTime findEventDateById(int id) {
		String sql = "SELECT * FROM MANUSCRIPTS_EVENT_DATE WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, eventDateRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<EventDateTime> findEventDatesByManuscriptId(int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_EVENT_DATE WHERE MANUSCRIPT_ID = ?";
		List<EventDateTime> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, eventDateRowMapper);	
		return list;
	}
	
	@Override
	public int findLastEventDateIdByManuscriptIdAndStatus(int manuscriptId, String status) {
		String sql = "SELECT max(ID) FROM MANUSCRIPTS_EVENT_DATE WHERE MANUSCRIPT_ID = ? and STATUS = ?";
		try {
			int id = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, status}, Integer.class);	
			return id;
		} catch(EmptyResultDataAccessException e) {
			return 0;
		}
	}

	@Override
	public void update(EventDateTime eventDate) {
		String sql = "UPDATE MANUSCRIPTS_EVENT_DATE SET MANUSCRIPT_ID = ?, REVISION_COUNT = ?, STATUS = ?, EVENT_DATE = ?, EVENT_TIME = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {eventDate.getManuscriptId(), eventDate.getRevisionCount(), eventDate.getStatus(), eventDate.getDate(), eventDate.getTime(), eventDate.getId()});	
	}

	@Override
	public void delete(EventDateTime eventDate) {
		String sql = "DELETE FROM MANUSCRIPTS_EVENT_DATE WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {eventDate.getId()});
		
	}



}
