package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalUploadedFile;

public interface JournalUploadedFileDao {
	public int insert(JournalUploadedFile juf);
	public JournalUploadedFile findById(int id);
	public List<JournalUploadedFile> findByJournalId(int journalId);
	public void update(JournalUploadedFile juf);
	public void deleteFileById(int id);
}
