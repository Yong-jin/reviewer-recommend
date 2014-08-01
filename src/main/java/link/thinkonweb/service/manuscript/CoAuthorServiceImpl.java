package link.thinkonweb.service.manuscript;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.user.AuthorityDao;
import link.thinkonweb.dao.user.ContactDao;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;

public class CoAuthorServiceImpl implements CoAuthorService {
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private UserService userService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CountryCodeDao countryCodeDao;

	@Override
	public void createCoAuthor(SystemUser user, Manuscript manuscript, boolean corresponding, boolean createdMember, String temporaryPassword) {
		int manuscriptId = manuscript.getId();
		int revisionCount = manuscript.getRevisionCount();
		userService.createWithoutLogin(user);

		SystemUser storedUser = userService.getByUsername(user.getUsername());
		CoAuthor coAuthor = new CoAuthor();
		coAuthor.setUserId(storedUser.getId());
		coAuthor.setManuscriptId(manuscriptId);
		coAuthor.setCorresponding(corresponding);
		coAuthor.setAuthorOrder(coAuthorDao.findCoAuthors(manuscriptId, revisionCount, 0, false).size() + 1);
		coAuthor.setRevisionCount(revisionCount);
		coAuthor.setCreatedMember(createdMember);
		coAuthor.setTemporaryPassword(temporaryPassword);

		CoAuthor corresAuthor = this.getCoAuthor(manuscriptId, 0, revisionCount, 0, true);
		if (coAuthor.isCorresponding()) {
			corresAuthor.setCorresponding(false);
			coAuthorDao.update(corresAuthor);
		}
		
		coAuthorDao.insert(coAuthor);
	}
	
	
	@Override
	public void setCoAuthorOrder(Manuscript manuscript, int userId, int authorOrder) {
		int manuscriptId = manuscript.getId();
		CoAuthor coAuthor = coAuthorDao.findCoAuthor(manuscriptId, userId, manuscript.getRevisionCount(), 0, false);
		coAuthor.setAuthorOrder(authorOrder);
		coAuthorDao.update(coAuthor);
	}
	
	@Override
	public void setCorrespondingAuthor(Manuscript manuscript, int userId, boolean corresponding) {
		int manuscriptId = manuscript.getId();
		CoAuthor coAuthor = coAuthorDao.findCoAuthor(manuscriptId, userId, manuscript.getRevisionCount(), 0, false);
		coAuthor.setCorresponding(corresponding);
		CoAuthor corresAuthor = this.getCoAuthor(manuscriptId, 0, manuscript.getRevisionCount(), 0, true);
		if (coAuthor.isCorresponding()) {
			corresAuthor.setCorresponding(false);
			coAuthorDao.update(corresAuthor);
		}
		coAuthorDao.update(coAuthor);
		
	}
	
	@Override
	public CoAuthor getCoAuthor(int manuscriptId, int userId, int revisionCount, int authorOrder, boolean corresponding) {
		CoAuthor correspondingAuthor = coAuthorDao.findCoAuthor(manuscriptId, userId, revisionCount, authorOrder, corresponding);
		SystemUser user = userService.getById(correspondingAuthor.getUserId());
		correspondingAuthor.setUser(user);
		return correspondingAuthor;
	}

	@Override
	public List<CoAuthor> getCoAuthors(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding) {
		List<CoAuthor> coAuthors = coAuthorDao.findCoAuthors(manuscriptId, revisionCount, authorOrder, corresponding);
		for(CoAuthor c: coAuthors) {
			SystemUser user = userService.getById(c.getUserId());
			c.setUser(user);
		}
		Collections.sort(coAuthors);
		return coAuthors;
	}
	
	@Override
	public List<Integer> getCoAuthorIds(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding) {
		List<Integer> coAuthorIds = coAuthorDao.findCoAuthorIds(manuscriptId, revisionCount, authorOrder, corresponding);
		return coAuthorIds;
	}
	
	@Override
	public List<SystemUser> getCoAuthorCandidateUsers(Manuscript manuscript, int journalId, List<String> acceptEmailList, Map<String, String> contactParams) {
		List<CoAuthor> currentCoAuthors = coAuthorDao.findCoAuthors(manuscript.getId(), manuscript.getRevisionCount(), 0, false);
		List<String> preventEmailList = new ArrayList<String>();

		for(CoAuthor coAuthor: currentCoAuthors) {
			SystemUser user = userService.getById(coAuthor.getUserId());
			String email = user.getUsername();
			preventEmailList.add(email);
		}
		
		return userDao.findUsersByParams(acceptEmailList, preventEmailList, contactParams, null);
	}
	
	
	@Override
	public void selectCoAuthor(int userId, Manuscript manuscript) {
		CoAuthor newCoAuthor = new CoAuthor();
		newCoAuthor.setUserId(userId);
		newCoAuthor.setManuscriptId(manuscript.getId());
		newCoAuthor.setAuthorOrder(coAuthorDao.findCoAuthors(manuscript.getId(), manuscript.getRevisionCount(), 0, false).size() + 1);
		newCoAuthor.setRevisionCount(manuscript.getRevisionCount());
		coAuthorDao.insert(newCoAuthor);
	}
	
