package link.thinkonweb.service.roles;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.AuthorityDao;
import link.thinkonweb.dao.user.ContactDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.constants.CameraReadyFileDesignation;
import link.thinkonweb.domain.constants.FileDesignation;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.SubmitIdGenerator;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;


public class ManagerServiceImpl implements ManagerService {
	@Autowired
	private SubmitIdGenerator submitIdGenerator;
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ContactDao contactDao;
	@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private DivisionDao divisionDao;
	@Autowired
	private EventDateTimeDao eventDateDao;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private UserService userService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private FileService fileService;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private SpecialIssueDao specialIssueDao;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	
	@Override
	public List<Manager> getManagersByJournalId(int journalId) {
		List<Manager> managerAll = journalRoleDao.findJournalManagers(0, journalId);
		for (Manager manager : managerAll) {
			SystemUser user = userService.getById(manager.getUserId());
			manager.setUser(user);
		}
		return managerAll;
	}
	
	@Override
	public List<SystemUser> getManagerUsersByJournalId(int journalId) {
		List<SystemUser> managerUserAll = new LinkedList<SystemUser>();
		List<Manager> managerAll = journalRoleDao.findJournalManagers(0, journalId);
		for (Manager manager : managerAll) {
			SystemUser user = userService.getById(manager.getUserId());
			managerUserAll.add(user);
		}
		return managerUserAll;
	}
	
