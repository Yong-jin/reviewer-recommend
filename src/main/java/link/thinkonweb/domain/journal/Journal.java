package link.thinkonweb.domain.journal;

import java.io.Serializable;
import java.sql.Time;
import java.sql.Date;

import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;

public class Journal implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384943L;	

	private int id;
	private String journalNameId;
	private String title;	
	private String shortTitle;
	private String homepage;
	private String organization;
	private String languageCode;
	private CountryCode publisherCountryCode;
	private String countryCode;
	private Date registeredDate;
	private Time registeredTime;
	private SystemUser creator;
	private boolean isCoverImageUploaded = false;
	private String coverImageFilename;
	private String type;
	private String about;
	private String issn;
	private boolean enabled;
	private boolean paid;

	public Journal() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public SystemUser getCreator() {
		return creator;
	}

	public void setCreator(SystemUser creator) {
		this.creator = creator;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}
	
	public String getShortTitle() {
		return shortTitle;
	}

	public void setShortTitle(String shortTitle) {
		this.shortTitle = shortTitle;
	}
	
	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	
	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public Date getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(Date registeredDate) {
		this.registeredDate = registeredDate;
	}
	
	public Time getRegisteredTime() {
		return registeredTime;
	}

	public void setRegisteredTime(Time registeredTime) {
		this.registeredTime = registeredTime;
	}

	public String getCoverImageFilename() {
		return coverImageFilename;
	}

	public void setCoverImageFilename(String coverImageFilename) {
		this.coverImageFilename = coverImageFilename;
	}
	
	public boolean isCoverImageUploaded() {
		return isCoverImageUploaded;
	}

	public void setCoverImageUploaded(boolean isCoverImageUploaded) {
		this.isCoverImageUploaded = isCoverImageUploaded;
	}

	public String getJournalNameId() {
		return journalNameId;
	}

	public void setJournalNameId(String journalNameId) {
		this.journalNameId = journalNameId;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getLanguageCode() {
		return languageCode;
	}

	public void setLanguageCode(String languageCode) {
		this.languageCode = languageCode;
	}

	public CountryCode getPublisherCountryCode() {
		return publisherCountryCode;
	}

	public void setPublisherCountryCode(CountryCode publisherCountryCode) {
		this.publisherCountryCode = publisherCountryCode;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getIssn() {
		return issn;
	}

	public void setIssn(String issn) {
		this.issn = issn;
	}

	public boolean isPaid() {
		return paid;
	}

	public void setPaid(boolean paid) {
		this.paid = paid;
	}

	@Override
	public String toString() {
		return "Journal [id=" + id + ", journalNameId=" + journalNameId
				+ ", title=" + title + ", shortTitle=" + shortTitle
				+ ", homepage=" + homepage + ", organization=" + organization
				+ ", languageCode=" + languageCode + ", publisherCountryCode="
				+ publisherCountryCode + ", countryCode=" + countryCode
				+ ", registeredDate=" + registeredDate + ", registeredTime="
				+ registeredTime + ", creator=" + creator
				+ ", isCoverImageUploaded=" + isCoverImageUploaded
				+ ", coverImageFilename=" + coverImageFilename + ", type="
				+ type + ", about=" + about + ", issn=" + issn + ", enabled="
				+ enabled + ", paid=" + paid + "]";
	}
	
}