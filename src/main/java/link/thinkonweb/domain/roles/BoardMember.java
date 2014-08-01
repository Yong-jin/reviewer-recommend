package link.thinkonweb.domain.roles;

import java.io.Serializable;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.user.SystemUser;

public class BoardMember extends JournalRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384954L;	
	
	private List<UserDivision> userDivisions;
	
	public BoardMember() {
		super();
		super.role = SystemConstants.roleBMember;
	}
	
	public BoardMember(int userId, int journalId, SystemUser user) {
		super();
		super.userId = userId;
		super.journalId = journalId;
		super.user = user;
		super.role = SystemConstants.roleBMember;
	}

	public List<UserDivision> getUserDivisions() {
		return userDivisions;
	}

	public void setUserDivisions(List<UserDivision> userDivisions) {
		this.userDivisions = userDivisions;
	}

	@Override
	public String toString() {
		return "BoardMember [userDivisions=" + userDivisions + ", id=" + id
				+ ", journalId=" + journalId + ", userId=" + userId
				+ ", authorityId=" + authorityId + ", user=" + user + ", role="
				+ role + "]";
	}
	
	
}