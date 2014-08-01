package link.thinkonweb.controller.home;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.constants.DegreeDesignation;
import link.thinkonweb.domain.constants.LocalJobTitleDesignation;
import link.thinkonweb.domain.constants.SalutationDesignation;
import link.thinkonweb.domain.user.Contact;
import link.thinkonweb.domain.user.CountryCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.email.EmailService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/*")
@SessionAttributes({"contact", "user"})
public class SignupController {	
	@Autowired
	private ContactService contactService;
	
	@Autowired
	private UserService userService;
		
	@Autowired
	private CountryCodeDao countryCodeDao;
	
	@Autowired
	private AuthorityService authorityService;
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private EmailService emailService;
	
	public SignupController() {
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/signup", method=RequestMethod.GET)
	public String setupUserForm(Model model, HttpServletRequest request, Locale locale) {
		Contact contact = new Contact();
		contact.setCountryCode(new CountryCode());
		SystemUser user = new SystemUser();
		user.setContact(contact);
		String refererUrl = request.getHeader("Referer");
		if (refererUrl.contains("/submitJournal")) {
			model.addAttribute("isFromSubmitJournal", true);
		}
		
		List<DegreeDesignation> degreeDesignations = new LinkedList<DegreeDesignation>();
		for (int i = 0; i < DegreeDesignation.values().length; i++) {
			degreeDesignations.add(DegreeDesignation.getType(i));
		}
		model.addAttribute("degreeDesignations", degreeDesignations);		
		
		List<SalutationDesignation> salutationDesignations = new LinkedList<SalutationDesignation>();
		for (int i = 0; i < SalutationDesignation.values().length; i++) {
			salutationDesignations.add(SalutationDesignation.getType(i));
		}
		model.addAttribute("salutationDesignations", salutationDesignations);			
		
		List<LocalJobTitleDesignation> localJobTitleDesignations = new LinkedList<LocalJobTitleDesignation>();
		for (int i = 0; i < LocalJobTitleDesignation.values().length; i++) {
			localJobTitleDesignations.add(LocalJobTitleDesignation.getType(i));
		}
		model.addAttribute("localJobTitleDesignations", localJobTitleDesignations);
		
		model.addAttribute("user", user);
		return "home.signup";
	}
	
	@RequestMapping(value = "/signup", method=RequestMethod.POST)
	public ModelAndView submitUserForm(@ModelAttribute("user") SystemUser user, 
							 	 BindingResult result, 
							 	 HttpServletRequest request,
							 	 SessionStatus status, 
							 	 Model model, Locale locale) {
		ModelAndView mav = new ModelAndView();		
		if (result.hasErrors()) {
			List<FieldError> errors = result.getFieldErrors();
		    for (FieldError error : errors ) {
		        System.out.println (error.getObjectName() + " - " + error.getDefaultMessage());
		    }
			
			model.addAttribute("user", user);
			mav.setViewName("home.signup");
			System.out.println("error");
			return mav;
		} else {
			user.setEnabled(true);
			this.userService.create(user);		
			status.setComplete();
			
			boolean isFromSubmitJournal = Boolean.parseBoolean(request.getParameter("isFromSubmitJournal"));
			if (isFromSubmitJournal) {
				RedirectView rv = new RedirectView("submitJournal");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
			} else {
				RedirectView rv = new RedirectView("promotion");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
			}
			
			emailService.sendEmailAtAccountCreation(49, user, user, null, null, request, locale);
			return mav;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/usernameDuplicateCheck", method=RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean isUsernameDuplicated(@RequestParam("username") String username, HttpServletRequest request) {
		if (userService.isUniqueUsername(username)) 
			return true;
		else 
			return false;
	}
}