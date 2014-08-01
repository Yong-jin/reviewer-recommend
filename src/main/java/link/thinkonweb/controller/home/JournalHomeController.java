package link.thinkonweb.controller.home;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/journals")
public class JournalHomeController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(JournalHomeController.class);
	
	@Autowired
	private JournalService journalService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AuthorityService authorityService;
	
	@Autowired
	private ManuscriptDao manuscriptDao;
	
	@RequestMapping(value="/{jnid}", method=RequestMethod.GET)
	public ModelAndView journalHome(@PathVariable(value="jnid") String jnid, 
							  Locale locale, 
							  HttpSession session,
							  HttpServletRequest request,
							  HttpServletResponse response,
							  @RequestParam(value="id", required=false) String username) {
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		
		ModelAndView mav = new ModelAndView();
		
		Journal journal = this.journalService.getByJournalNameId(jnid);
		mav.addObject("jnid", jnid);
		if (journal == null) {
			mav.setViewName("exception.404");
			return mav;
		} else {			
			if (authorityService.getUserDetails() == null) { // 대부분 이곳으로 들어옴
				if (request.getParameter("lang") == null) {
					if (journal.getLanguageCode().equals("ko")) {
						localeResolver.setLocale(request, response, new Locale("ko", "KR"));
					} else {
						localeResolver.setLocale(request, response, new Locale("en", "US"));
					}
				}
				mav.addObject("journal", journal);
				if (username != null)
					mav.addObject("loginUsername", username);
				mav.setViewName("journal.home.signin");
				return mav;
			} else {
				SystemUser user = this.userService.getByUsername(authorityService.getUserDetails().getUsername());
				if(!journal.isEnabled()) {
					if(authorityService.getAuthority(user.getId(), journal.getId(), SystemConstants.roleManager) != null) {
						String nextStep = "1";
						if(journal.getLanguageCode().equals("ko") && user.getContact().getLocalJobTitle() == null)
							nextStep = "0";
						
						RedirectView rv = new RedirectView("journals/"+ journal.getJournalNameId() + "/manager/configuration/journal/setup/step/" + nextStep);
						rv.setExposeModelAttributes(false);
						mav.setView(rv);
					} else {
						if(journal.getCreator() != null)
							mav.addObject("creator", journal.getCreator());
						mav.setViewName("exception.disabled");
					}
					return mav;
				} 
				
				/*else if(!journal.isPaid()) {
					if(journal.getCreator() != null)
						mav.addObject("creator", journal.getCreator());
					mav.setViewName("exception.unpaid");
					return mav;
				}
				
*/				if (authorityService.getAuthority(user.getId(), journal.getId(), SystemConstants.roleMember) == null) {
					mav.addObject("journal", journal);
					mav.setViewName("journal.home.journalSubscribe");
					return mav;
				} else {
					
					List<Authority> authorities = this.authorityService.getAuthorities(user.getId(), journal.getId(), null);
					
					Collections.sort(authorities, new Comparator<Authority>() {
						@Override
						public int compare(Authority a1, Authority a2) {
							if (a1.getRole().equals(SystemConstants.roleCEditor) && !a2.getRole().equals(SystemConstants.roleCEditor))
								return 1;
							else if (a1.getRole().equals(SystemConstants.roleManager) && !a2.getRole().equals(SystemConstants.roleManager))
								return -1;
							else if (a1.getRole().equals(SystemConstants.roleAEditor) && !a2.getRole().equals(SystemConstants.roleAEditor))
								return -1;
							else if (a1.getRole().equals(SystemConstants.roleGEditor) && !a2.getRole().equals(SystemConstants.roleGEditor))
								return -1;
							else if (a1.getRole().equals(SystemConstants.roleBMember) && !a2.getRole().equals(SystemConstants.roleBMember))
								return -1;
							else if (a1.getRole().equals(SystemConstants.roleReviewer) && !a2.getRole().equals(SystemConstants.roleReviewer))
								return -1;
							else 
								return 0;					
						}
					});
					List<String> roles = new ArrayList<String>();
					for(Authority a: authorities) {
						roles.add(a.getRole());
					}
					if (request.getParameter("lang") == null) {
						if (journal.getLanguageCode().equals("ko")) {
							localeResolver.setLocale(request, response, new Locale("ko", "KR"));
						} else {
							localeResolver.setLocale(request, response, new Locale("en", "US"));
						}
					}
					/*{SystemConstants.statusB, SystemConstants.statusI, SystemConstants.statusO, SystemConstants.statusR, 
					SystemConstants.statusE, SystemConstants.statusD, SystemConstants.statusV, SystemConstants.statusA, SystemConstants.statusM, 
					SystemConstants.statusG, SystemConstants.statusP, SystemConstants.statusJ, SystemConstants.statusW};
					*/
					List<String> submittedAndConfirmedStatus = new ArrayList<String>();
					submittedAndConfirmedStatus.add(SystemConstants.statusO);
					submittedAndConfirmedStatus.add(SystemConstants.statusR);
					submittedAndConfirmedStatus.add(SystemConstants.statusE);
					submittedAndConfirmedStatus.add(SystemConstants.statusD);
					submittedAndConfirmedStatus.add(SystemConstants.statusV);
					submittedAndConfirmedStatus.add(SystemConstants.statusA);
					submittedAndConfirmedStatus.add(SystemConstants.statusM);
					submittedAndConfirmedStatus.add(SystemConstants.statusG);
					submittedAndConfirmedStatus.add(SystemConstants.statusP);
					submittedAndConfirmedStatus.add(SystemConstants.statusJ);
					submittedAndConfirmedStatus.add(SystemConstants.statusW);
					int numSubmittedAndConfirmedStatus = manuscriptDao.numSubmittedManuscripts(0, journal.getId(), submittedAndConfirmedStatus);
					mav.addObject("numSubmittedAndConfirmedStatus", numSubmittedAndConfirmedStatus);
					
					List<String> underReviewdStatus = new ArrayList<String>();
					underReviewdStatus.add(SystemConstants.statusR);
					underReviewdStatus.add(SystemConstants.statusE);

					int numInReviewStatus = manuscriptDao.numSubmittedManuscripts(0, journal.getId(), underReviewdStatus);
					mav.addObject("numInReviewStatus", numInReviewStatus);
					
					List<String> acceptStatus = new ArrayList<String>();
					acceptStatus.add(SystemConstants.statusA);
					acceptStatus.add(SystemConstants.statusM);
					acceptStatus.add(SystemConstants.statusG);
					acceptStatus.add(SystemConstants.statusP);
					int numAcceptStatus = manuscriptDao.numSubmittedManuscripts(0, journal.getId(), acceptStatus);
					mav.addObject("numAcceptStatus", numAcceptStatus);
					
					request.getSession().setAttribute("authorityService", authorityService);
					request.getSession().setAttribute("journal", journal);
					request.getSession().setAttribute("roles", roles);
					request.getSession().setAttribute("username", user.getUsername());
					mav.setViewName("journal.home.journalHome");
					return mav;
				}
			} 
		}
	}
	
	@RequestMapping(value="/{jnid}/serviceDetail", method=RequestMethod.GET)
	public ModelAndView serviceDetail(@PathVariable(value="jnid") String jnid, 
							  Locale locale, 
							  HttpServletRequest request,
							  @RequestParam(value="serviceType", required=true) String serviceType) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("serviceType", serviceType);
		mav.setViewName("journal.home.serviceDetail");
		return mav;
	}
}