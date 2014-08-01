package link.thinkonweb.controller.roles;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.FileImageInputStream;
import javax.imageio.stream.ImageInputStream;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.CategoryDao;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.GuestEditorSpecialIssueDao;
import link.thinkonweb.dao.journal.JournalCategoryDao;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.journal.UserDivisionDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.constants.CameraReadyFileDesignation;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.LocalJobTitleDesignation;
import link.thinkonweb.domain.constants.ManuscriptColumn;
import link.thinkonweb.domain.constants.ReviewItemDesignation;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Category;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalCategory;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.journal.JournalUploadedFile;
import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.BoardMember;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.AssociateEditorService;
import link.thinkonweb.service.roles.BoardMemberService;
import link.thinkonweb.service.roles.ChiefEditorService;
import link.thinkonweb.service.roles.GuestEditorService;
import link.thinkonweb.service.roles.ManagerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;


@Controller
@Transactional
@RequestMapping("/journals/{jnid}/manager/*")
public class ManagerController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManagerService managerService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private AssociateEditorService aeService;
	@Autowired
	private GuestEditorService geService;
	@Autowired
	private ChiefEditorService chiefService;
	@Autowired
	private BoardMemberService bmService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private CountryCodeDao countryCodeDao;
	@Autowired
	private DivisionDao divisionDao;
	@Autowired
	private UserDivisionDao userDivisionDao;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private JournalCategoryDao journalCategoryDao;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private EmailService emailService;
	@Autowired
	private SpecialIssueDao specialIssueDao;
	@Autowired
	private GuestEditorSpecialIssueDao geSpecialIssueDao;
	@Autowired
	private JournalConfigurationService journalConfigurationService;
	@Inject
	private FileSystemResource fileSystemResource;
	@Autowired
	private ServletContext servletContext;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("manuscripts");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/getPapers/{pageType}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String getPapers(Model model, HttpServletRequest request, Locale locale, 
			@PathVariable(value="pageType") String pageType) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		//System.out.println(dRequest);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> status = new ArrayList<String>();
		List<Manuscript> manuscripts = null;
		if(pageType.equals("beingSubmitted")) {
			status.add(SystemConstants.statusB);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			manuscripts = manuscriptService.getSubmittedManuscripts(0, journal.getId(), status, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("submitted")) {
			status.add(SystemConstants.statusI);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Submission Date
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getSubmittedManuscripts(0, journal.getId(), status, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("revisionRequested")) {
			status.add(SystemConstants.statusD);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Submission Date
			sortableColumnNames.add("REVISION_DUE_DATE");
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("revisionSubmitted")) {
			status.add(SystemConstants.statusV);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add(null);
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Submission Date
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("underReview")) {
			status.add(SystemConstants.statusO);
			status.add(SystemConstants.statusR);
			status.add(SystemConstants.statusE);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Confirmation Date
			sortableColumnNames.add(null);
			sortableColumnNames.add("STATUS");
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("accepted")) {
			status.add(SystemConstants.statusA);
			status.add(SystemConstants.statusM);
			status.add(SystemConstants.statusG);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Confirmation Date
			sortableColumnNames.add("EVENT_DATE");	//Decision Date
			sortableColumnNames.add(null);
			sortableColumnNames.add("STATUS");
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("published")) {
			status.add(SystemConstants.statusP);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Submission Date
			sortableColumnNames.add("EVENT_DATE");	//Confirmation Date
			sortableColumnNames.add(null);
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		} else if(pageType.equals("withdrawn")) {
			status.add(SystemConstants.statusJ);
			status.add(SystemConstants.statusW);
			
			sortableColumnNames.add(null);
			sortableColumnNames.add("SUBMIT_ID");
			sortableColumnNames.add("TITLE");
			sortableColumnNames.add("EVENT_DATE");	//Submission Date
			sortableColumnNames.add("EVENT_DATE");	//Confirmation Date
			sortableColumnNames.add(null);
			sortableColumnNames.add("STATUS");
			manuscripts = manuscriptService.getManuscriptsByRoleUserId(user.getId(), journal.getId(), SystemConstants.roleManager, status, -1, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		}
		
		List<Manuscript> filteredManuscripts = null;
		if(pageType.equals("submitted") || pageType.equals("revisionRequested")) {
			if(dRequest.getiSortCol()[0] == 4) {

				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
			
		} if(pageType.equals("revisionSubmitted")) {
			if(dRequest.getiSortCol()[0] == 4) {

				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusV) != null && o2.getLastEventDateTime(SystemConstants.statusV) != null)
								return o1.getLastEventDateTime(SystemConstants.statusV).compareTo(o2.getLastEventDateTime(SystemConstants.statusV));
							else if(o1.getLastEventDateTime(SystemConstants.statusV) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusV) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusV) != null && o2.getLastEventDateTime(SystemConstants.statusV) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusV).compareTo(o2.getLastEventDateTime(SystemConstants.statusV));
							else if(o1.getLastEventDateTime(SystemConstants.statusV) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusV) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
			
		} else if(pageType.equals("underReview")) {
			if(dRequest.getiSortCol()[0] == 3) {
				if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB)) {
					Collections.sort(manuscripts, new Comparator<Manuscript>() {
						@Override
						public int compare(Manuscript o1, Manuscript o2) {
							if (dRequest.getsSortDir()[0].equals("asc")) {
								if(o1.getLastEventDateTime(SystemConstants.statusO) != null && o2.getLastEventDateTime(SystemConstants.statusO) != null)
									return o1.getLastEventDateTime(SystemConstants.statusO).compareTo(o2.getLastEventDateTime(SystemConstants.statusO));
								else if(o1.getLastEventDateTime(SystemConstants.statusO) == null)
									return -1;
								else if(o2.getLastEventDateTime(SystemConstants.statusO) == null)
									return 1;
								else
									return 0;
	
							} else {
								if(o1.getLastEventDateTime(SystemConstants.statusO) != null && o2.getLastEventDateTime(SystemConstants.statusO) != null)
									return -1 * o1.getLastEventDateTime(SystemConstants.statusO).compareTo(o2.getLastEventDateTime(SystemConstants.statusO));
								else if(o1.getLastEventDateTime(SystemConstants.statusO) == null)
									return 1;
								else if(o2.getLastEventDateTime(SystemConstants.statusO) == null)
									return -1;
								else
									return 0;
							}
						}
					});
				} else {
					Collections.sort(manuscripts, new Comparator<Manuscript>() {
						@Override
						public int compare(Manuscript o1, Manuscript o2) {
							if (dRequest.getsSortDir()[0].equals("asc")) {
								if(o1.getLastEventDateTime(SystemConstants.statusR) != null && o2.getLastEventDateTime(SystemConstants.statusR) != null)
									return o1.getLastEventDateTime(SystemConstants.statusR).compareTo(o2.getLastEventDateTime(SystemConstants.statusR));
								else if(o1.getLastEventDateTime(SystemConstants.statusR) == null)
									return -1;
								else if(o2.getLastEventDateTime(SystemConstants.statusR) == null)
									return 1;
								else
									return 0;
	
							} else {
								if(o1.getLastEventDateTime(SystemConstants.statusR) != null && o2.getLastEventDateTime(SystemConstants.statusR) != null)
									return -1 * o1.getLastEventDateTime(SystemConstants.statusR).compareTo(o2.getLastEventDateTime(SystemConstants.statusR));
								else if(o1.getLastEventDateTime(SystemConstants.statusR) == null)
									return 1;
								else if(o2.getLastEventDateTime(SystemConstants.statusR) == null)
									return -1;
								else
									return 0;
							}
						}
					});
				}
			}
		} else if(pageType.equals("accepted")) {
			if(dRequest.getiSortCol()[0] == 3) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			} else if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else if (pageType.equals("published")) {
			if (dRequest.getiSortCol()[0] == 3) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
				
			} else if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusP) != null && o2.getLastEventDateTime(SystemConstants.statusP) != null)
								return o1.getLastEventDateTime(SystemConstants.statusP).compareTo(o2.getLastEventDateTime(SystemConstants.statusP));
							else if(o1.getLastEventDateTime(SystemConstants.statusP) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusP) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusP) != null && o2.getLastEventDateTime(SystemConstants.statusP) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusP).compareTo(o2.getLastEventDateTime(SystemConstants.statusP));
							else if(o1.getLastEventDateTime(SystemConstants.statusP) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusP) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else if (pageType.equals("withdrawn")) {
			if (dRequest.getiSortCol()[0] == 3) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
				
			} else if(dRequest.getiSortCol()[0] == 4) {
				if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB)) {
					Collections.sort(manuscripts, new Comparator<Manuscript>() {
						@Override
						public int compare(Manuscript o1, Manuscript o2) {
							if (dRequest.getsSortDir()[0].equals("asc")) {
								if(o1.getLastEventDateTime(SystemConstants.statusO) != null && o2.getLastEventDateTime(SystemConstants.statusO) != null)
									return o1.getLastEventDateTime(SystemConstants.statusO).compareTo(o2.getLastEventDateTime(SystemConstants.statusO));
								else if(o1.getLastEventDateTime(SystemConstants.statusO) == null)
									return -1;
								else if(o2.getLastEventDateTime(SystemConstants.statusO) == null)
									return 1;
								else
									return 0;
	
							} else {
								if(o1.getLastEventDateTime(SystemConstants.statusO) != null && o2.getLastEventDateTime(SystemConstants.statusO) != null)
									return -1 * o1.getLastEventDateTime(SystemConstants.statusO).compareTo(o2.getLastEventDateTime(SystemConstants.statusO));
								else if(o1.getLastEventDateTime(SystemConstants.statusO) == null)
									return 1;
								else if(o2.getLastEventDateTime(SystemConstants.statusO) == null)
									return -1;
								else
									return 0;
							}
						}
					});
				} else {
					Collections.sort(manuscripts, new Comparator<Manuscript>() {
						@Override
						public int compare(Manuscript o1, Manuscript o2) {
							if (dRequest.getsSortDir()[0].equals("asc")) {
								if(o1.getLastEventDateTime(SystemConstants.statusR) != null && o2.getLastEventDateTime(SystemConstants.statusR) != null)
									return o1.getLastEventDateTime(SystemConstants.statusR).compareTo(o2.getLastEventDateTime(SystemConstants.statusR));
								else if(o1.getLastEventDateTime(SystemConstants.statusR) == null)
									return -1;
								else if(o2.getLastEventDateTime(SystemConstants.statusR) == null)
									return 1;
								else
									return 0;
	
							} else {
								if(o1.getLastEventDateTime(SystemConstants.statusR) != null && o2.getLastEventDateTime(SystemConstants.statusR) != null)
									return -1 * o1.getLastEventDateTime(SystemConstants.statusR).compareTo(o2.getLastEventDateTime(SystemConstants.statusR));
								else if(o1.getLastEventDateTime(SystemConstants.statusR) == null)
									return 1;
								else if(o2.getLastEventDateTime(SystemConstants.statusR) == null)
									return -1;
								else
									return 0;
							}
						}
					});
				}
			}
		}

		if(manuscripts.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredManuscripts = manuscripts;
		else
			filteredManuscripts = manuscripts.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > manuscripts.size() 
					? dRequest.getiDisplayStart() + (manuscripts.size() - dRequest.getiDisplayStart())
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredManuscripts.size());
		
		int i = 0, index = 0;
		int number = dRequest.getiDisplayStart() + 1;
		for (Manuscript m: filteredManuscripts) {
			dResponse.setAaData(i, index++, Integer.toString(number));	//No.
			if(pageType.equals("beingSubmitted"))
				dResponse.setAaData(i, index++, Integer.toString(m.getId()));	//TemporaryId
			else {
				if(m.getSubmitId() != null)
					dResponse.setAaData(i, index++, m.getSubmitId());	//SubmitId
				else
					dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.beingAssigned", null , locale));
			}
			if(pageType.equals("beingSubmitted") || pageType.equals("submitted") || pageType.equals("revisionRequested") || pageType.equals("revisionSubmitted")) {	//Submittor
				SystemUser submitter = userService.getById(m.getUserId());
				String submitterString = null;
				if(journal.getLanguageCode().equals("ko") && submitter.getContact().getLocalFullName() != null && !submitter.getContact().getLocalFullName().equals(""))
					submitterString = submitter.getContact().getLocalFullName();
				else
					submitterString = submitter.getContact().getFirstName() + "<br/>" + submitter.getContact().getLastName();
				dResponse.setAaData(i, index++, submitterString);
			}
			
			if(m.getTitle() == null)
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else {
				String invitedString = "";
				if(m.isInvite())
					invitedString  = "(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
				String titleUrl = "<a onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"summary\");'>" + invitedString + m.getTitle() + "</a>";

				dResponse.setAaData(i, index++, titleUrl);
			}
			
			if(pageType.equals("submitted") || pageType.equals("revisionSubmitted") || pageType.equals("revisionRequested")) {
				if(pageType.equals("submitted") || pageType.equals("revisionRequested")) {
					if(m.getLastEventDateTime(SystemConstants.statusI) != null)
						dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());	//Submission Date
					else
						dResponse.setAaData(i, index++, null);
				} else if(pageType.equals("revisionSubmitted")) {
					if(m.getLastEventDateTime(SystemConstants.statusV) != null)
						dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusV).getDate().toString());	//Submission Date
					else
						dResponse.setAaData(i, index++, null);
				}
				if(pageType.equals("revisionRequested")) {
					if(m.getRevisionDueDate() != null && m.getRevisionDueTime() != null)
						dResponse.setAaData(i, index++, m.getRevisionDueDate().toString());
					else
						dResponse.setAaData(i, index++, null);
				}
			} else if(pageType.equals("underReview")) {
				String confirmState = null;
				if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB))
					confirmState = SystemConstants.statusO;
				else
					confirmState = SystemConstants.statusR;
				
				if(m.getLastEventDateTime(confirmState) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(confirmState).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				
				List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleManager, true);
				if(comments != null && comments.size() > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("accepted")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				if(m.getLastEventDateTime(SystemConstants.statusA) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusA).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				
				List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleManager, true);
				if(comments != null && comments.size() > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("published")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				
				if(m.getLastEventDateTime(SystemConstants.statusP) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusP).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleManager, true);
				if(comments != null && comments.size() > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("withdrawn")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				
				
				String confirmState = null;
				if(journal.getType().equals(SystemConstants.journalTypeA) || journal.getType().equals(SystemConstants.journalTypeB))
					confirmState = SystemConstants.statusO;
				else
					confirmState = SystemConstants.statusR;
				
				if(m.getLastEventDateTime(confirmState) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(confirmState).getDate().toString());
				else
					dResponse.setAaData(i, index++, null);
				
				List<Comment> comments = commentDao.findEditorialMessages(m.getId(), user.getId(), SystemConstants.roleManager, true);
				if(comments != null && comments.size() > 0) {
					String commentString = "<a onClick='commentsView(" + m.getId() + ");'><i class='fa fa-comments-o'></i></a>";
					dResponse.setAaData(i, index++, commentString);
				} else
					dResponse.setAaData(i, index++, null);
			}
			
			if(!pageType.equals("beingSubmitted") && !pageType.equals("published"))
				dResponse.setAaData(i, index++, systemUtil.getStatusDatatableLabel(m.getStatus(), locale));
			
			if(pageType.equals("submitted") || pageType.equals("revisionSubmitted")) {
				String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='viewManuscript(" + m.getId() + ", \"" + pageType + "\", \"summary\");'/>" +
										messageSource.getMessage("system.confirmDecline", null , locale) + "</button>");
				
				//actionString += ("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='manageFiles(" + m.getId() + ");'/>" +
				//		messageSource.getMessage("manager.action.manageFiles", null , locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionString);
				else
					dResponse.setAaData(i, index++, null);
			} else if (pageType.equals("revisionRequested")) {
				String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='extendDueDate(" + m.getId() + ");'/>");
				if(m.isDueDateExtendRequest())
					actionString += (messageSource.getMessage("author.action.extendDueDateRequestedByAuthor", null , locale) + "</button>");
				else
					actionString += (messageSource.getMessage("author.action.extendDueDate", null , locale) + "</button>");
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionString);
				else
					dResponse.setAaData(i, index++, null);
			
			} else if(pageType.equals("accepted") && m.getStatus().equals(SystemConstants.statusM)) {
				if(m.isCameraReadyConfirm()) {
					String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='viewManuscript(" + m.getId() + ", \"" + pageType + "\", \"galleryProof\");'/>" +
							messageSource.getMessage("manager.action.manageGalleryProof", null , locale) + "</button>");
					dResponse.setAaData(i, index++, actionString);
				} else {
					String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='viewManuscript(" + m.getId() + ", \"" + pageType + "\", \"cameraReady\");'/>" + 
											messageSource.getMessage("manager.action.manageCameraReady", null , locale) + "</button>");
					if(journal.isPaid())
						dResponse.setAaData(i, index++, actionString);
					else
						dResponse.setAaData(i, index++, null);
				}
			} else if(pageType.equals("accepted") && m.getStatus().equals(SystemConstants.statusG)) {
				if(m.isGalleryProofConfirm()) {
					String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width100' onClick='viewManuscript(" + m.getId() + ", \"" + pageType + "\", \"galleryProof\");'/>" +
							messageSource.getMessage("manager.action.changeToPub", null , locale) + "</button>");
					if(journal.isPaid())
						dResponse.setAaData(i, index++, actionString);
					else
						dResponse.setAaData(i, index++, null);
				} else
					dResponse.setAaData(i, index++, null);

			}
			i++;
			number++;
			index = 0;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/extendDueDate", method=RequestMethod.GET)
	public ModelAndView extendDueDate(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(37, manuscript, journal, null, request, locale);
		mav.addObject("journal", journal);
		mav.addObject("emailMessage", emailMessage);
		SimpleDateFormat sdf = null;
		if(journal.getLanguageCode().equals("ko"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		String requestedDueDate = sdf.format(manuscript.getRevisionDueDate());
		mav.addObject("requestedDueDate", requestedDueDate);
		
		EventDateTime edt = manuscript.getLastEventDateTime(SystemConstants.statusD);
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		model.addAttribute("jc", jc);
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		calendar.setTime(edt.getDate());
		
		calendar.add(Calendar.DATE, jc.getResubmitDuration());
		
		
		String defaultDueDate = sdf.format(calendar.getTime());
		mav.addObject("defaultDueDate", defaultDueDate);
		boolean requested = manuscript.isDueDateExtendRequest();
		mav.addObject("requested", requested);
		mav.addObject("manuscript", manuscript);
		mav.setViewName("manager.manuscripts.dueDateEmailForm");
		return mav;
	}
	
	@RequestMapping(value="/manuscripts/extendDueDate", method=RequestMethod.POST)
	public @ResponseBody ModelAndView extendDueDate(Model model, HttpServletRequest request, Locale locale,
			@ModelAttribute("emailMessage") EmailMessage emailMessage, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @RequestParam(value="dateString", required=true) String dateString, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			managerService.extendDueDate(emailMessage, manuscript, journal, request, locale, dateString);
			RedirectView rv = new RedirectView("../manuscripts?pageType=revisionRequested");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@RequestMapping(value="/manuscripts/declineExtendDueDate", method=RequestMethod.POST)
	public @ResponseBody ModelAndView declineExtendDueDate(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		ModelAndView mav = new ModelAndView();
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.declineExtendingDueDate(manuscript, journal, request, locale);
		RedirectView rv = new RedirectView("../manuscripts?pageType=revisionRequested");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;

	}
	
/*	//TODO
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/uploadFileForm", method=RequestMethod.GET)
	public String uploadFileForm(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId") int manuscriptId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		model.addAttribute("jc", jc);
		
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		model.addAttribute("manuscript", manuscript);
		List<FileDesignation> fileDesignations = new LinkedList<FileDesignation>();
		for(int i=0; i<FileDesignation.values().length; i++)
			fileDesignations.add(FileDesignation.getType(i));

		model.addAttribute("fileDesignations", fileDesignations);
		return "manager.manuscripts.uploadFileForm";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/uploadedFileTable", method=RequestMethod.GET)
	public String uploadedFileTable(Model model, HttpServletRequest request, @RequestParam(value="manuscriptId") int manuscriptId) {
		
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		model.addAttribute("manuscript", manuscript);
		return "manager.manuscripts.uploadedFileTable";
		
	}
	
	
	@RequestMapping(value = "/manuscripts/additionalUploadedFileTable", method=RequestMethod.GET)
	public String additionalUploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId") int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		model.addAttribute("manuscript", manuscript);
		return "manager.manuscripts.additionalUploadedFileTable";
		
	}
	
	
	//TODO
	@RequestMapping(value="/manuscripts/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean upload(HttpServletRequest request, 
			Principal principal,
			MultipartHttpServletRequest req,
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="manuscriptId") int manuscriptId,
			@RequestParam(value="designation") String designation) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		try {
			fileService.processManuscriptFile(f, jnid, manuscript, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@RequestMapping(value="/manuscripts/additionalUpload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean additionalUpload(HttpServletRequest request, Principal principal, MultipartHttpServletRequest req, 
			@RequestParam(value="designation") String designation,
			@RequestParam(value="manuscriptId") int manuscriptId,
			@PathVariable(value="jnid") String jnid) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		try {
			fileService.processManuscriptFile(f, jnid, manuscript, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}*/
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/returnBack", method=RequestMethod.GET)
	public ModelAndView returnBack(Model model, HttpServletRequest request,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleManager)) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			manuscript.setManager(user);
			manuscript.setManagerUserId(user.getId());

			EmailMessage emailMessage = null;
			if(manuscript.getStatus().equals(SystemConstants.statusI)) 
				emailMessage = emailService.getGeneralEmailMessage(4, manuscript, journal, null, request, locale);
			else if(manuscript.getStatus().equals(SystemConstants.statusV))
				emailMessage = emailService.getGeneralEmailMessage(5, manuscript, journal, null, request, locale);
			
			mav.addObject("emailMessage", emailMessage);
			mav.setViewName("manager.manuscripts.returnBackEmailForm");
			return mav;
		}
		System.out.println("not authorized");
		mav.setViewName("../manuscripts");
		return mav;
	}

	@RequestMapping(value="/manuscripts/returnBack", method=RequestMethod.POST)
	public @ResponseBody ModelAndView returnBack(Model model, HttpServletRequest request, Locale locale,
			@ModelAttribute("emailMessage") EmailMessage emailMessage, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, @RequestParam(value="comments", required=true) String comments, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			manuscript.setManager(user);
			manuscript.setManagerUserId(user.getId());
			managerService.returnBackManuscript(manuscript, journal, emailMessage, comments, request, locale);
			RedirectView rv = new RedirectView("../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@RequestMapping(value="/manuscripts/confirm", method=RequestMethod.POST)
	public @ResponseBody Boolean confirm(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="editorUserId", required=true) int editorUserId, Locale locale) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.confirmManuscript(manuscript, user, journal, editorUserId, request, locale);
		return true;
	}
	
	@RequestMapping(value="/manuscripts/revisedConfirm", method=RequestMethod.POST)
	public @ResponseBody Boolean revisedConfirm(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		SystemUser manager = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.confirmManuscript(manuscript, manager, journal, 0, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/cameraReady/cameraReady", method=RequestMethod.GET)
	public String cameraReady(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		model.addAttribute("manuscript", m);
		model.addAttribute("pageType", pageType);
		return "manager.manuscripts.cameraReady.cameraReady";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/cameraReady/uploadedFileTable", method=RequestMethod.GET)
	public String cameraReadyUploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		int maxRevision = m.getCameraReadyRevision();
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<CameraReadyFileDesignation.values().length; i++)
			designations.add(CameraReadyFileDesignation.getType(i).name());
		
		List<UploadedFile> cameraReadyFiles = fileService.getFilesUploadedByCoAuthors(manuscriptId, designations);
		for(UploadedFile f: cameraReadyFiles)
			if(f.getCameraReadyRevision() > maxRevision)
				maxRevision = f.getCameraReadyRevision();
		
		List<Integer> revisionIndices = new ArrayList<Integer>();
		for(int i=maxRevision; i>=0; i--)
			revisionIndices.add(i);
		model.addAttribute("revisionIndices", revisionIndices);
		model.addAttribute("maxRevision", maxRevision);
		
		model.addAttribute("cameraReadyFiles", cameraReadyFiles);
		model.addAttribute("manuscript", m);
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		List<Comment> comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleMember, false);
		if(comments != null)
			Collections.sort(comments);
		model.addAttribute("comments", comments);
		model.addAttribute("pageType", pageType);
		return "manager.manuscripts.cameraReady.uploadedFileTable";
	}
	
	@RequestMapping(value="/manuscripts/cameraReady/confirm", method=RequestMethod.POST)
	public @ResponseBody Boolean cameraReadyConfirm(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		SystemUser manager = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.confirmManuscript(manuscript, manager, journal, 0, request, locale);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/cameraReady/returnBack", method=RequestMethod.GET)
	public String cameraReadyReturnBack(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		model.addAttribute("manuscript", manuscript);
		Comment comment = new Comment();
		model.addAttribute("comment", comment);
		EmailMessage emailMessage = emailService.getGeneralEmailMessage(44, manuscript, journal, null, request, locale);
		model.addAttribute("emailMessage", emailMessage);
		return "manager.manuscripts.cameraReady.returnBackEmailForm";
	}
	
	@RequestMapping(value="/manuscripts/cameraReady/returnBack", method=RequestMethod.POST)
	public @ResponseBody ModelAndView cameraRreturnBack(@RequestParam(value="manuscriptId", required=true) int manuscriptId, 
			@RequestParam(value="subject", required=true) String subject, 
			@RequestParam(value="body", required=true) String body, 
			@ModelAttribute Comment comment, 
			BindingResult result, 
			HttpServletRequest request, Locale locale,
			Model model) {
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			System.out.println("binding error");
			RedirectView rv = new RedirectView("../../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.EMAIL_BUILD);
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			EmailMessage emailMessage = new EmailMessage();
			emailMessage.setSubject(subject);
			emailMessage.setBody(body);
			managerService.returnBackCameraReady(comment, user, manuscript, journal, emailMessage, request, locale);
			RedirectView rv = new RedirectView("../../manuscripts");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}

	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/galleryProof/galleryProof", method=RequestMethod.GET)
	public String galleryProof(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		model.addAttribute("manuscript", m);
		model.addAttribute("pageType", pageType);
		return "manager.manuscripts.galleryProof.galleryProof";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/{pageType}/galleryProof/uploadedFileTable", method=RequestMethod.GET)
	public String galleryProofUploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId,
			@PathVariable(value="pageType") String pageType) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		
		List<String> designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeG);
		List<UploadedFile> galleryProofFiles = fileService.getFiles(manuscriptId, m.getManagerUserId(), m.getRevisionCount(), designations);
		int maxRevision = 0;
		for(UploadedFile f: galleryProofFiles)
			if(f.getGalleryProofRevision() > maxRevision)
				maxRevision = f.getGalleryProofRevision();
		
		List<Integer> revisionIndices = new ArrayList<Integer>();
		for(int i=maxRevision; i>=0; i--)
			revisionIndices.add(i);
		
		model.addAttribute("revisionIndices", revisionIndices);
		model.addAttribute("maxRevision", maxRevision);
		model.addAttribute("galleryProofFiles", galleryProofFiles);
		model.addAttribute("manuscript", m);
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		List<Comment> comments = commentDao.findEditorialMessages(manuscriptId, user.getId(), SystemConstants.roleManager, true);
		if(comments != null)
			Collections.sort(comments);
		model.addAttribute("comments", comments);
		
		designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeA);
		List<UploadedFile> galleryProofCorrectionFiles = fileService.getFilesUploadedByCoAuthors(manuscriptId, designations);
		model.addAttribute("galleryProofCorrectionFiles",galleryProofCorrectionFiles);
		model.addAttribute("pageType", pageType);
		return "manager.manuscripts.galleryProof.uploadedFileTable";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscripts/galleryProof/uploadedFileCount", method=RequestMethod.GET)
	public @ResponseBody String galleryProofUploadedFileCount(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		List<String> designations = new ArrayList<String>();
		designations.add(SystemConstants.fileTypeG);
		int fileUploadedCount = fileService.numGalleryProofFileUploadedCount(m, designations);
		model.addAttribute("fileUploadedCount", fileUploadedCount);
		return Integer.toString(fileUploadedCount);
	}
	
	@RequestMapping(value="/manuscripts/galleryProof/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean galleryProofUpload(HttpServletRequest request, 
			Principal principal, 
			MultipartHttpServletRequest req, 
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");

		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		try {
			fileService.processManuscriptFile(f, jnid, m, SystemConstants.fileTypeG);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return true;
	}
	
	@RequestMapping(value="/manuscripts/galleryProof/confirm", method=RequestMethod.POST)
	public @ResponseBody Boolean galleryProofConfirm(Model model, HttpServletRequest request, 
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		Manuscript manuscript = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.VIEW_BUILD);
		SystemUser manager = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.confirmManuscript(manuscript, manager, journal, 0, request, locale);
		return true;
	}
	
	@RequestMapping(value = "/manuscripts/galleryProof/publish", method=RequestMethod.POST)
	public @ResponseBody ModelAndView galleryProofReturnBack(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		ModelAndView mav = new ModelAndView();
		if(authorityService.hasRole(SystemConstants.roleManager)) {
			Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			manuscriptService.publishAction(m);
		}
		RedirectView rv = new RedirectView("../../manuscripts");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/backup", method=RequestMethod.GET)
	public ModelAndView backup(Model model, HttpServletRequest request, Locale locale) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("statusTooltipData", systemUtil.getStatusTooltipData(locale));
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		
		mav.addObject("allStatus", journalService.getAllStatus(journal));
		
		List<ManuscriptColumn> indexNames = new ArrayList<ManuscriptColumn>();
		for(int i=0; i<ManuscriptColumn.values().length; i++)
			indexNames.add(ManuscriptColumn.getType(i));
		mav.addObject("indexNames", indexNames);
		mav.addObject("pageType", "manuscriptsList");
		mav.setViewName("manager.configuration.backup.backup");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/backup/manuscripts", method=RequestMethod.GET)
	public ModelAndView backupManuscripts(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="num", required=false) String num,
			@RequestParam(value="temporaryId", required=false) String temporaryId,
			@RequestParam(value="submitId", required=false) String submitId,
			@RequestParam(value="submitter", required=false) String submitter,
			@RequestParam(value="institution", required=false) String institution,
			@RequestParam(value="revision", required=false) String revision,
			@RequestParam(value="title", required=false) String title,
			@RequestParam(value="submitDate", required=false) String submitDate,
			@RequestParam(value="acceptDate", required=false) String acceptDate,
			@RequestParam(value="reviewResult", required=false) String reviewResult,
			@RequestParam(value="reviewers", required=false) String reviewers,
			@RequestParam(value="chiefEditor", required=false) String chiefEditor,
			@RequestParam(value="manager", required=false) String manager,
			@RequestParam(value="associateEditor", required=false) String associateEditor,
			@RequestParam(value="guestEditor", required=false) String guestEditor,
			@RequestParam(value="status", required=false) String status) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("statusTooltipData", systemUtil.getStatusTooltipData(locale));
		mav.addObject("pageType", "manuscriptsList");
		int totalViewIndex = -1;
		if(num != null && num.equals("1")) {
			mav.addObject("num", 1);
			totalViewIndex++;
		} else
			mav.addObject("num", 0);
		
		if(temporaryId != null && temporaryId.equals("1")) {
			mav.addObject("temporaryId", 1);
			totalViewIndex++;
		} else
			mav.addObject("temporaryId", 0);
		
		if(submitId != null && submitId.equals("1")) {
			mav.addObject("submitId", 1);
			totalViewIndex++;
		} else
			mav.addObject("submitId", 0);
		
		if(submitter != null && submitter.equals("1")) {
			mav.addObject("submitter", 1);
			totalViewIndex++;
		} else
			mav.addObject("submitter", 0);
		
		if(institution != null && institution.equals("1")) {
			mav.addObject("institution", 1);
			totalViewIndex++;
		} else
			mav.addObject("institution", 0);
		
		if(revision != null && revision.equals("1")) {
			mav.addObject("revision", 1);
			totalViewIndex++;
		} else
			mav.addObject("revision", 0);
		
		if(title != null && title.equals("1")) {
			mav.addObject("title", 1);
			totalViewIndex++;
		} else
			mav.addObject("title", 0);
		
		if(submitDate != null && submitDate.equals("1")) {
			mav.addObject("submitDate", 1);
			totalViewIndex++;
		} else
			mav.addObject("submitDate", 0);
		
		if(acceptDate != null && acceptDate.equals("1")) {
			mav.addObject("acceptDate", 1);
			totalViewIndex++;
		} else
			mav.addObject("acceptDate", 0);
		
		if(reviewResult != null && reviewResult.equals("1")) {
			mav.addObject("reviewResult", 1);
			totalViewIndex++;
		} else
			mav.addObject("reviewResult", 0);
		
		if(reviewers != null && reviewers.equals("1")) {
			mav.addObject("reviewers", 1);
			totalViewIndex++;
		} else
			mav.addObject("reviewers", 0);
		
		if(chiefEditor != null && chiefEditor.equals("1")) {
			mav.addObject("chiefEditor", 1);
			totalViewIndex++;
		} else
			mav.addObject("chiefEditor", 0);
		
		if(manager != null && manager.equals("1")) {
			mav.addObject("manager", 1);
			totalViewIndex++;
		} else
			mav.addObject("manager", 0);
		
		if(associateEditor != null && associateEditor.equals("1")) {
			mav.addObject("associateEditor", 1);
			totalViewIndex++;
		} else
			mav.addObject("associateEditor", 0);
		
		if(guestEditor != null && guestEditor.equals("1")) {
			mav.addObject("guestEditor", 1);
			totalViewIndex++;
		} else
			mav.addObject("guestEditor", 0);
		
		if(status != null && status.equals("1")) {
			mav.addObject("status", 1);
			totalViewIndex++;
		} else
			mav.addObject("status", 0);
		
		mav.addObject("totalViewIndex", totalViewIndex);
		mav.setViewName("manager.configuration.backup.manuscriptTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/backup/getPapers", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String getBackupPapers(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="num", required=false) String num,
			@RequestParam(value="temporaryId", required=false) String temporaryId,
			@RequestParam(value="submitId", required=false) String submitId,
			@RequestParam(value="submitter", required=false) String submitter,
			@RequestParam(value="institution", required=false) String institution,
			@RequestParam(value="revision", required=false) String revision,
			@RequestParam(value="title", required=false) String title,
			@RequestParam(value="submitDate", required=false) String submitDate,
			@RequestParam(value="acceptDate", required=false) String acceptDate,
			@RequestParam(value="reviewResult", required=false) String reviewResult,
			@RequestParam(value="reviewers", required=false) String reviewers,
			@RequestParam(value="chiefEditor", required=false) String chiefEditor,
			@RequestParam(value="manager", required=false) String manager,
			@RequestParam(value="associateEditor", required=false) String associateEditor,
			@RequestParam(value="guestEditor", required=false) String guestEditor,
			@RequestParam(value="status", required=false) String status) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int iTotalRecords = manuscriptService.numSubmittedManuscripts(0, journal.getId(), null);
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> indexNames = new ArrayList<String>();
		List<String> statuses = journalService.getAllStatus(journal);
		int parameterIndex = 0;
		int submitDateIndex = 0;
		int acceptDateIndex = 0;
		
		List<Manuscript> manuscripts = null;
		
		if(num != null && num.equals("1")) {
			sortableColumnNames.add(null);
			indexNames.add("num");
			parameterIndex++;
		} 
		if(temporaryId != null && temporaryId.equals("1")) {
			sortableColumnNames.add("M.ID");
			indexNames.add("temporaryId");
			parameterIndex++;
		}
		if(submitId != null && submitId.equals("1")) {
			sortableColumnNames.add("M.SUBMIT_ID");
			indexNames.add("submitId");
			parameterIndex++;
		} 
		if(submitter != null && submitter.equals("1")) {
			sortableColumnNames.add("C.FIRST_NAME");
			indexNames.add("submitter");
			parameterIndex++;
		}
		if(institution != null && institution.equals("1")) {
			sortableColumnNames.add("C.INSTITUTION");
			indexNames.add("institution");
			parameterIndex++;
		}
		if(revision != null && revision.equals("1")) {
			sortableColumnNames.add("M.REVISION_COUNT");
			indexNames.add("revision");
			parameterIndex++;
		} 
		if(title != null && title.equals("1")) {
			sortableColumnNames.add("M.TITLE");
			indexNames.add("title");
			parameterIndex++;
		} 
		if(submitDate != null && submitDate.equals("1")) {
			sortableColumnNames.add("M.EVENT_DATE");	//Submission Date
			indexNames.add("submitDate");
			submitDateIndex = parameterIndex;
			parameterIndex++;
		}
		if(acceptDate != null && acceptDate.equals("1")) {
			sortableColumnNames.add("M.EVENT_DATE");	//Acceptance Date
			indexNames.add("acceptDate");
			acceptDateIndex = parameterIndex;
			parameterIndex++;
		}

		manuscripts = manuscriptService.getSubmittedManuscriptsFromManagerConfiguration(journal, statuses, dRequest, iTotalDisplayRecords, sortableColumnNames, indexNames, SystemConstants.TABLE_BUILD);
		
		List<Manuscript> filteredManuscripts = null;
		List<Manuscript> dateFilteredManuscripts = null;
		if(submitDate != null && submitDate.equals("1")) {
			if(dRequest.getiSortCol()[0] == submitDateIndex) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else
								return 0;
						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
							else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			} 
		}
		if(acceptDate != null && acceptDate.equals("1")) {
			if(dRequest.getiSortCol()[0] == acceptDateIndex) {
				Collections.sort(manuscripts, new Comparator<Manuscript>() {
					@Override
					public int compare(Manuscript o1, Manuscript o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else
								return 0;
						} else {
							if(o1.getLastEventDateTime(SystemConstants.statusA) != null && o2.getLastEventDateTime(SystemConstants.statusA) != null)
								return -1 * o1.getLastEventDateTime(SystemConstants.statusA).compareTo(o2.getLastEventDateTime(SystemConstants.statusA));
							else if(o1.getLastEventDateTime(SystemConstants.statusA) == null)
								return 1;
							else if(o2.getLastEventDateTime(SystemConstants.statusA) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		}
		String submitDateString = null;
		String submitDateStatus = null;
		String acceptDateString = null;
		String acceptDateStatus = null;
		if(submitDateIndex != 0 && !dRequest.getsSearch()[submitDateIndex].equals("")) {
			submitDateString = dRequest.getsSearch()[submitDateIndex];
			submitDateStatus = SystemConstants.statusI;
		} 
		
		if(acceptDateIndex != 0 && !dRequest.getsSearch()[acceptDateIndex].equals("")) {
			acceptDateString = dRequest.getsSearch()[acceptDateIndex];
			acceptDateStatus = SystemConstants.statusA;
		}
		if(submitDateString != null) {
			dateFilteredManuscripts = new ArrayList<Manuscript>();
			try {
				String[] submitDateStrings = submitDateString.split("_");
				String from = submitDateStrings[0];
				String to = submitDateStrings[1];
				java.sql.Date fromDate = java.sql.Date.valueOf(from); 
				java.sql.Date toDate = java.sql.Date.valueOf(to); 
				for(Manuscript manuscript: manuscripts) {
					EventDateTime edt = manuscript.getLastEventDateTime(submitDateStatus);
					if(edt != null) {
						Date date = edt.getDate();
						if((fromDate.compareTo(date) == -1 || fromDate.compareTo(date) == 0) && 
								(toDate.compareTo(date) == 1 || toDate.compareTo(date) == 0)) {
							dateFilteredManuscripts.add(manuscript);
						}
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			manuscripts = dateFilteredManuscripts;
			iTotalDisplayRecords[0] = dateFilteredManuscripts.size();
			
		}
		
		if(acceptDateString != null) {
			dateFilteredManuscripts = new ArrayList<Manuscript>();
			try {
				String[] acceptDateStrings = acceptDateString.split("_");
				String from = acceptDateStrings[0];
				String to = acceptDateStrings[1];
				java.sql.Date fromDate = java.sql.Date.valueOf(from); 
				java.sql.Date toDate = java.sql.Date.valueOf(to); 
				for(Manuscript manuscript: manuscripts) {
					EventDateTime edt = manuscript.getLastEventDateTime(acceptDateStatus);
					if(edt != null) {
						Date date = edt.getDate();
						if((fromDate.compareTo(date) == -1 || fromDate.compareTo(date) == 0) && 
								(toDate.compareTo(date) == 1 || toDate.compareTo(date) == 0)) {
							dateFilteredManuscripts.add(manuscript);
						}
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			manuscripts = dateFilteredManuscripts;
			iTotalDisplayRecords[0] = dateFilteredManuscripts.size();
		}

		if(manuscripts.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredManuscripts = manuscripts;
		else
			filteredManuscripts = manuscripts.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > manuscripts.size() 
					? dRequest.getiDisplayStart() + (manuscripts.size() - dRequest.getiDisplayStart())
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredManuscripts.size());
		
		int i = 0, index = 0;
		int number = dRequest.getiDisplayStart() + 1;
		for (Manuscript m: filteredManuscripts) {
			if(num != null && num.equals("1"))
				dResponse.setAaData(i, index++, Integer.toString(number));	//No.
			if(temporaryId != null && temporaryId.equals("1")) {
				if(m.getStatus().equals(SystemConstants.statusB) || m.getStatus().equals(SystemConstants.statusI))
					dResponse.setAaData(i, index++, Integer.toString(m.getId()));	//TemporaryId
				else
					dResponse.setAaData(i, index++, null);	//TemporaryId
			}
			
			if(submitId != null && submitId.equals("1")) {
				if(m.getSubmitId() != null)
					dResponse.setAaData(i, index++, m.getSubmitId());	//SubmitId
				else
					dResponse.setAaData(i, index++, null);
			}
			
			if(submitter != null && submitter.equals("1")) {
				SystemUser submitterUser = userService.getById(m.getUserId());
				String submitterString = null;
				if(journal.getLanguageCode().equals("ko") && submitterUser.getContact().getLocalFullName() != null && !submitterUser.getContact().getLocalFullName().equals(""))
					submitterString = submitterUser.getContact().getLocalFullName();
				else
					submitterString = submitterUser.getContact().getFirstName() + "<br/> " + submitterUser.getContact().getLastName();
				dResponse.setAaData(i, index++, submitterString);
			}
			
			if(institution != null && institution.equals("1")) {
				SystemUser submitterUser = userService.getById(m.getUserId());
				String institutionString = null;
				if(journal.getLanguageCode().equals("ko") && submitterUser.getContact().getLocalInstitution() != null && !submitterUser.getContact().getLocalInstitution().equals(""))
					institutionString = submitterUser.getContact().getLocalInstitution();
				else
					institutionString = submitterUser.getContact().getInstitution();
				dResponse.setAaData(i, index++, institutionString);
			}
			
			if(revision != null && revision.equals("1")) {
				if(m.getRevisionCount() == 0)
					dResponse.setAaData(i, index++, messageSource.getMessage("system.original", null, locale));
				else
					dResponse.setAaData(i, index++, messageSource.getMessage("system.revision", null, locale) + " #" + m.getRevisionCount());
			}
					
			if(title != null && title.equals("1")) {
				if(m.getTitle() == null)
					dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
				else {
					String invitedString = "";
					if(m.isInvite())
						invitedString  = "<span class='required'>*</span>(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
					String titleUrl = "<a onClick='viewManuscript(" + m.getId() +  ", \"manuscriptsList\", \"summary\");'>" + invitedString + m.getTitle() + "</a>";
					dResponse.setAaData(i, index++, titleUrl);
				}
			}
			
			if(submitDate != null && submitDate.equals("1")) {
				if(m.getLastEventDateTime(SystemConstants.statusI) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());	//Submission Date
				else
					dResponse.setAaData(i, index++, null);
			}
			if(acceptDate != null && acceptDate.equals("1")) {
				if(m.getLastEventDateTime(SystemConstants.statusA) != null)
					dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusA).getDate().toString());	//Acceptance Date
				else
					dResponse.setAaData(i, index++, null);
			}
			if(reviewResult != null && reviewResult.equals("1")) {
				StringBuffer reviewResultStringBuffer = new StringBuffer();
				if(m.getReviewList() != null && m.getReviewList().size() > 0) {
					for(List<Review> reviews : m.getReviewList()) {
						int count = 1;
						for(Review review: reviews) {
							if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerC)) {
								reviewResultStringBuffer.append("#" + count);
								if(review.getOverall() == 5)
									reviewResultStringBuffer.append(" " + messageSource.getMessage("reviewResult.strongAccept", null , locale));
								else if(review.getOverall() == 4)
									reviewResultStringBuffer.append(" " + messageSource.getMessage("reviewResult.accept", null , locale));
								else if(review.getOverall() == 3)
									reviewResultStringBuffer.append(" " + messageSource.getMessage("reviewResult.marginal", null , locale));
								else if(review.getOverall() == 2)
									reviewResultStringBuffer.append(" " + messageSource.getMessage("reviewResult.reject", null , locale));
								else if(review.getOverall() == 1)
									reviewResultStringBuffer.append(" " + messageSource.getMessage("reviewResult.strongReject", null , locale));
								count++;
								reviewResultStringBuffer.append("<br/>");
							}
						}
					}
				}
				dResponse.setAaData(i, index++, reviewResultStringBuffer.toString());
			}
			
			if(reviewers != null && reviewers.equals("1")) {
				StringBuffer reviewersStringBuffer = new StringBuffer();
				if(m.getReviewList() != null && m.getReviewList().size() > 0) {
					for(List<Review> reviews : m.getReviewList()) {
						int count = 1;
						for(Review review: reviews) {
							if(m.getRevisionCount() == review.getRevisionCount() && review.getStatus().equals(SystemConstants.reviewerC)) {
								reviewersStringBuffer.append("#" + count);
								int reviewerUserId = review.getUserId();
								String reviewerUserName = contactService.getFullName(userService.getById(reviewerUserId).getContact(), journal.getLanguageCode());
								reviewersStringBuffer.append(" " + reviewerUserName);
								count++;
								reviewersStringBuffer.append("<br/>");
							}
						}
					}
				}
				dResponse.setAaData(i, index++, reviewersStringBuffer.toString());
			}
			
			if(chiefEditor != null && chiefEditor.equals("1")) {
				if(m.getChiefEditorUserId() != 0) {
					SystemUser chiefUser = userService.getById(m.getChiefEditorUserId());
					dResponse.setAaData(i, index++, contactService.getFullName(chiefUser.getContact(), journal.getLanguageCode()));
				} else
					dResponse.setAaData(i, index++, null);
			}
			if(manager != null && manager.equals("1")) {
				if(m.getManagerUserId() != 0) {
					SystemUser managerUser = userService.getById(m.getManagerUserId());
					dResponse.setAaData(i, index++, contactService.getFullName(managerUser.getContact(), journal.getLanguageCode()));
				} else
					dResponse.setAaData(i, index++, null);
			}
			if(associateEditor != null && associateEditor.equals("1")) {
				if(m.getAssociateEditorUserId() != 0) {
					SystemUser aeUser = userService.getById(m.getAssociateEditorUserId());
					dResponse.setAaData(i, index++, contactService.getFullName(aeUser.getContact(), journal.getLanguageCode()));
				} else
					dResponse.setAaData(i, index++, null);
			}
			if(guestEditor != null && guestEditor.equals("1")) {
				if(m.getGuestEditorUserId() != 0) {
					SystemUser geUser = userService.getById(m.getGuestEditorUserId());
					dResponse.setAaData(i, index++, contactService.getFullName(geUser.getContact(), journal.getLanguageCode()));
				} else
					dResponse.setAaData(i, index++, null);
			}
			if(status != null && status.equals("1"))
				dResponse.setAaData(i, index++, messageSource.getMessage("system.title" + m.getStatus(), null, locale));
			
			i++;
			number++;
			index = 0;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/accounts/manageAccounts", method=RequestMethod.GET)
	public String manageAccounts(HttpServletRequest request, HttpServletResponse response, Locale locale) {
		return "manager.configuration.accounts.manageAccounts";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/accounts/accountsTable",  method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String accountsTable(HttpServletRequest request, Locale locale) {
		DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "users");
		int[] iTotalDisplayRecords = new int[1];

		List<SystemUser> users = userService.getManagerAccountList(dRequest, iTotalDisplayRecords, locale, journal.getId());
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], users.size());
		
		int i = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		
		for (SystemUser user : users) {
			sb.append("<button type='button' class='btn btn-default btn-xs' onClick='editAccount(" + user.getId() + ");'/>" + messageSource.getMessage("system.edit", null , locale) + "</button>");
			dResponse.setAaData(i, 0, Integer.toString(number));
			dResponse.setAaData(i, 1, user.getUsername());
			dResponse.setAaData(i, 2, contactService.getFullName(user.getContact(), journal.getLanguageCode()));
			dResponse.setAaData(i, 3, user.getContact().getInstitution(journal.getLanguageCode()));
			dResponse.setAaData(i, 4, user.getContact().getDepartment(journal.getLanguageCode()));
			dResponse.setAaData(i, 5, user.getContact().getCountryCode().getName());
			dResponse.setAaData(i, 6, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/accounts/editAccount", method=RequestMethod.GET)
	public ModelAndView editAccount(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="userId", required=true) int userId) {
		ModelAndView mav = new ModelAndView();
		SystemUser editableUser = userService.getById(userId);
		mav.addObject("editableUser", editableUser);
		
		Map<String,String> countries = null;
		try {
			countries = getCountryMap(editableUser.getContact().getCountry());
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i=0; i<DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		mav.addObject("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i=0; i<SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		mav.addObject("salutationDesignations", salutationDesignations);			
		
		List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
		for (int i=0; i<LocalJobTitleDesignation.values().length; i++)
			localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
		
		mav.addObject("localJobTitleDesignations", localJobTitleDesignations);
		mav.addObject("countries", countries);
		mav.setViewName("manager.configuration.accounts.editAccountForm");
		return mav;
	}
	
	@RequestMapping(value="/configuration/accounts/saveAccount", method=RequestMethod.POST)
	public @ResponseBody String saveAccount(@ModelAttribute("user") SystemUser user, BindingResult result, Locale locale, Model model, HttpServletRequest request,
			@RequestParam(value="email", required=false) String email) {
		SystemUser storedUser = this.userService.getByUsername(user.getUsername());
		Contact oldContactInfo = storedUser.getContact();
		Contact newContactInfo = user.getContact();
		
		if (email != null && !storedUser.getUsername().equals(email)) {
			storedUser.setUsername(email);
			userService.update(storedUser);
			//TODO session
		}
		if (oldContactInfo.getFirstName() == null || !oldContactInfo.getFirstName().equals(newContactInfo.getFirstName()))
			oldContactInfo.setFirstName(newContactInfo.getFirstName());
		
		if (oldContactInfo.getLastName() == null || !oldContactInfo.getLastName().equals(newContactInfo.getLastName()))
			oldContactInfo.setLastName(newContactInfo.getLastName());
		
		if (oldContactInfo.getDegree() == null || !oldContactInfo.getDegree().equals(newContactInfo.getDegree()))
			oldContactInfo.setDegree(newContactInfo.getDegree());
		
		if (oldContactInfo.getSalutation() == null || !oldContactInfo.getSalutation().equals(newContactInfo.getSalutation()))
			oldContactInfo.setSalutation(newContactInfo.getSalutation());
		
		if (oldContactInfo.getInstitution() == null || !oldContactInfo.getInstitution().equals(newContactInfo.getInstitution()))
			oldContactInfo.setInstitution(newContactInfo.getInstitution());
		
		if (oldContactInfo.getDepartment() == null || !oldContactInfo.getDepartment().equals(newContactInfo.getDepartment()))
			oldContactInfo.setDepartment(newContactInfo.getDepartment());
		
		if (oldContactInfo.getCountry() == null ||!oldContactInfo.getCountry().equals(newContactInfo.getCountry()))
			oldContactInfo.setCountry(newContactInfo.getCountry());
		
		if (oldContactInfo.getPhone() == null || !oldContactInfo.getPhone().equals(newContactInfo.getPhone()))
			oldContactInfo.setPhone(newContactInfo.getPhone());
		
		if (oldContactInfo.getMobile() == null || !oldContactInfo.getMobile().equals(newContactInfo.getMobile()))
			oldContactInfo.setMobile(newContactInfo.getMobile());
		
		if (oldContactInfo.getFax() == null || !oldContactInfo.getFax().equals(newContactInfo.getFax()))
			oldContactInfo.setFax(newContactInfo.getFax());
		
		if (oldContactInfo.getWebsite() == null || !oldContactInfo.getWebsite().equals(newContactInfo.getWebsite()))
			oldContactInfo.setWebsite(newContactInfo.getWebsite());
		
		if (oldContactInfo.getAbout() == null || !oldContactInfo.getAbout().equals(newContactInfo.getAbout()))
			oldContactInfo.setAbout(newContactInfo.getAbout());
		
		
		
		if (oldContactInfo.getLocalFullName() == null || !oldContactInfo.getLocalFullName().equals(newContactInfo.getLocalFullName())) {
			oldContactInfo.setLocalFullName(newContactInfo.getLocalFullName());
		}
		if (oldContactInfo.getLocalInstitution() == null || !oldContactInfo.getLocalInstitution().equals(newContactInfo.getLocalInstitution())) {
			oldContactInfo.setLocalInstitution(newContactInfo.getLocalInstitution());
		}
		if (oldContactInfo.getLocalDepartment() == null || !oldContactInfo.getLocalDepartment().equals(newContactInfo.getLocalDepartment())) {
			oldContactInfo.setLocalDepartment(newContactInfo.getLocalDepartment());
		}
		if (oldContactInfo.getLocalJobTitle() == null || !oldContactInfo.getLocalJobTitle().equals(newContactInfo.getLocalJobTitle())) {
			oldContactInfo.setLocalJobTitle(newContactInfo.getLocalJobTitle());
		}
		
		this.contactService.updateKoreanInfo(oldContactInfo);
		
		this.contactService.update(oldContactInfo);
		return "success";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/members/manageMembers", method=RequestMethod.GET)
	public ModelAndView manageEditors(HttpServletRequest request, HttpServletResponse response, Locale locale) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		ModelAndView mav = new ModelAndView();
		
		ChiefEditor chief = new ChiefEditor();
		SystemUser user1 = new SystemUser();
		Contact contact1 = new Contact();
		user1.setContact(contact1);
		chief.setUser(user1);
		mav.addObject("chiefEditor", chief);
		
		Manager manager = new Manager();
		SystemUser user2 = new SystemUser();
		Contact contact2 = new Contact();
		user2.setContact(contact2);
		manager.setUser(user2);
		mav.addObject("manager", manager);
		
		AssociateEditor ae = new AssociateEditor();
		SystemUser user3 = new SystemUser();
		Contact contact3 = new Contact();
		user3.setContact(contact3);
		ae.setUser(user3);
		mav.addObject("associateEditor", ae);
		
		GuestEditor ge = new GuestEditor();
		SystemUser user4 = new SystemUser();
		Contact contact4 = new Contact();
		user4.setContact(contact4);
		ge.setUser(user4);
		mav.addObject("guestEditor", ge);
		
		BoardMember bm = new BoardMember();
		SystemUser user5 = new SystemUser();
		Contact contact5 = new Contact();
		user4.setContact(contact5);
		bm.setUser(user5);
		mav.addObject("boardMember", bm);
		
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i=0; i<DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		mav.addObject("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i=0; i<SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		mav.addObject("salutationDesignations", salutationDesignations);			
		
		List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
		for (int i=0; i<LocalJobTitleDesignation.values().length; i++)
			localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
		
		mav.addObject("localJobTitleDesignations", localJobTitleDesignations);
		mav.addObject("journal", journal);
		
		String[] roleStrings = {"chiefEditor", "manager", "associateEditor", "guestEditor", "boardMember"};
		mav.addObject("roleStrings", roleStrings);
		mav.setViewName("manager.configuration.members.manageMembers");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/members/{role}Table", method=RequestMethod.GET)
	public ModelAndView membersTable(HttpServletRequest request, @PathVariable("role") String role) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		if(role.equals("chiefEditor")) {
			List<ChiefEditor> members = chiefService.getChiefEditorsByJournalId(journal.getId());
			mav.addObject("members", members);
		} else if(role.equals("manager")) {
			List<Manager> members = managerService.getManagersByJournalId(journal.getId());
			mav.addObject("members", members);
		} else if(role.equals("guestEditor")) {
			List<GuestEditor> members = geService.getGuestEditorsByJournalId(journal.getId());
			List<SpecialIssue> specialIssues = specialIssueDao.findByJournalId(journal.getId());
			mav.addObject("specialIssues", specialIssues);
			mav.addObject("members", members);
		} else if(role.equals("boardMember")) {
			List<BoardMember> members = bmService.getBoardMembersByJournalId(journal.getId());
			if(jc.isManageDivision()) {
				List<Division> divisions = journalService.getDivisionsById(journal.getId());
				mav.addObject("divisions", divisions);
			}
			mav.addObject("members", members);
		} else if(role.equals("associateEditor")) {
			List<AssociateEditor> members = aeService.getAssociateEditorsByJournalId(journal.getId());
			if(jc.isManageDivision()) {
				List<Division> divisions = journalService.getDivisionsById(journal.getId());
				mav.addObject("divisions", divisions);
			}
			mav.addObject("members", members);
		}
		mav.addObject("roleString", role);
		String roleStringUpper = role.substring(0,1);
		roleStringUpper = roleStringUpper.toUpperCase();
		roleStringUpper += role.substring(1);
		mav.addObject("roleStringUpper", roleStringUpper);
		mav.setViewName("manager.configuration.members.membersTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/members/{role}CandidateTable",  method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String memberCandidateTable(HttpServletRequest request, Locale locale, @PathVariable("role") String role) {
		DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "users");
		int[] iTotalDisplayRecords = new int[1];
		List<String> preventEmailList = new ArrayList<String>();
		if(role.equals("chiefEditor")) {
			List<ChiefEditor> editors = chiefService.getChiefEditorsByJournalId(journal.getId());
			for(ChiefEditor user: editors)
				preventEmailList.add(user.getUser().getUsername());
		} else if(role.equals("manager")) {
			List<Manager> managerList = managerService.getManagersByJournalId(journal.getId());
			for(Manager manager: managerList)
				preventEmailList.add(manager.getUser().getUsername());
		} else if(role.equals("associateEditor")) {
			List<AssociateEditor> aeList = aeService.getAssociateEditorsByJournalId(journal.getId());
			for(AssociateEditor ae: aeList)
				preventEmailList.add(ae.getUser().getUsername());
		} else if(role.equals("guestEditor")) {
			List<GuestEditor> editors = geService.getGuestEditorsByJournalId(journal.getId());
			for(GuestEditor user: editors)
				preventEmailList.add(user.getUser().getUsername());
		} else if(role.equals("boardMember")) {
			List<BoardMember> boardMembers = bmService.getBoardMembersByJournalId(journal.getId());
			for(BoardMember user: boardMembers)
				preventEmailList.add(user.getUser().getUsername());
		}
		
		String roleStringUpper = role.substring(0,1);
		roleStringUpper = roleStringUpper.toUpperCase();
		roleStringUpper += role.substring(1);

		List<SystemUser> users = userService.getEditorCandidateUsers(dRequest, iTotalDisplayRecords, locale, journal.getId(), preventEmailList);
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], users.size());
		
		int i = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		
		for (SystemUser user : users) {
			sb.append("<input type='hidden' id='userId' value='" + user.getId() + "'/>");
			sb.append("<button type='button' class='btn btn-default btn-xs editorSelectButton' onClick='select(\"" + role + "\", \"" + roleStringUpper + "\"," + user.getId() + ");'/>" + messageSource.getMessage("system.select", null , locale) + "</button>");
			dResponse.setAaData(i, 0, Integer.toString(number));
			dResponse.setAaData(i, 1, user.getUsername());
			dResponse.setAaData(i, 2, contactService.getFullName(user.getContact(), journal.getLanguageCode()));
			dResponse.setAaData(i, 3, user.getContact().getInstitution(journal.getLanguageCode()));
			dResponse.setAaData(i, 4, user.getContact().getCountryCode().getName());
			if(authorityService.hasRole(user, journal.getId(), SystemConstants.roleMember))
				dResponse.setAaData(i, 5, "O");
			else
				dResponse.setAaData(i, 5, null);
			dResponse.setAaData(i, 6, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@RequestMapping(value = "/configuration/members/select{roleStringUpper}", method=RequestMethod.POST)
	public @ResponseBody Boolean selectMember(HttpServletRequest request, Model model, 
			@PathVariable(value="roleStringUpper") String roleStringUpper,
			@RequestParam(value="userId", required=true) int userId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		if(roleStringUpper.equals("ChiefEditor"))
			chiefService.selectChiefEditor(userId, journal.getId());
		else if(roleStringUpper.equals("Manager"))
			managerService.selectManager(userId, journal.getId());
		else if(roleStringUpper.equals("AssociateEditor"))
			aeService.selectAssociateEditor(userId, journal.getId());
		else if(roleStringUpper.equals("GuestEditor"))
			geService.selectGuestEditor(userId, journal.getId());
		else if(roleStringUpper.equals("BoardMember"))
			bmService.selectBoardMember(userId, journal.getId());
		return true;
	}
	
	@RequestMapping(value = "/configuration/members/delete{roleStringUpper}", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteMember(HttpServletRequest request, Model model, 
			@PathVariable(value="roleStringUpper") String roleStringUpper,
			@RequestParam(value="userId", required=true) int userId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		if(roleStringUpper.equals("ChiefEditor"))
			chiefService.deleteChiefEditor(userId, journal.getId());
		else if(roleStringUpper.equals("Manager"))
			managerService.deleteManager(userId, journal.getId());
		else if(roleStringUpper.equals("AssociateEditor"))
			aeService.deleteAssociateEditor(userId, journal.getId());
		else if(roleStringUpper.equals("GuestEditor"))
			geService.deleteGuestEditor(userId, journal.getId());
		else if(roleStringUpper.equals("BoardMember"))
			bmService.deleteBoardMember(userId, journal.getId());
		return true;
	}
	
	@RequestMapping(value = "/configuration/members/signupAssociateEditor", method=RequestMethod.POST)
	public @ResponseBody Boolean aeSubmitUserForm(@ModelAttribute("associateEditor") AssociateEditor ae, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model, Locale locale) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = ae.getUser();
			user.setEnabled(true);
			String randomPassword = userService.generatePassword(8);
			user.setPassword(randomPassword);
			ae.setUser(user);
			ae.setJournalId(journal.getId());
			String[] divisionIds = request.getParameterValues("divisionId");
			List<UserDivision> userDivisions = new ArrayList<UserDivision>();
			if(divisionIds != null) {
				for (String id: divisionIds) {
					int divisionId = Integer.parseInt(id);
					UserDivision userDivision = new UserDivision();
					userDivision.setJournalId(journal.getId());
					userDivision.setDivisionId(divisionId);
					userDivisions.add(userDivision);
				}
			}
			ae.setUserDivisions(userDivisions);
			aeService.createAssociateEditor(ae);
			
			emailService.sendEmailAtAccountCreation(52, (SystemUser)request.getSession().getAttribute("user"), user, journal, randomPassword, request, locale);
			return true;
		}
	}

	@RequestMapping(value = "/configuration/members/setDivision", method=RequestMethod.POST)
	public @ResponseBody Boolean setDivision(HttpServletRequest request, Model model, 
			@RequestParam(value="divisionId", required=true) int divisionId,
			@RequestParam(value="userId", required=true) int userId,
			@RequestParam(value="roleString", required=true) String roleString) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		String role = null;
		if(roleString.equals("associateEditor"))
			role = SystemConstants.roleAEditor;
		else if(roleString.equals("boardMember"))
			role = SystemConstants.roleBMember;
		userDivisionDao.create(userId, journal.getId(), divisionId, role);
		return true;
	}

	@RequestMapping(value = "/configuration/members/unSetDivision", method=RequestMethod.POST)
	public @ResponseBody Boolean unSetDivision(HttpServletRequest request, Model model, 
			@RequestParam(value="userDivisionId", required=true) int userDivisionId) {
		userDivisionDao.delete(userDivisionId);
		return true;
	}
	
	@RequestMapping(value = "/configuration/members/signupChiefEditor", method=RequestMethod.POST)
	public @ResponseBody Boolean chiefEditorSubmitUserForm(@ModelAttribute("chiefEditor") ChiefEditor chief, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model, Locale locale) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = chief.getUser();
			user.setEnabled(true);
			String randomPassword = userService.generatePassword(8);
			user.setPassword(randomPassword);
			chief.setUser(user);
			chief.setJournalId(journal.getId());
			chiefService.createChiefEditor(chief);
			
			emailService.sendEmailAtAccountCreation(52, (SystemUser)request.getSession().getAttribute("user"), user, journal, randomPassword, request, locale);
			return true;
		}
	}
	
	@RequestMapping(value = "/configuration/members/signupManager", method=RequestMethod.POST)
	public @ResponseBody Boolean managerSubmitUserForm(@ModelAttribute("manager") Manager manager, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model, Locale locale) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = manager.getUser();
			user.setEnabled(true);
			String randomPassword = userService.generatePassword(8);
			user.setPassword(randomPassword);
			manager.setUser(user);
			manager.setJournalId(journal.getId());
			managerService.createManager(manager);
			
			emailService.sendEmailAtAccountCreation(52, (SystemUser)request.getSession().getAttribute("user"), user, journal, randomPassword, request, locale);
			return true;
		}
	}
	
	@RequestMapping(value = "/configuration/members/signupGuestEditor", method=RequestMethod.POST)
	public @ResponseBody Boolean guestEditorSubmitUserForm(@ModelAttribute("guestEditor") GuestEditor ge, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model, Locale locale) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = ge.getUser();
			user.setEnabled(true);
			String randomPassword = userService.generatePassword(8);
			user.setPassword(randomPassword);
			ge.setUser(user);
			ge.setJournalId(journal.getId());
			geService.createGuestEditor(ge);
			
			emailService.sendEmailAtAccountCreation(52, (SystemUser)request.getSession().getAttribute("user"), user, journal, randomPassword, request, locale);
			return true;
		}
	}
	
	@RequestMapping(value = "/configuration/members/setSpecialIssue", method=RequestMethod.POST)
	public @ResponseBody Boolean setSpecialIssue(HttpServletRequest request, Model model, 
			@RequestParam(value="specialIssueId", required=true) int specialIssueId,
			@RequestParam(value="geUserId", required=true) int geUserId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		geSpecialIssueDao.create(geUserId, journal.getId(), specialIssueId);
		SpecialIssue specialIssue = specialIssueDao.findById(specialIssueId);
		specialIssue.setGuestEditorUserId(geUserId);
		specialIssueDao.update(specialIssue);
		return true;
	}

	@RequestMapping(value = "/configuration/members/unSetSpecialIssue", method=RequestMethod.POST)
	public @ResponseBody Boolean unSetSpecialIssue(HttpServletRequest request, Model model, 
			@RequestParam(value="specialIssueId", required=true) int specialIssueId,
			@RequestParam(value="geSpecialIssueId", required=true) int geSpecialIssueId) {
		geSpecialIssueDao.delete(geSpecialIssueId);
		SpecialIssue specialIssue = specialIssueDao.findById(specialIssueId);
		specialIssue.setGuestEditorUserId(0);
		specialIssueDao.update(specialIssue);
		return true;
	}
	
	@RequestMapping(value = "/configuration/members/signupBoardMember", method=RequestMethod.POST)
	public @ResponseBody Boolean boardMembersubmitUserForm(@ModelAttribute("boardMember") BoardMember bm, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model, Locale locale) {
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = bm.getUser();
			user.setEnabled(true);
			String randomPassword = userService.generatePassword(8);
			user.setPassword(randomPassword);
			bm.setUser(user);
			bm.setJournalId(journal.getId());
			bmService.createBoardMember(bm);
			
			emailService.sendEmailAtAccountCreation(52, (SystemUser)request.getSession().getAttribute("user"), user, journal, randomPassword, request, locale);
			return true;
		}
	}

	@RequestMapping(value = "/configuration/members/selectBoardMember", method=RequestMethod.POST)
	public @ResponseBody Boolean selectBoardMember(HttpServletRequest request, Model model, 
			@RequestParam(value="userId", required=true) int userId) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		bmService.selectBoardMember(userId, journal.getId());
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/divisions/manageDivisions", method=RequestMethod.GET)
	public ModelAndView manageDivisions(HttpServletRequest request) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		ModelAndView mav = new ModelAndView();
		Division division = new Division();

		mav.addObject("division", division);
		mav.addObject("journal", journal);
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		mav.setViewName("manager.configuration.divisions.manageDivisions");
		return mav;
	}
	
	@RequestMapping(value = "/configuration/divisions/createDivision", method=RequestMethod.POST)
	public @ResponseBody Boolean createDivision(@ModelAttribute("division") Division division, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 Model model) {
		
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			division.setJournalId(journal.getId());
			managerService.createDivision(division);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/divisions/divisionTable", method=RequestMethod.GET)
	public ModelAndView divisionTable(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		List<Division> divisions = journalService.getDivisionsById(journal.getId());
		mav.addObject("divisions", divisions);
		mav.setViewName("manager.configuration.divisions.divisionTable");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/divisions/editDivision", method=RequestMethod.GET)
	public ModelAndView editDivision(HttpServletRequest request, Model model, 
			@RequestParam(value="divisionId", required=true) int divisionId) {
		ModelAndView mav = new ModelAndView();
		Division division = divisionDao.findById(divisionId);
		mav.addObject("division", division);
		mav.setViewName("manager.configuration.divisions.editDivisionForm");
		return mav;
	}
	
	@RequestMapping(value = "/configuration/divisions/editDivision", method=RequestMethod.POST)
	public @ResponseBody ModelAndView editDivision(@ModelAttribute("division") Division division, 
		 	 BindingResult result, 
		 	 HttpServletRequest request,
		 	 Model model) {
		ModelAndView mav = new ModelAndView();
		divisionDao.update(division);
		RedirectView rv = new RedirectView("../divisions/manageDivisions");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}

	@RequestMapping(value = "/configuration/divisions/deleteDivision", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteDivision(HttpServletRequest request, Model model, 
			@RequestParam(value="divisionId", required=true) int divisionId) {
		if(authorityService.hasRole(SystemConstants.roleManager))
			divisionDao.delete(divisionId);
		
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/specialIssues/manageSpecialIssue", method=RequestMethod.GET)
	public ModelAndView manageSpecialIssue(HttpServletRequest request) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		ModelAndView mav = new ModelAndView();
		Date date = systemUtil.getClientLocalDate(request, systemUtil.getUtcDate(), systemUtil.getUtcTime());
		SimpleDateFormat sdf = null;
		if(journal.getLanguageCode().equals("ko"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		String defaultDueDate = sdf.format(date);
		
		mav.addObject("defaultDueDate", defaultDueDate);
		SpecialIssue si = new SpecialIssue();
		mav.addObject("specialIssue", si);
		mav.addObject("journal", journal);
		mav.setViewName("manager.configuration.specialIssues.manageSpecialIssue");
		return mav;
	}
	
	@RequestMapping(value = "/configuration/specialIssues/createSpecialIssue", method=RequestMethod.POST)
	public @ResponseBody Boolean createSpecialIssue(@ModelAttribute("specialIssue") SpecialIssue specialIssue, 
							 	BindingResult result, 
							 	HttpServletRequest request,
							 	Model model,
							 	@RequestParam(value="dateString", required=true) String dateString) {
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			managerService.createSpecialIssue(journal, specialIssue, dateString);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/specialIssues/specialIssueTable", method=RequestMethod.GET)
	public ModelAndView spcialIssueTable(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager.configuration.specialIssues.specialIssueTable");
		return mav;
	}
	
	@RequestMapping(value = "/configuration/specialIssues/deleteSpecialIssue", method=RequestMethod.POST)
	public @ResponseBody Boolean deleteSpecialIssue(HttpServletRequest request, Model model, 
			@RequestParam(value="specialIssueId", required=true) int specialIssueId) {
		specialIssueDao.delete(specialIssueId);
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/specialIssues/getSpecialIssues", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String getSpecialIssues(Model model, HttpServletRequest request, Locale locale) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");

		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "special_issues");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<SpecialIssue> specialIssues = null;
		sortableColumnNames.add(null);
		sortableColumnNames.add("TITLE");
		sortableColumnNames.add(null);
		sortableColumnNames.add("SUBMIT_DUE_DATE");
		sortableColumnNames.add("CREATE_DATE");
		sortableColumnNames.add(null);
		sortableColumnNames.add("STATUS");
		specialIssues = specialIssueDao.findByJournalId(journal.getId(), dRequest, iTotalDisplayRecords, sortableColumnNames);

		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], specialIssues.size());
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		String localDateTime = null;
		for (SpecialIssue si: specialIssues) {
			index = 0;
			
			dResponse.setAaData(i, index++, Integer.toString(number));
			dResponse.setAaData(i, index++, si.getTitle());
			
			int guestEditorUserId = si.getGuestEditorUserId();
			if(guestEditorUserId != 0) {
				SystemUser guestEditorUser = userService.getById(guestEditorUserId);
				dResponse.setAaData(i, index++, contactService.getFullName(guestEditorUser.getContact(), journal.getLanguageCode()));
			} else
				dResponse.setAaData(i, index++, messageSource.getMessage("system.notAvailable2", null , locale));
			
			localDateTime = systemUtil.getClientLocalDateAsString(si.getSubmissionDueDate(), 
					  si.getSubmissionDueTime(), request, locale);
			
			dResponse.setAaData(i, index++, localDateTime);
			
			localDateTime = systemUtil.getClientLocalDateAsString(si.getCreationDate(), 
					  si.getCreationTime(), request, locale);
			
			dResponse.setAaData(i, index++, localDateTime);		
			
			if(si.getStatus())
				dResponse.setAaData(i, index++, null);
			else
				dResponse.setAaData(i, index++, messageSource.getMessage("system.closed", null , locale));
			
			String actionString = ("<button type='button' class='btn btn-default btn-xs actionButton width60' onClick='editSpecialIssue(" + si.getId() +");'/>" +
					messageSource.getMessage("system.edit", null , locale) + "</button>");
			if(si.getStatus())
				dResponse.setAaData(i, index++, actionString);
			else
				dResponse.setAaData(i, index++, null);
			
			i++;
			number++;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/specialIssues/editSpecialIssue", method=RequestMethod.GET)
	public ModelAndView editSpecialIssue(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="specialIssueId", required=true) int specialIssueId) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SpecialIssue specialIssue = specialIssueDao.findById(specialIssueId);
		mav.addObject("specialIssue", specialIssue);
		
		Date dueDate = specialIssue.getSubmissionDueDate();
		SimpleDateFormat sdf = null;
		if(journal.getLanguageCode().equals("ko"))
			sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
		else
			sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
		
		String submissionDueDate = sdf.format(dueDate);
		mav.addObject("submissionDueDate", submissionDueDate);
		mav.setViewName("manager.configuration.specialIssues.editSpecialIssueForm");
		return mav;
	}
	
	@RequestMapping(value="/configuration/specialIssues/editSpecialIssue", method=RequestMethod.POST)
	public @ResponseBody ModelAndView editSpecialIssue(Model model, HttpServletRequest request, Locale locale,
			@ModelAttribute("specialIssue") SpecialIssue specialIssue, 
			@RequestParam(value="dateString", required=true) String dateString, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		managerService.saveSpecialIssue(journal, specialIssue, dateString);
		RedirectView rv = new RedirectView("../specialIssues/manageSpecialIssue");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@RequestMapping(value="/configuration/journal/setup/coverImageCheck", method=RequestMethod.POST)
	public @ResponseBody Boolean coverImageCheck(HttpServletRequest request, Locale locale) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		//TODO
		if(journal.getCoverImageFilename() != null)
			return true;
		else
			return false;
	}
	
	@RequestMapping(value="/configuration/journal/setup/reviewItemCheck", method=RequestMethod.POST)
	public @ResponseBody Boolean reviewItemCheck(HttpServletRequest request, Locale locale) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		int numReviewItems = jc.getNumberOfReviewItems();
		HashSet<Integer> reviewItemIds = new HashSet<Integer>();
		for(int i=1; i<=numReviewItems; i++) {
			int id = jc.getReviewItemId(i);
			if(!reviewItemIds.contains(id))
				reviewItemIds.add(id);
			else
				return false;
		}
		return true;
	}
	
	@RequestMapping(value="/configuration/journal/setup/completeSubmission", method=RequestMethod.POST)
	public @ResponseBody Boolean submitComplete(HttpServletRequest request, @PathVariable(value="jnid") String jnid) {
		Journal journal = journalService.getByJournalNameId(jnid);
		journal.setEnabled(true);
		journalService.update(journal);
		request.getSession().removeAttribute("journal");
		request.getSession().setAttribute("journal", journal);
		return true;
	}
	
	@RequestMapping(value="/configuration/journal/setup/step/{step}", method=RequestMethod.GET)
	public ModelAndView setup(HttpServletRequest request, Locale locale, @PathVariable(value="jnid") String jnid, @PathVariable(value="step") String step) {
		Journal journal = journalService.getByJournalNameId(jnid);
		ModelAndView mav = new ModelAndView();
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("journal", journal);
		mav.addObject("jc", jc);
		List<ReviewItemDesignation> reviewItemDesignations = new ArrayList<ReviewItemDesignation>();
		for(int i=1; i<=ReviewItemDesignation.values().length; i++)
			reviewItemDesignations.add(ReviewItemDesignation.getType(i));
		mav.addObject("reviewItemDesignations", reviewItemDesignations);
		String[] fileTypes = {SystemConstants.fileTypeCT, SystemConstants.fileTypeCP, SystemConstants.fileTypeFC, SystemConstants.fileTypeCHK};
		mav.addObject("fileTypes", fileTypes);
		
		List<Category> categories = categoryDao.findAll();
		mav.addObject("categories", categories);
		int upperCategory = 0;
		List<JournalCategory> journalCategories = journalCategoryDao.findByJournalId(journal.getId());
		if(journalCategories != null && journalCategories.size() > 0) {
			String categoryName =  journalCategories.get(0).getName();
			Category category = categoryDao.findByName(categoryName);
			if(category != null)
				upperCategory = categoryDao.findByName(categoryName).getUpperCategory();
		}
		mav.addObject("upperCategory", upperCategory);
		mav.addObject("journalCategories", journalCategories);
		mav.addObject("pageType", "setup");
		mav.addObject("step", step);
		
		int currentStep = jc.getSetupStep();
		int pageStep = Integer.parseInt(step);
		if(currentStep + 1 ==  pageStep)
			jc.setSetupStep(pageStep);
		
		journalConfigurationService.update(jc);
		
		if(pageStep == 0) {
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			SystemUser editableUser = userService.getById(user.getId());
			request.setAttribute("user", editableUser);
			
			mav.addObject("editableUser", editableUser);
			
			Map<String,String> countries = null;
			try {
				countries = getCountryMap(editableUser.getContact().getCountry());
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
			for (int i=0; i<DegreeDesignation.values().length; i++)
				degreeDesignations.add(DegreeDesignation.getType(i));
			
			mav.addObject("degreeDesignations", degreeDesignations);		
			
			List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
			for (int i=0; i<SalutationDesignation.values().length; i++)
				salutationDesignations.add(SalutationDesignation.getType(i));
			
			mav.addObject("salutationDesignations", salutationDesignations);			
			
			List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
			for (int i=0; i<LocalJobTitleDesignation.values().length; i++)
				localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
			
			mav.addObject("localJobTitleDesignations", localJobTitleDesignations);
			mav.addObject("countries", countries);
		}
		mav.setViewName("manager.configuration.journal.settings");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/journal/settings", method=RequestMethod.GET)
	public ModelAndView settings(HttpServletRequest request, Locale locale) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		ModelAndView mav = new ModelAndView();
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("journal", journal);
		mav.addObject("jc", jc);
		List<ReviewItemDesignation> reviewItemDesignations = new ArrayList<ReviewItemDesignation>();
		for(int i=1; i<=ReviewItemDesignation.values().length; i++)
			reviewItemDesignations.add(ReviewItemDesignation.getType(i));
		mav.addObject("reviewItemDesignations", reviewItemDesignations);
		String[] fileTypes = {SystemConstants.fileTypeCT, SystemConstants.fileTypeCP, SystemConstants.fileTypeFC, SystemConstants.fileTypeCHK};
		mav.addObject("fileTypes", fileTypes);
		
		List<Category> categories = categoryDao.findAll();
		mav.addObject("categories", categories);
		int upperCategory = 0;
		List<JournalCategory> journalCategories = journalCategoryDao.findByJournalId(journal.getId());
		if(journalCategories != null && journalCategories.size() > 0) {
			String categoryName =  journalCategories.get(0).getName();
			Category category = categoryDao.findByName(categoryName);
			if(category != null)
				upperCategory = categoryDao.findByName(categoryName).getUpperCategory();
		}
		mav.addObject("upperCategory", upperCategory);
		mav.addObject("journalCategories", journalCategories);
		mav.addObject("pageType", "settings");
		mav.setViewName("manager.configuration.journal.settings");
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/journal/getCategories", method=RequestMethod.GET)
	public @ResponseBody String getCategories(HttpServletRequest request, Locale locale, @RequestParam(value="upperCategory", required=true) int upperCategory) {
		StringBuffer sb = new StringBuffer();
		List<Category> lowerCategories = categoryDao.findByUpperCategory(upperCategory);
		int count = 1;
		for(Category category: lowerCategories) {
			sb.append("<option value='" + category.getId() +"'>");
			sb.append(messageSource.getMessage("journal.category." + upperCategory + "." + count++, null, locale));
			sb.append("</option>");
		}
		return sb.toString();
	}
	
	@RequestMapping(value="/configuration/journal/saveJournalInfo", method=RequestMethod.POST)
	public @ResponseBody Boolean saveJournalInfo(Model model, HttpServletRequest request,
			@RequestParam(value="name", required=true) String name,
			@RequestParam(value="value", required=true) String value) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		if(name.equals("title"))
			journal.setTitle(value);
		else if(name.equals("shortTitle"))
			journal.setShortTitle(value);
		else if(name.equals("homepage"))
			journal.setHomepage(value);
		else if(name.equals("organization"))
			journal.setOrganization(value);
		else if(name.equals("countryCode"))
			journal.setCountryCode(value);
		else if(name.equals("languageCode"))
			journal.setLanguageCode(value);
		else if(name.equals("type"))
			journal.setType(value);

		journalService.update(journal);
		request.getSession().removeAttribute("journal");
		request.getSession().setAttribute("journal", journal);
		return true;
	}
	
	@RequestMapping(value="/configuration/journal/saveConfiguration", method=RequestMethod.POST)
	public @ResponseBody Boolean saveConfiguration(Model model, HttpServletRequest request,
			@RequestParam(value="name", required=true) String name,
			@RequestParam(value="value", required=true) String value) {
		if(authorityService.hasRole(SystemConstants.roleManager)) {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
	
			if(name.equals("reviewCompleteCount"))
				jc.setReviewCompleteCount(Integer.parseInt(value));
			else if(name.equals("reviewDueDuration"))
				jc.setReviewDueDuration(Integer.parseInt(value));
			else if(name.equals("assignRemindDuration"))
				jc.setAssignRemindDuration(Integer.parseInt(value));
			else if(name.equals("assignCancelDuration"))
				jc.setAssignCancelDuration(Integer.parseInt(value));
			else if(name.equals("inviteRemindDuration"))
				jc.setInviteRemindDuration(Integer.parseInt(value));
			else if(name.equals("inviteCancelDuration"))
				jc.setInviteCancelDuration(Integer.parseInt(value));
			else if(name.equals("resubmitDuration"))
				jc.setResubmitDuration(Integer.parseInt(value));
			else if(name.equals("cameraSubmitDuration"))
				jc.setCameraSubmitDuration(Integer.parseInt(value));
			else if(name.equals("gentleRemindResubmit"))
				jc.setGentleRemindResubmit(Integer.parseInt(value));
			else if(name.equals("gentleRemindReviewer"))
				jc.setGentleRemindReviewer(Integer.parseInt(value));
			else if(name.equals("gentleRemindCameraSubmit"))
				jc.setGentleRemindCameraSubmit(Integer.parseInt(value));
			else if(name.equals("remindReviewer"))
				jc.setRemindReviewer(Integer.parseInt(value));
			else if(name.equals("remindResubmit"))
				jc.setRemindResubmit(Integer.parseInt(value));
			else if(name.equals("remindCameraSubmit"))
				jc.setRemindCameraSubmit(Integer.parseInt(value));
			else if(name.equals(SystemConstants.fileTypeCT + "Url"))
				jc.setCameraReadyTemplateUrl(value);
			else if(name.equals(SystemConstants.fileTypeCP + "Url"))
				jc.setCopyrightFormUrl(value);
			else if(name.equals(SystemConstants.fileTypeFC + "Url"))
				jc.setFrontCoverUrl(value);
			else if(name.equals(SystemConstants.fileTypeCHK + "Url"))
				jc.setCheckListUrl(value);
			else if(name.equals("numberOfConfirms"))
				jc.setNumberOfConfirms(Integer.parseInt(value));
			else if(name.equals("confirm1"))
				jc.setConfirm1(value);
			else if(name.equals("confirm2"))
				jc.setConfirm2(value);
			else if(name.equals("confirm3"))
				jc.setConfirm3(value);
			else if(name.equals("confirm4"))
				jc.setConfirm4(value);
			else if(name.equals("confirm5"))
				jc.setConfirm5(value);
			else if(name.equals("textBasicInfo"))
				jc.setTextBasicInfo(value);
			else if(name.equals("textCoAuthor"))
				jc.setTextCoAuthor(value);
			else if(name.equals("textRp"))
				jc.setTextRp(value);		
			else if(name.equals("textCoverLetter"))
				jc.setTextCoverLetter(value);
			else if(name.equals("textFiles"))
				jc.setTextFiles(value);
			else if(name.equals("numberOfReviewItems"))
				jc.setNumberOfReviewItems(Integer.parseInt(value));
			else if(name.equals("reviewItemId1"))
				jc.setReviewItemId1(Integer.parseInt(value));
			else if(name.equals("reviewItemId2"))
				jc.setReviewItemId2(Integer.parseInt(value));
			else if(name.equals("reviewItemId3"))
				jc.setReviewItemId3(Integer.parseInt(value));
			else if(name.equals("reviewItemId4"))
				jc.setReviewItemId4(Integer.parseInt(value));
			else if(name.equals("reviewItemId5"))
				jc.setReviewItemId5(Integer.parseInt(value));
			else if(name.equals("reviewItemId6"))
				jc.setReviewItemId6(Integer.parseInt(value));
			else if(name.equals("reviewItemId7"))
				jc.setReviewItemId7(Integer.parseInt(value));
			else if(name.equals("reviewItemId8"))
				jc.setReviewItemId8(Integer.parseInt(value));
			else if(name.equals("reviewItemId9"))
				jc.setReviewItemId9(Integer.parseInt(value));
			else if(name.equals("reviewItemId10"))
				jc.setReviewItemId10(Integer.parseInt(value));
			else if(name.equals("changeAuthor")) {
				if(value.equals("1")) jc.setChangeAuthor(true);
				else jc.setChangeAuthor(false);
			} else if(name.equals("changeKeyword")) {
				if(value.equals("1")) jc.setChangeKeyword(true);
				else jc.setChangeKeyword(false);
			} else if(name.equals("changeDivision")) {
				if(value.equals("1")) jc.setChangeDivision(true);
				else jc.setChangeDivision(false);
			} else if(name.equals("changeRp")) {
				if(value.equals("1")) jc.setChangeRp(true);
				else jc.setChangeRp(false);
			} else if(name.equals("changeInvited")) {
				if(value.equals("1")) jc.setChangeInvited(true);
				else jc.setChangeInvited(false);
			} else if(name.equals("changeAdditionalFiles")) {
				if(value.equals("1")) jc.setChangeAdditionalFiles(true);
				else jc.setChangeAdditionalFiles(false);
			} else if(name.equals("manageDivision")) {
				if(value.equals("1")) jc.setManageDivision(true);
				else jc.setManageDivision(false);
			} else if(name.equals("requiredRunninghead")) {
				if(value.equals("1")) jc.setRequiredRunninghead(true);
				else jc.setRequiredRunninghead(false);
			} else if(name.equals("requiredKeyword")) {
				if(value.equals("1")) jc.setRequiredKeyword(true);
				else jc.setRequiredKeyword(false);
			} else if(name.equals("requiredCoverletter")) {
				if(value.equals("1")) jc.setRequiredCoverletter(true);
				else jc.setRequiredCoverletter(false);
			} else if(name.equals("requiredRp")) {
				if(value.equals("1")) jc.setRequiredRp(true);
				else jc.setRequiredRp(false);
			} else if(name.equals("requiredAdditionalFiles")) {
				if(value.equals("1")) jc.setRequiredAdditionalFiles(true);
				else {
					jc.setRequiredAdditionalFiles(false);
					fileService.deleteJournalFile(journal, SystemConstants.fileTypeFC);
					jc.setFrontCoverUrl(null);
					fileService.deleteJournalFile(journal, SystemConstants.fileTypeCHK);
					jc.setCheckListUrl(null);
				}
			} else if(name.equals("frontCoverManage")) {
				if(value.equals("0")) {
					fileService.deleteJournalFile(journal, SystemConstants.fileTypeFC);
					jc.setFrontCoverUrl(null);
				}
			} else if(name.equals("checkListManage")) {
				if(value.equals("0")) {
					fileService.deleteJournalFile(journal, SystemConstants.fileTypeCHK);
					jc.setCheckListUrl(null);
				}
			} else if(name.equals("reviewerViewAuthor")) {
				if(value.equals("1")) jc.setReviewerViewAuthor(true);
				else jc.setReviewerViewAuthor(false);
			} else
				System.out.println("name: " + name + ", value: " + value);
			
			journalConfigurationService.update(jc);
		}
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/configuration/journal/uploadedFileTable", method=RequestMethod.GET)
	public String uploadedFileTable(HttpServletRequest request, Model model,
			@RequestParam(value="journalId", required=true) int journalId, @RequestParam(value="designation", required=true) String designation) {
		List<JournalUploadedFile> files = fileService.getJournalFiles(journalId);
		model.addAttribute("files", files);
		model.addAttribute("designation", designation);
		return "manager.configuration.journal.uploadedFileTable";
	}
	
	@RequestMapping(value="/configuration/journal/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean uploadCopyright(HttpServletRequest request, 
			Principal principal, 
			MultipartHttpServletRequest req, 
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="designation") String designation) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		try {
			fileService.processJournalFile(user.getId(), f, journal, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/journal/getUrl", method=RequestMethod.GET)
	public @ResponseBody String getUrl(HttpServletRequest request, Locale locale, @RequestParam(value="designation", required=true) String designation) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		String url = null;
		if(designation.equals(SystemConstants.fileTypeCP))
			url = jc.getCopyrightFormUrl();
		else if(designation.equals(SystemConstants.fileTypeCT))
			url = jc.getCameraReadyTemplateUrl();
		else if(designation.equals(SystemConstants.fileTypeFC))
			url = jc.getFrontCoverUrl();
		else if(designation.equals(SystemConstants.fileTypeCHK))
			url = jc.getCheckListUrl();
		if(url == null)
			url = messageSource.getMessage("system.notAvailable2", null, locale);
		return url;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/configuration/journal/numFiles", method=RequestMethod.GET)
	public @ResponseBody String numFiles(HttpServletRequest request, Locale locale, @RequestParam(value="designation", required=true) String designation) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int count = 0;
        List<JournalUploadedFile> jufs = fileService.getJournalFiles(journal.getId());
        for(JournalUploadedFile juf: jufs)
        	if(juf.getDesignation().equals(designation))
        		count++;
		return Integer.toString(count);
	}
	
	@RequestMapping(value="/configuration/journal/saveImage", method=RequestMethod.POST)
	public @ResponseBody Boolean saveImage (HttpServletRequest request, Model model,
			@RequestParam(value="x1", required=true) int x1,
			@RequestParam(value="x2", required=true) int x2,
			@RequestParam(value="y1", required=true) int y1,
			@RequestParam(value="y2", required=true) int y2,
			@RequestParam(value="w", required=true) int w,
			@RequestParam(value="h", required=true) int h) {
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		int realW = 0;
		int realH = 0;
		try {
			String extension = this.getExtension(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + request.getParameter("imgName"));
			Iterator<ImageReader> iter = ImageIO.getImageReadersBySuffix(extension);
			ImageInputStream imgStream = null;
			if (iter.hasNext()) {
				ImageReader reader = iter.next();
				try {
					imgStream = new FileImageInputStream(new File(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + request.getParameter("imgName")));
					reader.setInput(imgStream);
					realW = reader.getWidth(reader.getMinIndex());
					realH = reader.getHeight(reader.getMinIndex());
				} catch (IOException e) {
					System.out.println(e.getMessage());
				} finally {
					reader.dispose();
				}
			} else {
				System.out.println("No reader found for given format: " + extension);
			}
			
			BufferedImage src = ImageIO.read(new File(fileSystemResource.getPath() +File.separator + "coverImages" + File.separator + request.getParameter("imgName")));
			int registerX = Math.round(x1 * realW / w);
			int registerY = Math.round(y1 * realH / h);
			int width = Math.round(x2 * realW / w) - registerX;
			int height = Math.round(y2 * realH / h) - registerY;
			
			BufferedImage registerImage = src.getSubimage(registerX, registerY, width, height);
			File outputfile = new File(fileSystemResource.getPath() + File.separator + "coverImages" + File.separator + "r-" + request.getParameter("imgName"));			
			ImageIO.write(registerImage, getExtension(request.getParameter("imgName")), outputfile);

			outputfile = new File(servletContext.getRealPath("") + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "images" + File.separator + "coverImages" + File.separator + "r-" + request.getParameter("imgName"));			
			ImageIO.write(registerImage, getExtension(request.getParameter("imgName")), outputfile);

			journal.setCoverImageFilename("r-" + request.getParameter("imgName"));
			journal.setCoverImageUploaded(true);
			journalService.update(journal);
			request.getSession().removeAttribute("journal");
			request.getSession().setAttribute("journal", journal);
		} catch (IOException e) {
			System.out.println(e);
		}
		return true;
	}
	
	private String getExtension(String fileName) {
		int dotPosition = fileName.lastIndexOf('.');		
		if (-1 != dotPosition && fileName.length() - 1 > dotPosition) {
			return fileName.substring(dotPosition + 1).toLowerCase();
		} else {
			return "";
		}
	}
	
	@Transactional(readOnly = true)
	private Map<String,String> getCountryMap(String countryCodeAlpha2) throws Exception {
		List<CountryCode> countryCodes = countryCodeDao.findAll();
		Map<String,String> countryMap = new LinkedHashMap<String,String>();
		countryMap.put(countryCodeAlpha2, countryCodeDao.findByAlpha2(countryCodeAlpha2).getName());
		
		Iterator<CountryCode> iterator = countryCodes.iterator();
		CountryCode countryCode = null;
		while(iterator.hasNext()) {
			countryCode = iterator.next();
			if (countryCode.getAlpha2().equals(countryCodeAlpha2)) {
				continue;
			}
			countryMap.put(countryCode.getAlpha2(), countryCode.getName());
		}
		return countryMap;
	}
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "manager";
	}
}
