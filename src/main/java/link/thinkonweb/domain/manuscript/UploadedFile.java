package link.thinkonweb.domain.manuscript;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

public class UploadedFile implements Serializable, Comparable<UploadedFile> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8368643254046317356L;
	private int id;
	private int manuscriptId;
	private int userId;
	private String name;
	private String designation;
	private Date date;
	private Time time;
	private String absolutePath;
	private String path;
	private String originalName;
	private int revisionCount;
	private boolean confirm;
	private String role;
	private int galleryProofRevision;
	private int cameraReadyRevision;
	
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
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
	public void setAbsolutePath(String absoultePath) {
		this.absolutePath = absoultePath;
	}
	public String getAbsolutePath() {
		return absolutePath;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getPath() {
		return path;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getUserId() {
		return userId;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public boolean isConfirm() {
		return confirm;
	}
	public void setConfirm(boolean confirm) {
		this.confirm = confirm;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public int getGalleryProofRevision() {
		return galleryProofRevision;
	}
	public void setGalleryProofRevision(int galleryProofRevision) {
		this.galleryProofRevision = galleryProofRevision;
	}
	public int getCameraReadyRevision() {
		return cameraReadyRevision;
	}
	public void setCameraReadyRevision(int cameraReadyRevision) {
		this.cameraReadyRevision = cameraReadyRevision;
	}
	
	
	@Override
	public String toString() {
		return "UploadedFile [id=" + id + ", manuscriptId=" + manuscriptId
				+ ", userId=" + userId + ", name=" + name + ", designation="
				+ designation + ", date=" + date + ", time=" + time
				+ ", absolutePath=" + absolutePath + ", path=" + path
				+ ", originalName=" + originalName + ", revisionCount="
				+ revisionCount + ", confirm=" + confirm + ", role=" + role
				+ ", galleryProofRevision=" + galleryProofRevision
				+ ", cameraReadyRevision=" + cameraReadyRevision + "]";
	}
	@Override
	public int compareTo(UploadedFile o) {
		if(this.designation.equals("mainDocument"))
			return -1;
		else {
			if(this.date.compareTo(o.getDate()) == 0)
				return this.time.compareTo(o.getTime());
			else
				this.date.compareTo(o.getDate());
		}
		return 0;
	}

}
