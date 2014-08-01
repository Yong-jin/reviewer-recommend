package link.thinkonweb.dao.email;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import link.thinkonweb.domain.email.EmailMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;


public class EmailMessageDaoImpl extends NamedParameterJdbcDaoSupport implements EmailMessageDao {
	@Autowired
	private EmailDeliveryRowMapper emailRowMapper;

	public void setEmmailRowMapper(EmailDeliveryRowMapper emailRowMapper) {
		this.emailRowMapper = emailRowMapper;
	}
	
	@Override
	public int insert(final EmailMessage email) {
		
		final String bodyText = email.getBody().replaceAll("\r\n", "<br/>");
		KeyHolder keyHolder = new GeneratedKeyHolder();
		
		this.getJdbcTemplate().update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(
                        	"INSERT INTO EMAIL_MESSAGES (SUBJECT, BODY) VALUES (?, ?)",
                        	new String[] { "ID" });
                ps.setString(1, email.getSubject().trim());
                ps.setString(2, bodyText.trim());
                return ps;
            }
        }, keyHolder);
		return keyHolder.getKey().intValue();
	}

	@Override
	public void update(EmailMessage email) {
		String sql = "UPDATE EMAIL_MESSAGES SET SUBJECT = ?, BODY = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {email.getSubject(), email.getBody(), email.getId()});	
	}

	@Override
	public void delete(EmailMessage email) {
		String sql = "DELETE FROM EMAIL_MESSAGES WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {email.getId()});
	}

}
