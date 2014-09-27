package link.thinkonweb.service.user;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.user.ContactDao;
import link.thinkonweb.domain.user.Contact;

import org.springframework.stereotype.Service;

@Service
public class ContactServiceImpl implements ContactService {
	@Inject
	private ContactDao contactDao;
		
	@Override
	public void create(Contact Contact) {
		this.contactDao.create(Contact);
	}

	@Override
	
	public List<Contact> getAll() {
		return this.contactDao.findAll();
	}

	@Override
	public void update(Contact Contact) {
		this.contactDao.update(Contact);		
	}
	
	@Override
	
	public void updateKoreanInfo(Contact contact) {
		this.contactDao.updateKoreanInfo(contact);
	}

	@Override
	public void delete(Contact Contact) {
		this.contactDao.delete(Contact);
	}

	@Override
	
	public Contact getById(int id) {
		return this.contactDao.findById(id);
	}
	
	@Override
	
	public Contact getByUserId(int userId) {
		return this.contactDao.findByUserId(userId);
	}
	
	@Override
	
	public List<Contact> getContactsWithParams(Map<String, String> paramValues) {
		return this.contactDao.findContactsWithParams(paramValues);
	}
	
	@Override
	
	public String getFullName(Contact contact, String languageCode) {
		String fullName = null;
		if(languageCode.equals(SystemConstants.koreanLanguageCode)) {
			if(contact.getLocalFullName() != null)
				fullName = contact.getLocalFullName();
			else
				fullName = contact.getFirstName() + " " + contact.getLastName();
		} else
			fullName = contact.getFirstName() + " " + contact.getLastName();
		
		return fullName;
	}
}
