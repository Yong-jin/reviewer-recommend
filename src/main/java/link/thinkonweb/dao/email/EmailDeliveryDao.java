package link.thinkonweb.dao.email;

import java.util.List;

import link.thinkonweb.domain.email.EmailDelivery;
import link.thinkonweb.util.DataTableClientRequest;

public interface EmailDeliveryDao {
	public void insert(EmailDelivery emailDelivery);
	public void update(EmailDelivery emailDelivery);
	public void delete(EmailDelivery emailDelivery);
	public List<EmailDelivery> findEmails(int userId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int numEmails(int userId);
	public EmailDelivery findById(int id);
}
