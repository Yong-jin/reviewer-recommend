package link.thinkonweb.service.manuscript;

import java.io.File;
import java.io.IOException;
import java.util.List;

import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalUploadedFile;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;

import org.springframework.web.multipart.MultipartFile;


public interface FileService {
	public void processJournalFile(int userId, MultipartFile file, Journal journal, String designation) throws IOException;
	public void processManuscriptFile(MultipartFile file, String jnid, Manuscript manuscript, String designation) throws IOException;
	public void processReviewFile(MultipartFile reviewFile, Review review, String jnid, String designation) throws IOException;
	public int numFileUploadedCount(Manuscript manuscript, List<String> designations);
	public int numGalleryProofFileUploadedCount(Manuscript manuscript, List<String> designations);
	public int numCameraReadyFileUploadedCount(Manuscript manuscript, List<String> designations);
	public void rename(UploadedFile uploadedFile, String jnid, String newName, String submitId) throws IOException;
	public void delete(int deleteFileId, String designation);
	public void deleteJournalFile(Journal journal, String designation);
	public void deleteJournalFile(int deleteFileId, String designation);
	public void update(UploadedFile file);
	public List<UploadedFile> getFilesUploadedByCoAuthors(int manuscriptId, List<String> designations);
	public List<UploadedFile> getFiles(int manuscriptId, int userId, int revisionCount, List<String> designations);
	public List<JournalUploadedFile> getJournalFiles(int journalId);
	public String changeToValidateFilename(String fileName);
	public File backupJournal(Journal journal);
	

}
