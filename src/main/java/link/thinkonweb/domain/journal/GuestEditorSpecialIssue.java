package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class GuestEditorSpecialIssue implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6449621331284403636L;
	private int id;
	private int userId;
	private int journalId;
	private int specialIssueId;
	private SpecialIssue specialIssue;
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
	public int getSpecialIssueId() {
		return specialIssueId;
	}
	public void setSpecialIssueId(int specialIssueId) {
		this.specialIssueId = specialIssueId;
	}
	public SpecialIssue getSpecialIssue() {
		return specialIssue;
	}
	public void setSpecialIssue(SpecialIssue specialIssue) {
		this.specialIssue = specialIssue;
	}
	@Override
	public String toString() {
		return "GuestEditorSpecialIssue [id=" + id + ", userId=" + userId
				+ ", journalId=" + journalId + ", specialIssueId="
				+ specialIssueId + ", specialIssue=" + specialIssue + "]";
	}
	
}
