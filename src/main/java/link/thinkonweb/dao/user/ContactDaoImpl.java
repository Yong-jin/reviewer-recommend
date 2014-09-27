package link.thinkonweb.dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import link.thinkonweb.domain.user.Contact;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class ContactDaoImpl extends NamedParameterJdbcDaoSupport implements ContactDao {
	@Inject
	private ContactRowMapper contactRowMapper;
	
	@Inject
	private CountryCodeDao countryCodeDao;
	
	@Override
	public void create(Contact contact) {
		String sql = "INSERT INTO CONTACTS (USER_ID, FIRST_NAME, LAST_NAME, LOCAL_FULL_NAME, DEGREE, SALUTATION, INSTITUTION, DEPARTMENT, LOCAL_INSTITUTION, LOCAL_DEPARTMENT, COUNTRY_CODE, PHONE, MOBILE, FAX, WEBSITE, ABOUT, LOCAL_JOB_TITLE) " +
					 "VALUES (:userid, :fn, :ln, :localfullname, :degree, :sal, :inst, :dept, :localinst, :localdept, :country, :phone, :mobile, :fax, :website, :about, :localJobTitle)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("userid", contact.getUserId());
		argMap.put("fn", contact.getFirstName().trim());
		argMap.put("ln", contact.getLastName().trim());
		if (contact.getLocalFullName() != null) {
			argMap.put("localfullname", contact.getLocalFullName().trim());
		} else { 
			argMap.put("localfullname", null);
		} 
		argMap.put("degree", contact.getDegree().trim());
		argMap.put("sal", contact.getSalutation().trim());
		argMap.put("inst", contact.getInstitution().trim());
		if (contact.getDepartment() != null) {
			argMap.put("dept", contact.getDepartment().trim());
		} else {
			argMap.put("dept", null);
		}
		if (contact.getLocalInstitution() != null) {
			argMap.put("localinst", contact.getLocalInstitution().trim());
		} else {
			argMap.put("localinst", null);
		}
		if (contact.getLocalDepartment() != null) {
			argMap.put("localdept", contact.getLocalDepartment().trim());
		} else {
			argMap.put("localdept", null);
		}
		argMap.put("country", contact.getCountry().trim());
		if (contact.getPhone() != null) {
			argMap.put("phone", contact.getPhone().trim());
		} else {
			argMap.put("phone", null);
		}
		if (contact.getMobile() != null) {
			argMap.put("mobile", contact.getMobile().trim());
		} else {
			argMap.put("mobile", null);
		}
		if (contact.getFax() != null) {
			argMap.put("fax", contact.getFax().trim());
		} else {
			argMap.put("fax", null);
		}
		if (contact.getWebsite() != null) {
			argMap.put("website", contact.getWebsite().trim());
		} else {
			argMap.put("website", null);
		}
		if (contact.getAbout() != null) {
			argMap.put("about", contact.getAbout().trim());
		} else {
			argMap.put("about", null);
		}
		if (contact.getLocalJobTitle() != null) {
			argMap.put("localJobTitle", contact.getLocalJobTitle().trim());
		} else {
			argMap.put("localJobTitle", null);
		}
			
		this.getNamedParameterJdbcTemplate().update(sql, argMap);
	}

	@Override
	public void update(Contact contact) {
		String sql = "UPDATE CONTACTS SET FIRST_NAME=?, LAST_NAME=?, LOCAL_FULL_NAME=?, DEGREE=?, SALUTATION=?, INSTITUTION=?, DEPARTMENT=?, LOCAL_INSTITUTION=?, LOCAL_DEPARTMENT=?, COUNTRY_CODE=?, PHONE=?, MOBILE=?, FAX=?, WEBSITE=?, ABOUT=?, LOCAL_JOB_TITLE=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {
												contact.getFirstName() == null ? null : contact.getFirstName().trim(), 
												contact.getLastName() == null ? null : contact.getLastName().trim(),
												contact.getLocalFullName() == null ? null : contact.getLocalFullName().trim(),
												contact.getDegree() == null ? null : contact.getDegree().trim(),
												contact.getSalutation() == null ? null : contact.getSalutation().trim(),
												contact.getInstitution() == null ? null : contact.getInstitution().trim(),
												contact.getDepartment() == null ? null : contact.getDepartment().trim(),
												contact.getLocalInstitution() == null ? null : contact.getLocalInstitution().trim(),
												contact.getLocalDepartment() == null ? null : contact.getLocalDepartment().trim(),
												contact.getCountry() == null ? null : contact.getCountry().trim(),
												contact.getPhone() == null ? null : contact.getPhone().trim(),
												contact.getMobile() == null ? null : contact.getMobile().trim(),
												contact.getFax() == null ? null : contact.getFax().trim(),
												contact.getWebsite() == null ? null : contact.getWebsite().trim(),
												contact.getAbout() == null ? null : contact.getAbout().trim(),
												contact.getLocalJobTitle() == null ? null : contact.getLocalJobTitle().trim(),
												contact.getId()});
	}
	
	@Override
	public void updatePersonalInfo(Contact contact) {
		String sql = "UPDATE CONTACTS SET FIRST_NAME=?, LAST_NAME=?, DEGREE=?, SALUTATION=?, INSTITUTION=?, DEPARTMENT=?, COUNTRY_CODE=?, PHONE=?, MOBILE=?, FAX=?, WEBSITE=?, ABOUT=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {
												contact.getFirstName() == null ? null : contact.getFirstName().trim(), 
												contact.getLastName() == null ? null : contact.getLastName().trim(),
												contact.getDegree() == null ? null : contact.getDegree().trim(),
												contact.getSalutation() == null ? null : contact.getSalutation().trim(),
												contact.getInstitution() == null ? null : contact.getInstitution().trim(),
												contact.getDepartment() == null ? null : contact.getDepartment().trim(),
												contact.getCountry() == null ? null : contact.getCountry().trim(),
												contact.getPhone() == null ? null : contact.getPhone().trim(),
												contact.getMobile() == null ? null : contact.getMobile().trim(),
												contact.getFax() == null ? null : contact.getFax().trim(),
												contact.getWebsite() == null ? null : contact.getWebsite().trim(),
												contact.getAbout() == null ? null : contact.getAbout().trim(),
												contact.getId()});
	}
	
	
	
	@Override
	public void updateKoreanInfo(Contact contact) {
		String sql = "UPDATE CONTACTS SET LOCAL_FULL_NAME=?, LOCAL_INSTITUTION=?, LOCAL_DEPARTMENT=?, LOCAL_JOB_TITLE=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {
												contact.getLocalFullName() == null ? null : contact.getLocalFullName().trim(),
												contact.getLocalInstitution() == null ? null : contact.getLocalInstitution().trim(),
												contact.getLocalDepartment() == null ? null : contact.getLocalDepartment().trim(),
												contact.getLocalJobTitle() == null ? null : contact.getLocalJobTitle().trim(),
												contact.getId()});
	}

	@Override
	public void delete(Contact contact) {
		String sql = "DELETE FROM CONTACTS WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {contact.getId()});
	}

	@Override
	public Contact findById(int id) {
		String sql = "SELECT * FROM CONTACTS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, contactRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public Contact findByUserId(int userId) {
		String sql = "SELECT * FROM CONTACTS WHERE USER_ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, contactRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Contact> findAll() {
		String sql = "SELECT * FROM CONTACTS";
		List<Contact> list = this.getJdbcTemplate().query(sql, contactRowMapper);	
		return list;
	}
	
	@Override
	public List<Contact> findContactsWithParams(Map<String, String> paramValues) {
		StringBuffer buf = new StringBuffer();
		buf.append("WHERE ");
		int index = 0;
		for(String key: paramValues.keySet()) {
			
			buf.append(key);
			buf.append(" LIKE '%");
			buf.append(paramValues.get(key));
			buf.append("%'");
			
			index++;
			if(index != paramValues.size())
				buf.append(" and ");
		}
		buf.append(" AND USER_ID > 2 COLLATE UTF8_GENERAL_CI ");

		String whereClause = buf.toString();
		String query = "SELECT * FROM CONTACTS " + whereClause;
		List<Contact> contactList = this.getJdbcTemplate().query(query, contactRowMapper);
		return contactList;
	}
	

	@Override
	public List<Contact> findContactsAndAuthoritiesWithParams(Map<String, String> paramValues, String role, int journalId) {
		StringBuffer buf = new StringBuffer();
		int index = 0;
		for(String key: paramValues.keySet()) {
			
			buf.append(key);
			buf.append(" LIKE '%");
			buf.append(paramValues.get(key));
			buf.append("%'");
			
			index++;
			if(index != paramValues.size())
				buf.append(" and ");
		}

		String whereClause = buf.toString();
		String query = "SELECT * FROM CONTACTS, AUTHORITIES WHERE CONTACTS.USER_ID = AUTHORITIES.USER_ID and JOURNAL_ID = ? and AUTHORITIES.ROLE = ? and " + whereClause;
		List<Contact> contactList = this.getJdbcTemplate().query(query, new Object[] {journalId, role}, contactRowMapper);
		return contactList;
	}
}