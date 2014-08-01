package link.thinkonweb.domain.roles;

import java.io.Serializable;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.user.SystemUser;

public class Manager extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384955L;	

	public Manager() {
		super();
		super.role = SystemConstants.roleManager;
	}
	
	public Manager(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleManager;
	}
}