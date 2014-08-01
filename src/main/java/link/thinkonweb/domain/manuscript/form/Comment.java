package link.thinkonweb.domain.manuscript.form;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

import link.thinkonweb.domain.user.SystemUser;

public class Comment implements Serializable, Comparable<Comment> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8338262494911455844L;
	private int id;
	private int fromUserId;
	private int toUserId;
	private int journalId;
	private int manuscriptId;
	private int revisionCount;
	private String text;
	private String textHtml;
	private String fromRole;
	private String toRole;
	private int scopeManager;
	private String status;
	private Date date;
	private Time time;
	private int cameraReadyRevision;
	private int galleryProofRevision;
	private SystemUser fromUser;
	private SystemUser toUser;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getFromUserId() {
		return fromUserId;
	}
	public void setFromUserId(int fromUserId) {
		this.fromUserId = fromUserId;
	}
	public int getToUserId() {
		return toUserId;
	}
	public void setToUserId(int toUserId) {
		this.toUserId = toUserId;
	}
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
		this.textHtml = text;
	}
	public void setTextHtml(String textHtml) {
		this.textHtml = textHtml;
	}
	public String getTextHtml() {
		if(textHtml != null)
			return (textHtml.replaceAll("\n", "<br/>")).trim();
		else if(text != null)
			return (text.replaceAll("\n", "<br/>")).trim();
		else
			return null;
	}
	public int getScopeManager() {
		return scopeManager;
	}
	public void setScopeManager(int scopeManager) {
		this.scopeManager = scopeManager;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public String getFromRole() {
		return fromRole;
	}
	public void setFromRole(String fromRole) {
		this.fromRole = fromRole;
	}
	public String getToRole() {
		return toRole;
	}
	public void setToRole(String toRole) {
		this.toRole = toRole;
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
	public SystemUser getFromUser() {
		return fromUser;
	}
	public void setFromUser(SystemUser fromUser) {
		this.fromUser = fromUser;
	}
	public SystemUser getToUser() {
		return toUser;
	}
	public void setToUser(SystemUser toUser) {
		this.toUser = toUser;
	}
	
	@Override
	public String toString() {
		return "Comment [id=" + id + ", fromUserId=" + fromUserId
				+ ", toUserId=" + toUserId + ", journalId=" + journalId
				+ ", manuscriptId=" + manuscriptId + ", revisionCount="
				+ revisionCount + ", text=" + text + ", fromRole=" + fromRole
				+ ", toRole=" + toRole + ", scopeManager=" + scopeManager
				+ ", status=" + status + ", date=" + date + ", time=" + time
				+ ", cameraReadyRevision=" + cameraReadyRevision
				+ ", galleryProofRevision=" + galleryProofRevision
				+ ", fromUser=" + fromUser + ", toUser=" + toUser + "]";
	}
	@Override
	public int compareTo(Comment o) {
		/*
		if(this.revisionCount != o.getRevisionCount()) {
			Integer myRevision = new Integer(this.revisionCount);
			Integer otherRevision = new Integer(o.getRevisionCount());
			int result = myRevision.compareTo(otherRevision);
			if(result != 0)
				return -1 * result;
		}
		
		if(this.status.equals(SystemConstants.statusM) && o.getStatus().equals(SystemConstants.statusM)) {
			Integer myRevision = new Integer(this.cameraReadyRevision);
			Integer otherRevision = new Integer(o.getCameraReadyRevision());
			int result = myRevision.compareTo(otherRevision);
			if(result != 0)
				return -1 * result;
	
		} else if(this.status.equals(SystemConstants.statusG) && o.getStatus().equals(SystemConstants.statusG)) {
			Integer myRevision = new Integer(this.cameraReadyRevision);
			Integer otherRevision = new Integer(o.getCameraReadyRevision());
			int result = myRevision.compareTo(otherRevision);
			if(result != 0)
				return -1 * result;
		}
		*/
		if(this.date.compareTo(o.getDate()) == 0)
			return this.time.compareTo(o.getTime());
		else
			this.date.compareTo(o.getDate());
		
		return 0;

	}

	

}
