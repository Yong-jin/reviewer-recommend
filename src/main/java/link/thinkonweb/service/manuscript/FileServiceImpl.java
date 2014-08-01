package link.thinkonweb.service.manuscript;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.TimeZone;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.JournalUploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.journal.JournalUploadedFile;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.util.CompressUtil;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;



public class FileServiceImpl implements FileService, ResourceLoaderAware, Serializable {

	private static final long serialVersionUID = -3040228551611189090L;
	@Autowired
	private ResourceLoader resourceLoader;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private JournalUploadedFileDaoImpl journalUploadedFileDao;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private CompressUtil compressUtil;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private JournalConfigurationService jcService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private MessageSource messageSource;
		

	@Override
	public void setResourceLoader(ResourceLoader arg0) {
		this.resourceLoader = arg0;
	}
	
	@Override
    public void processJournalFile(int userId, MultipartFile file, Journal journal, String designation) throws IOException {
    	File originDir = new File(SystemConstants.ORIGIN_PATH + journal.getJournalNameId() + File.separator + "template" + File.separator + designation);
    	if(!originDir.exists())
    		originDir.mkdirs();
    	//	/var/jms/jips/template
    	
    	String originalFileName = file.getOriginalFilename();
		int pos = originalFileName.lastIndexOf( "." );
		String ext = originalFileName.substring( pos + 1 );
        File originalFile = File.createTempFile(designation + "_", "." + ext, originDir);
        FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(originalFile));
    	JournalUploadedFile uploadedFile = new JournalUploadedFile();
        uploadedFile.setUserId(userId);
        uploadedFile.setJournalId(journal.getId());
        uploadedFile.setName(originalFile.getName());
        uploadedFile.setDesignation(designation);
        uploadedFile.setAbsolutePath(originalFile.getAbsolutePath());
        uploadedFile.setOriginalName(originalFile.getName());
        //uploadedFile.setPath(journal.getJournalNameId() + File.separator + "template" + File.separator + originalFile.getName());
        
        List<JournalUploadedFile> jufs = journalUploadedFileDao.findByJournalId(journal.getId());
        for(JournalUploadedFile juf: jufs)
        	if(juf.getDesignation().equals(designation))
        		this.deleteJournalFile(juf.getId(), designation);
        
        journalUploadedFileDao.insert(uploadedFile);
  
        JournalConfiguration jc = jcService.getByJournalId(journal.getId());
        if(designation.equals(SystemConstants.fileTypeCT))
        	jc.setCameraReadyTemplateUrl(SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId() + "/download/template/" + designation);
        else if(designation.equals(SystemConstants.fileTypeCP))
        	jc.setCopyrightFormUrl(SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId() + "/download/template/" + designation);
        else if(designation.equals(SystemConstants.fileTypeFC))
        	jc.setFrontCoverUrl(SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId() + "/download/template/" + designation);
        else if(designation.equals(SystemConstants.fileTypeCHK))
        	jc.setCheckListUrl(SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId() + "/download/template/" + designation);
        
