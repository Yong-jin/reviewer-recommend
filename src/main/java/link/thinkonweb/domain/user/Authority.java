package link.thinkonweb.domain.user;

import java.io.Serializable;

import org.springframework.security.core.GrantedAuthority;

public class Authority implements Serializable, GrantedAuthority {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384942L;
	
	private int id;
	private int userId;		
	private int journalId;
	private String role;
	
	public Authority() {
	}
	
	public Authority(int userId, String role) {
		this.userId = userId;
		this.journalId = 0;
		this.role = role;
	}
	
	public Authority(int userId, int journalId, String role) {
		this.userId = userId;
		this.journalId = journalId;
		this.role = role;
	}
		
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getJournalId() {
		return journalId;
	}

	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}

	@Override
	public String toString() {
		return "Authority [id=" + id + ", userId=" + userId + ", journalId="
				+ journalId + ", role=" + role + "]";
	}

	@Override
	public String getAuthority() {
		return role;
	}
}