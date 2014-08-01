package link.thinkonweb.controller.home;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.LocalJobTitleDesignation;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserExpertiseService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/account/*")
public class MyAccountController {	
	@Autowired
	private UserService userService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private CoAuthorDao coAuthorsDao;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private ContactService contactService;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private CountryCodeDao countryCodeDao;
	@Autowired
	private ShaPasswordEncoder shaPasswordEncoder;
	@Autowired
	private UserExpertiseService userExpertiseService;

	@Transactional(readOnly = true)
	@RequestMapping(value="/myAccount", method=RequestMethod.GET)
	public String myAccount(Locale locale, Model model, HttpServletRequest request) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		SystemUser loginUser = this.userService.getByUsername(username);
		
		boolean isLocalInformationNeeded = false;
		if (loginUser.getContact().getCountry().equals("KR") || this.journalService.isMemberOfNonEnglishJournal(loginUser))
			isLocalInformationNeeded = true;
		
		Map<String,String> countries = null;
		try {
			countries = getCountryMap(loginUser.getContact().getCountry());
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i = 0; i < DegreeDesignation.values().length; i++)
			degreeDesignations.add(DegreeDesignation.getType(i));
		
		model.addAttribute("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i = 0; i < SalutationDesignation.values().length; i++)
			salutationDesignations.add(SalutationDesignation.getType(i));
		
		model.addAttribute("salutationDesignations", salutationDesignations);			
		
		List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
		for (int i=0; i<LocalJobTitleDesignation.values().length; i++)
			localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
		
		model.addAttribute("localJobTitleDesignations", localJobTitleDesignations);
		
		model.addAttribute("user", loginUser);
		model.addAttribute("isLocalInformationNeeded", isLocalInformationNeeded);
		model.addAttribute("countries", countries);
		model.addAttribute("expertises", userExpertiseService.getExpertises(loginUser.getId()));
		
		return "home.myAccount";
	}
	
	@RequestMapping(value="/myAccountSave", method=RequestMethod.POST)
	public @ResponseBody String myAccountUpdate(@ModelAttribute("user") SystemUser user, BindingResult result, Locale locale, Model model, HttpServletRequest request) {
		SystemUser storedUser = this.userService.getByUsername(user.getUsername());
		Contact oldContactInfo = storedUser.getContact();
		Contact newContactInfo = user.getContact();
		if (oldContactInfo.getFirstName() == null || !oldContactInfo.getFirstName().equals(newContactInfo.getFirstName())) {
			oldContactInfo.setFirstName(newContactInfo.getFirstName());
		}
		if (oldContactInfo.getLastName() == null || !oldContactInfo.getLastName().equals(newContactInfo.getLastName())) {
			oldContactInfo.setLastName(newContactInfo.getLastName());
		}
		if (oldContactInfo.getDegree() == null || !oldContactInfo.getDegree().equals(newContactInfo.getDegree())) {
			oldContactInfo.setDegree(newContactInfo.getDegree());
		}
		if (oldContactInfo.getSalutation() == null || !oldContactInfo.getSalutation().equals(newContactInfo.getSalutation())) {
			oldContactInfo.setSalutation(newContactInfo.getSalutation());
		}
		if (oldContactInfo.getInstitution() == null || !oldContactInfo.getInstitution().equals(newContactInfo.getInstitution())) {
			oldContactInfo.setInstitution(newContactInfo.getInstitution());
		}
		if (oldContactInfo.getDepartment() == null || !oldContactInfo.getDepartment().equals(newContactInfo.getDepartment())) {
			oldContactInfo.setDepartment(newContactInfo.getDepartment());
		}
		if (oldContactInfo.getCountry() == null || !oldContactInfo.getCountry().equals(newContactInfo.getCountry())) {
			oldContactInfo.setCountry(newContactInfo.getCountry());
		}
		if (oldContactInfo.getPhone() == null || !oldContactInfo.getPhone().equals(newContactInfo.getPhone())) {
			oldContactInfo.setPhone(newContactInfo.getPhone());
		}
		if (oldContactInfo.getMobile() == null || !oldContactInfo.getMobile().equals(newContactInfo.getMobile())) {
			oldContactInfo.setMobile(newContactInfo.getMobile());
		}
		if (oldContactInfo.getFax() == null || !oldContactInfo.getFax().equals(newContactInfo.getFax())) {
			oldContactInfo.setFax(newContactInfo.getFax());
		}
		if (oldContactInfo.getWebsite() == null || !oldContactInfo.getWebsite().equals(newContactInfo.getWebsite())) {
			oldContactInfo.setWebsite(newContactInfo.getWebsite());
		}
		if (oldContactInfo.getAbout() == null || !oldContactInfo.getAbout().equals(newContactInfo.getAbout())) {
			oldContactInfo.setAbout(newContactInfo.getAbout());
		}
		this.contactService.update(oldContactInfo);
		return "success";
	}
	
	@RequestMapping(value="/myLocalInfoSave", method=RequestMethod.POST)
	public @ResponseBody String myLocalInfoUpdate(@ModelAttribute("user") SystemUser user, BindingResult result, Locale locale, Model model, HttpServletRequest request) {
		SystemUser storedUser = this.userService.getByUsername(user.getUsername());
		Contact oldContactInfo = storedUser.getContact();
		Contact newContactInfo = user.getContact();
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
		return "success";
	}
	
	@RequestMapping(value="/cpCheck", method=RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean isCurrentPasswordCorrect(@RequestBody String data, HttpServletRequest request) {
		StringTokenizer st = new StringTokenizer(data, "&");
		String username = st.nextToken().trim();
		String cp = st.nextToken().trim();
		
		String encodedPassword = shaPasswordEncoder.encodePassword(cp, username.trim());
		String currentPassword = this.userService.getByUsername(username.trim()).getPassword();
		if (encodedPassword.equals(currentPassword)) 
			return true;
		else 
			return false;
	}
	@Transactional(readOnly = true)
	@RequestMapping(value="/recommendExpertise", method=RequestMethod.GET, headers ={"Accept=application/json"})
	public @ResponseBody String recommendExpertise(HttpServletRequest request, @RequestParam("query") String query) {
		return this.userExpertiseService.getAllUniqueExpertisesAsJSONStringByQuery(query); 
	}
	
	@RequestMapping(value="/updateExpertise", method=RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody void updateExpertise(@RequestBody String data, HttpServletRequest request) {
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		this.userExpertiseService.deleteAllExpertises(user.getId());
		try {
			String decodedData = URLDecoder.decode(data, "UTF-8");
		
			StringTokenizer st = new StringTokenizer(decodedData, ",=");
			String capitalizedString = null;
			while (st.hasMoreTokens()) {
				capitalizedString = systemUtil.capitalize((String)st.nextElement());
				this.userExpertiseService.insertExpertise(new UserExpertise(user.getId(), capitalizedString));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/passwordChange", method=RequestMethod.POST)
	public @ResponseBody String passwordChange(Locale locale, Model model, HttpServletRequest request) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		SystemUser loginUser = this.userService.getByUsername(auth.getName());
		SystemUser storedUser = this.userService.getByUsername(request.getParameter("username").trim());
		if (loginUser.getId() == storedUser.getId()) {
			this.userService.changePassword(request.getParameter("np"), storedUser.getId(), request.getParameter("username").trim());
			return "success";
		} else {
			return "false";
		}
	}
	

	
	@RequestMapping(value="/journalSubscribe", method=RequestMethod.GET)
	public ModelAndView journalSubscribe(Locale locale, Model model, HttpServletRequest request, @RequestParam("jnid") String jnid) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		SystemUser loginUser = this.userService.getByUsername(auth.getName());
		Journal journal = this.journalService.getByJournalNameId(jnid);
		this.authorityService.create(loginUser.getId(), journal.getId(), SystemConstants.roleMember);
		//TODO ROLE_MEMBER 가입할 때 session 새로 고침
		
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("../journals/"+ jnid);
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
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
}