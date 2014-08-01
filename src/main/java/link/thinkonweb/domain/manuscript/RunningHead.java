package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class RunningHead implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -778997770974902819L;
	private int id;
	private String runningHead;
	private int revisionCount;
	private int manuscriptId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public void setRunningHead(String runningHead) {
		this.runningHead = runningHead;
	}
	public String getRunningHead() {
		return runningHead;
	}
	@Override
	public String toString() {
		return "ManuscriptRunningHead [id=" + id + ", runningHead="
				+ runningHead + ", revisionCount=" + revisionCount
				+ ", manuscriptId=" + manuscriptId + "]";
	}
	
}
