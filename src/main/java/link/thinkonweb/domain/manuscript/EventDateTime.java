package link.thinkonweb.domain.manuscript;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class EventDateTime implements Serializable, Comparable<EventDateTime> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7371013338159732369L;
	private int id;
	private int manuscriptId;
	private int revisionCount;
	private String status;
	private Date date;
	private Time time;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "EventDateTime [id=" + id + ", manuscriptId=" + manuscriptId
				+ ", revisionCount=" + revisionCount + ", status=" + status
				+ ", date=" + date + ", time=" + time + "]";
	}
	@Override
	public int compareTo(EventDateTime o) {
		if(this.date.compareTo(o.getDate()) == 0)
			return this.time.compareTo(o.getTime());
		else
			return this.date.compareTo(o.getDate());
	}
	
	
	

}
