package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class Keyword implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8812506125254904182L;
	private int id;
	private String keyword;
	private int manuscriptId;
	private int journalId;
	private int userId;
	private int revisionCount;
	
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
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	@Override
	public String toString() {
		return "Keyword [id=" + id + ", keyword=" + keyword + ", manuscriptId="
				+ manuscriptId + ", journalId=" + journalId + ", userId="
				+ userId + ", revisionCount=" + revisionCount + "]";
	}
	
}
