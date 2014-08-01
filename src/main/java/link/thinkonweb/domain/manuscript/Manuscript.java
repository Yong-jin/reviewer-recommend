package link.thinkonweb.domain.manuscript;
import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.user.SystemUser;
public class Manuscript implements Serializable, Comparable<Manuscript> {
	private static final long serialVersionUID = 1L;
	
	private int id;	
	private int userId;
	private int journalId;
	private String title;
	private String currentTitle;
	private String runningHead;
	private String paperAbstract;
	private List<String> keyword;
	private int specialIssueId;
	
	private List<CoAuthor> coAuthors;
	private CoAuthor firstAuthor;
	private CoAuthor corresAuthor;
	private List<ReviewPreference> reviewPreferences;
	
	private List<Title> titles;
	private List<RunningHead> runningHeads;
	private List<ManuscriptAbstract> abstracts;
	private List<CoverLetter> coverLetters;
	private List<Keyword> keywords;
	private List<FinalDecision> decisions;
	private List<EventDateTime> eventDateTimes;
	private List<EventDateTime> lastEventDateTimes;
	
	private List<UploadedFile> files;
	private String coverLetter;
	private boolean confirm1;
	private boolean confirm2;
	private boolean confirm3;
	private boolean confirm4;
	private boolean confirm5;
	private int divisionId;
	private Division division;
	
	private int manuscriptTypeId;
	private int manuscriptTrackId;

	private String status;
	
	private String submitId;
	
	private int submitStep;
	private int revisionCount;
	private int cameraReadyRevision;
	private int galleryProofRevision;
	
	private int chiefEditorUserId;
	private int associateEditorUserId;
	private int guestEditorUserId;
	private int managerUserId;
	
	private SystemUser submitter;
	private SystemUser chiefEditor;
	private SystemUser associateEditor;
	private SystemUser manager;
	private SystemUser guestEditor;

	private boolean invite;
	private String editorStatus;
	
	private List<List<Review>> reviewList;	// all reviews
	private List<Review> reviews;	// current revision reviews
	private List<Comment> comments;
	
	private boolean galleryProofConfirm;
	private boolean cameraReadyConfirm;
	private Date aeAssignDate;
	private Time aeAssignTime;
	private Date revisionDueDate;
	private Time revisionDueTime;
	private Date cameraDueDate;
	private Time cameraDueTime;
	private boolean dueDateExtendRequest;
	
	public Manuscript() {
		status = SystemConstants.statusB;
	}
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCurrentTitle() {
		return currentTitle;
	}
	public void setCurrentTitle(String currentTitle) {
		this.currentTitle = currentTitle;
	}
	public String getRunningHead() {
		return runningHead;
	}
	public void setRunningHead(String runningHead) {
		this.runningHead = runningHead;
	}
	public String getPaperAbstract() {
		return paperAbstract;
	}
	public void setPaperAbstract(String paperAbstract) {
		this.paperAbstract = paperAbstract;
	}
	public List<String> getKeyword() {
		return keyword;
	}
	public void setKeyword(List<String> keyword) {
		this.keyword = keyword;
	}
	public List<CoAuthor> getCoAuthors() {
		return coAuthors;
	}
	public void setCoAuthors(List<CoAuthor> coAuthors) {
		this.coAuthors = coAuthors;
	}
	public CoAuthor getFirstAuthor() {
		return firstAuthor;
	}
	public void setFirstAuthor(CoAuthor firstAuthor) {
		this.firstAuthor = firstAuthor;
	}
	public CoAuthor getCorresAuthor() {
		return corresAuthor;
	}
	public void setCorresAuthor(CoAuthor corresAuthor) {
		this.corresAuthor = corresAuthor;
	}
	public List<ReviewPreference> getReviewPreferences() {
		return reviewPreferences;
	}
	public void setReviewPreferences(List<ReviewPreference> reviewPreferences) {
		this.reviewPreferences = reviewPreferences;
	}
	public List<Title> getTitles() {
		return titles;
	}
	public void setTitles(List<Title> titles) {
		this.titles = titles;
	}
	public List<RunningHead> getRunningHeads() {
		return runningHeads;
	}
	public void setRunningHeads(List<RunningHead> runningHeads) {
		this.runningHeads = runningHeads;
	}
	public List<ManuscriptAbstract> getAbstracts() {
		return abstracts;
	}
	public void setAbstracts(List<ManuscriptAbstract> abstracts) {
		this.abstracts = abstracts;
	}
	
