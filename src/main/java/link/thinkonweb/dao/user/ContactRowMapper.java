package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.inject.Inject;

import link.thinkonweb.domain.user.Contact;

import org.springframework.jdbc.core.RowMapper;

public class ContactRowMapper implements RowMapper<Contact> {
	@Inject
	private CountryCodeDao countryCodeDao; 
	
	public ContactRowMapper(CountryCodeDao countryCodeDao) {
		this.countryCodeDao = countryCodeDao;
	}
	
	@Override
	public Contact mapRow(ResultSet rs, int rowNum) throws SQLException {
		Contact contact = new Contact();
		contact.setId(rs.getInt("ID"));
		contact.setUserId(rs.getInt("USER_ID"));
		contact.setFirstName(rs.getString("FIRST_NAME"));
		contact.setLastName(rs.getString("LAST_NAME"));
		contact.setDegree(rs.getString("DEGREE"));
		contact.setSalutation(rs.getString("SALUTATION"));
		contact.setInstitution(rs.getString("INSTITUTION"));
		contact.setDepartment(rs.getString("DEPARTMENT"));
		contact.setLocalInstitution(rs.getString("LOCAL_INSTITUTION"));
		contact.setLocalDepartment(rs.getString("LOCAL_DEPARTMENT"));
		contact.setCountryCode(countryCodeDao.findByAlpha2(rs.getString("COUNTRY_CODE")));
		contact.setCountry(rs.getString("COUNTRY_CODE"));
		contact.setPhone(rs.getString("PHONE"));
		contact.setMobile(rs.getString("MOBILE"));
		contact.setFax(rs.getString("FAX"));
		contact.setWebsite(rs.getString("WEBSITE"));
		contact.setAbout(rs.getString("ABOUT"));
		contact.setLocalJobTitle(rs.getString("LOCAL_JOB_TITLE"));
		contact.setLocalFullName(rs.getString("LOCAL_FULL_NAME"));
		return contact;
	}
}
