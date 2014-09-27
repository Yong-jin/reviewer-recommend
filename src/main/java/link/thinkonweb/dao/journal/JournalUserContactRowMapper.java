package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.SystemUser;

import javax.inject.Inject;
import org.springframework.jdbc.core.RowMapper;

public class JournalUserContactRowMapper implements RowMapper<Journal> {
	@Inject
	private CountryCodeDao countryCodeDao; 
	
	public JournalUserContactRowMapper() {
	}
	
	@Override
	public Journal mapRow(ResultSet rs, int rowNum) throws SQLException {
		SystemUser creator = new SystemUser();
		creator.setId(rs.getInt("U.ID"));
		creator.setUsername(rs.getString("U.USERNAME"));
		creator.setPassword(rs.getString("U.PASSWORD"));
		creator.setSignupDate(rs.getDate("U.SIGNUP_DATE"));
		creator.setSignupTime(rs.getTime("U.SIGNUP_TIME"));
		creator.setEnabled(rs.getBoolean("U.ENABLED"));
		
		Contact contact = new Contact();
		contact.setId(rs.getInt("C.ID"));
		contact.setUserId(rs.getInt("C.USER_ID"));
		contact.setFirstName(rs.getString("C.FIRST_NAME"));
		contact.setLastName(rs.getString("C.LAST_NAME"));
		contact.setInstitution(rs.getString("C.INSTITUTION"));
		contact.setDegree(rs.getString("C.DEGREE"));
		contact.setSalutation(rs.getString("C.SALUTATION"));
		contact.setCountryCode(countryCodeDao.findByAlpha2(rs.getString("C.COUNTRY_CODE")));
		creator.setContact(contact);

		Journal journal = new Journal();
		journal.setId(rs.getInt("J.ID"));
		journal.setJournalNameId(rs.getString("J.JOURNAL_NAME_ID"));
		journal.setTitle(rs.getString("J.TITLE"));
		journal.setShortTitle(rs.getString("J.SHORT_TITLE"));
		journal.setHomepage(rs.getString("HOMEPAGE"));
		journal.setOrganization(rs.getString("J.ORGANIZATION"));
		journal.setLanguageCode(rs.getString("J.LANGUAGE_CODE"));
		journal.setPublisherCountryCode(countryCodeDao.findByAlpha2(rs.getString("J.PUBLISHER_COUNTRY_CODE")));
		journal.setRegisteredDate(rs.getDate("J.REGISTERED_DATE"));
		journal.setRegisteredTime(rs.getTime("J.REGISTERED_TIME"));
		journal.setCoverImageFilename(rs.getString("J.COVER_IMAGE_FILENAME"));
		journal.setEnabled(rs.getBoolean("J.ENABLED"));
		journal.setCreator(creator);
		return journal;
	}
}