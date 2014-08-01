package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import link.thinkonweb.domain.journal.JournalConfiguration;

public class JournalConfigurationRowMapper implements RowMapper<JournalConfiguration>{
	@Override
	public JournalConfiguration mapRow(ResultSet rs, int rowNum) throws SQLException {
		JournalConfiguration jc = new JournalConfiguration();
		jc.setId(rs.getInt("ID"));
		jc.setJournalId(rs.getInt("JOURNAL_ID"));
		jc.setSetupStep(rs.getInt("SETUP_STEP"));
		jc.setAssignCancelDuration(rs.getInt("ASSIGN_CANCEL_DURATION"));
		jc.setAssignRemindDuration(rs.getInt("ASSIGN_REMIND_DURATION"));
		jc.setCameraSubmitDuration(rs.getInt("CAMERA_SUBMIT_DURATION"));
		jc.setGentleRemindCameraSubmit(rs.getInt("GENTLE_REMIND_CAMERA_SUBMIT"));
		jc.setGentleRemindResubmit(rs.getInt("GENTLE_REMIND_RESUBMIT"));
		jc.setGentleRemindReviewer(rs.getInt("GENTLE_REMIND_REVIEWER"));
		jc.setInviteCancelDuration(rs.getInt("INVITE_CANCEL_DURATION"));
		jc.setInviteRemindDuration(rs.getInt("INVITE_REMIND_DURATION"));
		jc.setRemindCameraSubmit(rs.getInt("REMIND_CAMERA_SUBMIT"));
		jc.setRemindResubmit(rs.getInt("REMIND_RESUBMIT"));
		jc.setRemindReviewer(rs.getInt("REMIND_REVIEWER"));
		jc.setResubmitDuration(rs.getInt("RESUBMIT_DURATION"));
		jc.setReviewCompleteCount(rs.getInt("REVIEW_COMPLETE_COUNT"));
		jc.setReviewDueDuration(rs.getInt("REVIEW_DUE_DURATION"));
		jc.setCameraReadyTemplateUrl(rs.getString("CAMERA_TEMPLATE_URL"));
		jc.setCopyrightFormUrl(rs.getString("COPYRIGHT_URL"));
		jc.setNumberOfConfirms(rs.getInt("NUM_CONFIRMS"));
		jc.setConfirm1(rs.getString("CONFIRM1"));
		jc.setConfirm2(rs.getString("CONFIRM2"));
		jc.setConfirm3(rs.getString("CONFIRM3"));
		jc.setConfirm4(rs.getString("CONFIRM4"));
		jc.setConfirm5(rs.getString("CONFIRM5"));
		jc.setFrontCoverUrl(rs.getString("FRONT_COVER_URL"));
		jc.setCheckListUrl(rs.getString("CHECKLIST_URL"));
		jc.setTextBasicInfo(rs.getString("TEXT_BASIC_INFO"));
		jc.setTextCoAuthor(rs.getString("TEXT_COAUTHOR"));
		jc.setTextCoverLetter(rs.getString("TEXT_COVERLETTER"));
		jc.setTextRp(rs.getString("TEXT_RP"));
		jc.setTextFiles(rs.getString("TEXT_FILES"));
		jc.setNumberOfReviewItems(rs.getInt("NUM_REVIEW_ITEMS"));
		jc.setReviewItemId1(rs.getInt("REVIEW_ITEM_ID1"));
		jc.setReviewItemId2(rs.getInt("REVIEW_ITEM_ID2"));
		jc.setReviewItemId3(rs.getInt("REVIEW_ITEM_ID3"));
		jc.setReviewItemId4(rs.getInt("REVIEW_ITEM_ID4"));
		jc.setReviewItemId5(rs.getInt("REVIEW_ITEM_ID5"));
		jc.setReviewItemId6(rs.getInt("REVIEW_ITEM_ID6"));
		jc.setReviewItemId7(rs.getInt("REVIEW_ITEM_ID7"));
		jc.setReviewItemId8(rs.getInt("REVIEW_ITEM_ID8"));
		jc.setReviewItemId9(rs.getInt("REVIEW_ITEM_ID9"));
		jc.setReviewItemId10(rs.getInt("REVIEW_ITEM_ID10"));
		jc.setChangeAuthor(rs.getBoolean("CHANGE_AUTHOR"));
		jc.setChangeKeyword(rs.getBoolean("CHANGE_KEYWORD"));
		jc.setChangeAdditionalFiles(rs.getBoolean("CHANGE_ADDITIONAL_FILES"));
		jc.setChangeDivision(rs.getBoolean("CHANGE_DIVISION"));
		jc.setChangeInvited(rs.getBoolean("CHANGE_INVITED"));
		jc.setChangeRp(rs.getBoolean("CHANGE_RP"));
		jc.setReviewerViewAuthor(rs.getBoolean("REVIEWER_VIEW_AUTHOR"));
		jc.setRequiredCoverletter(rs.getBoolean("REQUIRED_COVERLETTER"));
		jc.setRequiredKeyword(rs.getBoolean("REQUIRED_KEYWORD"));
		jc.setRequiredRp(rs.getBoolean("REQUIRED_RP"));
		jc.setRequiredRunninghead(rs.getBoolean("REQUIRED_RUNNINGHEAD"));
		jc.setManageDivision(rs.getBoolean("MANAGE_DIVISION"));
		jc.setReviewerViewAuthor(rs.getBoolean("REVIEWER_VIEW_AUTHOR"));
		jc.setRequiredAdditionalFiles(rs.getBoolean("REQUIRED_ADDITIONAL_FILES"));
		return jc;
	}
}
