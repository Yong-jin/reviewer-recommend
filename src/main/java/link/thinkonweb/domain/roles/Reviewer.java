package link.thinkonweb.domain.roles;

import java.io.Serializable;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.user.SystemUser;

public class Reviewer extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384956L;	
	private int invitedUpToNow;	// In journal
	private int assignedUpToNow;	// In journal
	private int completedUpToNow;	// In journal
	
    
	public Reviewer() {
		super();
		super.role = SystemConstants.roleReviewer;
	}
	
	public Reviewer(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleReviewer;
	}

	public int getInvitedUpToNow() {
		return invitedUpToNow;
	}

	public void setInvitedUpToNow(int invitedUpToNow) {
		this.invitedUpToNow = invitedUpToNow;
	}

	public int getAssignedUpToNow() {
		return assignedUpToNow;
	}

	public void setAssignedUpToNow(int assignedUpToNow) {
		this.assignedUpToNow = assignedUpToNow;
	}

	public int getCompletedUpToNow() {
		return completedUpToNow;
	}

	public void setCompletedUpToNow(int completedUpToNow) {
		this.completedUpToNow = completedUpToNow;
	}

}