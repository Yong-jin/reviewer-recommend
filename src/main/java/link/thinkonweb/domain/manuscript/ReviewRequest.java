package link.thinkonweb.domain.manuscript;
public class ReviewRequest {
	private int id;
	private String query;
	private int manuscriptId;
	private int editorUserId;
	private int reviewerUserId;
	private int reviewId;
	private boolean available = true;
	
	public void setQuery(String query) {
		this.query = query;
	}
	public String getQuery() {
		return query;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	
	public int getEditorUserId() {
		return editorUserId;
	}
	public void setEditorUserId(int editorUserId) {
		this.editorUserId = editorUserId;
	}
	public int getReviewerUserId() {
		return reviewerUserId;
	}
	public void setReviewerUserId(int reviewerUserId) {
		this.reviewerUserId = reviewerUserId;
	}
	public void setAvailable(boolean available) {
		this.available = available;
	}
	public boolean isAvailable() {
		return available;
	}
	@Override
	public String toString() {
		return "ReviewRequest [id=" + id + ", query=" + query
				+ ", manuscriptId=" + manuscriptId + ", editorUserId="
				+ editorUserId + ", reviewerUserId=" + reviewerUserId
				+ ", reviewId=" + reviewId + ", available=" + available + "]";
	}
	
}
