package link.thinkonweb.service.manuscript;

import java.util.List;
import java.util.Map;

import link.thinkonweb.dao.manuscript.ReviewPreferenceDao;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ReviewPreference;
import link.thinkonweb.domain.user.SystemUser;


public interface ReviewPreferenceService {
	public List<ReviewPreference> getReviewPreferences(int manuscriptId, int revisionCount);
	public int numReviewPreferences(int manuscriptId, int revisionCount);
	public void deleteReviewPreference(int rpId);
	public void editReviewPreference(int rpId, ReviewPreference rp);
	public List<SystemUser> getReviewerCandidateContacts(int manuscriptId, int journalId, List<String> acceptEmailList, Map<String, String> paramValues);
	public void createReviewPreference(ReviewPreference rp);
	public void setReviewPreferenceDao(ReviewPreferenceDao reviewPreferenceDao);
	public void selectReviewPreference(int userId, Manuscript manuscript);
	public void copyReviewPreferenceRevisions(Manuscript manuscript, int toRevision);
	public void updateReviewPreferenceRevisions(Manuscript manuscript, int revisionCount);
}
