package link.thinkonweb.controller.roles;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.EmailDesignation;
import link.thinkonweb.domain.constants.JournalTypeDesignation;
import link.thinkonweb.domain.constants.ManuscriptTrack;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.journal.JournalUserEditor;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping(value="/superManager/*")
public class SuperManagerController {
	final static String[] sortableCoName = {SystemConstants.roleSuperManager, 
											SystemConstants.roleMember,
											SystemConstants.roleManager,
											SystemConstants.roleCEditor,
											SystemConstants.roleGEditor,
											SystemConstants.roleAEditor,
											SystemConstants.roleBMember,
											SystemConstants.roleReviewer};
	@Autowired
	private UserService userService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private DataSource dataSource;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private JournalRoleDao journalMemberDao;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private ShaPasswordEncoder shaPasswordEncoder;
	@Autowired
	private VelocityEngine velocityEngine;
	@Autowired
	private CoAuthorService coAuthorService;
	@Resource(name="sessionRegistry")
    private SessionRegistry sessionRegistry;
	/*
	@Autowired
	public SuperManagerController(SessionRegistry sessionRegistry) {
		if (sessionRegistry == null) {
            throw new IllegalArgumentException("sessionRegistry cannot be null");
        }
        this.sessionRegistry = sessionRegistry;
	}
	 */
	
	
	@RequestMapping(value = "/dashboard", method=RequestMethod.GET)
	public String dashboard(Model model) {
		return "superManager.dashboard";
	}
	
	@RequestMapping(value = "/accountList", method=RequestMethod.GET)
	public String displayUsers(Model model, Locale locale) {
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i=0; i < DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		model.addAttribute("degreeDesignations", degreeDesignations);	
		return "superManager.accountList";
	}
	
	
	/*
	@RequestMapping(value = "/password", method=RequestMethod.GET)
	public void password(Model model) {
		List<SystemUser> systemUsers = this.userService.getAll();
		Iterator<SystemUser> userIterator = systemUsers.iterator();
		while (userIterator.hasNext()) {
			SystemUser user = (SystemUser)userIterator.next();
	        String encodedPassword = shaPasswordEncoder.encodePassword(user.getPassword(), user.getUsername());
	        user.setPassword(encodedPassword);
	        this.userService.update(user);
		}
	}
	*/
	
	@RequestMapping(value = "/userDelete", method=RequestMethod.GET)
	public String deleteUser(Model model, @RequestParam("userId") int userId) {
		SystemUser storedUser = this.userService.getById(userId);	
		// 추가로 작업할 일 많음. 예. Manuscript 정보 등...
		
		Iterator<Authority> iterator = this.authorityService.getAuthorities(userId, 0, null).iterator();
		Authority authority = null;
		while (iterator.hasNext()) {
			authority = iterator.next();
			this.authorityService.delete(authority);
		}
		this.userService.delete(storedUser);
		return "superManager.accountListRedirect";
	}
	
	@RequestMapping(value = "/journalList", method=RequestMethod.GET)
	public String displayJournals(Model model) {
		return "superManager.journalList";
	}
	
	@RequestMapping(value = "/journalDelete", method=RequestMethod.GET)
	public String deleteJournal(Model model, @RequestParam("jnid") int jnid) {
		this.journalService.delete(this.journalService.getById(jnid));
		return "superManager.journalListRedirect";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/roleList", method=RequestMethod.GET)
	public String displayRoles(Model model, @RequestParam("jnid") String jnid) {
		List<Journal> journals = this.journalService.getAll();
		model.addAttribute("journals", journals);
		model.addAttribute("journalNameId", jnid);
		if (!jnid.equals("any")) {
			model.addAttribute("journalTitle", this.journalService.getByJournalNameId(jnid).getTitle() + " (Journal ID: " + jnid + ")");
		}
		return "superManager.roleList";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/accountListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String accountList(HttpServletRequest request, Locale locale) {
		DataTableClientRequest dRequest = new DataTableClientRequest(request);
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "users");
		int[] iTotalDisplayRecords = new int[1]; //placeHolder (call by reference) trick!
		List<SystemUser> users = userService.getSuperManagerAccountList(dRequest, iTotalDisplayRecords);				
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], users.size());
		
