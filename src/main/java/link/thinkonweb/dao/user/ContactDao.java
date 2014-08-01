package link.thinkonweb.dao.user;

import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.user.Contact;

public interface ContactDao {
	public void create(Contact Contact);
	public void update(Contact Contact);
	public void delete(Contact Contact);
	public Contact findById(int id);
	public Contact findByUserId(int userId);	
	public List<Contact> findAll();
	public List<Contact> findContactsWithParams(Map<String, String> paramValues);
	public List<Contact> findContactsAndAuthoritiesWithParams(Map<String, String> paramValues, String role, int journalId);
	public void updatePersonalInfo(Contact contact);
	public void updateKoreanInfo(Contact contact);
}
