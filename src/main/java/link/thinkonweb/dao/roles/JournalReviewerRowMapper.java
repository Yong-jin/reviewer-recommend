package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.Reviewer;

public class JournalReviewerRowMapper extends JournalRoleRowMapper<Reviewer> {
	public JournalReviewerRowMapper() {
	}
	
	@Override
	public Reviewer instantiateEntityClass(final ResultSet rs, final int rowNum) throws SQLException {
		return new Reviewer();
	}
}