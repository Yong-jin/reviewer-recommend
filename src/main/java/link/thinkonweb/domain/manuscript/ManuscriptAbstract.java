package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class ManuscriptAbstract implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3718227544838917477L;
	private int id;
	private String paperAbstract;
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
	public String getPaperAbstract() {
		return paperAbstract;
	}
	public void setPaperAbstract(String paperAbstract) {
		this.paperAbstract = paperAbstract;
	}
	@Override
	public String toString() {
		return "ManuscriptAbstract [id=" + id + ", paperAbstract="
				+ paperAbstract + ", revisionCount=" + revisionCount
				+ ", manuscriptId=" + manuscriptId + "]";
	}
	

	

}
