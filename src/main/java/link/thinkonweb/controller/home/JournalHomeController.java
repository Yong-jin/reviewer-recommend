package link.thinkonweb.controller.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
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
		
		List<String> reviewStatus = new ArrayList<String>();
		//reviewStatus.add(SystemConstants.reviewerI);
		reviewStatus.add(SystemConstants.reviewerA);
		List<Manuscript> manuscripts = new ArrayList<Manuscript>();
		List<Manuscript> newManuscripts = manuscriptService.getSubmittedManuscripts(journal.getId(), SystemConstants.statusO, 0);
		List<Manuscript> updatedManuscripts = manuscriptService.getSubmittedManuscripts(journal.getId(), SystemConstants.statusR, Integer.MAX_VALUE);
		for(Manuscript manuscript: newManuscripts)
			manuscripts.add(manuscript);
		
		for(Manuscript manuscript: updatedManuscripts)
			manuscripts.add(manuscript);
		
		for(Manuscript manuscript: manuscripts) {
		  List<Keyword> keywords = manuscript.getKeywords();
		  System.out.println("Manuscript ID: " + manuscript.getId());
		  System.out.print("Keyword: ");
		  for(Keyword keyword: keywords)
		    System.out.print(keyword.getKeyword() + ", ");
		  System.out.println();
		  
		  System.out.println("Authors");
		  List<Integer> coAuthorUserIds = coAuthorDao.findCoAuthorIds(manuscript.getId(), -1, 0, false);
		  for(Integer id: coAuthorUserIds)
			  System.out.print(id + ", ");
		  System.out.println();
		  
		  //int numCurrentReview = reviewerService.numReviewManuscripts(0, manuscript.getId(), journal.getId(), manuscript.getRevisionCount(), reviewStatus);
		 // System.out.println("Current Review: " + numCurrentReview);
		  List<Review> reviews = reviewerService.getReviews(0, manuscript.getId(), journal.getId(), manuscript.getRevisionCount(), SystemConstants.reviewerA);
		  if(reviews != null)
			  System.out.println("number of current review of this paper: " + reviews.size());
		  
		  for(Review review: reviews) {
			  int userId = review.getUserId();
			  SystemUser reviewerUser = userService.getById(userId);
			  System.out.println(reviewerUser.getUsername());	//email
			  System.out.println(reviewerUser.getContact().getFirstName());	//firstname
			  System.out.println(reviewerUser.getContact().getLastName());	//lastname
		  }
		  
		  int userId = 45;
		  List<Review> reviewsOfUser = reviewerService.getReviews(userId, manuscript.getId(), journal.getId(), manuscript.getRevisionCount(), SystemConstants.reviewerA);
		  if(reviewsOfUser == null)
			  System.out.println("this reviewer review XX");
		  else
			  System.out.println("this reviewer review O");
		  
		}
		
		List<Reviewer> reviewers = reviewerService.getReviewers(0, journal.getId());	//all reviewer
		List<Reviewer> filteredReviewers = new ArrayList<Reviewer>();	//filtered reviewers
		for(Reviewer reviewer: reviewers) {
		  System.out.println("Reviewer User ID: " + reviewer.getUser().getId());
		  SystemUser reviewerUser = reviewer.getUser();
		  List<UserExpertise> expertises = userExpertiseService.getExpertises(reviewerUser.getId());
		  System.out.print("Expertise: ");
		  for(UserExpertise ue: expertises)
		    System.out.print(ue.getExpertise() + ", ");
		  System.out.println();
		  int numCurrentReview = reviewerService.numReviewManuscripts(reviewer.getUser().getId(), 0, journal.getId(), -1, reviewStatus);
		  System.out.println("Current Reviewing Manuscripts: " + numCurrentReview);
		  if(numCurrentReview < 3)
			  filteredReviewers.add(reviewer);
		  
		}
		
		for(Reviewer reviewer: filteredReviewers) {
			//
		}
		
		mav.setViewName("journal.home.journalHome");
		return mav;
	}
}
