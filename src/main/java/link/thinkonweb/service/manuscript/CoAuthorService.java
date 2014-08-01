package link.thinkonweb.service.manuscript;

import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.user.SystemUser;


public interface CoAuthorService {
	public void createCoAuthor(SystemUser user, Manuscript manuscript, boolean corresponding, boolean createdMember, String temporaryPassword);
	public void selectCoAuthor(int userId, Manuscript manuscript);
	public void deleteCoAuthor(int userId, Manuscript manuscript);
	public void setCoAuthorOrder(Manuscript manuscript, int userId, int authorOrder);
	public void setCorrespondingAuthor(Manuscript manuscript, int userId, boolean corresponding);
	public void copyCoAuthorRevisions(Manuscript manuscript, int toRevision);
	public void updateCoAuthorRevisions(Manuscript manuscript, int toRevision);
	public boolean isOneOfAuthor(int userId, int manuscriptId);
	public String getCoAuthorNames(int manuscriptId);
	public CoAuthor getCoAuthor(int manuscriptId, int userId, int revisionCount, int authorOrder, boolean corresponding);
	public List<CoAuthor> getCoAuthors(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding);
	public List<Integer> getCoAuthorIds(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding);
	public List<CoAuthor> getCoAuthorAll(int manuscriptId);
	public List<SystemUser> getCoAuthorCandidateUsers(Manuscript manuscript, int journalId, List<String> acceptEmailList, Map<String, String> contactParams);
}
