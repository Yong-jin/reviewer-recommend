package link.thinkonweb.service.recommend;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.domain.user.UserExpertise;
import link.thinkonweb.service.user.UserExpertiseService;

public class RecommendService {
	private List<Keyword> keywords;
	private List<UserExpertise> expertises;
	private UserExpertiseService userExpertiseService;
	private int constraint_review_num_for_paper;
	private int constraint_review_num_for_reviewer;
	private int FR_period_days;
	
	public RecommendService() {
		constraint_review_num_for_paper = 3;
		constraint_review_num_for_reviewer = 3;
		FR_period_days = 180;
	}
	
	public void setConstraint_review_num_for_paper(int paper_cons) {  //논문당 최대 리뷰 제한수
		constraint_review_num_for_paper = paper_cons;
	}
	
	public void setConstraint_review_num_for_reviewer(int reviewer_cons) { //리뷰어당 최대 리뷰 제한수
		constraint_review_num_for_reviewer = reviewer_cons;
	}
	
	
	
	public double functionU(Manuscript m, Reviewer r) {
		double result = 0;
		int common = 0;
		
		keywords = m.getKeywords();
		expertises = userExpertiseService.getExpertises(r.getUser().getId()); 
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
		
		if(common == 0 || keywords.size() == 0)
			return 0;
		
		result = common / keywords.size();
		return result;
	}
	
	public double functionV(Manuscript m, Reviewer r) {
		keywords = m.getKeywords();
		
		
		
		//m을 review 중인 컴토자 찾아서 진행
		
		return 0;
	}
	
	public double functionFR(Reviewer r) {
		double result = 0;
		int review_num = 0; //get - 해당 리뷰어가 이전 날짜 이후로 몇개의 리뷰를 했는가에 대한 수
		
		
		Calendar calendar = Calendar.getInstance();
		//DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		calendar.add(Calendar.DATE, -FR_period_days);
		
		//formatter.format(calendar.getTime())
		//review_num = function( calendar.getTime() )이후로 현재까지의 리뷰에 대한 수
		
		result = review_num / FR_period_days;		
		
		return result;
	}
	
	
	public HashMap<Manuscript, List<Reviewer>> recommend_Assignment(List<Manuscript> manuscripts)
	{
		HashMap<Manuscript, List<Reviewer>> map = new HashMap<Manuscript, List<Reviewer>>();
		
		List<Reviewer> reviewers = getPossibleReviewers();
			
		return null;
	}
	
	public List<Reviewer> getPossibleReviewers() {
		List<Reviewer> possible_Reviewers = new ArrayList<Reviewer>();
		//현재 리뷰갯수 제한에 걸리지 않아서 리뷰어에 참여할 수 있는 조건이 갖추어진 리뷰어들 만을 리스트로 반환
		return possible_Reviewers;
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

