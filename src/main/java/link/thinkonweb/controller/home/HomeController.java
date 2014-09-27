package link.thinkonweb.controller.home;


import java.util.Locale;

import javax.inject.Inject;
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
	@Inject
	private UserService userService;
	
	@Inject
	private JournalService journalService;
		
	@Inject
	private AuthorityService authorityService;
	
	@Inject
	private ServletContext context;
	
	@Inject
	private ChangePasswordCodeDao changePasswordCodeDao;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("home.signin");
		return mav;
	}
}