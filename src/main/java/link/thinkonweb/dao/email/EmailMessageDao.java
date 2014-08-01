package link.thinkonweb.dao.email;

import link.thinkonweb.domain.email.EmailMessage;

public interface EmailMessageDao {
	public int insert(EmailMessage email);
	public void update(EmailMessage email);
	public void delete(EmailMessage email);
}