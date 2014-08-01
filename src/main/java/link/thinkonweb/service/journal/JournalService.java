package link.thinkonweb.service.journal;

import java.util.List;
import java.util.Locale;
import java.util.Set;

import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;

public interface JournalService {
	public int 				create(Journal journal);
	public int 				submit(Journal journal);
	public void 			update(Journal journal);
	public void 			delete(Journal journal);
	public Journal 			getById(int id);
	public Journal 			getByJournalNameId(String jnid);
	public List<Journal> 	getByTitle(String journalName);
	public List<Journal> 	getAll();
	public List<Journal> 	getByShortTitle(String journalShortTitle);
	public List<Journal> 	getByCreator(SystemUser creator);
	public List<Division> 	getDivisionsById(int id);
	public Journal			getBeingCreated(int creatorId);
	public boolean 			isUniqueJournalNameID(String jnid);
	
	public List<Journal> 	getBySuperManagerJournalList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale);
	public List<Journal> 	getJournalsByUserFromMyActivity(SystemUser user, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
	
	
	public Set<Journal> 	getJournalsByUser(SystemUser user, String role);
	public int			 	numJournalsByUser(SystemUser user, String role);
	
	public Set<SystemUser> 	getUsersByJournal(Journal journal, String role);
	public int		  		numUsersByJournal(Journal journal, String role);
	
	public boolean			isMemberOfNonEnglishJournal(SystemUser user);
	public List<String>		getAllStatus(Journal journal);
}