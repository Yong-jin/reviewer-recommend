package link.thinkonweb.domain.manuscript;

public class ManuscriptActivity {
	private Manuscript manuscript;
	private String manuscriptTitle;
	private String coAuthorsNames;
	private String authorOrder;
	private String submitter;
	private String correspondingAuthor;
	private String journalTitle;
	private String localSubmissionDate;
	private String statusMessage;
	private boolean checked;

	public ManuscriptActivity() {
		this.checked = true;
	}
	
	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	public Manuscript getManuscript() {
		return manuscript;
	}
	public void setManuscript(Manuscript manuscript) {
		this.manuscript = manuscript;
	}
	public String getManuscriptTitle() {
		return manuscriptTitle;
	}
	public void setManuscriptTitle(String manuscriptTitle) {
		this.manuscriptTitle = manuscriptTitle;
	}
	public String getCoAuthorsNames() {
		return coAuthorsNames;
	}
	public void setCoAuthorsNames(String coAuthorsNames) {
		this.coAuthorsNames = coAuthorsNames;
	}
	public String getAuthorOrder() {
		return authorOrder;
	}
	public void setAuthorOrder(String authorOrder) {
		this.authorOrder = authorOrder;
	}
	public String getSubmitter() {
		return submitter;
	}
	public void setSubmitter(String submitter) {
		this.submitter = submitter;
	}
	public String getCorrespondingAuthor() {
		return correspondingAuthor;
	}
	public void setCorrespondingAuthor(String correspondingAuthor) {
		this.correspondingAuthor = correspondingAuthor;
	}
	public String getJournalTitle() {
		return journalTitle;
	}
	public void setJournalTitle(String journalTitle) {
		this.journalTitle = journalTitle;
	}
	public String getLocalSubmissionDate() {
		return localSubmissionDate;
	}
	public void setLocalSubmissionDate(String localSubmissionDate) {
		this.localSubmissionDate = localSubmissionDate;
	}
	public String getStatusMessage() {
		return statusMessage;
	}
	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}
}
