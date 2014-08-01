package link.thinkonweb.domain.journal;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class JournalUploadedFile implements Serializable, Comparable<JournalUploadedFile> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8368643254046317356L;
	private int id;
	private int userId;
	private int journalId;
	private String name;
	private String designation;
	private Date date;
	private Time time;
	private String absolutePath;
	private String originalName;
	private String path;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getJournalId() {
		return journalId;
	}

	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
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

	public String getAbsolutePath() {
		return absolutePath;
	}

	public void setAbsolutePath(String absolutePath) {
		this.absolutePath = absolutePath;
	}

	public String getOriginalName() {
		return originalName;
	}

	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Override
	public int compareTo(JournalUploadedFile o) {
		if(this.designation.equals("mainDocument"))
			return -1;
		else {
			if(this.date.compareTo(o.getDate()) == 0)
				return this.time.compareTo(o.getTime());
			else
				this.date.compareTo(o.getDate());
		}
		return 0;
	}

	@Override
	public String toString() {
		return "JournalUploadedFile [id=" + id + ", userId=" + userId
				+ ", journalId=" + journalId + ", name=" + name
				+ ", designation=" + designation + ", date=" + date + ", time="
				+ time + ", absolutePath=" + absolutePath + ", originalName="
				+ originalName + ", path=" + path + "]";
	}

}
