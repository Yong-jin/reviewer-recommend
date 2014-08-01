package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalConfiguration;



public interface JournalConfigurationDao {
	public int insert(JournalConfiguration journalConfiguration);
	public JournalConfiguration findById(int id);
	public JournalConfiguration findByJournalId(int journalId);
	public List<JournalConfiguration> findAll();
	public void update(JournalConfiguration journalConfiguration);
}
