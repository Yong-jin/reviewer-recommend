package link.thinkonweb.domain.roles;

import java.io.Serializable;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.user.SystemUser;

public class ChiefEditor extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384952L;	
	
	public ChiefEditor() {
		super();
		super.role = SystemConstants.roleCEditor;
	}
	
	public ChiefEditor(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleCEditor;
	}

	@Override
	public String toString() {
		return "ChiefEditor [id=" + id + ", journalId=" + journalId
				+ ", userId=" + userId + ", authorityId=" + authorityId
				+ ", user=" + user + ", role=" + role + "]";
	}
	
	
}