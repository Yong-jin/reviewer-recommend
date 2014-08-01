package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.Reviewer;

public class JournalReviewerRowMapper extends JournalRoleRowMapper<Reviewer> {
	public JournalReviewerRowMapper() {
	}
	
	@Override
	public Reviewer instantiateEntityClass(final ResultSet rs, final int rowNum) throws SQLException {
		Reviewer reviewer = new Reviewer();
		reviewer.setAssignedUpToNow(rs.getInt("ASSIGNED_UP_TO_NOW"));
		reviewer.setInvitedUpToNow(rs.getInt("INVITED_UP_TO_NOW"));
		reviewer.setCompletedUpToNow(rs.getInt("COMPLETED_UP_TO_NOW"));
		return reviewer;
	}
}