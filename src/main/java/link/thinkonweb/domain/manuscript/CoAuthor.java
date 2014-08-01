package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

import link.thinkonweb.domain.user.SystemUser;

public class CoAuthor implements Serializable , Comparable<CoAuthor> {
	private static final long serialVersionUID = -6040304721211048939L;
	private int manuscriptId;
	private int revisionCount;
	private int authorOrder;
	private int userId;
	private SystemUser user;
	private boolean corresponding;
	private boolean createdMember;
	private String temporaryPassword;
	
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getAuthorOrder() {
		return authorOrder;
	}
	public void setAuthorOrder(int authorOrder) {
		this.authorOrder = authorOrder;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public boolean isCorresponding() {
		return corresponding;
	}
	public boolean isCreatedMember() {
		return createdMember;
	}
	public void setCreatedMember(boolean createdMember) {
		this.createdMember = createdMember;
	}
	public void setCorresponding(boolean corresponding) {
		this.corresponding = corresponding;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public SystemUser getUser() {
		return user;
	}
	public void setUser(SystemUser user) {
		this.user = user;
	}
	
	public String getTemporaryPassword() {
		return temporaryPassword;
	}
	public void setTemporaryPassword(String temporaryPassword) {
		this.temporaryPassword = temporaryPassword;
	}
	@Override
    public boolean equals(Object o) {		
        CoAuthor other = (CoAuthor)o; 
        if(this.userId == other.getUserId())
        	return true;
        else
        	return false;
    } 
	@Override
	public int hashCode(){   
		return 0; //just for overriding purpose  
	} 
	@Override
	public int compareTo(CoAuthor other) {
		int result;
		int compare = other.authorOrder;
		if (this.authorOrder > compare)
			result = 1;
		else if (this.authorOrder == compare)
			result = 0;
		else
			result = -1;
		return result;
	}
	@Override
	public String toString() {
		return "CoAuthor [manuscriptId=" + manuscriptId + ", revisionCount="
				+ revisionCount + ", authorOrder=" + authorOrder + ", userId="
				+ userId + ", corresponding=" + corresponding + ", user="
				+ user + ", createdMember=" + createdMember
				+ ", temporaryPassword=" + temporaryPassword + "]";
	}
	
}
