package link.thinkonweb.domain.email;

import java.util.List;

public class EmailDeliverySet {
	private List<EmailDelivery> emailDeliveries;
	private EmailMessage emailMessage;
	
	public EmailDeliverySet() {
	}
	
	public List<EmailDelivery> getEmailDeliveries() {
		return emailDeliveries;
	}

	public void setEmailDeliveries(List<EmailDelivery> emailDeliveries) {
		this.emailDeliveries = emailDeliveries;
	}

	public EmailMessage getEmailMessage() {
		return emailMessage;
	}

	public void setEmailMessage(EmailMessage emailMessage) {
		this.emailMessage = emailMessage;
	}

	@Override
	public String toString() {
		return "EmailDeliverySet [emailDeliveries=" + emailDeliveries
				+ ", emailMessage=" + emailMessage + "]";
	}
}
