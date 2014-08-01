package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

import link.thinkonweb.domain.user.SystemUser;

public class ReviewPreference implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5444105470849474454L;

	private int id;
	private int userId;
	private int revisionCount;
	private int manuscriptId;
	private String firstName;
	private String lastName;
	private String email;
	private String institution;
	private String degree;
	private String salutation;
	private String countryCode;
	private String department;
	private String localInstitution;
	private String localDepartment;
	private String localFullName;
	private SystemUser user;
	
	
	public SystemUser getUser() {
		return user;
	}
	public void setUser(SystemUser user) {
		this.user = user;
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
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getInstitution() {
		return institution;
	}
	
	public String getInstitution(String languageCode) {
		if(languageCode.equals("ko") && localInstitution != null && !localInstitution.trim().equals(""))
			return localInstitution;
		else
			return institution;
	}
	
	public void setInstitution(String institution) {
		this.institution = institution;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getSalutation() {
		return salutation;
	}
	public void setSalutation(String salutation) {
		this.salutation = salutation;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getLocalInstitution() {
		return localInstitution;
	}
	public void setLocalInstitution(String localInstitution) {
		this.localInstitution = localInstitution;
	}
	public String getLocalDepartment() {
		return localDepartment;
	}
	public void setLocalDepartment(String localDepartment) {
		this.localDepartment = localDepartment;
	}
	public String getLocalFullName() {
		return localFullName;
	}
	public void setLocalFullName(String localFullName) {
		this.localFullName = localFullName;
	}
	
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	@Override
	public String toString() {
		return "ReviewPreference [id=" + id + ", userId=" + userId
				+ ", manuscriptId=" + manuscriptId + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", email=" + email
				+ ", institution=" + institution + ", degree=" + degree
				+ ", salutation=" + salutation + ", countryCode=" + countryCode
				+ ", department=" + department + ", localInstitution="
				+ localInstitution + ", localDepartment=" + localDepartment
				+ ", localFullName=" + localFullName + "]";
	}
	
	


}
