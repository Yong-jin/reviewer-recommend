package link.thinkonweb.domain.journal;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class SpecialIssue implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7803440903467432111L;
	private int id;
	private int journalId;
	private int guestEditorUserId;
	private String title;
	private String description;
	private Date submissionDueDate;
	private Time submissionDueTime;
	private Date creationDate;
	private Time creationTime;
	private boolean status;
	
	public SpecialIssue() {
		status = true;
	}
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
	
	public int getGuestEditorUserId() {
		return guestEditorUserId;
	}
	public void setGuestEditorUserId(int guestEditorUserId) {
		this.guestEditorUserId = guestEditorUserId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public Date getSubmissionDueDate() {
		return submissionDueDate;
	}
	public void setSubmissionDueDate(Date submissionDueDate) {
		this.submissionDueDate = submissionDueDate;
	}
	public Time getSubmissionDueTime() {
		return submissionDueTime;
	}
	public void setSubmissionDueTime(Time submissionDueTime) {
		this.submissionDueTime = submissionDueTime;
	}
	
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Time getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(Time creationTime) {
		this.creationTime = creationTime;
	}
	
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "SpecialIssue [id=" + id + ", journalId=" + journalId
				+ ", guestEditorUserId=" + guestEditorUserId + ", title="
				+ title + ", description=" + description
				+ ", submissionDueDate=" + submissionDueDate
				+ ", submissionDueTime=" + submissionDueTime
				+ ", creationDate=" + creationDate + ", creationTime="
				+ creationTime + ", status=" + status + "]";
	}
	
}
