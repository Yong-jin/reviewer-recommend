package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.UploadedFile;

public interface UploadedFileDao {
	
	public int insert(UploadedFile uf);
	public UploadedFile findById(int id);
	public List<UploadedFile> getFilesByManuscriptId(int manuscriptId);
	public List<UploadedFile> getUploadedFiles(int manuscriptId, List<Integer> userIds, int revisionCount, List<String> designations);
	public List<UploadedFile> getUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations);
	public int numUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations);
	public int numGalleryProofUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations);
	public int numCameraReadyUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations);
	public void update(UploadedFile uf);
	public void deleteFileById(int id);
	

}
