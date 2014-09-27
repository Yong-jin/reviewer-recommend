package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.inject.Inject;

import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.SystemUser;

import org.springframework.jdbc.core.RowMapper;

public class UserContactRowMapper implements RowMapper<SystemUser> {
	@Inject
	private CountryCodeDao countryCodeDao; 
	
	public UserContactRowMapper() {
	}
	
	@Override
	public SystemUser mapRow(ResultSet rs, int rowNum) throws SQLException {
		SystemUser user = new SystemUser();
		user.setId(rs.getInt("U.ID"));
		user.setUsername(rs.getString("U.USERNAME"));
		user.setPassword(rs.getString("U.PASSWORD"));
		user.setSignupDate(rs.getDate("U.SIGNUP_DATE"));
		user.setSignupTime(rs.getTime("U.SIGNUP_TIME"));
		user.setEnabled(rs.getBoolean("U.ENABLED"));
		
		Contact contact = new Contact();
		contact.setId(rs.getInt("C.ID"));
		contact.setUserId(rs.getInt("C.USER_ID"));
		contact.setFirstName(rs.getString("C.FIRST_NAME"));
		contact.setLastName(rs.getString("C.LAST_NAME"));
		contact.setInstitution(rs.getString("C.INSTITUTION"));
		contact.setDegree(rs.getString("C.DEGREE"));
		contact.setSalutation(rs.getString("C.SALUTATION"));
		contact.setCountryCode(countryCodeDao.findByAlpha2(rs.getString("C.COUNTRY_CODE")));
		contact.setDepartment(rs.getString("C.DEPARTMENT"));
		contact.setLocalInstitution(rs.getString("C.LOCAL_INSTITUTION"));
		contact.setLocalDepartment(rs.getString("C.LOCAL_DEPARTMENT"));
		contact.setPhone(rs.getString("C.PHONE"));
		contact.setMobile(rs.getString("C.MOBILE"));
		contact.setFax(rs.getString("C.FAX"));
		contact.setWebsite(rs.getString("C.WEBSITE"));
		contact.setAbout(rs.getString("C.ABOUT"));
		contact.setLocalJobTitle(rs.getString("C.LOCAL_JOB_TITLE"));
		contact.setLocalFullName(rs.getString("C.LOCAL_FULL_NAME"));
		
		user.setContact(contact);
		return user;
	}
}