package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class FinalDecision implements Serializable, Comparable<FinalDecision> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7520329222058221283L;
	private int id;
	private int manuscriptId;
	private int journalId;
	private int userId;
	private int decision;
	private int revisionCount;
	private int editorRecommend;
	
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

	public int getDecision() {
		return decision;
	}

	public void setDecision(int decision) {
		this.decision = decision;
	}

	public int getRevisionCount() {
		return revisionCount;
	}

	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}

	public int getEditorRecommend() {
		return editorRecommend;
	}

	public void setEditorRecommend(int editorRecommend) {
		this.editorRecommend = editorRecommend;
	}

	@Override
	public int compareTo(FinalDecision compareObject) {		

		int otherRevisionCount = compareObject.getRevisionCount();
		if(otherRevisionCount > this.revisionCount)
			return 1;
		else if(otherRevisionCount < this.revisionCount)
			return -1;
		else
			return 0;
	}

	@Override
	public String toString() {
		return "FinalDecision [id=" + id + ", manuscriptId=" + manuscriptId
				+ ", journalId=" + journalId + ", userId=" + userId
				+ ", decision=" + decision + ", revisionCount=" + revisionCount
				+ ", editorRecommend=" + editorRecommend + "]";
	}

	
	
}
