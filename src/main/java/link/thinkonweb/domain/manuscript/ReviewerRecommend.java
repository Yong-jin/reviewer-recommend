package link.thinkonweb.domain.manuscript;


public class ReviewerRecommend {
	
	private int id;
	private int reviewer_user_id;
	private int manuscript_id;
	private int revision_count;
	private double recommend_value;
	private double fr_value;
	
	public double getFr_value() {
		return fr_value;
	}

	public void setFr_value(double fr_value) {
		this.fr_value = fr_value;
	}

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

	public int getRevision_count() {
		return revision_count;
	}
	public void setRevision_count(int revision_count) {
		this.revision_count = revision_count;
	}
	
	
	public double getRecommend_value() {
		return recommend_value;
	}

	public void setRecommend_value(double recommend_value) {
		this.recommend_value = recommend_value;
	}

	@Override
	public String toString() {
		return "ReviewerRecommend [id=" + id + ", reviewer_user_id="
				+ reviewer_user_id + ", manuscript_id=" + manuscript_id
				+ ", revision_count="
				+ revision_count + ", recommend_value = " + recommend_value + ", fr_value : " + fr_value + " ]";
	}
}
