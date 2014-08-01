package link.thinkonweb.domain.journal;

import java.io.Serializable;
import java.sql.Timestamp;

public class ReviewerSummary implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1589892121024532606L;
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String title;
	private int accountId;
	private int manuscriptId;
	private Timestamp dueDate;
	private int status;
	private int bankConfirm;
	private String country;
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public Timestamp getDueDate() {
		return dueDate;
	}
	public void setDueDate(Timestamp dueDate) {
		this.dueDate = dueDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getBankConfirm() {
		return bankConfirm;
	}
	public void setBankConfirm(int bankConfirm) {
		this.bankConfirm = bankConfirm;
	}
	public String getFirstName() {
		if (firstName != null) {
			return firstName.trim();
		} else {
			return firstName;
		}
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		if (lastName != null) {
			return lastName.trim();
		} else {
			return lastName;
		}
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
}
