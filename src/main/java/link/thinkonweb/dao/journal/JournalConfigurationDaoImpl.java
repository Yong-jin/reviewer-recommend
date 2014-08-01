package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalConfiguration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class JournalConfigurationDaoImpl extends NamedParameterJdbcDaoSupport implements JournalConfigurationDao {
	@Autowired
	private JournalConfigurationRowMapper jcRowMapper;
	@Override
	public int insert(JournalConfiguration journalConfiguration) {
		String sql = "INSERT INTO JOURNAL_CONFIGURATION (JOURNAL_ID, REVIEW_COMPLETE_COUNT, REVIEW_DUE_DURATION, "
				+ "ASSIGN_REMIND_DURATION, ASSIGN_CANCEL_DURATION, INVITE_REMIND_DURATION, INVITE_CANCEL_DURATION, "
				+ "RESUBMIT_DURATION, CAMERA_SUBMIT_DURATION, GENTLE_REMIND_REVIEWER, GENTLE_REMIND_RESUBMIT, "
				+ "GENTLE_REMIND_CAMERA_SUBMIT, REMIND_REVIEWER, REMIND_RESUBMIT, REMIND_CAMERA_SUBMIT, CAMERA_TEMPLATE_URL, COPYRIGHT_URL, NUM_CONFIRMS, CONFIRM1,"
				+ "CONFIRM2, CONFIRM3, CONFIRM4, CONFIRM5, FRONT_COVER_URL, CHECKLIST_URL, TEXT_BASIC_INFO, TEXT_COAUTHOR, TEXT_COVERLETTER, TEXT_RP, TEXT_FILES,"
				+ "NUM_REVIEW_ITEMS, REVIEW_ITEM_ID1, REVIEW_ITEM_ID2, REVIEW_ITEM_ID3, REVIEW_ITEM_ID4, REVIEW_ITEM_ID5, REVIEW_ITEM_ID6, REVIEW_ITEM_ID7, REVIEW_ITEM_ID8, REVIEW_ITEM_ID9, REVIEW_ITEM_ID10, CHANGE_AUTHOR, CHANGE_KEYWORD, SETUP_STEP, "
				+ "CHANGE_RP, CHANGE_INVITED, CHANGE_DIVISION, CHANGE_ADDITIONAL_FILES, REVIEWER_VIEW_AUTHOR, REQUIRED_RUNNINGHEAD, REQUIRED_KEYWORD, REQUIRED_COVERLETTER, REQUIRED_RP, REQUIRED_ADDITIONAL_FILES, MANAGE_DIVISION) " +
				 "VALUES (:journalId, :reviewCompleteCount, :reviewDueDuration, :assignRemindDuration, :assignCancelDuration, :inviteRemindDuration, "
				 + ":inviteCancelDuration, :resubmitDuration, :cameraSubmitDuration, :gentleRemindReviewer, :gentleRemindResubmit, "
				 + ":gentleRemindCameraSubmit, :remindReviewer, :remindResubmit, :remindCameraSubmit, :cameraReadyTemplateUrl, :copyrightFormUrl, :numberOfConfirms, :confirm1,"
				 + ":confirm2, :confirm3, :confirm4, :confirm5, :frontCoverUrl, :checkListUrl, :textBasicInfo, :textCoAuthor, :textCoverLetter, :textRp, :textFiles,"
				 + ":numberOfReviewItems, :reviewItemId1,  :reviewItemId2, :reviewItemId3, :reviewItemId4, :reviewItemId5, :reviewItemId6, :reviewItemId7, :reviewItemId8, :reviewItemId9, :reviewItemId10,"
				 + ":changeAuthor, :changeKeyword, :setupStep, :changeRp, :changeInvited, :changeDivision, :changeAdditionalFiles, :reviewerViewAuthor, "
				 + ":requiredRunninghead, :requiredKeyword, :requiredCoverletter, :requiredRp, :requiredAdditionalFiles, :manageDivision)";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(journalConfiguration);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public JournalConfiguration findById(int id) {
		try {
			String sql = "SELECT * FROM JOURNAL_CONFIGURATION WHERE ID = ?";
			JournalConfiguration jc = this.getJdbcTemplate().queryForObject(sql, new Object[]{id}, jcRowMapper);	
			return jc;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public JournalConfiguration findByJournalId(int journalId) {
		try {
			String sql = "SELECT * FROM JOURNAL_CONFIGURATION WHERE JOURNAL_ID = ?";
			JournalConfiguration jc = this.getJdbcTemplate().queryForObject(sql, new Object[]{journalId}, jcRowMapper);	
			return jc;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(JournalConfiguration jc) {
		String sql = "UPDATE JOURNAL_CONFIGURATION SET JOURNAL_ID = ?, REVIEW_COMPLETE_COUNT =?, REVIEW_DUE_DURATION =?, "
				+ "ASSIGN_REMIND_DURATION =?, ASSIGN_CANCEL_DURATION =?, INVITE_REMIND_DURATION =?, "
				+ "INVITE_CANCEL_DURATION =?, RESUBMIT_DURATION =?, CAMERA_SUBMIT_DURATION =?, "
				+ "GENTLE_REMIND_REVIEWER =?, GENTLE_REMIND_RESUBMIT =?, GENTLE_REMIND_CAMERA_SUBMIT =?, "
				+ "REMIND_REVIEWER =?, REMIND_RESUBMIT =?, REMIND_CAMERA_SUBMIT =?, CAMERA_TEMPLATE_URL = ?, COPYRIGHT_URL = ?, NUM_CONFIRMS = ?, CONFIRM1 = ?, "
				+ " CONFIRM2 = ?, CONFIRM3 = ?, CONFIRM4 = ?, CONFIRM5 = ?, FRONT_COVER_URL = ?, CHECKLIST_URL = ?, "
				+ "TEXT_BASIC_INFO = ?, TEXT_COAUTHOR = ?, TEXT_COVERLETTER = ?, TEXT_RP = ?, TEXT_FILES = ?,"
				+ "NUM_REVIEW_ITEMS = ?, REVIEW_ITEM_ID1 = ?, REVIEW_ITEM_ID2 = ?, REVIEW_ITEM_ID3 = ?, REVIEW_ITEM_ID4 = ?, REVIEW_ITEM_ID5 = ?, REVIEW_ITEM_ID6 = ?, "
				+ "REVIEW_ITEM_ID7 = ?, REVIEW_ITEM_ID8 = ?, REVIEW_ITEM_ID9 = ?, REVIEW_ITEM_ID10 = ?, CHANGE_AUTHOR = ?, CHANGE_KEYWORD = ?, SETUP_STEP = ?,"
				+ "CHANGE_RP = ?, CHANGE_ADDITIONAL_FILES = ?, CHANGE_INVITED = ?, CHANGE_DIVISION = ?, REVIEWER_VIEW_AUTHOR = ?, REQUIRED_RUNNINGHEAD = ?, "
				+ "REQUIRED_KEYWORD = ?, REQUIRED_COVERLETTER = ?, REQUIRED_RP = ?, REQUIRED_ADDITIONAL_FILES = ?, MANAGE_DIVISION = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {jc.getJournalId(), jc.getReviewCompleteCount(), jc.getReviewDueDuration(), 
				jc.getAssignRemindDuration(), jc.getAssignCancelDuration(), jc.getInviteRemindDuration(), 
				jc.getInviteCancelDuration(), jc.getResubmitDuration(), jc.getCameraSubmitDuration(), jc.getGentleRemindReviewer(),
				jc.getGentleRemindResubmit(), jc.getGentleRemindCameraSubmit(), jc.getRemindReviewer(), jc.getRemindResubmit(),
				jc.getRemindCameraSubmit(), jc.getCameraReadyTemplateUrl(), jc.getCopyrightFormUrl(), jc.getNumberOfConfirms(), jc.getConfirm1(), 
				jc.getConfirm2(), jc.getConfirm3(), jc.getConfirm4(), jc.getConfirm5(), jc.getFrontCoverUrl(), jc.getCheckListUrl(), 
				jc.getTextBasicInfo(), jc.getTextCoAuthor(), jc.getTextCoverLetter(), jc.getTextRp(), jc.getTextFiles(),
				jc.getNumberOfReviewItems(), jc.getReviewItemId1(), jc.getReviewItemId2(), jc.getReviewItemId3(), jc.getReviewItemId4(), jc.getReviewItemId5(), 
				jc.getReviewItemId6(), jc.getReviewItemId7(), jc.getReviewItemId8(), jc.getReviewItemId9(), jc.getReviewItemId10(), jc.isChangeAuthor(), jc.isChangeKeyword(),
				jc.getSetupStep(), jc.isChangeRp(), jc.isChangeAdditionalFiles(), jc.isChangeInvited(), jc.isChangeDivision(), jc.isReviewerViewAuthor(), 
				jc.isRequiredRunninghead(), jc.isRequiredKeyword(), jc.isRequiredCoverletter(), jc.isRequiredRp(), jc.isRequiredAdditionalFiles(), jc.isManageDivision(), jc.getId()});
	}

	@Override
	public List<JournalConfiguration> findAll() {
		try {
			String sql = "SELECT * FROM JOURNAL_CONFIGURATION";
			List<JournalConfiguration> jcs = this.getJdbcTemplate().query(sql, jcRowMapper);	
			return jcs;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
