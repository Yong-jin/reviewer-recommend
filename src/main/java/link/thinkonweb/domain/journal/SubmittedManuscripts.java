package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class SubmittedManuscripts implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7236442909832649772L;
	private int id;
	private int journalId;
	private int year;
	private int month;
	private int manuscriptCount;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getYear() {
		return year;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getMonth() {
		return month;
	}
	public int getManuscriptCount() {
		return manuscriptCount;
	}
	public void setManuscriptCount(int manuscriptCount) {
		this.manuscriptCount = manuscriptCount;
	}
	@Override
	public String toString() {
		return "SubmittedManuscripts [id=" + id + ", journalId=" + journalId
				+ ", year=" + year + ", month=" + month + ", manuscriptCount="
				+ manuscriptCount + "]";
	}
	
	

}
