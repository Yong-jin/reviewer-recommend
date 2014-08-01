package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class Title implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2845374857250018097L;
	private int id;
	private String title;
	private int revisionCount;
	private int manuscriptId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitle() {
		return title;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	@Override
	public String toString() {
		return "ManuscriptTitle [id=" + id + ", title=" + title
				+ ", revisionCount=" + revisionCount + ", manuscriptId="
				+ manuscriptId + "]";
	}
	

	
}
