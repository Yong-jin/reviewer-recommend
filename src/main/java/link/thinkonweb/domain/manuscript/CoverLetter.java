package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class CoverLetter implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3718227544838917477L;
	private int id;
	private String coverLetter;
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
	public String getCoverLetter() {
		return coverLetter;
	}
	
	public String getCoverLetterHtml() {
		if(coverLetter != null)
			return coverLetter.replaceAll("\n", "<br/>");
		else
			return null;
	}
	public void setCoverLetter(String coverLetter) {
		this.coverLetter = coverLetter;
	}
	@Override
	public String toString() {
		return "CoverLetter [id=" + id + ", coverLetter=" + coverLetter
				+ ", revisionCount=" + revisionCount + ", manuscriptId="
				+ manuscriptId + "]";
	}
	

}
