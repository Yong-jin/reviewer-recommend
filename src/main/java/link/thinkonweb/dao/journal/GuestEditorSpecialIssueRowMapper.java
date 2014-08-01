package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;

import org.springframework.jdbc.core.RowMapper;

public class GuestEditorSpecialIssueRowMapper implements RowMapper<GuestEditorSpecialIssue> {
	
	@Override
	public GuestEditorSpecialIssue mapRow(ResultSet rs, int rowNum) throws SQLException {
		GuestEditorSpecialIssue geSpecialIssue = new GuestEditorSpecialIssue();
		geSpecialIssue.setId(rs.getInt("ID"));
		geSpecialIssue.setJournalId(rs.getInt("JOURNAL_ID"));
		geSpecialIssue.setUserId(rs.getInt("USER_ID"));
		geSpecialIssue.setSpecialIssueId(rs.getInt("SPECIAL_ISSUE_ID"));
		return geSpecialIssue;
	}
}
