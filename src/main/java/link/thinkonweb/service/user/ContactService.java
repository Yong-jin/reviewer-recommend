package link.thinkonweb.service.user;

import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.user.Contact;

public interface ContactService {
	public void create(Contact Contact);
	public void update(Contact Contact);
	public void delete(Contact Contact);
	public Contact getById(int id);
	public Contact getByUserId(int userId);
	public List<Contact> getAll();
	public List<Contact> getContactsWithParams(Map<String, String> paramValues);
	public void updateKoreanInfo(Contact contact);
	public String getFullName(Contact contact, String languageCode);
}