	@Override
	public void confirmManuscript(Manuscript manuscript, SystemUser manager, Journal journal, int editorUserId, HttpServletRequest request, Locale locale) {
		try {
			String status = manuscript.getStatus();
			if (status.equals(SystemConstants.statusI)) {
				List<String> designations = new ArrayList<String>();
				for(int i=0; i<FileDesignation.values().length; i++)
					designations.add(FileDesignation.getType(i).name());
			
				designations.add(SystemConstants.fileTypeFC);
				designations.add(SystemConstants.fileTypeCHK);
			
				//TODO additional files
				List<UploadedFile> files = fileService.getFilesUploadedByCoAuthors(manuscript.getId(), designations);
				String submitId = submitIdGenerator.generate(manuscript.getJournalId());
				manuscript.setSubmitId(submitId);			
				manuscript.setManagerUserId(manager.getId());
				manuscript.setManager(manager);
				SystemUser editorUser = userService.getById(editorUserId);
				if(manuscript.getManuscriptTrackId() == 0) {
					manuscript.setChiefEditorUserId(editorUserId);
					manuscript.setChiefEditor(editorUser);
					if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB))
						manuscript.setStatus(SystemConstants.statusO);
					else {
						manuscript.setStatus(SystemConstants.statusR);
						manuscript.setEditorStatus(SystemConstants.editorT);
					}
				} else {
					manuscript.setGuestEditorUserId(editorUserId);
					manuscript.setGuestEditor(editorUser);
					manuscript.setStatus(SystemConstants.statusR);
				}

				int mainDocumentCount = 0;
				int figureImageDocumentCount = 0;
				int tableDocument = 0;
				int supplementaryFile = 0;
				int frontCoverFile = 0;
				int checkListFile = 0;
				eventDateDao.insert(manuscriptService.generateEventDateTime(manuscript));
				for (UploadedFile file : files) {
					file.setConfirm(true);
					String prefix = null;
					if(file.getDesignation().equals(FileDesignation.getType(0).name())) {
						mainDocumentCount++;
						prefix = FileDesignation.getType(0).name();
						prefix += "-" + mainDocumentCount;
					} else if(file.getDesignation().equals(FileDesignation.getType(1).name())) {
						figureImageDocumentCount++;
						prefix = FileDesignation.getType(1).name();
						prefix += "-" + figureImageDocumentCount;
					} else if(file.getDesignation().equals(FileDesignation.getType(2).name())) {
						tableDocument++;
						prefix = FileDesignation.getType(2).name();
						prefix += "-" + tableDocument;
					} else if(file.getDesignation().equals(FileDesignation.getType(3).name())) {
						supplementaryFile++;
						prefix = FileDesignation.getType(3).name();
						prefix += "-" + supplementaryFile;
					} else if(file.getDesignation().equals(SystemConstants.fileTypeFC)) {
						frontCoverFile++;
						prefix = SystemConstants.fileTypeFC;
						prefix += "-" + frontCoverFile;
					} else if(file.getDesignation().equals(SystemConstants.fileTypeCHK)) {
						checkListFile++;
						prefix = SystemConstants.fileTypeCHK;
						prefix += "-" + checkListFile;
					}
					
					int pos = file.getOriginalName().lastIndexOf( "." );
					String ext = file.getOriginalName().substring( pos + 1 );
					String revision = null;
					if (file.getRevisionCount() == 0)
						revision = "Original";
					else
						revision = "Rev" + file.getRevisionCount();
					
					String newName = prefix + "-[" + submitId + "]-" + revision + "." + ext;
					
					try {
						fileService.rename(file, journal.getJournalNameId(), newName, submitId);
					} catch(Exception e) {
						e.printStackTrace();
					}
					
					uploadedFileDao.update(file);
				}
				
				manuscriptDao.update(manuscript);

				emailService.sendEmail(6, manuscript, journal, null, request, locale);
				emailService.sendEmail(8, manuscript, journal, null, request, locale);
			} else if (status.equals(SystemConstants.statusV)) {
				manuscript.setStatus(SystemConstants.statusR);
				manuscript.setManagerUserId(manager.getId());	
				eventDateDao.insert(manuscriptService.generateEventDateTime(manuscript));
					
				List<String> designations = new ArrayList<String>();
				for(int i=0; i<4; i++)
					designations.add(FileDesignation.getType(i).name());
				
				int mainDocumentCount = 0;
				int figureImageDocumentCount = 0;
				int tableDocument = 0;
				int supplementaryFile = 0;
				int frontCoverFile = 0;
				int checkListFile = 0;
				List<UploadedFile> files = fileService.getFilesUploadedByCoAuthors(manuscript.getId(), designations);
				for (UploadedFile file : files) {
					file.setConfirm(true);
					int pos = file.getOriginalName().lastIndexOf( "." );
					String ext = file.getOriginalName().substring(pos + 1);
					
					String prefix = null;
					if(file.getDesignation().equals(FileDesignation.getType(0).name())) {
						mainDocumentCount++;
						prefix = FileDesignation.getType(0).name();
						prefix += "-" + mainDocumentCount;
					} else if(file.getDesignation().equals(FileDesignation.getType(1).name())) {
						figureImageDocumentCount++;
						prefix = FileDesignation.getType(1).name();
						prefix += "-" + figureImageDocumentCount;
					} else if(file.getDesignation().equals(FileDesignation.getType(2).name())) {
						tableDocument++;
						prefix = FileDesignation.getType(2).name();
						prefix += "-" + tableDocument;
					} else if(file.getDesignation().equals(FileDesignation.getType(3).name())) {
						supplementaryFile++;
						prefix = FileDesignation.getType(3).name();
						prefix += "-" + supplementaryFile;
					} else if(file.getDesignation().equals(SystemConstants.fileTypeFC)) {
						frontCoverFile++;
						prefix = SystemConstants.fileTypeFC;
						prefix += "-" + frontCoverFile;
					} else if(file.getDesignation().equals(SystemConstants.fileTypeCHK)) {
						checkListFile++;
						prefix = SystemConstants.fileTypeCHK;
						prefix += "-" + checkListFile;
					}
					String revision = "Revision-" + file.getRevisionCount();
					String newName = prefix + "-[" + manuscript.getSubmitId() + "]-" + revision + "." + ext;
					
					try {
						fileService.rename(file, journal.getJournalNameId(), newName, manuscript.getSubmitId());
					} catch(Exception e) {
						e.printStackTrace();
					}
					uploadedFileDao.update(file);
				}
				
				manuscriptDao.update(manuscript);

				emailService.sendEmail(7, manuscript, journal, null, request, locale);
				emailService.sendEmail(9, manuscript, journal, null, request, locale);
			} else if(status.equals(SystemConstants.statusM)) {
				if(!manuscript.isCameraReadyConfirm()) {
					List<String> designations = new ArrayList<String>();
					for(int i=0; i<3; i++)
						designations.add(CameraReadyFileDesignation.getType(i).name());
					
					int cameraReadyPaperCount = 0;
					int copyrightCount = 0;
					int biographyCount = 0;
					
					List<UploadedFile> files = fileService.getFilesUploadedByCoAuthors(manuscript.getId(), designations);
					if(files != null)
						Collections.sort(files);
					for (UploadedFile file : files) {
						file.setConfirm(true);
						int pos = file.getOriginalName().lastIndexOf( "." );
						String ext = file.getOriginalName().substring(pos + 1);
						String prefix = null;
						if(file.getDesignation().equals(CameraReadyFileDesignation.getType(0).name())) {
							cameraReadyPaperCount++;
							prefix = CameraReadyFileDesignation.getType(0).name();
							prefix += "-" + cameraReadyPaperCount;
						} else if(file.getDesignation().equals(CameraReadyFileDesignation.getType(1).name())) {
							copyrightCount++;
							prefix = CameraReadyFileDesignation.getType(1).name();
							prefix += "-" + copyrightCount;
						} else if(file.getDesignation().equals(CameraReadyFileDesignation.getType(2).name())) {
							biographyCount++;
							prefix = CameraReadyFileDesignation.getType(2).name();
							prefix += "-" + biographyCount;
						}
						
						String revision = null;
						if(file.getCameraReadyRevision() == 0)
							revision = "Original";
						else
							revision = "Revision-" + file.getCameraReadyRevision();
						String newName = prefix + "-[" + manuscript.getSubmitId() + "]-" + revision + "." + ext;
						
						try {
							fileService.rename(file, journal.getJournalNameId(), newName, manuscript.getSubmitId());
						} catch(Exception e) {
							e.printStackTrace();
						}
						uploadedFileDao.update(file);
					}
					manuscript.setCameraReadyConfirm(true);
					EmailMessage emailMessage = emailService.getGeneralEmailMessage(45, manuscript, journal, null, request, locale);
					emailService.sendEmailToAuthorsWithMessageModification(45, manuscript, journal, emailMessage, request, locale);
				} else {
					manuscript.setStatus(SystemConstants.statusG);
					eventDateDao.insert(manuscriptService.generateEventDateTime(manuscript));
					List<String> designations = new ArrayList<String>();
					designations.add(SystemConstants.fileTypeG);
					List<UploadedFile> galleryProofFiles = fileService.getFiles(manuscript.getId(), manuscript.getManagerUserId(), manuscript.getRevisionCount(), designations);
					if(galleryProofFiles != null)
						Collections.sort(galleryProofFiles);
					int fileCount = 1;
					for (UploadedFile file : galleryProofFiles) {
						file.setConfirm(true);
						int pos = file.getOriginalName().lastIndexOf( "." );
						String ext = file.getOriginalName().substring(pos + 1);
						String prefix = "GalleryProof-" + fileCount;
						String revision = null;
						if(file.getGalleryProofRevision() == 0)
							revision = "Original";
						else
							revision = "Revision-" + file.getGalleryProofRevision();
						String newName = prefix + "-[" + manuscript.getSubmitId() + "]-" + revision + "." + ext;
						
						try {
							fileService.rename(file, journal.getJournalNameId(), newName, manuscript.getSubmitId());
						} catch(Exception e) {
							e.printStackTrace();
						}
						uploadedFileDao.update(file);
						fileCount++;
					}
					EmailMessage emailMessage = emailService.getGeneralEmailMessage(46, manuscript, journal, null, request, locale);
					emailService.sendEmailToAuthorsWithMessageModification(46, manuscript, journal, emailMessage, request, locale);
				}
			} else {
				throw new Exception();
			}

