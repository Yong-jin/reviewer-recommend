package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.Manuscript;

import org.springframework.jdbc.core.RowMapper;

public class ManuscriptRowMapper implements RowMapper<Manuscript> {
	
	@Override
	public Manuscript mapRow(ResultSet rs, int rowNum) throws SQLException {
		Manuscript manuscript = new Manuscript();
		manuscript.setId(rs.getInt("ID"));
		manuscript.setStatus(rs.getString("STATUS"));
		manuscript.setRevisionCount(rs.getInt("REVISION_COUNT"));
		manuscript.setCoverLetter(rs.getString("COVERLETTER"));
		manuscript.setSubmitId(rs.getString("SUBMIT_ID"));
		manuscript.setUserId(rs.getInt("USER_ID"));
		manuscript.setJournalId(rs.getInt("JOURNAL_ID"));
		manuscript.setDivisionId(rs.getInt("DIVISION_ID"));
		manuscript.setSpecialIssueId(rs.getInt("SPECIAL_ISSUE_ID"));
		manuscript.setSubmitStep(rs.getInt("SUBMIT_STEP"));
		manuscript.setTitle(rs.getString("TITLE"));
		manuscript.setRunningHead(rs.getString("RUNNINGHEAD"));
		manuscript.setPaperAbstract(rs.getString("PAPER_ABSTRACT"));
		manuscript.setChiefEditorUserId(rs.getInt("CHIEF_USER_ID"));
		manuscript.setAssociateEditorUserId(rs.getInt("AE_USER_ID"));
		manuscript.setGuestEditorUserId(rs.getInt("GE_USER_ID"));
		manuscript.setManagerUserId(rs.getInt("MANAGER_USER_ID"));
		manuscript.setInvite(rs.getBoolean("INVITE"));
		manuscript.setConfirm1(rs.getBoolean("CONFIRM1"));
		manuscript.setConfirm2(rs.getBoolean("CONFIRM2"));
		manuscript.setConfirm3(rs.getBoolean("CONFIRM3"));
		manuscript.setConfirm4(rs.getBoolean("CONFIRM4"));
		manuscript.setConfirm5(rs.getBoolean("CONFIRM5"));
		manuscript.setEditorStatus(rs.getString("EDITOR_STATUS"));
		manuscript.setCameraReadyRevision(rs.getInt("CAMERA_READY_REVISION"));
		manuscript.setGalleryProofRevision(rs.getInt("GALLERY_PROOF_REVISION"));
		manuscript.setCameraReadyConfirm(rs.getBoolean("CAMERA_READY_CONFIRM"));
		manuscript.setGalleryProofConfirm(rs.getBoolean("GALLERY_PROOF_CONFIRM"));
		manuscript.setManuscriptTypeId(rs.getInt("TYPE_ID"));
		manuscript.setManuscriptTrackId(rs.getInt("TRACK_ID"));
		manuscript.setAeAssignDate(rs.getDate("AE_ASSIGN_DATE"));
		manuscript.setAeAssignTime(rs.getTime("AE_ASSIGN_TIME"));
		manuscript.setRevisionDueDate(rs.getDate("REVISION_DUE_DATE"));
		manuscript.setRevisionDueTime(rs.getTime("REVISION_DUE_TIME"));
		manuscript.setCameraDueDate(rs.getDate("CAMERA_DUE_DATE"));
		manuscript.setCameraDueTime(rs.getTime("CAMERA_DUE_TIME"));
		manuscript.setDueDateExtendRequest(rs.getBoolean("DUE_DATE_EXTEND_REQUEST"));
		
		return manuscript;
	}
}
