package link.thinkonweb.controller.manuscript;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.JournalUploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalUploadedFile;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DatabaseInfo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("decline")
@Transactional
@RequestMapping("/journals/{jnid}*")
public class FileController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private  ManuscriptService manuscriptService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private CountryCodeDao countryCodeDao;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private JournalUploadedFileDaoImpl journalUploadedFileDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private DatabaseInfo databaseInfo;

	@Transactional(readOnly = true)
	@RequestMapping(value="/download/{fn}", method=RequestMethod.GET)
	public void downloadFile(@PathVariable("fn") int fn,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		UploadedFile uf = uploadedFileDao.findById(fn);
		if(uf != null) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Authority> authorities = authorityService.getAuthorities(user.getId(), 0, null);
			boolean passAuthority = false;
			for (Authority authority : authorities) {
				String authorityString = authority.getRole();
				if (authorityString.equals(SystemConstants.roleMember) || authorityString.equals(SystemConstants.roleManager))
					passAuthority = true;
				else if (authorityString.equals(SystemConstants.roleReviewer)) {
					Manuscript manuscript = manuscriptService.getManuscriptById(uf.getManuscriptId(), SystemConstants.NONE_BUILD);
					List<Review> reviews = reviewerService.getReviews(user.getId(), 0, journal.getId(), -1, null);
					for (Review review : reviews) {
						if (review.getManuscriptId() == manuscript.getId())
							passAuthority = true;
					}
					
				}
			}
			if(passAuthority) {
				File file = new File(uf.getAbsolutePath());
				response.setContentLength((int)file.length());
				response.setHeader("Content-type", "application/octet-stream");
		        response.setHeader("Content-Transfer-Encoding", "binary");
		        response.setHeader("Content-Disposition", "attachment;fileName=\""+uf.getOriginalName()+"\";");
		        
		        FileInputStream fis = null;
		        try {
		        	OutputStream out = response.getOutputStream();
		            fis = new FileInputStream(file);
		            FileCopyUtils.copy(fis,out);
		        } catch(IOException e) {
		            e.printStackTrace();
		        }  finally {
		            if(fis != null) 
		            	fis.close();
		        }
			}
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/download/template/{designation}", method=RequestMethod.GET)
	public void downloadJournalFile(@PathVariable("designation") String designation,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalUploadedFile uf = null;
		List<JournalUploadedFile> jufs = journalUploadedFileDao.findByJournalId(journal.getId());
		for(JournalUploadedFile juf: jufs) {
			if(juf.getDesignation().equals(designation)) {
				uf = juf;
				break;
			}
		}
		
		if(uf != null) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Authority> authorities = authorityService.getAuthorities(user.getId(), 0, null);
			boolean passAuthority = false;
			for (Authority authority : authorities) {
				String authorityString = authority.getRole();
				if (authorityString.equals(SystemConstants.roleManager) && uf.getJournalId() == journal.getId())
					passAuthority = true;
			}
			if(passAuthority) {
				File file = new File(uf.getAbsolutePath());
				response.setContentLength((int)file.length());
				response.setHeader("Content-type", "application/octet-stream");
		        response.setHeader("Content-Transfer-Encoding", "binary");
		        response.setHeader("Content-Disposition", "attachment;fileName=\""+uf.getOriginalName()+"\";");
		        
		        FileInputStream fis = null;
		        try {
		        	OutputStream out = response.getOutputStream();
		            fis = new FileInputStream(file);
		            FileCopyUtils.copy(fis,out);
		        } catch(IOException e) {
		            e.printStackTrace();
		        }  finally {
		            if(fis != null) 
		            	fis.close();
		        }
			}
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/download/backupJournal", method=RequestMethod.GET)
	public void backupJournal(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		List<Authority> authorities = authorityService.getAuthorities(user.getId(), 0, null);
		boolean passAuthority = false;
		for (Authority authority : authorities) {
			String authorityString = authority.getRole();
			if (authorityString.equals(SystemConstants.roleManager))
				passAuthority = true;
		}
		if(passAuthority) {
			
			File file = fileService.backupJournal(journal);
			response.setContentLength((int)file.length());
			response.setHeader("Content-type", "application/octet-stream");
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.setHeader("Content-Disposition", "attachment;fileName=\""+file.getName()+"\";");
	        
	        FileInputStream fis = null;
	        try {
	        	OutputStream out = response.getOutputStream();
	            fis = new FileInputStream(file);
	            FileCopyUtils.copy(fis,out);
	        } catch(IOException e) {
	            e.printStackTrace();
	        }  finally {
	            if(fis != null) 
	            	fis.close();
	        }
		}
		
	}
	
	@RequestMapping(value="/delete/{designation}/{fn}", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteFile(@PathVariable("fn") int fn,
			@PathVariable("designation") String designation,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

		UploadedFile uf = uploadedFileDao.findById(fn);
		if(uf != null) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Authority> authorities = authorityService.getAuthorities(user.getId(), 0, null);
			
			boolean passAuthority = false;
			for (Authority authority : authorities) {
				String authorityString = authority.getRole();
				if (authorityString.equals(SystemConstants.roleMember) || authorityString.equals(SystemConstants.roleManager))
					passAuthority = true;
				else if (authorityString.equals(SystemConstants.roleReviewer)) {
					Manuscript manuscript = manuscriptService.getManuscriptById(uf.getManuscriptId(), SystemConstants.NONE_BUILD);
					List<Review> reviews = reviewerService.getReviews(user.getId(), 0, journal.getId(), -1, null);
					for (Review review : reviews) {
						if (review.getManuscriptId() == manuscript.getId())
							passAuthority = true;
					}
				}
			}
			
			if(passAuthority)
				fileService.delete(fn, designation);
			else
				System.out.println("not authorized");
		}
		return true;
	}
	
	@RequestMapping(value="/delete/journal/{designation}/{fn}", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteJournalFile(@PathVariable("fn") int fn,
			@PathVariable("designation") String designation,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		JournalUploadedFile uf = journalUploadedFileDao.findById(fn);
		if(uf != null) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			List<Authority> authorities = authorityService.getAuthorities(user.getId(), 0, null);
			
			boolean passAuthority = false;
			for (Authority authority : authorities) {
				String authorityString = authority.getRole();
				if (authorityString.equals(SystemConstants.roleManager) && uf.getJournalId() == journal.getId())
					passAuthority = true;
			}
			if(passAuthority)
				fileService.deleteJournalFile(fn, designation);
			else
				System.out.println("not authorized");
		}
		return true;
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
}
