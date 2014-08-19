package link.thinkonweb.controller.home;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.recommend.RecommendService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserExpertiseService;
import link.thinkonweb.service.user.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private UserExpertiseService userExpertiseService;
	@Autowired
	private RecommendService recommendService;
	
	@RequestMapping(value="/{jnid}", method=RequestMethod.GET)
	public ModelAndView journalHome(@PathVariable(value="jnid") String jnid, 
							  Locale locale, 
							  HttpSession session,
							  HttpServletRequest request,
							  HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		Journal journal = this.journalService.getByJournalNameId(jnid);
		mav.addObject("jnid", jnid);
		
		HashMap<Manuscript, List<Reviewer>> recommend_List = recommendService.recommend_Assignment(journal);
		mav.setViewName("journal.home.journalHome");
		
		System.out.println("test 1");
		
		for(Manuscript m: recommend_List.keySet())
		{
			System.out.println("Manuscript : " + m.getId());
			for(Reviewer r: recommend_List.get(m))
			{
				System.out.println("Reviewer : " + r.getUser().getId());
			}
		}
		return mav;
	}
}
