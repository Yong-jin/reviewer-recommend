package link.thinkonweb.domain.manuscript;

import java.io.Serializable;

public class ReviewerSuggest implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5444105470849454454L;

	private int id;
	private int reviewerUserId;	//reviewer who suggest someone
	private int editorUserId;
	private int reviewId;
	private int manuscriptId;
	private int reason;
	private String comment;
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
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public int getEditorUserId() {
		return editorUserId;
	}
	public void setEditorUserId(int editorUserId) {
		this.editorUserId = editorUserId;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public int getReason() {
		return reason;
	}
	public void setReason(int reason) {
		this.reason = reason;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getReviewerUserId() {
		return reviewerUserId;
	}
	public void setReviewerUserId(int reviewerUserId) {
		this.reviewerUserId = reviewerUserId;
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
	@Override
	public String toString() {
		return "ReviewerSuggest [id=" + id + ", reviewerUserId="
				+ reviewerUserId + ", editorUserId=" + editorUserId
				+ ", reviewId=" + reviewId + ", manuscriptId=" + manuscriptId
				+ ", reason=" + reason + ", comment=" + comment
				+ ", firstName=" + firstName + ", lastName=" + lastName
				+ ", email=" + email + ", institution=" + institution
				+ ", degree=" + degree + ", salutation=" + salutation
				+ ", countryCode=" + countryCode + ", department=" + department
				+ ", localInstitution=" + localInstitution
				+ ", localDepartment=" + localDepartment + ", localFullName="
				+ localFullName + "]";
	}
	

	
}
