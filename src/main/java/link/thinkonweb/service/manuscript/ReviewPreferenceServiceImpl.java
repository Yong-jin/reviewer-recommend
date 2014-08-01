package link.thinkonweb.service.manuscript;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.ReviewPreferenceDao;
import link.thinkonweb.dao.user.ContactDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ReviewPreference;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;


public class ReviewPreferenceServiceImpl implements ReviewPreferenceService {
	@Autowired
	private ReviewPreferenceDao reviewPreferenceDao;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private UserService userService;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ManuscriptService manuscriptService;
	
	@Override
	public void setReviewPreferenceDao(ReviewPreferenceDao reviewPreferenceDao) {
		this.reviewPreferenceDao = reviewPreferenceDao;
	}
	
	@Override 
	public void createReviewPreference(ReviewPreference rp) {
		reviewPreferenceDao.insert(rp);
	}
	
	@Override
	public List<ReviewPreference> getReviewPreferences(int manuscriptId, int revisionCount) {		
		return reviewPreferenceDao.findReviewPreferences(manuscriptId, revisionCount);
	}
	@Override
	public void deleteReviewPreference(int rpID) {
		reviewPreferenceDao.delete(rpID);
	}
	@Override
	public void editReviewPreference(int rpID, ReviewPreference rp) {
		rp.setId(rpID);
		reviewPreferenceDao.update(rp);
	}

	@Override
	public List<SystemUser> getReviewerCandidateContacts(int manuscriptId, int journalId, List<String> acceptEmailList, Map<String, String> contactParams) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<CoAuthor> currentCoAuthors = coAuthorDao.findAll(manuscriptId);
		List<ReviewPreference> currentRps = reviewPreferenceDao.findReviewPreferences(manuscriptId, manuscript.getRevisionCount());
		List<String> preventEmailList = new ArrayList<String>();
		for(CoAuthor coAuthor: currentCoAuthors) {
			SystemUser user = userService.getById(coAuthor.getUserId());
			String email = user.getUsername();
			preventEmailList.add(email);
		}
		
		for(ReviewPreference rp: currentRps) {
			String email = rp.getEmail();
			preventEmailList.add(email);
		}
		return userDao.findUsersByParams(acceptEmailList, preventEmailList, contactParams, null);
	}

	@Override
	public void selectReviewPreference(int userId, Manuscript manuscript) {
		SystemUser user = userService.getById(userId);
		Contact contact = user.getContact();
		ReviewPreference rp = new ReviewPreference();
		rp.setEmail(user.getUsername());
		rp.setFirstName(contact.getFirstName());
		rp.setLastName(contact.getLastName());
		rp.setInstitution(contact.getInstitution());
		rp.setUserId(user.getId());
		rp.setCountryCode(contact.getCountry());
		rp.setDegree(contact.getDegree());
		rp.setSalutation(contact.getSalutation());
		rp.setManuscriptId(manuscript.getId());
		rp.setRevisionCount(manuscript.getRevisionCount());
		reviewPreferenceDao.insert(rp);
	}

	@Override
	public void updateReviewPreferenceRevisions(Manuscript manuscript, int revisionCount) {
		List<ReviewPreference> rpList = reviewPreferenceDao.findReviewPreferences(manuscript.getId(), manuscript.getRevisionCount());
		for(ReviewPreference rp: rpList) {
			rp.setRevisionCount(revisionCount);
			reviewPreferenceDao.update(rp);
		}
		
	}
	
	@Override
	public void copyReviewPreferenceRevisions(Manuscript manuscript, int toRevision) {
		List<ReviewPreference> rpList = reviewPreferenceDao.findReviewPreferences(manuscript.getId(), manuscript.getRevisionCount());
		for(ReviewPreference rp: rpList) {
			rp.setRevisionCount(toRevision);
			ReviewPreference testRp = reviewPreferenceDao.findReviewPreference(rp.getManuscriptId(), toRevision, rp.getEmail());
			if(testRp == null)
				reviewPreferenceDao.insert(rp);
			else
				reviewPreferenceDao.update(rp);
		}
	}

	@Override
	public int numReviewPreferences(int manuscriptId, int revisionCount) {
		return reviewPreferenceDao.numReviewPreferences(manuscriptId, revisionCount);
	}
}
