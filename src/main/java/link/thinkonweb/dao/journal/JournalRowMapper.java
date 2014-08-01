package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.SystemUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;

public class JournalRowMapper implements RowMapper<Journal> {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CountryCodeDao countryCodeDao; 

	@Override
	public Journal mapRow(ResultSet rs, int rowNum) throws SQLException {
		Journal journal = new Journal();
		journal.setId(rs.getInt("ID"));
		journal.setJournalNameId(rs.getString("JOURNAL_NAME_ID"));
		journal.setTitle(rs.getString("TITLE"));
		journal.setShortTitle(rs.getString("SHORT_TITLE"));
		journal.setHomepage(rs.getString("HOMEPAGE"));
		journal.setOrganization(rs.getString("ORGANIZATION"));
		journal.setRegisteredDate(rs.getDate("REGISTERED_DATE"));
		journal.setRegisteredTime(rs.getTime("REGISTERED_TIME"));		
		journal.setLanguageCode(rs.getString("LANGUAGE_CODE"));
		journal.setPublisherCountryCode(countryCodeDao.findByAlpha2(rs.getString("PUBLISHER_COUNTRY_CODE")));
		journal.setCountryCode(rs.getString("PUBLISHER_COUNTRY_CODE"));
		SystemUser user = userDao.findById(rs.getInt("CREATOR_ID"));
		journal.setCreator(user);
		journal.setCoverImageFilename(rs.getString("COVER_IMAGE_FILENAME"));
		journal.setType(rs.getString("TYPE"));
		journal.setAbout(rs.getString("ABOUT"));
		journal.setIssn(rs.getString("ISSN"));
		journal.setEnabled(rs.getBoolean("ENABLED"));
		journal.setPaid(rs.getBoolean("PAID"));
		return journal;
	}
}