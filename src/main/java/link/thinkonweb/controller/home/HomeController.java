package link.thinkonweb.controller.home;


import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.user.ChangePasswordCodeDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.ChangePasswordCode;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/*")
public class HomeController {	
//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SignupController signupController;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JournalService journalService;
		
	@Autowired
	private AuthorityService authorityService;
	
	@Autowired
	private ServletContext context;
	
	@Autowired
	private ChangePasswordCodeDao changePasswordCodeDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();

		if (username.equals("anonymousUser")) {
			mav.setViewName("home.signin");
			return mav;
		} else {
			RedirectView rv = new RedirectView("activity/myActivity");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}

	@Transactional
	@RequestMapping(value="/resetPassword", method=RequestMethod.POST)
	public @ResponseBody Boolean resetPassword(Locale locale, Model model, HttpServletRequest request, @RequestParam("username") String username) {
		userService.resetPassword(username, request, locale);
		return true;
	}

	@Transactional(readOnly = true)	
	@RequestMapping(value="/changePassword", method=RequestMethod.GET)
	public ModelAndView changePassword(Model model, @RequestParam(value="code") String code) {
		ModelAndView mav = new ModelAndView();
		try {
			ChangePasswordCode changePasswordCode = changePasswordCodeDao.getChangePasswordCodeByCode(code);
			if (changePasswordCode != null && !changePasswordCode.isExpired()) {
				
				mav.setViewName("home.changePassword");	
				
				SystemUser targetUser = userService.getByUsername(changePasswordCode.getEmail());
				model.addAttribute("userId", targetUser.getId());
				model.addAttribute("email", targetUser.getUsername());
				model.addAttribute("code", code);
			} else {
				RedirectView rv = new RedirectView("/");
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
		
	}

	@Transactional
	@RequestMapping(value="/changePassword", method=RequestMethod.POST)
	public @ResponseBody Boolean changePasswordProcess(Model model, @RequestParam(value="code") String code,
			@RequestParam(value="np") String password,
			@RequestParam(value="email") String email) {
		ChangePasswordCode changePasswordCode = changePasswordCodeDao.getChangePasswordCodeByCode(code);
		if(changePasswordCode == null)
			return false;
		
		try {			
			SystemUser targetUser = userService.getByUsername(email);
			targetUser.setPassword(password);
			userService.changePassword(password, targetUser.getId(), email);
			changePasswordCode.setExpired(true);
			changePasswordCodeDao.update(changePasswordCode);
			targetUser = userService.getByUsername(email);
			
			authorityService.authenticateUserAndSetSession(targetUser);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return true;
	}
	
	@RequestMapping(value="/promotion", method=RequestMethod.GET)
	public String promotion(Locale locale, Model model) {
		return "promotion.home";
	}
	
	@RequestMapping(value="/promotionSignin", method=RequestMethod.GET)
	public ModelAndView promotionSignin(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		if (username.equals("anonymousUser")) {
			mav.setViewName("promotion.signin");
			return mav;
		} else { 
			RedirectView rv = new RedirectView("activity/myActivity");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
	
	@RequestMapping(value="/signinFailed", method = RequestMethod.GET)
	public ModelAndView signinFailed(Model model, HttpServletRequest request, RedirectAttributes redirectAttrs) {
		ModelAndView mav = new ModelAndView();
		redirectAttrs.addFlashAttribute("signinError", "true");
		
		String refererUrl = request.getHeader("Referer");
		if (refererUrl.contains("/journals/")) {
			int fromIndex = refererUrl.indexOf("/journals/") + 10;
			String jnid = null;
			if (refererUrl.contains("?")) {
				jnid = refererUrl.substring(fromIndex, refererUrl.indexOf("?"));
			} else {
				jnid = refererUrl.substring(fromIndex);
			}			
			RedirectView rv = new RedirectView(context.getContextPath() + "/journals/" + jnid);
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
		} else if (refererUrl.contains("/promotionSignin")) {
			RedirectView rv = new RedirectView(context.getContextPath() + "/promotionSignin");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
		} else {
			String contextPath = context.getContextPath();
			if (contextPath.length() == 0) {
				contextPath = "/";
			}
			RedirectView rv = new RedirectView(contextPath);
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
		}
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/signinSuccess", method=RequestMethod.GET)
	public ModelAndView signinSuccess(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		SystemUser user = null;
		if (authorityService.getUserDetails() != null) {
			user = userService.getByUsername(authorityService.getUserDetails().getUsername());
			request.getSession().setAttribute("user", user);
		}
		
		/*
		if (authorityService.hasRole("ROLE_SUPER_MANAGER")) {
			RedirectView rv = new RedirectView("superManager/dashboard");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
		*/
		
		String refererUrl = request.getHeader("Referer");		
		if (refererUrl.contains("/journals/")) {
			int fromIndex = refererUrl.indexOf("/journals/") + 10;
			String jnid = null;
			if (refererUrl.contains("?")) {
				jnid = refererUrl.substring(fromIndex, refererUrl.indexOf("?"));
			} else {
				jnid = refererUrl.substring(fromIndex);
			}
	    	
			Journal journal = this.journalService.getByJournalNameId(jnid);
			Authority authority = authorityService.getAuthority(user.getId(), journal.getId(), SystemConstants.roleMember);
			
			if (authority == null) {
				mav.addObject("journal", journal);
				mav.setViewName("journal.home.journalSubscribe");
				return mav;
			} else {
				RedirectView rv = new RedirectView("journals/"+ jnid);
				rv.setExposeModelAttributes(false);
				mav.setView(rv);
				return mav;
			}
		} else if (refererUrl.contains("/submitJournal")) {
			RedirectView rv = new RedirectView("submitJournal");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		} else {
			RedirectView rv = new RedirectView("activity/myActivity");
			rv.setExposeModelAttributes(false);
			mav.setView(rv);
			return mav;
		}
	}
}