        jcService.update(jc);
        
    }
	@Override
    public void processManuscriptFile(MultipartFile file, String jnid, Manuscript manuscript, String designation) throws IOException {
    	int manuscriptId = manuscript.getId();

    	Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		int year = calendar.get(Calendar.YEAR);
    	File originDir = new File(SystemConstants.ORIGIN_PATH + jnid + File.separator + year + File.separator + manuscriptId + File.separator + manuscript.getRevisionCount() + File.separator + designation);
    	if(!originDir.exists())
    		originDir.mkdirs();
    	//	/var/jms/jips/2014/80
    	
    	String originalFileName = file.getOriginalFilename();
		int pos = originalFileName.lastIndexOf( "." );
		String ext = originalFileName.substring( pos + 1 );
        File originalFile = File.createTempFile(designation + "_", "." + ext, originDir);
        FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(originalFile));

    	UploadedFile uploadedFile = new UploadedFile();
        uploadedFile.setManuscriptId(manuscriptId);
        if(designation.equals(SystemConstants.fileTypeG))
        	uploadedFile.setUserId(manuscript.getManagerUserId());
        else
        	uploadedFile.setUserId(manuscript.getUserId());
        uploadedFile.setName(originalFile.getName());
        uploadedFile.setDesignation(designation);
        uploadedFile.setAbsolutePath(originalFile.getAbsolutePath());
        uploadedFile.setOriginalName(originalFile.getName());
        uploadedFile.setRevisionCount(manuscript.getRevisionCount());
        uploadedFile.setGalleryProofRevision(manuscript.getGalleryProofRevision());
        uploadedFile.setCameraReadyRevision(manuscript.getCameraReadyRevision());
        //uploadedFile.setPath(jnid + File.separator + year + File.separator + manuscriptId + File.separator + originalFile.getName());
        uploadedFileDao.insert(uploadedFile);       
    }
	
	@Override
	public void processReviewFile(MultipartFile reviewFile, Review review, String jnid, String designation) throws IOException {
		if(reviewFile != null) {
	    	Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			int year = calendar.get(Calendar.YEAR);
	    	int manuscriptId = review.getManuscriptId();
	    	Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			
	    	File originDir = new File(SystemConstants.ORIGIN_PATH + jnid + File.separator + year + File.separator + manuscriptId + File.separator + manuscript.getRevisionCount() + File.separator + designation);
	    	if(!originDir.exists())
	    		originDir.mkdirs();
			
	    	String originalFileName = reviewFile.getOriginalFilename();
			int pos = originalFileName.lastIndexOf( "." );
			String ext = originalFileName.substring( pos + 1 );
	        File originalFile = File.createTempFile(designation + "_", "." + ext, originDir);
	        FileCopyUtils.copy(reviewFile.getInputStream(), new FileOutputStream(originalFile));
        	UploadedFile uploadedFile = new UploadedFile();
            uploadedFile.setManuscriptId(manuscriptId);
            uploadedFile.setUserId(review.getUserId());
            uploadedFile.setName(originalFile.getName());
            uploadedFile.setDesignation(designation);
            uploadedFile.setAbsolutePath(originalFile.getAbsolutePath());
            uploadedFile.setOriginalName(originalFile.getName());
            uploadedFile.setRevisionCount(review.getRevisionCount());
            uploadedFile.setConfirm(true);
            //uploadedFile.setPath(jnid + File.separator + year + File.separator + manuscriptId + File.separator + manuscript.getRevisionCount() + File.separator + designation + File.separator + reviewFile.getOriginalFilename());
            uploadedFileDao.insert(uploadedFile);
		}
	}
	
	@Override
	public void delete(int deleteFileId, String designation) {
		UploadedFile targetFile = uploadedFileDao.findById(deleteFileId);
		
		String path = targetFile.getAbsolutePath();
		File origin = new File(path);
		try {
			origin.delete();
		}catch(Exception e) {
			System.out.println("file delete failed" + origin);
		}
		uploadedFileDao.deleteFileById(deleteFileId);

		System.out.println("file deleted" + deleteFileId);
	}
	
	public void deleteJournalFile(int deleteFileId, String designation) {
		JournalUploadedFile targetFile = journalUploadedFileDao.findById(deleteFileId);
		Journal journal = journalService.getById(targetFile.getJournalId());
		String path = targetFile.getAbsolutePath();
		File origin = new File(path);
		try {
			origin.delete();
		}catch(Exception e) {
			System.out.println("file delete failed" + origin);
		}
		journalUploadedFileDao.deleteFileById(deleteFileId);
		int count = 0;
        List<JournalUploadedFile> jufs = journalUploadedFileDao.findByJournalId(journal.getId());
        for(JournalUploadedFile juf: jufs)
        	if(juf.getDesignation().equals(designation))
        		count++;
		if(count == 0) {
			JournalConfiguration jc = jcService.getByJournalId(journal.getId());
			if(designation.equals(SystemConstants.fileTypeCP))
				jc.setCopyrightFormUrl(null);
			else if(designation.equals(SystemConstants.fileTypeCT))
				jc.setCameraReadyTemplateUrl(null);
			else if(designation.equals(SystemConstants.fileTypeFC))
				jc.setFrontCoverUrl(null);
			else if(designation.equals(SystemConstants.fileTypeCHK))
				jc.setCheckListUrl(null);
			
			jcService.update(jc);
		}

		System.out.println("file deleted" + deleteFileId);
	}

	@Override
	public void deleteJournalFile(Journal journal, String designation) {
        List<JournalUploadedFile> jufs = journalUploadedFileDao.findByJournalId(journal.getId());
        for(JournalUploadedFile juf: jufs) {
        	if(juf.getDesignation().equals(designation)) {
        		String path = juf.getAbsolutePath();
        		File origin = new File(path);
        		try {
        			origin.delete();
        		}catch(Exception e) {
        			System.out.println("file delete failed" + origin);
        		}
        		journalUploadedFileDao.deleteFileById(juf.getId());
        	}
        }
		JournalConfiguration jc = jcService.getByJournalId(journal.getId());
		if(designation.equals(SystemConstants.fileTypeCP))
			jc.setCopyrightFormUrl(null);
		else if(designation.equals(SystemConstants.fileTypeCT))
			jc.setCameraReadyTemplateUrl(null);
		else if(designation.equals(SystemConstants.fileTypeFC))
			jc.setFrontCoverUrl(null);
		else if(designation.equals(SystemConstants.fileTypeCHK))
			jc.setCheckListUrl(null);
		
		jcService.update(jc);
	}
	
	@Override
	public void rename(UploadedFile uploadedFile, String jnid, String newName, String submitId) throws IOException {
		String absolutePath = uploadedFile.getAbsolutePath();
		Resource resource = resourceLoader.getResource("file:"+absolutePath);
		Date date = uploadedFile.getDate();
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		cal.setTime(date);
		int year = cal.get(Calendar.YEAR);
    	File newDir = new File(SystemConstants.ORIGIN_PATH + jnid + File.separator + year + File.separator + submitId + File.separator + uploadedFile.getRevisionCount() + File.separator + uploadedFile.getDesignation());
    	if(!newDir.exists())
    		newDir.mkdirs();
		
        File originalFile = File.createTempFile("file", newName, newDir);
        FileCopyUtils.copy(resource.getInputStream(), new FileOutputStream(originalFile));
        uploadedFile.setName(originalFile.getName());
        uploadedFile.setAbsolutePath(originalFile.getAbsolutePath());
        uploadedFile.setOriginalName(newName);
        //uploadedFile.setPath(SystemConstants.ORIGIN_PATH + jnid + File.separator + year + File.separator + submitId + File.separator + uploadedFile.getRevisionCount() + File.separator + uploadedFile.getDesignation());
        uploadedFileDao.update(uploadedFile);
	}
	
	@Override
	public List<UploadedFile> getFilesUploadedByCoAuthors(int manuscriptId, List<String> designations) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		
		List<Integer> userIds = new ArrayList<Integer>();
		List<CoAuthor> coAuthors = coAuthorDao.findCoAuthors(manuscriptId, m.getRevisionCount(), 0, false);
		for(CoAuthor coAuthor: coAuthors) 
			userIds.add(coAuthor.getUserId());
		
		List<UploadedFile> files = uploadedFileDao.getUploadedFiles(manuscriptId, userIds, m.getRevisionCount(), designations);
		Collections.sort(files);
		return files;
	}
	
	@Override
	public List<UploadedFile> getFiles(int manuscriptId, int userId, int revisionCount, List<String> designations) {
		List<UploadedFile> files = uploadedFileDao.getUploadedFiles(manuscriptId, userId, revisionCount, designations);
		Collections.sort(files);
		return files;
	}

	@Override
	public String changeToValidateFilename(String fileName) {
		String[] preventString = {"!", "@", "#", "$", "%", "^", "&", "*", "`"};
		for(String s: preventString)
			if(fileName.contains(s))
				fileName = fileName.replace(s, "");
		
		fileName = fileName.replace(" ", "_");
		return fileName;
		
	}
	
	@Override
	public int numFileUploadedCount(Manuscript manuscript, List<String> designations) {
		return uploadedFileDao.numUploadedFiles(manuscript.getId(), manuscript.getUserId(), manuscript.getRevisionCount(), designations);
	}
	
	@Override
	public int numGalleryProofFileUploadedCount(Manuscript manuscript, List<String> designations) {
		return uploadedFileDao.numGalleryProofUploadedFiles(manuscript.getId(), manuscript.getManagerUserId(), manuscript.getGalleryProofRevision(), designations);
	}
	
	@Override
	public int numCameraReadyFileUploadedCount(Manuscript manuscript, List<String> designations) {
		return uploadedFileDao.numCameraReadyUploadedFiles(manuscript.getId(), manuscript.getUserId(), manuscript.getCameraReadyRevision(), designations);
	}
	
	@Override
	public void update(UploadedFile file) {
		uploadedFileDao.update(file);
	}

	@Override
	public List<JournalUploadedFile> getJournalFiles(int journalId) {
		return journalUploadedFileDao.findByJournalId(journalId);
	}

	@Override
	public File backupJournal(Journal journal) {
		try {
			compressUtil.zip(new File(SystemConstants.ORIGIN_PATH + File.separator + journal.getJournalNameId()));
			return new File(SystemConstants.ORIGIN_PATH + File.separator + journal.getJournalNameId() + ".zip");
		} catch(IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	


}
