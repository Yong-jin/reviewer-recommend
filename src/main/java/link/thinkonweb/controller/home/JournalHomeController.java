package link.thinkonweb.controller.home;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ManuscriptReviewerRecommendDao;
import link.thinkonweb.dao.manuscript.ReviewDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ReviewerRecommend;
import link.thinkonweb.domain.roles.Reviewer;
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
	@Autowired
	private ManuscriptReviewerRecommendDao manuscriptReviewerRecommendDao;
	
	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value="/{jnid}", method=RequestMethod.GET)
	public ModelAndView journalHome(@PathVariable(value="jnid") String jnid, 
							  Locale locale, 
							  HttpSession session,
							  HttpServletRequest request,
							  HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		Journal journal = this.journalService.getByJournalNameId(jnid);
		mav.addObject("jnid", jnid);
		
		//HashMap<Manuscript, List<Reviewer>> recommend_List = recommendService.recommend_Assignment(journal);

		//밑줄 주석 해제 - 추천 수행
		
		recommendService.process_Recommend(journal); //수행 DB에 저장
		
		mav.setViewName("journal.home.journalHome");
		
		List<ReviewerRecommend> reviewerRecommends = manuscriptReviewerRecommendDao.findAll(); //DB에서 불러오기
		List<Keyword> keywords = new ArrayList<Keyword>();
		List<UserExpertise> expertises = new ArrayList<UserExpertise>();
		
		int manuscriptId = reviewerRecommends.get(0).getManuscript_id();
		System.out.println("\nPaper Id " + manuscriptId + "`s Recommend List");
		for(Keyword k :  keywordDao.findByManuscriptId(manuscriptId)) //(manuscriptDao.findById(manuscriptId)).getKeywords()  )
		{
			System.out.print(k.getKeyword()+"\n");
		}
		System.out.println();
		for(ReviewerRecommend r: reviewerRecommends)
		{
			if( manuscriptId == r.getManuscript_id()) {
				System.out.println(" - " + r.getReviewer_user_id());
				for(UserExpertise ue: userExpertiseService.getExpertises(r.getReviewer_user_id()) )
				{
					System.out.print(ue.getExpertise() + "\n");
				}
				System.out.println();
				System.out.println("	F_value : " + r.getRecommend_value());
				System.out.println("	FR_value : " + r.getFr_value());
			}
			else {
				manuscriptId = r.getManuscript_id();
				System.out.println("\nPaper Id " + manuscriptId + "`s Recommend List");
				for(Keyword k : keywordDao.findByManuscriptId(manuscriptId) )
				{
					System.out.print(k.getKeyword()+"\n");
				}
				System.out.println();
				System.out.println(" - " + r.getReviewer_user_id());
				for(UserExpertise ue: userExpertiseService.getExpertises(r.getReviewer_user_id()) )
				{
					System.out.print(ue.getExpertise() + "\n");
				}
				System.out.println();
				System.out.println("	F_value : " + r.getRecommend_value());
				System.out.println("	FR_value : " + r.getFr_value());

			}
		}
		
		System.out.println("Fitness value : " + recommendService.fitness_function(reviewerRecommends));
		/*
		for(Manuscript m: recommend_List.keySet())
		{
			System.out.println("Manuscript : " + m.getId());
			for(Reviewer r: recommend_List.get(m))
			{
				System.out.println("Reviewer : " + r.getUser().getId());
			}
		}
		*/
		return mav;
	}
}
