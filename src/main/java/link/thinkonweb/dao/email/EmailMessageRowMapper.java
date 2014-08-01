package link.thinkonweb.dao.email;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.email.EmailMessage;

import org.springframework.jdbc.core.RowMapper;

public class EmailMessageRowMapper implements RowMapper<EmailMessage> {	
	@Override
	public EmailMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
		EmailMessage em = new EmailMessage();
		em.setId(rs.getInt("ID"));
		em.setSubject(rs.getString("SUBJECT"));
		em.setBody(rs.getString("BODY"));		
		return em;
	}
}
