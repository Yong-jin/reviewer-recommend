package link.thinkonweb.domain.manuscript;


public class ReviewerRecommend {
	
	private int id;
	private int reviewer_user_id;
	private int manuscript_id;
	private int journal_id;
	private int revision_count;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getReviewer_user_id() {
		return reviewer_user_id;
	}
	public void setReviewer_user_id(int reviewer_user_id) {
		this.reviewer_user_id = reviewer_user_id;
	}
	public int getManuscript_id() {
		return manuscript_id;
	}
	public void setManuscript_id(int manuscript_id) {
		this.manuscript_id = manuscript_id;
	}
	public int getJournal_id() {
		return journal_id;
	}
	public void setJournal_id(int journal_id) {
		this.journal_id = journal_id;
	}
	public int getRevision_count() {
		return revision_count;
	}
	public void setRevision_count(int revision_count) {
		this.revision_count = revision_count;
	}
	
	@Override
	public String toString() {
		return "ReviewerRecommend [id=" + id + ", reviewer_user_id="
				+ reviewer_user_id + ", manuscript_id=" + manuscript_id
				+ ", journal_id=" + journal_id + ", revision_count="
				+ revision_count + "]";
	}
}
