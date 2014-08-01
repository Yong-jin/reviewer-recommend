package link.thinkonweb.domain.roles;

import java.io.Serializable;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.user.SystemUser;

public class Member extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384943L;	

	public Member() {
		super();
		super.role = SystemConstants.roleMember;
	}
	
	public Member(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleMember;
	}
}