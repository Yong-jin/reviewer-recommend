package link.thinkonweb.service.recommend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.ManuscriptReviewerRecommendDao;
import link.thinkonweb.dao.manuscript.ReviewEventDateTimeDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewerRecommend;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.UserExpertiseService;

import org.springframework.beans.factory.annotation.Autowired;

public class RecommendService {
	private List<Keyword> keywords;
	private List<UserExpertise> expertises;
	@Autowired
	private UserExpertiseService userExpertiseService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ReviewEventDateTimeDao reviewEventDateTimeDao;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private ManuscriptReviewerRecommendDao manuscriptReviewerRecommendDao;

	private HashMap<Reviewer, Integer> recommend_constraint = new HashMap<Reviewer, Integer>();
	
	public double commonKeywords(Manuscript m, SystemUser r) {  //공통키워드 수 찾기
		double common = 0;

		keywords = m.getKeywords();
		expertises = userExpertiseService.getExpertises(r.getId()); 
		for(Keyword keyword: keywords)
		{
			for(UserExpertise ue: expertises)
			{
				if( (keyword.getKeyword()).equals( ue.getExpertise() ) )
				{
					common++;
				}
			}
		}

		return common;
	}

	public double functionU(Manuscript m, SystemUser r) { //공통키워드수 찾기 함수 이용해서 functionU완료
		double result = 0;
		double common = 0;

		common = commonKeywords(m, r);
		keywords = m.getKeywords();

		if(common == 0)
			return 0;

		result = common / keywords.size();
		return result;
	}

	public double functionV(Manuscript m, SystemUser r, Journal journal) { //SystemUser 을 Reviewer의 개념으로 사용  //일단완료
		double result = 0;
		double sumU = 0;
		double sd = 0;
		keywords = m.getKeywords();
		List<Double> commonValues = new ArrayList<Double>();

		//m을 review 중인 컴토자 찾아서 진행
		List<Review> reviews = reviewerService.getReviews(0, m.getId(), journal.getId(), m.getRevisionCount(), SystemConstants.reviewerA);
		if(reviews != null)
			for(Review re: reviews) {
				sumU += functionU(m, re.getUser());  //원래 리뷰중이던 리뷰어들의 functionU의 값을 합산
				commonValues.add(commonKeywords(m, re.getUser()));
			}
		sumU += functionU(m, r);   //새로 하나 추가해보고 싶은 r에 대한 functionU의 값도 합산
		commonValues.add(commonKeywords(m, r));

		sd = standardDeviation(commonValues);

		result = sumU - sd;

		return result;
	}

	public double function_F(Manuscript m, SystemUser r, Journal journal) {  //functionF =  (a)FunctionU+(1-a)functionV   //일단완료 
		return SystemConstants.u_weight_value*functionU(m, r) + (1-SystemConstants.u_weight_value)*functionV(m, r, journal);
	}

	public double functionFR(SystemUser r) { //Reviewer가 온다고 생각 SystemUser을 사용하지만 //일단완료
		double result = 0;
		int review_num = 0; //get - 해당 리뷰어가 이전 날짜 이후로 몇개의 리뷰를 했는가에 대한 수

		review_num = reviewEventDateTimeDao.numReviewsBeforeSpecificDays(r.getId(), SystemConstants.FR_period_days);

		result = review_num / SystemConstants.FR_period_days;		

		return result;
	}

	public boolean isReviewing(Manuscript m, Reviewer r, Journal journal) {  //둘사이에 리뷰 중인가. 일단완료
		boolean isReview = false;
		List<Review> reviews = reviewerService.getReviews(0, m.getId(), journal.getId(), m.getRevisionCount(), SystemConstants.reviewerA);
		if(reviews != null)
			for(Review re: reviews) {
				if(re.getUser().getId() == r.getUser().getId())  // 현재 둘 사이에 리뷰 중인가
					isReview = true;
			}
		if(recommend_constraint.get(r) < 1)  //추천 제한 수 걸러내기
			isReview = false;
		
		return isReview;
	}

	public void process_Recommend(Journal journal)
	{
		/*
		 * if( flag == true)
		 * flag = false;
		 */
		
		HashMap<Manuscript, List<Reviewer>> recommend_List = recommend_Assignment(journal);
		ReviewerRecommend reviewerRecommend = new ReviewerRecommend();
		reviewerRecommend.setJournal_id(journal.getId());
		System.out.println("test - 4");
		for(Manuscript m: recommend_List.keySet())
		{
			reviewerRecommend.setManuscript_id(m.getId());
			reviewerRecommend.setRevision_count(m.getRevisionCount());
			for(Reviewer r: recommend_List.get(m))
			{
				reviewerRecommend.setReviewer_user_id(r.getUser().getId());
				manuscriptReviewerRecommendDao.insert(reviewerRecommend);
			}
		}
		
		System.out.println("end recommend Assignment");
	}
	
