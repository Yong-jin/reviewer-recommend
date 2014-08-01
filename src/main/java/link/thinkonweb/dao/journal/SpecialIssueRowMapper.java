package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.SpecialIssue;

import org.springframework.jdbc.core.RowMapper;

public class SpecialIssueRowMapper implements RowMapper<SpecialIssue> {
	
	@Override
	public SpecialIssue mapRow(ResultSet rs, int rowNum) throws SQLException {
		SpecialIssue specialIssue = new SpecialIssue();
		specialIssue.setId(rs.getInt("ID"));
		specialIssue.setJournalId(rs.getInt("JOURNAL_ID"));
		specialIssue.setGuestEditorUserId(rs.getInt("GE_USER_ID"));
		specialIssue.setTitle(rs.getString("TITLE"));
		specialIssue.setDescription(rs.getString("DESCRIPTION"));
		specialIssue.setSubmissionDueDate(rs.getDate("SUBMIT_DUE_DATE"));
		specialIssue.setSubmissionDueTime(rs.getTime("SUBMIT_DUE_TIME"));
		specialIssue.setCreationDate(rs.getDate("CREATE_DATE"));
		specialIssue.setCreationTime(rs.getTime("CREATE_TIME"));
		specialIssue.setStatus(rs.getBoolean("STATUS"));
		
		return specialIssue;
	}
}