		int i = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		String localDateTime = null;
		for (SystemUser user : users) {
			sb.append("<a class='btn btn-default btn-xs actionButton width135' href=\'?userId=").append(user.getId()).append("\'>")
			  .append(messageSource.getMessage("user.action.passwordReset", null, locale))
			  .append("</a>")
			  .append("<br/><a class='btn btn-default btn-xs actionButton width135' href=\'?userId=").append(user.getId()).append("\'>")
			  .append(messageSource.getMessage("system.modify", null, locale))
			  .append("</a>")
			  .append("<br/><a class='btn btn-default btn-xs actionButton width135' href=\'superManager/userDelete?userId=").append(user.getId()).append("\'>")
			  .append(messageSource.getMessage("system.delete", null, locale))
			  .append("</a>");
			
			//dResponse.setAaData(i, 0, "<input type='checkbox'>");
			dResponse.setAaData(i, 0, Integer.toString(number));
			dResponse.setAaData(i, 1, user.getUsername());
			dResponse.setAaData(i, 2, user.getContact().getFirstName());
			dResponse.setAaData(i, 3, user.getContact().getLastName());
			dResponse.setAaData(i, 4, user.getContact().getInstitution());
			dResponse.setAaData(i, 5, user.getContact().getCountryCode().getName());
			dResponse.setAaData(i, 6, user.getContact().getDegree());
			
			localDateTime = systemUtil.getClientLocalDateAsString(user.getSignupDate(), user.getSignupTime(), request, locale);
			
			dResponse.setAaData(i, 7, localDateTime);
			dResponse.setAaData(i, 8, user.isEnabled() ? "Enabled" : "Disabled");
			dResponse.setAaData(i, 9, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/journalListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String journalList(HttpServletRequest request, Locale locale) {
		DataTableClientRequest dRequest = new DataTableClientRequest(request);
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "journals");
		
		int[] iTotalDisplayRecords = new int[1]; //placeHolder (call by reference) trick!
		List<Journal> journals = journalService.getBySuperManagerJournalList(dRequest, iTotalDisplayRecords, locale);				
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], journals.size());
		