	public HashMap<Manuscript, List<Reviewer>> recommend_Assignment(Journal journal)  //Main !!! //일단완료
	{
		System.out.println("start recommend Assignment");
		
		manuscriptReviewerRecommendDao.deleteAll();
		
		HashMap<Manuscript, List<Reviewer>> map = new HashMap<Manuscript, List<Reviewer>>();

		System.out.println("test - 1");
		List<Reviewer> reviewers = getPossibleReviewers(journal);
		System.out.println("test - 2");
		List<Manuscript> manuscripts = getNeedManuscripts(journal);
		System.out.println("test - 3");

		/*
		for(Reviewer rr : recommend_constraint.keySet() )
		{
			System.out.println(rr.getUser().getId() + " count : " + recommend_constraint.get(rr));
		}
		*/
		
		for(Manuscript m: manuscripts) {
			List<Reviewer> final_reviewers = new ArrayList<Reviewer>();
			List<Reviewer> reviewers_1 = new ArrayList<Reviewer>();
			Reviewer max_r = new Reviewer();
			boolean someone_possible = false;
			//리뷰 가능한 사람이 아무도 없는경우 - 해당 논문 추천 필터링
			
			for(int i=0; i<SystemConstants.constraint_review_num_for_paper*SystemConstants.recommend_extra_ratio; i++) { // f함수를 가지고 1차를 추천 목록 추려냄
				
				for(Reviewer r_init: reviewers) {   //가능한 리뷰어중 초기값
					if(isReviewing(m, r_init, journal) == false && reviewers_1.contains(r_init) == false) {
						max_r = r_init;
						someone_possible = true;
						break;
					}
				}
				
				if(someone_possible == false)
					break;
				
				for(Reviewer r: reviewers) {
					if(isReviewing(m, r, journal) == false && reviewers_1.contains(r) == false) {  //현재 리뷰상태가 아닌  and 1차목록에 없는
						if( function_F(m, r.getUser(), journal) > function_F(m, max_r.getUser(), journal) )
								max_r = r;
					}
				}
				reviewers_1.add(max_r);
			}//1차 추천목록 끝
			
			if(someone_possible == false)
				continue;
			
			
			//1차 추천 목록을 가지고 FR로 추천목록 결정하기
			Reviewer min_r = new Reviewer();
			
			for(int j=0; j<SystemConstants.constraint_review_num_for_paper*SystemConstants.recommend_extra_ratio; j++) {
				min_r = reviewers_1.get(0);  //1차목록중 초기값
				
				for(Reviewer r: reviewers_1) {
					if(functionFR(r.getUser()) < functionFR(min_r.getUser())) {
						min_r = r;
					}
				}
				final_reviewers.add(min_r);
				reviewers_1.remove(min_r);
				recommend_constraint.put(min_r, recommend_constraint.get(min_r) - 1);
				if(reviewers_1.size() == 0)  // 1차목록에서 차례로 뽑아내던중 더이상 목록이 없는경우.
					break;
			}
			//한 논문에 대하여 추천목록 결정완료
			map.put(m, final_reviewers);
			
		}

		return map;
	}

	public List<Reviewer> getPossibleReviewers(Journal journal) {  //일단 완료
		//현재 리뷰갯수 제한에 걸리지 않아서 리뷰어에 참여할 수 있는 조건이 갖추어진 리뷰어들 만을 리스트로 반환
		List<Reviewer> reviewers = reviewerService.getReviewers(0, journal.getId());	//all reviewer
		List<Reviewer> possible_Reviewers = new ArrayList<Reviewer>();	//filtered possible reviewers
		List<String> reviewStatus = new ArrayList<String>();
		reviewStatus.add(SystemConstants.reviewerA);

		for(Reviewer reviewer: reviewers) {
			SystemUser reviewerUser = reviewer.getUser();
			//List<UserExpertise> expertises = userExpertiseService.getExpertises(reviewerUser.getId());
			int numCurrentReview = reviewerService.numReviewManuscripts(reviewerUser.getId(), 0, journal.getId(), -1, reviewStatus);
			if(numCurrentReview < SystemConstants.constraint_review_num_for_reviewer) {
				possible_Reviewers.add(reviewer);
				recommend_constraint.put(reviewer, ( SystemConstants.constraint_review_num_for_reviewer - numCurrentReview )  );
			}
		}

		return possible_Reviewers;
	}

	public List<Manuscript> getNeedManuscripts(Journal journal) {  //일단완료
		List<Manuscript> need_Manuscripts = new ArrayList<Manuscript>();

		List<Manuscript> manuscripts = new ArrayList<Manuscript>();
		List<Manuscript> newManuscripts = manuscriptService.getSubmittedManuscripts(journal.getId(), SystemConstants.statusO, 0);
		List<Manuscript> updatedManuscripts = manuscriptService.getSubmittedManuscripts(journal.getId(), SystemConstants.statusR, Integer.MAX_VALUE);
		for(Manuscript manuscript: newManuscripts)
			manuscripts.add(manuscript);

		for(Manuscript manuscript: updatedManuscripts)
			manuscripts.add(manuscript);
		/*
		for(Manuscript manuscript: manuscripts)
		{
			if(manuscript.getStatus().equals("B")  || manuscript.getStatus().equals("I") || manuscript.getStatus().equals("R"))
				need_Manuscripts.add(manuscript);
		}
*/
		for(Manuscript manuscript: manuscripts) {
			List<Review> reviews = reviewerService.getReviews(0, manuscript.getId(), journal.getId(), manuscript.getRevisionCount(), SystemConstants.reviewerA);
			if(reviews != null)  //현재 논문 리뷰중인 애들 찾기
			{
				if(reviews.size() < SystemConstants.constraint_review_num_for_paper)
					need_Manuscripts.add(manuscript);
			}
			else 
			{
				need_Manuscripts.add(manuscript);
			}
					
		}

		return need_Manuscripts;
	}


	public double mean(List<Double> list) { // 평균
		double sum = 0;
		for(double d: list) {
			sum += d;
		}

		return sum / list.size();
	}

	public double standardDeviation(List<Double> list) {  //표준편차
		if( list.size() < 2)
			return 0;
		double sd = 0;
		double dif;
		double sum = 0;
		double meanValue = mean(list);
		for(double num: list) {
			dif = num - meanValue;
			sum += dif * dif;
		}

		sd = Math.sqrt(sum / list.size());

		return sd;
	}
}