	public boolean isDueDateExtendRequest() {
		return dueDateExtendRequest;
	}

	public void setDueDateExtendRequest(boolean dueDateExtendRequest) {
		this.dueDateExtendRequest = dueDateExtendRequest;
	}

	public List<CoverLetter> getCoverLetters() {
		return coverLetters;
	}

	public void setCoverLetters(List<CoverLetter> coverLetters) {
		this.coverLetters = coverLetters;
	}

	public List<Keyword> getKeywords() {
		return keywords;
	}
	public void setKeywords(List<Keyword> keywords) {
		this.keywords = keywords;
	}
	public List<FinalDecision> getDecisions() {
		return decisions;
	}
	public void setDecisions(List<FinalDecision> decisions) {
		this.decisions = decisions;
	}
	
	public List<UploadedFile> getFiles() {
		return files;
	}
	public void setFiles(List<UploadedFile> files) {
		this.files = files;
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
	public boolean isConfirm1() {
		return confirm1;
	}
	public void setConfirm1(boolean confirm1) {
		this.confirm1 = confirm1;
	}
	public boolean isConfirm2() {
		return confirm2;
	}
	public void setConfirm2(boolean confirm2) {
		this.confirm2 = confirm2;
	}
	public boolean isConfirm3() {
		return confirm3;
	}
	public void setConfirm3(boolean confirm3) {
		this.confirm3 = confirm3;
	}
	public boolean isConfirm4() {
		return confirm4;
	}
	public void setConfirm4(boolean confirm4) {
		this.confirm4 = confirm4;
	}
	
	public boolean isConfirm5() {
		return confirm5;
	}

	public void setConfirm5(boolean confirm5) {
		this.confirm5 = confirm5;
	}

	public int getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(int divisionId) {
		this.divisionId = divisionId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getChiefEditorUserId() {
		return chiefEditorUserId;
	}

	public void setChiefEditorUserId(int chiefEditorUserId) {
		this.chiefEditorUserId = chiefEditorUserId;
	}

	public int getAssociateEditorUserId() {
		return associateEditorUserId;
	}

	public void setAssociateEditorUserId(int associateEditorUserId) {
		this.associateEditorUserId = associateEditorUserId;
	}

	public int getGuestEditorUserId() {
		return guestEditorUserId;
	}

	public void setGuestEditorUserId(int guestEditorUserId) {
		this.guestEditorUserId = guestEditorUserId;
	}
	public int getManagerUserId() {
		return managerUserId;
	}

	public void setManagerUserId(int managerUserId) {
		this.managerUserId = managerUserId;
	}

	public String getSubmitId() {
		return submitId;
	}
	public void setSubmitId(String submitId) {
		this.submitId = submitId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getSubmitStep() {
		return submitStep;
	}
	public void setSubmitStep(int submitStep) {
		this.submitStep = submitStep;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public SystemUser getManager() {
		return manager;
	}
	public void setManager(SystemUser manager) {
		this.manager = manager;
	}
	public SystemUser getChiefEditor() {
		return chiefEditor;
	}

	public void setChiefEditor(SystemUser chiefEditor) {
		this.chiefEditor = chiefEditor;
	}

	public SystemUser getAssociateEditor() {
		return associateEditor;
	}

	public void setAssociateEditor(SystemUser associateEditor) {
		this.associateEditor = associateEditor;
	}
	public SystemUser getGuestEditor() {
		return guestEditor;
	}

	public void setGuestEditor(SystemUser guestEditor) {
		this.guestEditor = guestEditor;
	}
	public boolean isInvite() {
		return invite;
	}
	public void setInvite(boolean invite) {
		this.invite = invite;
	}
	public Division getDivision() {
		return division;
	}

	public void setDivision(Division division) {
		this.division = division;
	}
	
	public int getManuscriptTypeId() {
		return manuscriptTypeId;
	}

	public void setManuscriptTypeId(int manuscriptTypeId) {
		this.manuscriptTypeId = manuscriptTypeId;
	}
	
	public int getManuscriptTrackId() {
		return manuscriptTrackId;
	}

	public void setManuscriptTrackId(int manuscriptTrackId) {
		this.manuscriptTrackId = manuscriptTrackId;
	}
	
	public List<EventDateTime> getEventDateTimes() {
		return eventDateTimes;
	}

	public void setEventDateTimes(List<EventDateTime> eventDateTimes) {
		this.eventDateTimes = eventDateTimes;
	}

	public List<EventDateTime> getLastEventDateTimes() {
		return lastEventDateTimes;
	}

	public void setLastEventDateTimes(List<EventDateTime> lastEventDateTimes) {
		this.lastEventDateTimes = lastEventDateTimes;
	}
	
	public List<Review> getReviews() {
		return reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}
	
	public int getSpecialIssueId() {
		return specialIssueId;
	}

	public void setSpecialIssueId(int specialIssueId) {
		this.specialIssueId = specialIssueId;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	
	public String getEditorStatus() {
		return editorStatus;
	}

	public void setEditorStatus(String editorStatus) {
		this.editorStatus = editorStatus;
	}

	public List<List<Review>> getReviewList() {
		return reviewList;
	}

	public void setReviewList(List<List<Review>> reviewList) {
		this.reviewList = reviewList;
	}

	public int getCameraReadyRevision() {
		return cameraReadyRevision;
	}

	public void setCameraReadyRevision(int cameraReadyRevision) {
		this.cameraReadyRevision = cameraReadyRevision;
	}

	public int getGalleryProofRevision() {
		return galleryProofRevision;
	}

	public void setGalleryProofRevision(int galleryProofRevision) {
		this.galleryProofRevision = galleryProofRevision;
	}
	

	public boolean isGalleryProofConfirm() {
		return galleryProofConfirm;
	}

	public void setGalleryProofConfirm(boolean galleryProofConfirm) {
		this.galleryProofConfirm = galleryProofConfirm;
	}
	

	public boolean isCameraReadyConfirm() {
		return cameraReadyConfirm;
	}

	public void setCameraReadyConfirm(boolean cameraReadyConfirm) {
		this.cameraReadyConfirm = cameraReadyConfirm;
	}
	
	

	public Date getAeAssignDate() {
		return aeAssignDate;
	}

	public void setAeAssignDate(Date aeAssignDate) {
		this.aeAssignDate = aeAssignDate;
	}

	public Time getAeAssignTime() {
		return aeAssignTime;
	}

	public void setAeAssignTime(Time aeAssignTime) {
		this.aeAssignTime = aeAssignTime;
	}
	
	

	public Date getRevisionDueDate() {
		return revisionDueDate;
	}

	public void setRevisionDueDate(Date revisionDueDate) {
		this.revisionDueDate = revisionDueDate;
	}

	public Time getRevisionDueTime() {
		return revisionDueTime;
	}

	public void setRevisionDueTime(Time revisionDueTime) {
		this.revisionDueTime = revisionDueTime;
	}

	public Date getCameraDueDate() {
		return cameraDueDate;
	}

	public void setCameraDueDate(Date cameraDueDate) {
		this.cameraDueDate = cameraDueDate;
	}

	public Time getCameraDueTime() {
		return cameraDueTime;
	}

	public void setCameraDueTime(Time cameraDueTime) {
		this.cameraDueTime = cameraDueTime;
	}

	public SystemUser getSubmitter() {
		return submitter;
	}

	public void setSubmitter(SystemUser submitter) {
		this.submitter = submitter;
	}
	
	public FinalDecision getFinalDecision(int revisionCount) {
		if(decisions != null) {
			for(FinalDecision fd: decisions) {
				if(fd.getRevisionCount() == revisionCount)
					return fd;
			}
			return null;
		} else
			return null;
	}

	public EventDateTime getLastEventDateTime(String status) {
		if(lastEventDateTimes != null) {
			for(EventDateTime eventDateTime: lastEventDateTimes) {
				if(eventDateTime.getStatus().equals(status))
					return eventDateTime;
			}
		}
		return null;
	}
	
	public EventDateTime getEventDateTime(String status, int revisionCount) {
		if(eventDateTimes != null) {
			for(EventDateTime eventDateTime: eventDateTimes)
				if(eventDateTime.getStatus().equals(status) && eventDateTime.getRevisionCount() == revisionCount)
					return eventDateTime;
		}
		return null;
	}
	
	@Override
	public int compareTo(Manuscript compareObject) {		
		String compare = compareObject.submitId;
		if (compare == null) {
			compare = "";
		}
		if (this.submitId == null) {
			this.submitId = "";
		}
		return this.submitId.compareTo(compare);
		
	}

	@Override
	public String toString() {
		return "Manuscript [id=" + id + ", userId=" + userId + ", journalId="
				+ journalId + ", title=" + title + ", currentTitle="
				+ currentTitle + ", runningHead=" + runningHead
				+ ", paperAbstract=" + paperAbstract + ", keyword=" + keyword
				+ ", specialIssueId=" + specialIssueId + ", coAuthors="
				+ coAuthors + ", firstAuthor=" + firstAuthor
				+ ", corresAuthor=" + corresAuthor + ", reviewPreferences="
				+ reviewPreferences + ", titles=" + titles + ", runningHeads="
				+ runningHeads + ", abstracts=" + abstracts + ", coverLetters="
				+ coverLetters + ", keywords=" + keywords + ", decisions="
				+ decisions + ", eventDateTimes=" + eventDateTimes
				+ ", lastEventDateTimes=" + lastEventDateTimes + ", files="
				+ files + ", coverLetter=" + coverLetter + ", confirm1="
				+ confirm1 + ", confirm2=" + confirm2 + ", confirm3="
				+ confirm3 + ", confirm4=" + confirm4 + ", divisionId="
				+ divisionId + ", division=" + division + ", manuscriptTypeId="
				+ manuscriptTypeId + ", manuscriptTrackId=" + manuscriptTrackId
				+ ", status=" + status + ", submitId=" + submitId
				+ ", submitStep=" + submitStep + ", revisionCount="
				+ revisionCount + ", cameraReadyRevision="
				+ cameraReadyRevision + ", galleryProofRevision="
				+ galleryProofRevision + ", chiefEditorUserId="
				+ chiefEditorUserId + ", associateEditorUserId="
				+ associateEditorUserId + ", guestEditorUserId="
				+ guestEditorUserId + ", managerUserId=" + managerUserId
				+ ", chiefEditor=" + chiefEditor + ", associateEditor="
				+ associateEditor + ", manager=" + manager + ", guestEditor="
				+ guestEditor + ", invite=" + invite + ", editorStatus="
				+ editorStatus + ", reviewList=" + reviewList + ", reviews="
				+ reviews + ", comments=" + comments + ", galleryProofConfirm="
				+ galleryProofConfirm + ", cameraReadyConfirm="
				+ cameraReadyConfirm + ", aeAssignDate=" + aeAssignDate
				+ ", aeAssignTime=" + aeAssignTime + ", revisionDueDate="
				+ revisionDueDate + ", revisionDueTime=" + revisionDueTime
				+ ", cameraDueDate=" + cameraDueDate + ", cameraDueTime="
				+ cameraDueTime + ", dueDateExtendRequest="
				+ dueDateExtendRequest + "]";
	}

	
}