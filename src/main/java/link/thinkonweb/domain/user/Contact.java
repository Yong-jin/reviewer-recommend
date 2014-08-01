package link.thinkonweb.domain.user;

import java.io.Serializable;

import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.SalutationDesignation;
public class Contact implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384944L;
	
	private int id;
	private int userId;
	private String firstName;
	private String lastName;
	private String localFullName;
	private String localFirstName;
	private String localLastName;
	private String degree;
	private String salutation;
	private String institution;
	private String department;
	private String localInstitution;
	private String localDepartment;
	private String localJobTitle;
	private CountryCode countryCode;
	private String country;
	private String phone;
	private String mobile;
	private String fax;
	private String website;
	private String about;

	public Contact() {
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

	public String getDegree() {
		return degree;
	}
	
	public DegreeDesignation getDegreeDesignation() {
		if(degree != null) {
			int degreeNumber = Integer.parseInt(degree);
			return DegreeDesignation.getType(degreeNumber);
		} else
			return null;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getSalutation() {
		return salutation;
	}
	
	public SalutationDesignation getSalutationDesignation() {
		if(salutation != null) {
			int salutationNumber = Integer.parseInt(salutation);
			return SalutationDesignation.getType(salutationNumber);
		} else
			return null;
	}

	public void setSalutation(String salutation) {
		this.salutation = salutation;
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
	
	public String getDepartment(String languageCode) {
		if(languageCode.equals("ko") && localDepartment != null && !localDepartment.trim().equals(""))
			return localDepartment;
		else
			return department;
	}

	public void setInstitution(String institution) {
		this.institution = institution;
	}

	public CountryCode getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(CountryCode countryCode) {
		this.countryCode = countryCode;
	}

	public String getLocalFullName() {
		return localFullName;
	}

	public void setLocalFullName(String localFullName) {
		this.localFullName = localFullName;
	}

	public String getLocalFirstName() {
		return localFirstName;
	}

	public void setLocalFirstName(String localFirstName) {
		this.localFirstName = localFirstName;
	}

	public String getLocalLastName() {
		return localLastName;
	}

	public void setLocalLastName(String localLastName) {
		this.localLastName = localLastName;
	}
	
	public String getLocalJobTitle() {
		return localJobTitle;
	}

	public void setLocalJobTitle(String localJobTitle) {
		this.localJobTitle = localJobTitle;
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
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}
	

	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	@Override
	public String toString() {
		return "Contact [id=" + id + ", userId=" + userId + ", firstName="
				+ firstName + ", lastName=" + lastName + ", localFullName="
				+ localFullName + ", localFirstName=" + localFirstName
				+ ", localLastName=" + localLastName + ", degree=" + degree
				+ ", salutation=" + salutation + ", institution=" + institution
				+ ", department=" + department + ", localInstitution="
				+ localInstitution + ", localDepartment=" + localDepartment
				+ ", localJobTitle=" + localJobTitle + ", countryCode="
				+ countryCode + ", country=" + country + ", phone=" + phone
				+ ", mobile=" + mobile + ", fax=" + fax + ", website="
				+ website + ", about=" + about + "]";
	}
	
}