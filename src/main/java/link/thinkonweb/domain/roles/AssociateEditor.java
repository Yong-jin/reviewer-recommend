package link.thinkonweb.domain.roles;

import java.io.Serializable;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.user.SystemUser;

public class AssociateEditor extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384951L;
	
	private List<UserDivision> userDivisions;

	public AssociateEditor() {
		super();
		super.role = SystemConstants.roleAEditor;
	}
	
	public AssociateEditor(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleAEditor;
	}

	public List<UserDivision> getUserDivisions() {
		return userDivisions;
	}

	public void setUserDivisions(List<UserDivision> userDivisions) {
		this.userDivisions = userDivisions;
	}

	@Override
	public String toString() {
		return "AssociateEditor [userDivisions=" + userDivisions + ", id=" + id
				+ ", journalId=" + journalId + ", userId=" + userId
				+ ", authorityId=" + authorityId + ", user=" + user + ", role="
				+ role + "]";
	}

}