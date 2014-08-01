package link.thinkonweb.dao.email;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.email.EmailDelivery;

import org.springframework.jdbc.core.RowMapper;

public class EmailDeliveryRowMapper implements RowMapper<EmailDelivery> {
	
	@Override
	public EmailDelivery mapRow(ResultSet rs, int rowNum) throws SQLException {
		EmailDelivery ed = new EmailDelivery();
		ed.setId(rs.getInt("ID"));
		ed.setSenderUserId(rs.getInt("SENDER_USER_ID"));
		ed.setReceiverUserId(rs.getInt("RECEIVER_USER_ID"));
		ed.setDate(rs.getDate("DATE"));
		ed.setTime(rs.getTime("TIME"));
		ed.setJournalId(rs.getInt("JOURNAL_ID"));
		ed.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		ed.setMessageId(rs.getInt("MESSAGE_ID"));
		ed.setCc(rs.getBoolean("IS_CC"));
		return ed;
	}
}