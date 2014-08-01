package link.thinkonweb.service.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalConfiguration;

public interface JournalConfigurationService {
	public JournalConfiguration create(int journalId);
	public JournalConfiguration getById(int id);
	public JournalConfiguration getByJournalId(int journalId);
	public List<JournalConfiguration> getAll();
	public void update(JournalConfiguration journalConfiguration);
}
