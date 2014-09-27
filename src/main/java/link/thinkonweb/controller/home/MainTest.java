package link.thinkonweb.controller.home;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptReviewerRecommendDao;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.ReviewerRecommend;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.recommend.RecommendService;
import link.thinkonweb.service.user.UserExpertiseService;

@Component
public class MainTest {
	@Inject
	private static KeywordDao keywordDao;
	@Inject
	private static UserExpertiseService userExpertiseService;
	@Inject
	private static RecommendService recommendService;
	@Autowired
	private static ManuscriptReviewerRecommendDao manuscriptReviewerRecommendDao;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
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
	}

}
