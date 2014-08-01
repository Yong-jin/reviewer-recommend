package link.thinkonweb.service.journal;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.JournalConfigurationDao;
import link.thinkonweb.domain.journal.JournalConfiguration;

public class JournalConfigurationServiceImpl implements JournalConfigurationService {
	@Autowired
	private JournalConfigurationDao jcDao;

	@Override
	public JournalConfiguration create(int journalId) {
		JournalConfiguration jc = new JournalConfiguration();
		jc.setJournalId(journalId);
		jc.setSetupStep(-1);
		jc.setAssignCancelDuration(SystemConstants.ASSIGN_CANCEL_DURATION);
		jc.setAssignRemindDuration(SystemConstants.ASSIGN_REMIND_DURATION);
		jc.setCameraSubmitDuration(SystemConstants.CAMERA_SUBMIT_DURATION);
		jc.setGentleRemindCameraSubmit(SystemConstants.GENTLE_REMIND_CAMERA_SUBMIT);
		jc.setGentleRemindResubmit(SystemConstants.GENTLE_REMIND_RESUBMIT);
		jc.setGentleRemindReviewer(SystemConstants.GENTLE_REMIND_REVIEWER);
		jc.setInviteCancelDuration(SystemConstants.INVITE_CANCEL_DURATION);
		jc.setInviteRemindDuration(SystemConstants.INVITE_REMIND_DURATION);
		jc.setRemindCameraSubmit(SystemConstants.REMIND_CAMERA_SUBMIT);
		jc.setRemindResubmit(SystemConstants.REMIND_RESUBMIT);
		jc.setRemindReviewer(SystemConstants.REMIND_REVIEWER);
		jc.setResubmitDuration(SystemConstants.RESUBMIT_DURATION);
		jc.setReviewCompleteCount(SystemConstants.REVIEW_COMPLETE_COUNT);
		jc.setReviewDueDuration(SystemConstants.REVIEW_DUE_DURATION);
		jc.setNumberOfConfirms(0);
		jc.setNumberOfReviewItems(0);
		
		
		int id = jcDao.insert(jc);
		JournalConfiguration storedJc = jcDao.findById(id);
		return storedJc;
	}

	@Override
	public JournalConfiguration getById(int id) {
		return jcDao.findById(id);
	}

	@Override
	public JournalConfiguration getByJournalId(int journalId) {
		return jcDao.findByJournalId(journalId);
	}

	@Override
	public void update(JournalConfiguration journalConfiguration) {
		jcDao.update(journalConfiguration);
	}

	@Override
	public List<JournalConfiguration> getAll() {
		return jcDao.findAll();
	}
}
