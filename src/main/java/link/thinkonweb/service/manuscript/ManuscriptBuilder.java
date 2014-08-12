package link.thinkonweb.service.manuscript;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.manuscript.AbstractDao;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.CoverLetterDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.FinalDecisionDao;
import link.thinkonweb.dao.manuscript.KeywordDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.dao.manuscript.ReviewDaoImpl;
import link.thinkonweb.dao.manuscript.ReviewPreferenceDao;
import link.thinkonweb.dao.manuscript.RunningHeadDao;
import link.thinkonweb.dao.manuscript.TitleDao;
import link.thinkonweb.dao.manuscript.UploadedFileDaoImpl;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.CoverLetter;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Keyword;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ManuscriptAbstract;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.ReviewPreference;
import link.thinkonweb.domain.manuscript.RunningHead;
import link.thinkonweb.domain.manuscript.Title;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;



public class ManuscriptBuilder {
	@Autowired
	private UserService userService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ManuscriptDao manuscriptDao;
	@Autowired
	private TitleDao titleDao;
	@Autowired
	private CoverLetterDao coverLetterDao;
	@Autowired
	private RunningHeadDao runningHeadDao;
	@Autowired
	private AbstractDao abstractDao;
	@Autowired
	private KeywordDao keywordDao;
	@Autowired
	private ReviewPreferenceDao reviewPreferenceDao;
	@Autowired
	private UploadedFileDaoImpl uploadedFileDao;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private FinalDecisionDao finalDecisionDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private DivisionDao divisionDao;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private CommentDao commentDao;
	

