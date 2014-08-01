package link.thinkonweb.domain.email;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

import link.thinkonweb.configuration.SystemConstants;

public class EmailDelivery implements Serializable {
	/**
	 * 
	 */
	public static final long serialVersionUID = 2160842633075378988L;
	protected int id;
	protected String senderUsername;
	protected int senderUserId;

	protected String receiverUsername;
	protected int receiverUserId;
	
	protected int journalId;
	protected int manuscriptId;
	protected int messageId;
	protected Date date;
	protected Time time;
	protected EmailMessage emailMessage;
	
	protected boolean isCc; //Carbon Copy
	
	public EmailDelivery() {
		
	}
	
	public EmailDelivery(String receiverUsername, int receiverUserId, int journalId, int manuscriptId, boolean isCc) {
		this.senderUsername = SystemConstants.EMAIL_FROM_USERNAME;
		this.senderUserId = SystemConstants.NO_REPLY_USER_ID;
		this.receiverUsername = receiverUsername;
		this.receiverUserId = receiverUserId;
		this.journalId = journalId;
		this.manuscriptId = manuscriptId;
		this.isCc = isCc;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSenderUsername() {
		return senderUsername;
	}

	public void setSenderUsername(String senderUsername) {
		this.senderUsername = senderUsername;
	}

	public int getSenderUserId() {
		return senderUserId;
	}

	public void setSenderUserId(int senderUserId) {
		this.senderUserId = senderUserId;
	}

	public String getReceiverUsername() {
		return receiverUsername;
	}

	public void setReceiverUsername(String receiverUsername) {
		this.receiverUsername = receiverUsername;
	}

	public int getReceiverUserId() {
		return receiverUserId;
	}

	public void setReceiverUserId(int receiverUserId) {
		this.receiverUserId = receiverUserId;
	}

	public int getJournalId() {
		return journalId;
	}

	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}

	public int getManuscriptId() {
		return manuscriptId;
	}

	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}

	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Time getTime() {
		return time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	public boolean isCc() {
		return isCc;
	}

	public void setCc(boolean isCc) {
		this.isCc = isCc;
	}
	
	public EmailMessage getEmailMessage() {
		return emailMessage;
	}

	public void setEmailMessage(EmailMessage emailMessage) {
		this.emailMessage = emailMessage;
	}

	@Override
	public String toString() {
		return "EmailDelivery [id=" + id + ", senderUsername=" + senderUsername
				+ ", senderUserId=" + senderUserId + ", receiverUsername="
				+ receiverUsername + ", receiverUserId=" + receiverUserId
				+ ", journalId=" + journalId + ", manuscriptId=" + manuscriptId
				+ ", messageId=" + messageId + ", date=" + date + ", time="
				+ time + ", emailMessage=" + emailMessage + ", isCc=" + isCc
				+ "]";
	}

	
}
