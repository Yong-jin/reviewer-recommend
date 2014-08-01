package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.Manuscript;

import org.springframework.jdbc.core.RowMapper;

public class ManuscriptEventDateTimeRowMapper implements RowMapper<Manuscript> {
	
	@Override
	public Manuscript mapRow(ResultSet rs, int rowNum) throws SQLException {
		Manuscript manuscript = new Manuscript();
		manuscript.setId(rs.getInt("M.ID"));
		manuscript.setStatus(rs.getString("M.STATUS"));
		manuscript.setRevisionCount(rs.getInt("M.REVISION_COUNT"));
		manuscript.setCoverLetter(rs.getString("M.COVERLETTER"));
		manuscript.setSubmitId(rs.getString("M.SUBMIT_ID"));
		manuscript.setUserId(rs.getInt("M.USER_ID"));
		manuscript.setJournalId(rs.getInt("M.JOURNAL_ID"));
		manuscript.setDivisionId(rs.getInt("M.DIVISION_ID"));
		manuscript.setSpecialIssueId(rs.getInt("M.SPECIAL_ISSUE_ID"));
		manuscript.setSubmitStep(rs.getInt("M.SUBMIT_STEP"));
		manuscript.setTitle(rs.getString("M.TITLE"));
		manuscript.setRunningHead(rs.getString("M.RUNNINGHEAD"));
		manuscript.setPaperAbstract(rs.getString("M.ABSTRACT"));
		manuscript.setChiefEditorUserId(rs.getInt("M.CHIEF_USER_ID"));
		manuscript.setAssociateEditorUserId(rs.getInt("M.AE_USER_ID"));
		manuscript.setGuestEditorUserId(rs.getInt("M.GE_USER_ID"));
		manuscript.setManagerUserId(rs.getInt("M.MANAGER_USER_ID"));
		manuscript.setInvite(rs.getBoolean("M.INVITE"));
		manuscript.setConfirm1(rs.getBoolean("M.CONFIRM1"));
		manuscript.setConfirm2(rs.getBoolean("M.CONFIRM2"));
		manuscript.setConfirm3(rs.getBoolean("M.CONFIRM3"));
		manuscript.setConfirm4(rs.getBoolean("M.CONFIRM4"));
		manuscript.setConfirm5(rs.getBoolean("M.CONFIRM5"));
		manuscript.setEditorStatus(rs.getString("M.EDITOR_STATUS"));
		manuscript.setCameraReadyRevision(rs.getInt("M.CAMERA_READY_REVISION"));
		manuscript.setGalleryProofRevision(rs.getInt("M.GALLERY_PROOF_REVISION"));
		manuscript.setCameraReadyConfirm(rs.getBoolean("M.CAMERA_READY_CONFIRM"));
		manuscript.setGalleryProofConfirm(rs.getBoolean("M.GALLERY_PROOF_CONFIRM"));
		manuscript.setManuscriptTypeId(rs.getInt("M.TYPE_ID"));
		manuscript.setManuscriptTrackId(rs.getInt("M.TRACK_ID"));
		manuscript.setAeAssignDate(rs.getDate("M.AE_ASSIGN_DATE"));
		manuscript.setAeAssignTime(rs.getTime("M.AE_ASSIGN_TIME"));
		manuscript.setRevisionDueDate(rs.getDate("M.REVISION_DUE_DATE"));
		manuscript.setRevisionDueTime(rs.getTime("M.REVISION_DUE_TIME"));
		manuscript.setCameraDueDate(rs.getDate("M.CAMERA_DUE_DATE"));
		manuscript.setCameraDueTime(rs.getTime("M.CAMERA_DUE_TIME"));
		manuscript.setDueDateExtendRequest(rs.getBoolean("M.DUE_DATE_EXTEND_REQUEST"));
		return manuscript;
	}
}