	public Manuscript build(Manuscript manuscript, int level) {
			if(manuscript == null) return null;
			
			int manuscriptId = manuscript.getId();
			if(level == SystemConstants.NONE_BUILD)
				return manuscript;
			else if(level ==  SystemConstants.VIEW_BUILD) {
				try {
					List<Keyword> keywords = keywordDao.findByManuscriptIdAndRevisionCount(manuscriptId, manuscript.getRevisionCount());
					if(keywords != null) {
						manuscript.setKeywords(keywords);
						List<String> keyword = new ArrayList<String>();
						for (Keyword manuscriptKeyword : keywords)
							keyword.add(manuscriptKeyword.getKeyword());
						
						manuscript.setKeyword(keyword);
					}

					List<CoAuthor> coAuthors = coAuthorService.getCoAuthors(manuscriptId, manuscript.getRevisionCount(), 0, false);
					if(coAuthors != null) {
						Collections.sort(coAuthors);
						manuscript.setCoAuthors(coAuthors);
						for(CoAuthor coAuthor: coAuthors) {
							if(coAuthor.getAuthorOrder() == 1)
								manuscript.setFirstAuthor(coAuthor);
							
							if(coAuthor.isCorresponding())
								manuscript.setCorresAuthor(coAuthor);
						}
					}
	
					List<ReviewPreference> reviewPreferences = reviewPreferenceDao.findReviewPreferences(manuscript.getId(), manuscript.getRevisionCount());
					if(reviewPreferences != null) manuscript.setReviewPreferences(reviewPreferences);
					
					if(manuscript.getDivisionId() != 0) {
						Division division = divisionDao.findById(manuscript.getDivisionId());
						if(division != null)
							manuscript.setDivision(division);
					}
					
					if(!manuscript.getStatus().equals(SystemConstants.statusB) &&
							!manuscript.getStatus().equals(SystemConstants.statusI) && 
							!manuscript.getStatus().equals(SystemConstants.statusO)) {
						List<FinalDecision> decisions = finalDecisionDao.findByManuscriptId(manuscriptId);
						if(decisions != null) manuscript.setDecisions(decisions);
					}
					
					if(!manuscript.getStatus().equals(SystemConstants.statusB) &&
							!manuscript.getStatus().equals(SystemConstants.statusI) && 
							!manuscript.getStatus().equals(SystemConstants.statusO)) {
						List<Review> allReviews = reviewerService.getReviews(0, manuscriptId, manuscript.getJournalId(), -1, null);
						if(allReviews != null && allReviews.size() > 0)
							Collections.sort(allReviews);
						manuscript.setReviews(allReviews);

						if (allReviews.size() > 0) {
							List<List<Review>> reviewList = new ArrayList<List<Review>>();
							int revisionCount = manuscript.getRevisionCount();
							for (int i=0; i<=revisionCount; i++) {
								List<Review> reviews = reviewerService.getReviews(0, manuscriptId, manuscript.getJournalId(), i, null);
								if (reviews != null && reviews.size() > 0) {
									//Collections.sort(reviews);
									reviewList.add(reviews);
								} 
/*								else {
									reviews = new ArrayList<Review>();
									Review r = new Review();
									reviews.add(r);
									reviewList.add(reviews);
								}*/
								
							}
							manuscript.setReviewList(reviewList);
						}
					}
					
					if (manuscript.getManagerUserId() != 0)
						manuscript.setManager(userService.getById(manuscript.getManagerUserId()));
					
					if (manuscript.getChiefEditorUserId() != 0)
						manuscript.setChiefEditor(userService.getById(manuscript.getChiefEditorUserId()));
					
					if(manuscript.getManuscriptTrackId() == 0) {
						if (manuscript.getAssociateEditorUserId() != 0)
							manuscript.setAssociateEditor(userService.getById(manuscript.getAssociateEditorUserId()));
					} else {
						if (manuscript.getGuestEditorUserId() != 0)
							manuscript.setGuestEditor(userService.getById(manuscript.getGuestEditorUserId()));
					}
					
					List<Comment> comments = commentDao.findByManuscriptId(manuscriptId);
					if(comments != null) manuscript.setComments(comments);
	
					List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
					if(manuscriptEventDates != null) {
						manuscript.setEventDateTimes(manuscriptEventDates);
						List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
						Set<String> statusSet = new HashSet<String>();
						for(EventDateTime eventDate: manuscriptEventDates) {
							String status = eventDate.getStatus();
							statusSet.add(status);
						}
						
						for(String status: statusSet) {
							int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
							EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
							manuscriptLastEventDates.add(eventDate);
						}
						manuscript.setLastEventDateTimes(manuscriptLastEventDates);
					}
				} catch (Exception e) {
					System.out.println("BUILD ERROR MANUSCRIPT ID: " + manuscript.getId());
					e.printStackTrace();
				}
				return manuscript;
			} else if(level == SystemConstants.TABLE_BUILD) {
				try {

					if(manuscript.getStatus().equals(SystemConstants.statusR)) {
						List<Review> allReviews = reviewerService.getReviews(0, manuscriptId, manuscript.getJournalId(), -1, null);
						if(allReviews != null && allReviews.size() > 0)
							Collections.sort(allReviews);
						manuscript.setReviews(allReviews);

						if (allReviews.size() > 0) {
							List<List<Review>> reviewList = new ArrayList<List<Review>>();
							int revisionCount = manuscript.getRevisionCount();
							for (int i=0; i<=revisionCount; i++) {
								List<Review> reviews = reviewerService.getReviews(0, manuscriptId, manuscript.getJournalId(), i, null);
								if (reviews != null && reviews.size() > 0) {
									//Collections.sort(reviews);
									reviewList.add(reviews);
								} 
								/*
								else {
									reviews = new ArrayList<Review>();
									Review r = new Review();
									reviews.add(r);
									reviewList.add(reviews);
								}
								*/
							}
							manuscript.setReviewList(reviewList);
						}
					}
					
					List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
					if(manuscriptEventDates != null) {
						manuscript.setEventDateTimes(manuscriptEventDates);
						
						List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
						Set<String> statusSet = new HashSet<String>();
						for(EventDateTime eventDate: manuscriptEventDates) {
							String status = eventDate.getStatus();
							statusSet.add(status);
						}
						
						for(String status: statusSet) {
							int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
							EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
							manuscriptLastEventDates.add(eventDate);
						}
						manuscript.setLastEventDateTimes(manuscriptLastEventDates);
					}
				} catch (Exception e) {
					System.out.println("BUILD ERROR MANUSCRIPT ID: " + manuscript.getId());
					e.printStackTrace();
				}
				return manuscript;
			} else if(level == SystemConstants.HISTORY_BUILD) {
				try {
					
					List<Title> titles = titleDao.findByManuscriptId(manuscriptId);
					if(titles != null) manuscript.setTitles(titles);
	
					List<RunningHead> runningHeads = runningHeadDao.findByManuscriptId(manuscriptId);
					if(runningHeads != null) manuscript.setRunningHeads(runningHeads);
					
					List<ManuscriptAbstract> abstracts = abstractDao.findByManuscriptId(manuscriptId);
					if(abstracts != null) manuscript.setAbstracts(abstracts);
					
					List<Keyword> keywords = keywordDao.findByManuscriptId(manuscriptId);
					if(keywords != null) {
						manuscript.setKeywords(keywords);
						List<String> keyword = new ArrayList<String>();
						for (Keyword manuscriptKeyword : keywords)
							keyword.add(manuscriptKeyword.getKeyword());
						
						manuscript.setKeyword(keyword);
					}
					
					List<CoverLetter> coverLetters = coverLetterDao.findByManuscriptId(manuscriptId);
					if(coverLetters != null) manuscript.setCoverLetters(coverLetters);
					
					List<CoAuthor> coAuthors = coAuthorService.getCoAuthorAll(manuscriptId);
					if(coAuthors != null) {
						Collections.sort(coAuthors);
						manuscript.setCoAuthors(coAuthors);
						for(CoAuthor coAuthor: coAuthors) {
							if(coAuthor.getAuthorOrder() == 1)
								manuscript.setFirstAuthor(coAuthor);
							
							if(coAuthor.isCorresponding())
								manuscript.setCorresAuthor(coAuthor);
						}
					}
	
					List<ReviewPreference> reviewPreferences = reviewPreferenceDao.findReviewPreferences(manuscriptId, -1);
					if(reviewPreferences != null) manuscript.setReviewPreferences(reviewPreferences);
					
					if(manuscript.getDivisionId() != 0) {
						Division division = divisionDao.findById(manuscript.getDivisionId());
						manuscript.setDivision(division);
					}
					
					List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
					if(manuscriptEventDates != null) {
						manuscript.setEventDateTimes(manuscriptEventDates);
						List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
						Set<String> statusSet = new HashSet<String>();
						for(EventDateTime eventDate: manuscriptEventDates) {
							String status = eventDate.getStatus();
							statusSet.add(status);
						}
						
						for(String status: statusSet) {
							int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
							EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
							manuscriptLastEventDates.add(eventDate);
						}
						manuscript.setLastEventDateTimes(manuscriptLastEventDates);
					}
					
				} catch (Exception e) {
					System.out.println("BUILD ERROR MANUSCRIPT ID: " + manuscript.getId());
					e.printStackTrace();
				}
				return manuscript;
			} else if(level == SystemConstants.EMAIL_BUILD) {
				try {
					List<CoAuthor> coAuthors = coAuthorService.getCoAuthors(manuscriptId, manuscript.getRevisionCount(), 0, false);
					if(coAuthors != null) {
						Collections.sort(coAuthors);
						manuscript.setCoAuthors(coAuthors);
						for(CoAuthor coAuthor: coAuthors) {
							if(coAuthor.getAuthorOrder() == 1)
								manuscript.setFirstAuthor(coAuthor);
							
							if(coAuthor.isCorresponding())
								manuscript.setCorresAuthor(coAuthor);
						}
					}
					
					manuscript.setSubmitter(userService.getById(manuscript.getUserId()));
					
					if (manuscript.getManagerUserId() != 0)
						manuscript.setManager(userService.getById(manuscript.getManagerUserId()));
					
					if (manuscript.getChiefEditorUserId() != 0)
						manuscript.setChiefEditor(userService.getById(manuscript.getChiefEditorUserId()));
					
					if(manuscript.getManuscriptTrackId() == 0) {
						if (manuscript.getAssociateEditorUserId() != 0)
							manuscript.setAssociateEditor(userService.getById(manuscript.getAssociateEditorUserId()));
					} else {
						if (manuscript.getGuestEditorUserId() != 0)
							manuscript.setGuestEditor(userService.getById(manuscript.getGuestEditorUserId()));
					}
	
					List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
					if(manuscriptEventDates != null) {
						manuscript.setEventDateTimes(manuscriptEventDates);
						List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
						Set<String> statusSet = new HashSet<String>();
						for(EventDateTime eventDate: manuscriptEventDates) {
							String status = eventDate.getStatus();
							statusSet.add(status);
						}
						
						for(String status: statusSet) {
							int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
							EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
							manuscriptLastEventDates.add(eventDate);
						}
						manuscript.setLastEventDateTimes(manuscriptLastEventDates);
					}
				} catch (Exception e) {
					System.out.println("BUILD ERROR MANUSCRIPT ID: " + manuscript.getId());
					e.printStackTrace();
				}
				return manuscript;
			} else if(level == SystemConstants.EVENT_DATE_TIME_BUILD) {
				try {
					List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
					if(manuscriptEventDates != null) {
						manuscript.setEventDateTimes(manuscriptEventDates);
						List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
						Set<String> statusSet = new HashSet<String>();
						for(EventDateTime eventDate: manuscriptEventDates) {
							String status = eventDate.getStatus();
							statusSet.add(status);
						}
						
						for(String status: statusSet) {
							int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
							EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
							manuscriptLastEventDates.add(eventDate);
						}
						manuscript.setLastEventDateTimes(manuscriptLastEventDates);
					}
				} catch (Exception e) {
					System.out.println("BUILD ERROR MANUSCRIPT ID: " + manuscript.getId());
					e.printStackTrace();
				}
				return manuscript;
			} else
				return manuscript;
	}
	
	public List<Manuscript> builds(List<Manuscript> manuscripts, int level) {
		if(manuscripts == null) return null;
		List<Manuscript> result = new ArrayList<Manuscript>();
		for (Manuscript manuscript : manuscripts) {
			Manuscript builtManuscript = build(manuscript, level);
			result.add(builtManuscript);
		}
		return result;
	}
	
}
