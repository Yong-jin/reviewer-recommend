package link.thinkonweb.domain.user;

import java.io.Serializable;

public class UserExpertise implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1112506125254904183L;
	private int id;
	private int userId;		
	private String expertise;
	
	public UserExpertise() {
		
	}
	
	public UserExpertise(int userId, String expertise) {
		super();
		this.userId = userId;
		this.expertise = expertise;
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
	public String getExpertise() {
		return expertise;
	}
	public void setExpertise(String expertise) {
		this.expertise = expertise;
	}
	@Override
	public String toString() {
		return "UserExpertise [id=" + id + ", userId=" + userId
				+ ", expertise=" + expertise + "]";
	}
}
