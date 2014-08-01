package link.thinkonweb.dao.roles;

import java.util.List;
import java.util.Set;

import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.BoardMember;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.roles.JournalRole;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.roles.Member;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;

public interface JournalRoleDao {
	public void 				create(int userId, int journalId, int authorityId, String role);
	public void 				create(int userId, int journalId, int authorityId, Object roleType);
	//public void 				delete(int userId, int journalId, String role);
	
	public void 				update(JournalRole journalRole);
	
	public JournalRole 			findSpecificJournalRole(int id, String role);
	public JournalRole			findSpecificJournalRole(int userId, int journalId, String role);
	
	public List<JournalRole> 	findAnyJournalRoles(int userId, int journalId);
	
	public Member 				findJournalMember(int userId, int journalId);
	public List<Member> 		findJournalMembers(int userId, int journalId);
	public int					numJournalMembers(int userId, int journalId);
	
	public Manager				findJournalManager(int userId, int journalId);
	public List<Manager> 		findJournalManagers(int userId, int journalId);
	public int					numJournalManagers(int userId, int journalId);
	
	public ChiefEditor			findJournalChiefEditor(int userId, int journalId);
	public List<ChiefEditor>	findJournalChiefEditors(int userId, int journalId);
	public int					numJournalChiefEditors(int userId, int journalId);
	
	public AssociateEditor		findJournalAssociateEditor(int userId, int journalId);
	public List<AssociateEditor>findJournalAssociateEditors(int userId, int journalId);
	public int					numJournalAssociateEditors(int userId, int journalId);
	
	public GuestEditor			findJournalGuestEditor(int userId, int journalId);
	public List<GuestEditor>	findJournalGuestEditors(int userId, int journalId);
	public int					numJournalGuestEditors(int userId, int journalId);
	
	public BoardMember			findJournalBoardMember(int userId, int journalId);
	public List<BoardMember>	findJournalBoardMembers(int userId, int journalId);
	public int					numJournalBoardMembers(int userId, int journalId);
	
	public Reviewer				findJournalReviewer(int userId, int journalId);
	public List<Reviewer>		findJournalReviewers(int userId, int journalId);
	public int					numJournalReviewers(int userId, int journalId);
	
	public Set<Journal> 		getJournalsByUser(int userId, String role);
	public int			 		numJournalsByUser(int userId, String role);
	
	public Set<SystemUser> 		getUsersByJournal(int journalId, String role);
	public int		  			numUsersByJournal(int journalId, String role);
}