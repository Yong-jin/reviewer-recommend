package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.EventDateTime;

public interface EventDateTimeDao {
	public void insert(EventDateTime eventDate);
	public void update(EventDateTime eventDate);
	public void delete(EventDateTime eventDate);
	public int findLastEventDateIdByManuscriptIdAndStatus(int manuscriptId, String status);
	public EventDateTime findEventDateById(int id);
	public List<EventDateTime> findEventDatesByManuscriptId(int manuscriptId);


}
