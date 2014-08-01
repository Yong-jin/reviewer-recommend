package link.thinkonweb.domain.roles;

import java.io.Serializable;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;
import link.thinkonweb.domain.user.SystemUser;

public class GuestEditor extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384953L;	

	private List<GuestEditorSpecialIssue> geSpecialIssues;
	
	public GuestEditor() {
		super();
		super.role = SystemConstants.roleGEditor;
	}
	
	public GuestEditor(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleGEditor;
	}

	public List<GuestEditorSpecialIssue> getGeSpecialIssues() {
		return geSpecialIssues;
	}

	public void setGeSpecialIssues(List<GuestEditorSpecialIssue> geSpecialIssues) {
		this.geSpecialIssues = geSpecialIssues;
	}

	@Override
	public String toString() {
		return "GuestEditor [geSpecialIssues=" + geSpecialIssues + ", id=" + id
				+ ", journalId=" + journalId + ", userId=" + userId
				+ ", authorityId=" + authorityId + ", user=" + user + ", role="
				+ role + "]";
	}
}