			manuscriptDao.update(manuscript);
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	@Override
	public void returnBackManuscript(Manuscript manuscript, Journal journal, EmailMessage emailMessage, String comments, HttpServletRequest request, Locale locale) {
		try {
			String status = manuscript.getStatus();
			if (status.equals(SystemConstants.statusI)) {
				manuscript.setStatus(SystemConstants.statusB);
				eventDateDao.insert(manuscriptService.generateEventDateTime(manuscript));
				
				String text = emailMessage.getBody();
				if (comments != null && !comments.equals(""))
					text = text.replace("[comments]", comments);
				else
					text = text.replace("[comments]", "");
				emailMessage.setBody(text);
				
				emailService.sendEmailToAuthorsWithMessageModification(4, manuscript, journal, emailMessage, request, locale);
			} else if(status.equals(SystemConstants.statusV)) {
				manuscript.setStatus(SystemConstants.statusD);
				eventDateDao.insert(manuscriptService.generateEventDateTime(manuscript));
				
				String text = emailMessage.getBody();
				if (comments != null && !comments.equals(""))
					text = text.replace("[comments]", comments);
				else
					text = text.replace("[comments]", "");
				emailMessage.setBody(text);
				
				emailService.sendEmailToAuthorsWithMessageModification(5, manuscript, journal, emailMessage, request, locale);
			} else if (status.equals(SystemConstants.statusM)) {
				/*
				List<String> designations = new ArrayList<String>();
				for(int i=0; i<3; i++)
					designations.add(CameraReadyFileDesignation.getType(i).name());
				List<UploadedFile> files = fileService.getFiles(manuscript.getId(), 0, designations);
				for(UploadedFile uf: files)
					fileService.delete(uf.getId(), uf.getDesignation());
				*/
				manuscript.setStatus(SystemConstants.statusA);
				//emailService.sendEmail(e, manuscript, journal, additionalParams, request, locale);
			} else {
				throw new Exception();
			}
			
			manuscriptDao.update(manuscript);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
	}
	
	@Override
	public void createDivision(Division division) {
		divisionDao.insert(division);
	}

	@Override
	public void returnBackCameraReady(Comment comment, SystemUser managerUser,
			Manuscript manuscript, Journal journal, EmailMessage emailMessage,
			HttpServletRequest request, Locale locale) {
		comment.setJournalId(manuscript.getJournalId());
		comment.setFromRole(SystemConstants.roleManager);
		comment.setToRole(SystemConstants.roleMember);
		comment.setFromUserId(managerUser.getId());
		comment.setToUserId(manuscript.getUserId());
		comment.setRevisionCount(manuscript.getRevisionCount());
		comment.setStatus(SystemConstants.statusM);
		comment.setCameraReadyRevision(manuscript.getCameraReadyRevision());
		commentDao.insert(comment);
		manuscript.setStatus(SystemConstants.statusA);
		manuscript.setCameraReadyRevision(manuscript.getCameraReadyRevision() + 1);
		manuscriptService.update(manuscript);
		
		String body = emailMessage.getBody();
		body = body.replace("[comments]", comment.getText());
		emailMessage.setBody(body);
		emailService.sendEmailToAuthorsWithMessageModification(44, manuscript, journal, emailMessage, request, locale);
	}
	
	@Override
	public void createSpecialIssue(Journal journal, SpecialIssue specialIssue, String dateString) {
		try {
			SimpleDateFormat sdf = null;
			if(journal.getLanguageCode().equals("ko"))
				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			Date parseDate = sdf.parse(dateString);
			java.sql.Date submitDueDate = new java.sql.Date(parseDate.getTime());
			specialIssue.setSubmissionDueDate(submitDueDate);
			specialIssueDao.insert(specialIssue);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void saveSpecialIssue(Journal journal, SpecialIssue specialIssue, String dateString) {
		try {
			SimpleDateFormat sdf = null;
			if(journal.getLanguageCode().equals("ko"))
				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			Date parseDate = sdf.parse(dateString);
			java.sql.Date submitDueDate = new java.sql.Date(parseDate.getTime());
			specialIssue.setSubmissionDueDate(submitDueDate);
			specialIssueDao.update(specialIssue);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void extendDueDate(EmailMessage emailMessage, Manuscript manuscript, Journal journal,
			HttpServletRequest request, Locale locale, String dateString) {
		try {
			manuscript.setDueDateExtendRequest(false);
			SimpleDateFormat format = null;
			if(journal.getLanguageCode().equals("ko"))
				format = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
			else
				format = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
			Date parseDate = format.parse(dateString);
			java.sql.Date requestedDueDate = new java.sql.Date(parseDate.getTime());
			manuscript.setRevisionDueDate(requestedDueDate);
			emailService.sendEmail(37, manuscript, journal, emailMessage, request, locale);
			manuscriptService.update(manuscript);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void declineExtendingDueDate(Manuscript manuscript, Journal journal,
			HttpServletRequest request, Locale locale) {
		EventDateTime edt = manuscript.getLastEventDateTime(SystemConstants.statusD);
		manuscript.setDueDateExtendRequest(false);
		manuscript.setRevisionDueDate(edt.getDate());
		manuscriptService.update(manuscript);
		SystemUser submitter = userService.getById(manuscript.getUserId());
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(38, manuscript, journal, submitter.getUsername(), request, locale);
		SimpleDateFormat sdf = null;
		if(journal.getLanguageCode().equals("ko"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		String defaultDueDate = sdf.format(edt.getDate());
		String body = emailMessage.getBody();
		body = body.replace("[updatedManuscriptSubmitDate]", defaultDueDate);
		emailMessage.setBody(body);
		emailService.sendEmailToAuthorsWithMessageModification(38, manuscript, journal, emailMessage, request, locale);
	}

	@Override
	public void checkSpecialIssues() {
		Calendar todayCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		List<SpecialIssue> specialIssues = specialIssueDao.findAll();
		for(SpecialIssue si: specialIssues) {
			Date submissionDueDate = si.getSubmissionDueDate();
			if (submissionDueDate != null) {
				Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
				dueDateCalendar.setTime(submissionDueDate);
				int dueDateDayOfYear = dueDateCalendar.get(Calendar.DAY_OF_YEAR);
				int todayDayOfYear = todayCalendar.get(Calendar.DAY_OF_YEAR);
				int diff = todayDayOfYear - dueDateDayOfYear;
				if(dueDateCalendar.get(Calendar.YEAR) < todayCalendar.get(Calendar.YEAR) && diff == 0) {
					si.setStatus(false);
					specialIssueDao.update(si);
				}
			}
		}
	}

	@Override
	public void update(Manager manager) {
		journalRoleDao.update(manager);
	}

	@Override
	public void createManager(Manager manager) {
		Journal journal = journalService.getById(manager.getJournalId());
		SystemUser user = manager.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleManager);
	}

	@Override
	public void selectManager(int userId, int journalId) {
		authorityService.create(userId, journalId, SystemConstants.roleManager);
	}

	@Override
	public void deleteManager(int userId, int journalId) {
		Authority authority = authorityService.getAuthority(userId, journalId, SystemConstants.roleManager);
		authorityService.delete(authority);
	}

}
