package link.thinkonweb.dao.journal;

import java.util.List;
import java.util.Locale;

import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;

public interface JournalDao {
	public int create(Journal journal);
	public void update(Journal journal);
	public void updateRegisteredDate(Journal journal);
	public void delete(Journal journal);
	public Journal findById(int id);
	public List<Journal> findByTitle(String title);
	public List<Journal> findByShortTitle(String shortTitle);
	public List<Journal> findAll();
	public List<Journal> findByCreator(SystemUser creator);
	public Journal findByJournalNameID(String jnid);
	public Journal findBeingCreated(int creatorId);
	public List<Journal> findByCustomJournalUserContactSql(String sql);
	public List<Journal> findByCustomJournalSql(String sql);
	public int getNumOfRecordsByCustomSql(String sql);
	public List<Journal> findBySuperManagerJournalList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale);
	public List<Journal> findJournalsByUserFromMyActivity(SystemUser user, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
}