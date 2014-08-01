package link.thinkonweb.controller.journal;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.LocalJobTitleDesignation;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/journals")
public class SignupAtJournalController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(SignupAtJournalController.class);
	@Autowired
	private JournalService journalService;
	@Autowired
	private UserService userService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private EmailService emailService;
	@Autowired
	private MessageSource messageSource;
	
	@Transactional(readOnly = true)
	@RequestMapping(value="{jnid}/journalSignup", method=RequestMethod.GET)
	public ModelAndView journalSignup(@PathVariable(value="jnid") String jnid, Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) {
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		
		ModelAndView mav = new ModelAndView();
		Contact contact = new Contact();
		contact.setCountryCode(new CountryCode());
		SystemUser user = new SystemUser();
		user.setContact(contact);
		
		Journal journal = this.journalService.getByJournalNameId(jnid);
		
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i = 0; i < DegreeDesignation.values().length; i++) {
			degreeDesignations.add(DegreeDesignation.getType(i));
		}
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i = 0; i < SalutationDesignation.values().length; i++) {
			salutationDesignations.add(SalutationDesignation.getType(i));
		}
		
		if (journal.getLanguageCode().equals("ko")) {
			localeResolver.setLocale(request, response, new Locale("ko", "KR"));
			List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
			for (int i = 0; i < LocalJobTitleDesignation.values().length; i++) {
				localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
			}
			mav.addObject("localJobTitleDesignations", localJobTitleDesignations);
		} else {
			localeResolver.setLocale(request, response, new Locale("en", "US"));
		}
		
		mav.addObject("degreeDesignations", degreeDesignations);
		mav.addObject("salutationDesignations", salutationDesignations);		
		mav.addObject("journal", journal);
		mav.addObject("user", user);
		mav.setViewName("home.signup");
		return mav;
	}
	
	@RequestMapping(value="{jnid}/journalSignup", method=RequestMethod.POST)
	public ModelAndView journalSignupSubmit(@PathVariable(value="jnid") String jnid, 
										Model model,
										@ModelAttribute("user") SystemUser user,
										BindingResult result,
										SessionStatus status,
										HttpServletRequest request, 
										HttpServletResponse response, Locale locale) {
		ModelAndView mav = new ModelAndView();
		if (result.hasErrors()) {
			mav.addObject("user", user);
			mav.setViewName("home.signup");
			return mav;
		} else {
			user.setEnabled(true);
			this.userService.create(user);
			status.setComplete();
			
			SystemUser storedUser = this.userService.getByUsername(user.getUsername());			
			authorityService.create(storedUser.getId(), this.journalService.getByJournalNameId(jnid).getId(), SystemConstants.roleMember);
			
			emailService.sendEmailAtAccountCreation(50, user, user, this.journalService.getByJournalNameId(jnid), null, request, locale);
			
			RedirectView rv = new RedirectView("../" + jnid);
			mav.setView(rv);
			return mav;
		}
	}
}