package link.thinkonweb.service.recommend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

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
	private HashMap<Reviewer, Integer> recommend_constraint = new HashMap<Reviewer, Integer>();

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



	public double commonKeywords(Manuscript m, SystemUser r) {  //공통키워드 수 찾기
		double common = 0;

		keywords = m.getKeywords();
		expertises = userExpertiseService.getExpertises(r.getId()); 
		for(Keyword keyword: keywords)
		{
			for(UserExpertise ue: expertises)
			{
				if( computeDistance(keyword.getKeyword(), ue.getExpertise())/ ( (double)ue.getExpertise().length() > (double)keyword.getKeyword().length() ? (double)ue.getExpertise().length() : (double)keyword.getKeyword().length() ) < 0.2 ) // keyword 전체 비교
				{
					common++;
				}
				else
				{
					String[] k_words = keyword.getKeyword().toLowerCase().split(" |,|_|-");
					String[] e_words = ue.getExpertise().toLowerCase().split(" |,|_|-");
					List<String> k_tList = new ArrayList<String>();
					List<String> e_tList = new ArrayList<String>();
					List<Boolean> k_boolList = new ArrayList<Boolean>();
					List<Boolean> e_boolList = new ArrayList<Boolean>();
					for(String s : k_words)
					{
						k_tList.add(s);
						k_boolList.add(false);
					}
					for(String s : e_words)
					{
						e_tList.add(s);
						e_boolList.add(false);
					}
					int list_size = k_tList.size() < e_tList.size() ? k_tList.size() : e_tList.size();
					int mixNum = list_size - 1;
					boolean getCommon = false;
					while(mixNum > (list_size/2))
					{
						List<String> k_rList  = mixString(mixNum, k_tList, 0, "", new ArrayList<String>(), 0, k_boolList);
						List<String> e_rList  = mixString(mixNum, e_tList, 0, "", new ArrayList<String>(), 0, e_boolList);
						for(String k: k_rList)
						{
							for(String e: e_rList)
							{
								if( computeDistance(k, e)/ ( (double)e.length() > (double)k.length() ? (double)e.length() : (double)k.length() ) < 0.2 ) //조합으로 나눈거 비교
								{
									common++;
									getCommon = true;
									break;
								}
							}
							if(getCommon)
								break;
						}
						if(getCommon)
							break;
						mixNum -= 1;
					}
						
				}
			}
		}

		return common;
	}

	public int computeDistance(String s1, String s2) { //글자 얼마나 비슷한가 체크
		s1 = s1.toLowerCase();
		s2 = s2.toLowerCase();

		int[] costs = new int[s2.length() + 1];

		for(int i =0; i<=s1.length(); i++) {
			int lastValue = i;
			for( int j = 0; j<=s2.length(); j++) {
				if( i==0)
					costs[j] = j;
				else {
					if(j>0) {
						int newValue = costs[j-1];
						if( s1.charAt(i-1) != s2.charAt(j-1))
							newValue = Math.min(Math.min(newValue, lastValue), costs[j])+1;

						costs[j-1] = lastValue;
						lastValue = newValue;
					}
				}
			}

			if(i>0)
				costs[s2.length()] = lastValue;
		}

		return costs[s2.length()];
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
		if(functionU(m, r) == 0) 
			return 0;

		return SystemConstants.u_weight_value*functionU(m, r) + (1-SystemConstants.u_weight_value)*functionV(m, r, journal);
	}

	public double functionFR(SystemUser r) { //Reviewer가 온다고 생각 SystemUser을 사용하지만 //일단완료
		double result = 0;
		int review_num = 0; //get - 해당 리뷰어가 이전 날짜 이후로 몇개의 리뷰를 했는가에 대한 수

		review_num = reviewEventDateTimeDao.numReviewsBeforeSpecificDays(r.getId(), SystemConstants.FR_period_days);

		result = review_num / SystemConstants.FR_period_days;		

		return result;
	}

	public double fitness_function(List<ReviewerRecommend> reviewerRecommends) {
		double total_value_F = 0;
		for(ReviewerRecommend rr: reviewerRecommends) {
			total_value_F += rr.getRecommend_value();
		}
		return total_value_F / (double)reviewerRecommends.size();
	}

	public boolean canReview(Manuscript m, Reviewer r, Journal journal) {  //둘사이에 리뷰 중인가. 일단완료
		boolean canReview = true;

		List<Review> reviews = new ArrayList<Review>();
		for(int i=0; i<= m.getRevisionCount(); i++)  // 이전 RevisionCount 까지 확인하기 위해 다 불러옴
		{
			List<Review> temp_reviewsA = new ArrayList<Review>( reviewerService.getReviews(0, m.getId(), journal.getId(), i, SystemConstants.reviewerA) );
			List<Review> temp_reviewsC = new ArrayList<Review>( reviewerService.getReviews(0, m.getId(), journal.getId(), i, SystemConstants.reviewerC) );
			if(temp_reviewsA != null)
			{
				for(Review tr: temp_reviewsA) {
					reviews.add(tr);
				}
			}
			if(temp_reviewsC != null)
			{
				for(Review tr: temp_reviewsC) {
					reviews.add(tr);
				}
			}
		}		

		if(reviews != null)
			for(Review re: reviews) {
				if(re.getUser().getId() == r.getUser().getId()) { // 현재 둘 사이에 리뷰 중인가  //혹은 이전에도 리뷰한 기록이 있는가.
					canReview = false;
					break;
				}
			}
		if(recommend_constraint.get(r) < 1)  //추천 제한 수 걸러내기
			canReview = false;

		return canReview;
	}

	public void process_Recommend(Journal journal)
	{
		/*
		 * if( flag == true)
		 * flag = false;
		 */

		//HashMap<Manuscript, List<Reviewer>> recommend_List = recommend_Assignment(journal);
		manuscriptReviewerRecommendDao.deleteAll();

		List<ReviewerRecommend> reviewerRecommends = recommend_Assignment(journal);

		System.out.println("test - 4");
		for(ReviewerRecommend rr: reviewerRecommends)
		{
			manuscriptReviewerRecommendDao.insert(rr);
		}

		System.out.println("end recommend Assignment");
	}

	public List<ReviewerRecommend> recommend_Assignment(Journal journal)  //Main !!! //일단완료
	{
		System.out.println("start recommend Assignment");

		HashMap<Manuscript, List<Reviewer>> map = new HashMap<Manuscript, List<Reviewer>>();

		HashMap<Reviewer, Double> reviewer_Fvalue = new HashMap<Reviewer, Double>();
		HashMap<Reviewer, Double> reviewer_FRvalue = new HashMap<Reviewer, Double>();
		List<ReviewerRecommend> reviewerRecommends = new ArrayList<ReviewerRecommend>();
		ReviewerRecommend reviewerRecommend = new ReviewerRecommend();

		//System.out.println("test - 1");
		List<Reviewer> reviewers = getPossibleReviewers(journal);
		//System.out.println("test - 2");
		List<Manuscript> manuscripts = getNeedManuscripts(journal);
		//System.out.println("test - 3");

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
			Reviewer min_r = new Reviewer();
			reviewer_Fvalue = new HashMap<Reviewer, Double>();
			reviewer_FRvalue = new HashMap<Reviewer, Double>();

			//리뷰 가능한 사람이 아무도 없는경우 - 해당 논문 추천 필터링

			for(Reviewer r: reviewers) {
				if(canReview(m, r, journal) == true ) {
					reviewer_Fvalue.put(r, function_F(m, r.getUser(), journal));
				}
			}

			if (reviewer_Fvalue.size() == 0 )
				continue;

			for(int i=0; i<SystemConstants.constraint_review_num_for_paper*SystemConstants.recommend_extra_ratio; i++) { // f함수를 가지고 1차를 추천 목록 추려냄
				if( i == reviewer_Fvalue.size())
					break;

				List<Reviewer> keyList = new ArrayList<Reviewer>( reviewer_Fvalue.keySet() );

				for(Reviewer r: keyList) {
					if(reviewers_1.contains(r) == false) {
						max_r = r;
						break;
					}
				}

				for(Reviewer r: keyList) {
					if( reviewer_Fvalue.get(max_r) < reviewer_Fvalue.get(r) && reviewers_1.contains(r) == false)
						max_r = r;
				}

				if( reviewer_Fvalue.get(max_r) == 0)
					break;

				reviewers_1.add(max_r);

			}//1차 추천목록 끝

			//1차 추천 목록을 가지고 FR로 추천목록 결정하기

			for(Reviewer r: reviewers_1) {
				reviewer_FRvalue.put(r, functionFR(r.getUser()));
			}

			for(int j=0; j<SystemConstants.constraint_review_num_for_paper*SystemConstants.recommend_extra_ratio; j++) {
				if( j == reviewer_FRvalue.size())
					break;

				for(Reviewer r: reviewers_1)
				{
					if( final_reviewers.contains(r) == false) {
						min_r = r;
						break;
					}

				} //1차목록중 초기값

				for(Reviewer r: reviewers_1) {
					if( reviewer_FRvalue.get(min_r) > reviewer_FRvalue.get(r) && final_reviewers.contains(r) == false) {
						min_r = r;
					}
				}

				final_reviewers.add(min_r);
				recommend_constraint.put(min_r, recommend_constraint.get(min_r) - 1);
			}
			//한 논문에 대하여 추천목록 결정완료
			map.put(m, final_reviewers);


			//@@@
			for(Reviewer r : final_reviewers)
			{
				reviewerRecommend = new ReviewerRecommend();
				reviewerRecommend.setManuscript_id(m.getId());
				reviewerRecommend.setRevision_count(m.getRevisionCount());
				reviewerRecommend.setReviewer_user_id(r.getUser().getId());
				reviewerRecommend.setRecommend_value(reviewer_Fvalue.get(r));
				reviewerRecommend.setFr_value(reviewer_FRvalue.get(r));

				reviewerRecommends.add(reviewerRecommend);
			}
			//@@@
		}
		/*
		for(Reviewer rr : recommend_constraint.keySet() )
		{
			System.out.println(rr.getUser().getId() + " count : " + recommend_constraint.get(rr));
		}
		 */

		return reviewerRecommends;
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

	public static List<String> mixString(int mixNum, List<String> sList, int currentIndex, String currentS, List<String> resultList, int currentMix, List<Boolean> boolList)
	{                                     //몇개 조합	     전체 스트링 리스트			 몇번재부터 시작			현재 스트링상태			결과목록			현재 몇개 섞음			누가 포함됐는지
		if(currentMix == mixNum)
		{
			resultList.add(currentS);
			if(currentIndex+1 == sList.size())
			{
				return resultList;
			}
			else
			{
				for(int i=0; i<boolList.size(); i++)
				{
					boolList.set(i, false);
				}
				currentS="";
				currentMix = 0;

				return mixString(mixNum, sList, currentIndex, currentS, resultList, currentMix, boolList);
			}
		}
		else
		{
			if(sList.size()-currentIndex < mixNum)
				return resultList;

			for(int i=currentIndex; i<sList.size(); i++)
			{
				if(boolList.get(i) == true)
					continue;
				if(!resultList.contains(currentS.concat(sList.get(i))))
				{
					currentS = currentS.concat(sList.get(i));
					boolList.set(i, true);
					currentMix += 1;
					return mixString(mixNum, sList, currentIndex, currentS, resultList, currentMix, boolList);
				}
			}
			for(int i=0; i<boolList.size(); i++)
			{
				boolList.set(i, false);
			}
			currentS="";
			currentMix = 0;

			return mixString(mixNum, sList, currentIndex+1, currentS, resultList, currentMix, boolList);

		}
	}//COI빼야대고 "" null인애 빼야댐
}

