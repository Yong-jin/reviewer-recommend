package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class UserDivision implements Serializable, Comparable<UserDivision> {

	private static final long serialVersionUID = -3795585952841447441L;
	private int id;
	private int userId;
	private int journalId;
	private int divisionId;
	private Division division;
	private String role;
	
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
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}
	public int getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(int divisionId) {
		this.divisionId = divisionId;
	}
	public Division getDivision() {
		return division;
	}
	public void setDivision(Division division) {
		this.division = division;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "UserDivision [id=" + id + ", userId=" + userId + ", journalId="
				+ journalId + ", divisionId=" + divisionId + ", division="
				+ division + ", role=" + role + "]";
	}
	@Override
	public int compareTo(UserDivision o) {
		if(this.division != null && o.getDivision() != null) {
			return this.division.getSymbol().compareTo(o.getDivision().getSymbol());
		} else
			return 0;
	}
}
