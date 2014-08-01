package link.thinkonweb.service.roles;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.user.SystemUser;


public interface ManagerService {
	public void update(Manager manager);
	public void createManager(Manager manager);
	public void selectManager(int userId, int journalId);
	public void deleteManager(int userId, int journalId);
	public List<Manager> getManagersByJournalId(int journalId);
	public List<SystemUser> getManagerUsersByJournalId(int journalId);
	public void confirmManuscript(Manuscript manuscript, SystemUser manager, Journal journal, int editorUserId, HttpServletRequest request, Locale locale);
	public void returnBackManuscript(Manuscript m, Journal journal, EmailMessage emailMessage, String comments, HttpServletRequest request, Locale locale);
	public void returnBackCameraReady(Comment comment, SystemUser managerUser, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale);
	public void createDivision(Division division);
	public void	createSpecialIssue(Journal journal, SpecialIssue specialIssue, String dateString);
	public void saveSpecialIssue(Journal journal, SpecialIssue specialIssue, String dateString);
	public void	extendDueDate(EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, String dateString);
	public void	declineExtendingDueDate(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void checkSpecialIssues();
	/*
	 * 

	public void publishManuscript(Manuscript m, String managerUsername, ExternalContext externalContext);
	public List<User> getBoardAll();
	
	public void deleteBoard(int selectUserId);
	public boolean setDeleteResult(boolean result);	

	public void grantBoard(Board board);

	public void grantAuthority(AuthorityCriteria authorityCriteria);
	*/
}
