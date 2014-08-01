package link.thinkonweb.domain.email;

import java.io.Serializable;

public class EmailMessage implements Serializable {
	/**
	 * 
	 */
	public static final long serialVersionUID = 2160842633075378989L;
	protected int id;
	protected String subject;
	protected String body;
	
	public EmailMessage() {
	}
	
	public EmailMessage(String subject, String body) {
		this.subject = subject;
		this.body = body;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	
	@Override
	public String toString() {
		return "EmailMessage [id=" + id + ", subject=" + subject + ", body="
				+ body + "]";
	}
}