	@Override
	public void deleteCoAuthor(int userId, Manuscript manuscript) {	
		int manuscriptId = manuscript.getId();
		int revisionCount = manuscript.getRevisionCount();

		CoAuthor targetCoAuthor = coAuthorDao.findCoAuthor(manuscriptId, userId, revisionCount, 0, false);
		int targetCoAuthorOrder = targetCoAuthor.getAuthorOrder();
		int manuscriptCoAuthorCount = coAuthorDao.findCoAuthors(manuscriptId, revisionCount, 0, false).size();
		
		for (int i=targetCoAuthorOrder; i<=manuscriptCoAuthorCount; i++) {
			CoAuthor changeOrderCoAuthor = coAuthorDao.findCoAuthor(manuscriptId, 0, revisionCount, i, false);
			if(changeOrderCoAuthor.getAuthorOrder() != targetCoAuthorOrder) {
				changeOrderCoAuthor.setAuthorOrder(changeOrderCoAuthor.getAuthorOrder()-1);
				coAuthorDao.update(changeOrderCoAuthor);
			}
		}
		if(targetCoAuthor.isCorresponding()) {
			CoAuthor corresCandidate = coAuthorDao.findCoAuthor(manuscriptId, 0, revisionCount, 1, false);
			corresCandidate.setCorresponding(true);
			coAuthorDao.update(corresCandidate);
		}
		
		coAuthorDao.delete(targetCoAuthor);
	}
	
	@Override
	public boolean isOneOfAuthor(int userId, int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		if(manuscript.getUserId() == userId)
			return true;
		else {
			List<CoAuthor> coAuthors = coAuthorDao.findCoAuthors(manuscriptId, manuscript.getRevisionCount(), 0, false);
			if(coAuthors == null)
				return false;
			else
				for(CoAuthor coAuthor: coAuthors)
					if(coAuthor.getUserId() == userId)
						return true;
		}
		return false;
	}
	
	@Override
	public String getCoAuthorNames(int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		Journal journal = journalService.getById(manuscript.getJournalId());
		List<CoAuthor> coAuthors = manuscript.getCoAuthors();
		StringBuffer coAuthorsAllName = new StringBuffer();
		
		CoAuthor coAuthor = null;
		Contact c = null;
		String coAuthorName = null;
		for (int i=0; i < coAuthors.size(); i++) {
			coAuthor = coAuthors.get(i);
			int userId = coAuthor.getUserId();
			c = contactService.getByUserId(userId);
			coAuthorName = contactService.getFullName(c, journal.getLanguageCode());
			coAuthorsAllName.append(coAuthorName);
			
			if (i < coAuthors.size() - 1)
				coAuthorsAllName.append(", ");
		}
		return coAuthorsAllName.toString();
	}


	@Override
	public List<CoAuthor> getCoAuthorAll(int manuscriptId) {
		List<CoAuthor> coAuthorAll = coAuthorDao.findAll(manuscriptId);
		for(CoAuthor c: coAuthorAll) {
			SystemUser user = userService.getById(c.getUserId());
			c.setUser(user);
		}
		Collections.sort(coAuthorAll);
		return coAuthorAll;
	}


	@Override
	public void copyCoAuthorRevisions(Manuscript manuscript, int toRevision) {
		int manuscriptId = manuscript.getId();
		int fromRevision = manuscript.getRevisionCount();
		List<CoAuthor> fromCoAuthors = coAuthorDao.findCoAuthors(manuscriptId, fromRevision, 0, false);
		for(CoAuthor coAuthor: fromCoAuthors) {
			coAuthor.setRevisionCount(toRevision);
			CoAuthor testCoAuthor = coAuthorDao.findCoAuthor(manuscriptId, coAuthor.getUserId(), coAuthor.getRevisionCount(), coAuthor.getAuthorOrder(), coAuthor.isCorresponding());
			if(testCoAuthor == null)
				coAuthorDao.insert(coAuthor);
			else
				coAuthorDao.update(coAuthor);
		}
	}


	@Override
	public void updateCoAuthorRevisions(Manuscript manuscript, int toRevision) {
		int manuscriptId = manuscript.getId();
		List<CoAuthor> coAuthors = coAuthorDao.findCoAuthors(manuscriptId, manuscript.getRevisionCount(), 0, false);
		for(CoAuthor coAuthor: coAuthors) {
			coAuthor.setRevisionCount(toRevision);
			coAuthorDao.update(coAuthor);
		}
	}
}
