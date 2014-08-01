package link.thinkonweb.dao.email;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.email.EmailDelivery;
import link.thinkonweb.domain.email.EmailMessage;

import org.springframework.jdbc.core.RowMapper;

public class EmailDeliveryEmailMessageRowMapper implements RowMapper<EmailDelivery> {
	
	@Override
	public EmailDelivery mapRow(ResultSet rs, int rowNum) throws SQLException {
		EmailDelivery ed = new EmailDelivery();
		ed.setId(rs.getInt("ED.ID"));
		ed.setSenderUserId(rs.getInt("ED.SENDER_USER_ID"));
		ed.setReceiverUserId(rs.getInt("ED.RECEIVER_USER_ID"));
		ed.setDate(rs.getDate("ED.DATE"));
		ed.setTime(rs.getTime("ED.TIME"));
		ed.setJournalId(rs.getInt("ED.JOURNAL_ID"));
		ed.setManuscriptId(rs.getInt("ED.MANUSCRIPT_ID"));
		ed.setMessageId(rs.getInt("ED.MESSAGE_ID"));
		ed.setCc(rs.getBoolean("ED.IS_CC"));
		
		EmailMessage em = new EmailMessage();
		em.setId(rs.getInt("EM.ID"));
		em.setBody(rs.getString("EM.BODY"));
		em.setSubject(rs.getString("EM.SUBJECT"));
		ed.setEmailMessage(em);
		
		return ed;
	}
}