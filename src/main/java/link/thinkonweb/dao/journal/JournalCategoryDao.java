package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalCategory;

public interface JournalCategoryDao {
	public int insert(JournalCategory jc);
	public JournalCategory findById(int id);
	public List<JournalCategory> findByJournalId(int journalId);
	public JournalCategory findByCategoryIdAndJournalId(int categoryId, int journalId);
	public JournalCategory findByNameAndJournalId(String name, int journalId);
	public void update(JournalCategory jc);
	public void delete(int id);
	public void deleteByJournalId(int journalId);
}