		int i = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		String language = null;
		for (Journal journal : journals) {
			sb.append("<a class='btn btn-default btn-xs' href=\'?journalId=").append(journal.getId()).append("\'>")
			  .append(messageSource.getMessage("system.modify", null, locale))
			  .append("</a>")
			  .append("<br/><a class='btn btn-default btn-xs' href=\'superManager/journalDelete?journalId=").append(journal.getId()).append("\'>")
			  .append(messageSource.getMessage("system.delete", null, locale))
			  .append("</a>");
			
			//dResponse.setAaData(i, 0, "<input type='checkbox'>");
			dResponse.setAaData(i, 0, Integer.toString(number));
			dResponse.setAaData(i, 1, journal.getJournalNameId());
			dResponse.setAaData(i, 2, journal.getCreator().getUsername());
			
			if (locale.getCountry().equals("KR")) {
				dResponse.setAaData(i, 3, journal.getCreator().getContact().getLastName() + " " + journal.getCreator().getContact().getFirstName());
			} else {
				dResponse.setAaData(i, 3, journal.getCreator().getContact().getFirstName() + " " + journal.getCreator().getContact().getLastName());
			}
			
			dResponse.setAaData(i, 4, journal.getShortTitle());
			dResponse.setAaData(i, 5, journal.getTitle());
			dResponse.setAaData(i, 6, journal.getOrganization());
			
			language = journal.getLanguageCode();
			if (language.equals(SystemConstants.englishLanguageCode)) {
				language = this.messageSource.getMessage("system.english2", null, locale);
			} else if (language.equals(SystemConstants.koreanLanguageCode)) {
				language = this.messageSource.getMessage("system.korean2", null, locale);
			}
			dResponse.setAaData(i, 7, language);
			dResponse.setAaData(i, 8, journal.getPublisherCountryCode().getName());
			
			String[] localDateTime = systemUtil.getClientLocalDateTimeAsString(request, journal.getRegisteredDate(), journal.getRegisteredTime());
			
			
							
			dResponse.setAaData(i, 9, localDateTime[0]);
			dResponse.setAaData(i, 10, localDateTime[1]);
			dResponse.setAaData(i, 11, "<img id='previewImage' src='" + servletContext.getContextPath()
										+ "/images/coverImages/" + journal.getCoverImageFilename() + "' width='80px' border='0'/>");
			dResponse.setAaData(i, 12, journal.isEnabled() ? "Enabled" : "Disabled");			
			dResponse.setAaData(i, 13, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}	
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/roleListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String roleList(HttpServletRequest request, Locale locale) {
		DataTableClientRequest dRequest = new DataTableClientRequest(request);
		
		
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "users");
		
		int[] iTotalDisplayRecords = new int[1]; //placeHolder (call by reference) trick!
		List<SystemUser> users = userService.getSuperManagerRoleList(dRequest, iTotalDisplayRecords);
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], users.size());
		
		int i = 0;
		
	    int SortCol = dRequest.getiSortCol()[0];
	    if (SortCol == 5) {
			for (SystemUser user : users) {
				if (authorityService.hasRole(user, "ROLE_SUPER_MANAGER")) {
					setDResponse(i, user, dResponse, request.getParameter("jnid"));
					i++;
				}
			}
			for (SystemUser user : users) {
				if (!authorityService.hasRole(user, "ROLE_SUPER_MANAGER")) {
					setDResponse(i, user, dResponse, request.getParameter("jnid"));
					i++;
				}
			}
	    } else if (SortCol >= 6 && SortCol <= 12) {
	    	for (SystemUser user : users) {
				if (authorityService.hasRole(user, this.journalService.getByJournalNameId(request.getParameter("jnid")).getId(), sortableCoName[SortCol-5])) {
					setDResponse(i, user, dResponse, request.getParameter("jnid"));
					i++;
				}
	    	}
	    	for (SystemUser user : users) {
				if (!authorityService.hasRole(user, this.journalService.getByJournalNameId(request.getParameter("jnid")).getId(), sortableCoName[SortCol-5])) {
					setDResponse(i, user, dResponse, request.getParameter("jnid"));
					i++;
				}
	    	}
	    }
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	private void setDResponse(int i, SystemUser user, DataTableServerResponse dResponse, String jnid) {
		dResponse.setAaData(i, 0, Integer.toString(i+1));
		dResponse.setAaData(i, 1, user.getUsername());
		dResponse.setAaData(i, 2, user.getContact().getFirstName());
		dResponse.setAaData(i, 3, user.getContact().getLastName());
		dResponse.setAaData(i, 4, user.isEnabled() ? "Enabled" : "Disabled");
		dResponse.setAaData(i, 5, (authorityService.hasRole(user, "ROLE_SUPER_MANAGER") 
				? "<input type='checkbox' class='userRole' id='" + user.getId() + ":0:" + "ROLE_SUPER_MANAGER' checked='checked'>"
				: "<input type='checkbox' class='userRole' id='" + user.getId() + ":0:" + "ROLE_SUPER_MANAGER'>"));
		if (!jnid.equals("any")) {
			for (int j = 6; j <= 12; j++) {
				dResponse.setAaData(i, j, (authorityService.hasRole(user, this.journalService.getByJournalNameId(jnid).getId(), sortableCoName[j-5])
						? "<input type='checkbox' class='userRole' id='" + user.getId() + ":" + jnid + ":" + sortableCoName[j-5] + "' checked='checked'>" 
						: "<input type='checkbox' class='userRole' id='" + user.getId() + ":" + jnid + ":" + sortableCoName[j-5] + "'>" ));						
			}
		} else {
			for (int j = 6; j <= 12; j++) {
				StringBuffer outTextBf = new StringBuffer();
				List<Journal> journals = this.journalService.getAll();
				for (Journal journal : journals) {
					if (authorityService.hasRole(user, journal.getId(), sortableCoName[j-5])) {
						outTextBf.append("<button type='button' class='btn btn-default btn-xs disabled'>" + journal.getJournalNameId()).append("</button>")
						.append("<input type='checkbox' class='userRole' id='" + user.getId() + ":" + journal.getJournalNameId() + ":" + sortableCoName[j-5] + "' checked='checked'>");
					} else {
						outTextBf.append("<button type='button' class='btn btn-default btn-xs disabled'>" + journal.getJournalNameId()).append("</button>")
						.append("<input type='checkbox' class='userRole' id='" + user.getId() + ":" + journal.getJournalNameId() + ":" + sortableCoName[j-5] + "'>");
					}	
				}
				
				dResponse.setAaData(i, j, outTextBf.toString());						
			}
		}
		dResponse.setAaData(i, 13, "");
	}
	
	@RequestMapping(value = "/journalInfo", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String journalInfo(HttpServletRequest request, @RequestParam("jnid") String jnid) {
		Journal journal = this.journalService.getByJournalNameId(jnid);
		return journal.getTitle() + " (Journal ID: " + journal.getJournalNameId() + ")";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/changeRole", method = RequestMethod.POST)
	public @ResponseBody String changeRole(HttpServletRequest request, 
											@RequestParam String userId, 
											@RequestParam String jnid, 
											@RequestParam String role, 
											@RequestParam String action) {
		authorityService.changeRole(Integer.parseInt(userId), jnid, role, action);
		return "success";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(link.thinkonweb.domain.user.SystemUser.class, new JournalUserEditor(this.userService));
	}
	
	@RequestMapping("/sessionList")
    public String sessions(Authentication authentication, ModelMap model) {
		List<Object> principals = sessionRegistry.getAllPrincipals();
		List<SessionInformation> sessions = new LinkedList<SessionInformation>();
		for (Object principal: principals) {
			sessions.addAll(sessionRegistry.getAllSessions(principal, false));
		}
		model.put("sessions", sessions);
	    return "superManager.sessionList";
    }
    
    @RequestMapping(value="/sessionDelete/{sessionId}", method=RequestMethod.DELETE)
    public ModelAndView removeSession(@PathVariable String sessionId, RedirectAttributes redirectAttrs) {
        SessionInformation sessionInformation = sessionRegistry.getSessionInformation(sessionId);
        if(sessionInformation != null) {
            sessionInformation.expireNow();
        }
        redirectAttrs.addFlashAttribute("message", "Session was removed");
        ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../sessionList");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
    }
    
    @Transactional(readOnly = true)
    @RequestMapping(value="/emailTemplateTest", method={RequestMethod.GET})
	public ModelAndView emailTemplateTest(HttpServletRequest request, Locale locale, @RequestParam(value="mailId", required=true) int mailId, @RequestParam(value="journalType", required=true) String journalType, @RequestParam(value="manuscriptTrack", required=true) int manuscriptTrack) {
    	ModelAndView mav = new ModelAndView();
    	
    	String subjectEn = null, subjectKr = null;
    	String bodyEn = null, bodyKr = null;
    	String closingRole = null;
    	String toRole = null;
    	String receiverRolesString = null;
    	String[] ccRoles = null;
    	String ccRolesString = "";
    	int journalTypeId = 0;
    	ArrayList<String> receiverRolesList = new ArrayList<String>();
    	
    	switch(journalType) {
    		case "A":
    			journalTypeId = 0;
    			break;
    		case "B":
    			journalTypeId = 1;
    			break;
    		case "C":
    			journalTypeId = 2;
    			break;
    		case "D":
    			journalTypeId = 3;
    			break;
    	}

    	mav.addObject("emailDesignationSet", EmailDesignation.getIdToEnumObjectMapping());
    	mav.addObject("journalTypeDesignationSet", JournalTypeDesignation.getIdToEnumObjectMapping());
    	mav.addObject("manuscriptTrackSet", ManuscriptTrack.getIdToEnumObjectMapping());
    	
    	mav.addObject("mailId", mailId);
    	mav.addObject("journalType", journalType);
    	mav.addObject("manuscriptTrack", manuscriptTrack);
    	
    	closingRole 		= SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscriptTrack][0];
    	receiverRolesString = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscriptTrack][1];
    	
    	if (receiverRolesString != null) {
    		Manuscript manuscript = new Manuscript();
    		manuscript.setTitle(this.messageSource.getMessage("test.email.manuscriptTitle", null, locale));
    		
    		Journal journal = new Journal();
    		journal.setTitle(this.messageSource.getMessage("test.email.journalTitle", null, locale));
    		
	    	StringTokenizer st = new StringTokenizer(receiverRolesString, "/");
	    	int i = 0;
	    	while (st.hasMoreElements()) {
	    		receiverRolesList.add(i, (String)st.nextElement());
	    		i++;
	    	}
	    	toRole = receiverRolesList.get(0);
	    	receiverRolesList.remove(0);
	    	ccRoles = (String[])receiverRolesList.toArray(new String[receiverRolesList.size()]);
	    	
	    	Map<String, Object> modelEn = getVelocityModel(mailId, journalType, manuscriptTrack, closingRole, toRole, ccRoles, manuscript, journal, Locale.ENGLISH);
			bodyEn = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "/emails/email_en.vm", "UTF-8", modelEn);
			
	    	Map<String, Object> modelKr = getVelocityModel(mailId, journalType, manuscriptTrack, closingRole, toRole, ccRoles, manuscript, journal, Locale.KOREAN);
			bodyKr = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "/emails/email_kr.vm", "UTF-8", modelKr);
			
		    if (mailId == 0 || mailId == 1 || mailId == 4 || mailId == 50 || mailId == 51 || mailId == 52) {
		    	subjectEn = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{(String)modelEn.get("journalShortTitleOrTitle")}, Locale.ENGLISH);
		    	subjectKr = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{(String)modelKr.get("journalShortTitleOrTitle")}, Locale.KOREAN);
		    } else if (mailId == 49 || mailId == 53) {
		    	subjectEn = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", null, Locale.ENGLISH);	    	
		    	subjectKr = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", null, Locale.KOREAN);
		    } else { 
		    	subjectEn = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{(String)modelEn.get("manuscriptId"), (String)modelEn.get("journalShortTitleOrTitle")}, Locale.ENGLISH);	    	
		    	subjectKr = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{(String)modelKr.get("manuscriptId"), (String)modelKr.get("journalShortTitleOrTitle")}, Locale.KOREAN);
		    }
	    	
	    	mav.addObject("subjectEn", subjectEn);
	    	mav.addObject("subjectKr", subjectKr);
	    	
	    	mav.addObject("bodyEn", bodyEn);
	    	mav.addObject("bodyKr", bodyKr);
	    	
	    	mav.addObject("closingRole", closingRole);
	    	mav.addObject("toRole", toRole);
	    	for (String ccRole : ccRoles) {
	    		ccRolesString += this.messageSource.getMessage("user.role2." + ccRole, null, locale) + ", ";
	    	}
	    	if (ccRolesString.length() > 2) {
	    		ccRolesString = ccRolesString.substring(0, ccRolesString.length() - 2);
	    	}
	    	mav.addObject("ccRoles", ccRolesString);
    	}
    	
		mav.setViewName("superManager.emailTemplateTest");
		
		return mav;
    }

    private HashMap<String, Object> getVelocityModel(int mailId, String journalType, int manuscriptTrack, String closingRole, String toRole, String[] ccRoles, Manuscript manuscript, Journal journal, Locale locale) {
    	HashMap<String, Object> model = new HashMap<String, Object>();
    	model.put("mailId", mailId);
    	model.put("journalType", journalType);
    	model.put("manuscriptTrack", manuscriptTrack);
    	model.put("closingRole", closingRole);
    	model.put("toRole", toRole);
    	
    	model.put("manuscript", manuscript);
    	model.put("journal", journal);
    	model.put("coAuthorService", coAuthorService);
    	
    	return model;
    }
    /*
    private HashMap<String, Object> getVelocityModel_Old(int mailId, String journalType, int manuscriptTrack, String closingRole, String toRole, String[] ccRoles, Locale locale) {
    	HashMap<String, Object> model = new HashMap<String, Object>();
    	model.put("mailId", mailId);
    	model.put("journalType", journalType);
    	model.put("manuscriptTrack", manuscriptTrack);
    	model.put("closingRole", closingRole);
    	model.put("toRole", toRole);
    	
    	String authorEmail = messageSource.getMessage("test.email.authorEmail", null, locale);	//각 저자별로 변경 필요
    	model.put("authorEmail", authorEmail);	// 각 저자별로 변경 필요

    	String manuscriptTitle = messageSource.getMessage("test.email.manuscriptTitle", null, locale);
        model.put("manuscriptTitle", manuscriptTitle);
        
    	String manuscriptId = messageSource.getMessage("test.email.manuscriptId", null, locale);
        model.put("manuscriptId", manuscriptId);
        
    	String journalUrl = messageSource.getMessage("test.email.journalUrl", null, locale);
    	String journalHomeUrl = messageSource.getMessage("test.email.journalHomeUrl", null, locale);    	
        model.put("journalUrl", journalUrl);
        model.put("journalHomeUrl", journalHomeUrl);

    	String authors = messageSource.getMessage("test.email.authors", null, locale);    	
        model.put("authors", authors);
        
    	String correspondingAuthorSalutation = messageSource.getMessage("test.email.correspondingAuthorSalutation", null, locale);
    	String correspondingAuthorFirstname = messageSource.getMessage("test.email.correspondingAuthorFirstname", null, locale);
    	String correspondingAuthorLastname = messageSource.getMessage("test.email.correspondingAuthorLastname", null, locale);
    	String correspondingAuthorLocalFullname = messageSource.getMessage("test.email.correspondingAuthorLocalFullname", null, locale);
    	String correspondingAuthorAffiliation = messageSource.getMessage("test.email.correspondingAuthorAffiliation", null, locale);
    	String correspondingAuthorLocalAffiliation = messageSource.getMessage("test.email.correspondingAuthorLocalAffiliation", null, locale);
        model.put("correspondingAuthorSalutation", correspondingAuthorSalutation);
        model.put("correspondingAuthorFirstname", correspondingAuthorFirstname);
        model.put("correspondingAuthorLastname", correspondingAuthorLastname);
        model.put("correspondingAuthorLocalFullname", correspondingAuthorLocalFullname);
        model.put("correspondingAuthorAffiliation", correspondingAuthorAffiliation);
        model.put("correspondingAuthorLocalAffiliation", correspondingAuthorLocalAffiliation);
    	
    	String durationReviewByWeeks = messageSource.getMessage("test.email.durationReviewByWeeks", null, locale);
    	model.put("durationReviewByWeeks", durationReviewByWeeks);
    	
    	String reviewInviteUrl = messageSource.getMessage("test.email.reviewInviteUrl", null, locale);
    	model.put("reviewInviteUrl", reviewInviteUrl);
    	
    	String manuscriptAbstract = messageSource.getMessage("test.email.manuscriptAbstract", null, locale);
    	model.put("manuscriptAbstract", manuscriptAbstract);

    	String reviewInviteRejectReason = messageSource.getMessage("test.email.reviewInviteRejectReason", null, locale);
    	model.put("reviewInviteRejectReason", reviewInviteRejectReason);
    	
    	String reviewDueDate = messageSource.getMessage("test.email.reviewDueDate", null, locale);
    	model.put("reviewDueDate", reviewDueDate);

    	String temporaryPassword = messageSource.getMessage("test.email.temporaryPassword", null, locale);
    	model.put("temporaryPassword", temporaryPassword);
    	
    	String reviewCompleteCount = messageSource.getMessage("test.email.reviewCompleteCount", null, locale);    	
        model.put("reviewCompleteCount", reviewCompleteCount);
        
    	String cameraReadyTemplateUrl = messageSource.getMessage("test.email.cameraReadyTemplateUrl", null, locale);    	
        model.put("cameraReadyTemplateUrl", cameraReadyTemplateUrl);
        
    	String copyrightUrl = messageSource.getMessage("test.email.copyrightUrl", null, locale);    	
        model.put("copyrightUrl", copyrightUrl);

    	String cameraReadySubmitDate = messageSource.getMessage("test.email.cameraReadySubmitDate", null, locale);    	
        model.put("cameraReadySubmitDate", cameraReadySubmitDate);

    	String reviewResultByEditor = messageSource.getMessage("test.email.reviewResultByEditor", null, locale);    	
        model.put("reviewResultByEditor", reviewResultByEditor);
        
    	String reviewResultByAssociateEditor = messageSource.getMessage("test.email.reviewResultByAssociateEditor", null, locale);    	
        model.put("reviewResultByAssociateEditor", reviewResultByAssociateEditor);

    	String reviewResultByReviewers = messageSource.getMessage("test.email.reviewResultByReviewers", null, locale);    	
        model.put("reviewResultByReviewers", reviewResultByReviewers);

   	
        String updatedManuscriptSubmitDate = messageSource.getMessage("test.email.updatedManuscriptSubmitDate", null, locale);    	
        model.put("updatedManuscriptSubmitDate", updatedManuscriptSubmitDate);
        
    	String chiefEditorSalutation = messageSource.getMessage("test.email.chiefEditorSalutation", null, locale);
    	String chiefEditorFirstname = messageSource.getMessage("test.email.chiefEditorFirstname", null, locale);
    	String chiefEditorLastname = messageSource.getMessage("test.email.chiefEditorLastname", null, locale);
    	String chiefEditorLocalFullname = messageSource.getMessage("test.email.chiefEditorLocalFullname", null, locale);
    	String chiefEditorEmail = messageSource.getMessage("test.email.chiefEditorEmail", null, locale);
    	String chiefEditorLocalJobTitle = messageSource.getMessage("test.email.chiefEditorLocalJobTitle", null, locale);
    	model.put("chiefEditorSalutation", chiefEditorSalutation);
    	model.put("chiefEditorFirstname", chiefEditorFirstname);
    	model.put("chiefEditorLastname", chiefEditorLastname);
    	model.put("chiefEditorLocalFullname", chiefEditorLocalFullname);
    	model.put("chiefEditorEmail", chiefEditorEmail);
    	model.put("chiefEditorLocalJobTitle", chiefEditorLocalJobTitle);
    	
    	
    	String associateEditorSalutation = messageSource.getMessage("test.email.associateEditorSalutation", null, locale);
    	String associateEditorFirstname = messageSource.getMessage("test.email.associateEditorFirstname", null, locale);
    	String associateEditorLastname = messageSource.getMessage("test.email.associateEditorLastname", null, locale);
    	String associateEditorLocalFullname = messageSource.getMessage("test.email.associateEditorLocalFullname", null, locale);
    	String associateEditorEmail = messageSource.getMessage("test.email.associateEditorEmail", null, locale);
    	String associateEditorLocalJobTitle = messageSource.getMessage("test.email.associateEditorLocalJobTitle", null, locale);
    	model.put("associateEditorSalutation", associateEditorSalutation);
    	model.put("associateEditorFirstname", associateEditorFirstname);
    	model.put("associateEditorLastname", associateEditorLastname);
    	model.put("associateEditorLocalFullname", associateEditorLocalFullname);
       	model.put("associateEditorEmail", associateEditorEmail);
    	model.put("associateEditorLocalJobTitle", associateEditorLocalJobTitle);
    	
    	
    	String guestEditorSalutation = messageSource.getMessage("test.email.guestEditorSalutation", null, locale);
    	String guestEditorFirstname = messageSource.getMessage("test.email.guestEditorFirstname", null, locale);
    	String guestEditorLastname = messageSource.getMessage("test.email.guestEditorLastname", null, locale);
    	String guestEditorLocalFullname = messageSource.getMessage("test.email.guestEditorLocalFullname", null, locale);
    	String guestEditorEmail = messageSource.getMessage("test.email.guestEditorEmail", null, locale);
    	String guestEditorLocalJobTitle = messageSource.getMessage("test.email.guestEditorLocalJobTitle", null, locale);
    	model.put("guestEditorSalutation", guestEditorSalutation);
    	model.put("guestEditorFirstname", guestEditorFirstname);
    	model.put("guestEditorLastname", guestEditorLastname);
    	model.put("guestEditorLocalFullname", guestEditorLocalFullname);
    	model.put("guestEditorEmail", guestEditorEmail);
    	model.put("guestEditorLocalJobTitle", guestEditorLocalJobTitle);
    	

    	String managerSalutation = messageSource.getMessage("test.email.managerSalutation", null, locale);
    	String managerFirstname = messageSource.getMessage("test.email.managerFirstname", null, locale);
    	String managerLastname = messageSource.getMessage("test.email.managerLastname", null, locale);
    	String managerLocalFullname = messageSource.getMessage("test.email.managerLocalFullname", null, locale);
    	String managerEmail = messageSource.getMessage("test.email.managerEmail", null, locale);
    	String managerLocalJobTitle = messageSource.getMessage("test.email.managerLocalJobTitle", null, locale);
    	model.put("managerSalutation", managerSalutation);
    	model.put("managerFirstname", managerFirstname);
    	model.put("managerLastname", managerLastname);
    	model.put("managerLocalFullname", managerLocalFullname);
    	model.put("managerEmail", managerEmail);
    	model.put("managerLocalJobTitle", managerLocalJobTitle);
    	
    	
    	String reviewerSalutation = messageSource.getMessage("test.email.reviewerSalutation", null, locale);
    	String reviewerFirstname = messageSource.getMessage("test.email.reviewerFirstname", null, locale);
    	String reviewerLastname = messageSource.getMessage("test.email.reviewerLastname", null, locale);   
    	String reviewerLocalFullname = messageSource.getMessage("test.email.reviewerLocalFullname", null, locale);
    	String reviewerEmail = messageSource.getMessage("test.email.reviewerEmail", null, locale);
    	model.put("reviewerSalutation", reviewerSalutation);
    	model.put("reviewerFirstname", reviewerFirstname);
    	model.put("reviewerLastname", reviewerLastname);
    	model.put("reviewerLocalFullname", reviewerLocalFullname);
    	model.put("reviewerEmail", reviewerEmail);
    	
    	String newUserSalutation = messageSource.getMessage("test.email.newUserSalutation", null, locale);
    	String newUserFirstname = messageSource.getMessage("test.email.newUserFirstname", null, locale);
    	String newUserLastname = messageSource.getMessage("test.email.newUserLastname", null, locale);   
    	String newUserLocalFullname = messageSource.getMessage("test.email.newUserLocalFullname", null, locale);
    	String newUserEmail = messageSource.getMessage("test.email.newUserEmail", null, locale);
    	model.put("newUserSalutation", newUserSalutation);
    	model.put("newUserFirstname", newUserFirstname);
    	model.put("newUserLastname", newUserLastname);
    	model.put("newUserLocalFullname", newUserLocalFullname);
    	model.put("newUserEmail", newUserEmail);
    	
    	String otherAccountCreatorSalutation = messageSource.getMessage("test.email.otherAccountCreatorSalutation", null, locale);
    	String otherAccountCreatorFirstname = messageSource.getMessage("test.email.otherAccountCreatorFirstname", null, locale);
    	String otherAccountCreatorLastname = messageSource.getMessage("test.email.otherAccountCreatorLastname", null, locale);   
    	String otherAccountCreatorLocalFullname = messageSource.getMessage("test.email.otherAccountCreatorLocalFullname", null, locale);
    	String otherAccountCreatorEmail = messageSource.getMessage("test.email.otherAccountCreatorEmail", null, locale);
    	model.put("otherAccountCreatorSalutation", otherAccountCreatorSalutation);
    	model.put("otherAccountCreatorFirstname", otherAccountCreatorFirstname);
    	model.put("otherAccountCreatorLastname", otherAccountCreatorLastname);
    	model.put("otherAccountCreatorLocalFullname", otherAccountCreatorLocalFullname);
    	model.put("otherAccountCreatorEmail", otherAccountCreatorEmail);
    	
    	String journalTitle = messageSource.getMessage("test.email.journalTitle", null, locale);
    	String journalShortTitle=messageSource.getMessage("test.email.journalShortTitle", null, locale);
    	String journalShortTitleOrTitle = journalShortTitle != null ? journalShortTitle : journalTitle;
    	String journalTitleAndShortTitleInPaParentheses = journalShortTitle != null && !journalShortTitle.equals(journalTitle) ? journalTitle + " (" + journalShortTitle + ")" : journalTitle;
    	model.put("journalTitle", journalTitle);
    	model.put("journalShortTitle", journalShortTitle);
    	model.put("journalShortTitleOrTitle", journalShortTitleOrTitle);
    	model.put("journalTitleAndShortTitleInPaParentheses", journalTitleAndShortTitleInPaParentheses);
    	
    	String submissionDate = messageSource.getMessage("test.email.submissionDate", null, locale);
        model.put("submissionDate", submissionDate);
        
        String notificationDate = messageSource.getMessage("test.email.notificationDate", null, locale);
        model.put("notificationDate", notificationDate);
        
        String requestedUpdatedManuscriptSubmitDate = messageSource.getMessage("test.email.requestedUpdatedManuscriptSubmitDate", null, locale);
        model.put("requestedUpdatedManuscriptSubmitDate", requestedUpdatedManuscriptSubmitDate);
        
        String confirmedUpdatedManuscriptSubmitDate = messageSource.getMessage("test.email.confirmedUpdatedManuscriptSubmitDate", null, locale);
        model.put("confirmedUpdatedManuscriptSubmitDate", confirmedUpdatedManuscriptSubmitDate);
        
        String returnBackManuscriptReasonByManager = messageSource.getMessage("test.email.returnBackManuscriptReasonByManager", null, locale);
        model.put("returnBackManuscriptReasonByManager", returnBackManuscriptReasonByManager);
        
        String manuscriptAssignRequestRejectReasonByAE = messageSource.getMessage("test.email.manuscriptAssignRequestRejectReasonByAE", null, locale);
        model.put("manuscriptAssignRequestRejectReasonByAE", manuscriptAssignRequestRejectReasonByAE);
        
        String returnBackCameraReadyPaperReasonByManager = messageSource.getMessage("test.email.returnBackCameraReadyPaperReasonByManager", null, locale);
        model.put("returnBackCameraReadyPaperReasonByManager", returnBackCameraReadyPaperReasonByManager);
        
        String correctionCommentsForGalleryProofByAuthor = messageSource.getMessage("test.email.correctionCommentsForGalleryProofByAuthor", null, locale);
        model.put("correctionCommentsForGalleryProofByAuthor", correctionCommentsForGalleryProofByAuthor);
        
        String passwordChangeUrl = messageSource.getMessage("test.email.passwordChangeUrl", null, locale);
        model.put("passwordChangeUrl", passwordChangeUrl);
        
        String specialIssueTitle = messageSource.getMessage("test.email.specialIssueTitle", null, locale);
        model.put("specialIssueTitle", specialIssueTitle);
        
    	return model;
    }
    

	@RequestMapping(value="/sessionRefresh", method=RequestMethod.POST)
	public void sessionRefresh(Locale locale, Model model, HttpServletRequest request, @RequestParam("username") String username) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<SessionInformation> sessionsInfo = sessionRegistry.getAllSessions(user, false);
        if(null != sessionsInfo && sessionsInfo.size() > 0) {
            for (SessionInformation sessionInformation : sessionsInfo) {
                sessionRegistry.refreshLastRequest(sessionInformation.getSessionId());
                System.out.println(sessionInformation.getSessionId() + " : " + sessionInformation.getLastRequest());
            }
        }
	}
	*/
}