package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;



import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;
import link.thinkonweb.domain.journal.SpecialIssue;

import org.springframework.jdbc.core.RowMapper;

public class GuestEditorSpecialIssueSpecialIssueRowMapper implements RowMapper<GuestEditorSpecialIssue> {
	
	@Override
	public GuestEditorSpecialIssue mapRow(ResultSet rs, int rowNum) throws SQLException {
		GuestEditorSpecialIssue userSpecialIssue = new GuestEditorSpecialIssue();
		userSpecialIssue.setId(rs.getInt("GS.ID"));
		userSpecialIssue.setJournalId(rs.getInt("GS.JOURNAL_ID"));
		userSpecialIssue.setUserId(rs.getInt("GS.USER_ID"));
		userSpecialIssue.setSpecialIssueId(rs.getInt("GS.SPECIAL_ISSUE_ID"));
		
		SpecialIssue si = new SpecialIssue();
		si.setId(rs.getInt("SI.ID"));
		si.setTitle(rs.getString("SI.TITLE"));
		si.setDescription(rs.getString("SI.DESCRIPTION"));
		si.setJournalId(rs.getInt("SI.JOURNAL_ID"));
		userSpecialIssue.setSpecialIssue(si);
		
		return userSpecialIssue;
	}
}
