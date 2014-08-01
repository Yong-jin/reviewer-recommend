package link.thinkonweb.controller.roles;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.manuscript.ReviewRequestDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.constants.AdditionalReviewFileDesignation;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.UploadedFile;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.Reviewer;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.AssociateEditorService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@Transactional
@RequestMapping("/journals/{jnid}/reviewer/*")
public class ReviewerController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ReviewerController.class);
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserService userService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private AssociateEditorService aeService;
	@Autowired
	private FileService fileService;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private ReviewRequestDao reviewRequestDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private JournalConfigurationService journalConfigurationService;

	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("manuscripts");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/manuscripts/getPapers/{pageType}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String myPapers(Model model, HttpServletRequest request, Locale locale, @PathVariable(value="pageType") String pageType) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts_review");
		int[] iTotalDisplayRecords = new int[1];

		List<String> sortableColumnNames = new ArrayList<String>();
		List<Review> reviews = null;
		if(pageType.equals("assigned")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("M.SUBMIT_ID");
			sortableColumnNames.add("M.REVISION_COUNT");
			sortableColumnNames.add("M.TITLE");
			sortableColumnNames.add("MR.EVENT_DATE");
			sortableColumnNames.add("MR.DUE_DATE");
			sortableColumnNames.add("MR.STATUS");
			sortableColumnNames.add(null);
			reviews = reviewerService.getReviews(user.getId(), journal.getId(), SystemConstants.reviewerA, dRequest, iTotalDisplayRecords, sortableColumnNames);
		} else if(pageType.equals("completed")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("M.SUBMIT_ID");
			sortableColumnNames.add("M.REVISION_COUNT");
			sortableColumnNames.add("M.TITLE");
			sortableColumnNames.add("MR.EVENT_DATE");
			sortableColumnNames.add("MR.STATUS");
			sortableColumnNames.add("MR.OVERALL");
			reviews = reviewerService.getReviews(user.getId(), journal.getId(), SystemConstants.reviewerC, dRequest, iTotalDisplayRecords, sortableColumnNames);
		} else if(pageType.equals("dismissed")) {
			sortableColumnNames.add(null);
			sortableColumnNames.add("M.SUBMIT_ID");
			sortableColumnNames.add("M.REVISION_COUNT");
			sortableColumnNames.add("M.TITLE");
			sortableColumnNames.add("MR.EVENT_DATE");
			sortableColumnNames.add("MR.STATUS");
			sortableColumnNames.add("MR.OVERALL");
			reviews = reviewerService.getDismissedReviews(user.getId(), journal.getId(), dRequest, iTotalDisplayRecords, sortableColumnNames);
		}
		
		List<Review> filteredReviews = null;
		if(pageType.equals("assigned")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerA) != null && o2.getReviewEventDateTime(SystemConstants.reviewerA) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerA).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerA));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return 1;
							else
								return 0;

						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerA) != null && o2.getReviewEventDateTime(SystemConstants.reviewerA) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerA).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerA));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerA) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		}  else if(pageType.equals("completed")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null && o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 0;
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else
								return 0;
						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null && o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 0;
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else
								return 0;
						}
					}
				});
			}
		} else if(pageType.equals("dismissed")) {
			if(dRequest.getiSortCol()[0] == 4) {
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							int result = 0;
							if(o1.getReviewEventDateTime(SystemConstants.reviewerM) != null && o2.getReviewEventDateTime(SystemConstants.reviewerM) != null)
								result = -1 * o1.getReviewEventDateTime(SystemConstants.reviewerM).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerM));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerT) != null && o2.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = -1 * o1.getReviewEventDateTime(SystemConstants.reviewerT).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerT));
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerM) == null && o2.getReviewEventDateTime(SystemConstants.reviewerM) == null)
									&& (o1.getReviewEventDateTime(SystemConstants.reviewerT) == null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null))
								result = 0;
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerM) == null && o1.getReviewEventDateTime(SystemConstants.reviewerT) == null
									&& o2.getReviewEventDateTime(SystemConstants.reviewerM) != null || o2.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerM) == null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null
									&& o1.getReviewEventDateTime(SystemConstants.reviewerM) != null || o1.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = 1;
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerM) != null && o1.getReviewEventDateTime(SystemConstants.reviewerT) == null)
									&& (o2.getReviewEventDateTime(SystemConstants.reviewerT) != null && o2.getReviewEventDateTime(SystemConstants.reviewerM) == null))
								result = -1 * o1.getReviewEventDateTime(SystemConstants.reviewerM).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerT));
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerT) != null && o1.getReviewEventDateTime(SystemConstants.reviewerM) == null)
									&& (o2.getReviewEventDateTime(SystemConstants.reviewerM) != null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null))
								result = -1 * o1.getReviewEventDateTime(SystemConstants.reviewerT).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerM));
							else
								result = 0;
							return result;
						} else {
							int result = 0;
							if(o1.getReviewEventDateTime(SystemConstants.reviewerM) != null && o2.getReviewEventDateTime(SystemConstants.reviewerM) != null)
								result = o1.getReviewEventDateTime(SystemConstants.reviewerM).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerM));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerT) != null && o2.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = o1.getReviewEventDateTime(SystemConstants.reviewerT).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerT));
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerM) == null && o2.getReviewEventDateTime(SystemConstants.reviewerM) == null)
									&& (o1.getReviewEventDateTime(SystemConstants.reviewerT) == null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null))
								result = 0;
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerM) == null && o1.getReviewEventDateTime(SystemConstants.reviewerT) == null
									&& o2.getReviewEventDateTime(SystemConstants.reviewerM) != null || o2.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerM) == null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null
									&& o1.getReviewEventDateTime(SystemConstants.reviewerM) != null || o1.getReviewEventDateTime(SystemConstants.reviewerT) != null)
								result = -1;
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerM) != null && o1.getReviewEventDateTime(SystemConstants.reviewerT) == null)
									&& (o2.getReviewEventDateTime(SystemConstants.reviewerT) != null && o2.getReviewEventDateTime(SystemConstants.reviewerM) == null))
								result = o1.getReviewEventDateTime(SystemConstants.reviewerM).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerT));
							else if((o1.getReviewEventDateTime(SystemConstants.reviewerT) != null && o1.getReviewEventDateTime(SystemConstants.reviewerM) == null)
									&& (o2.getReviewEventDateTime(SystemConstants.reviewerM) != null && o2.getReviewEventDateTime(SystemConstants.reviewerT) == null))
								result = o1.getReviewEventDateTime(SystemConstants.reviewerT).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerM));
							else
								result = 0;
							return result;
						}
					}
				});
			}
		}

		if(reviews.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredReviews = reviews;
		else
			filteredReviews = reviews.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > reviews.size() 
					? dRequest.getiDisplayStart() + (reviews.size() - dRequest.getiDisplayStart()) 
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredReviews.size());
		
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer actionStringBuffer = new StringBuffer();
		for (Review r: filteredReviews) {
			index = 0;
			
			String dateString = null;
			String dismissDateString = null;
			dResponse.setAaData(i, index++, Integer.toString(number));
			if(r.getManuscript().getSubmitId() != null)
				dResponse.setAaData(i, index++, r.getManuscript().getSubmitId());
			else
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.beingAssigned", null , locale));
			
			int revision = r.getRevisionCount();
			String revisionString;
			if(revision == 0)
				revisionString = messageSource.getMessage("system.original", null , locale);
			else
				revisionString = messageSource.getMessage("system.revision", null , locale) + " #" + revision;
			
			dResponse.setAaData(i, index++, revisionString);

			if(r.getManuscript().getTitle() == null)
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else {
				String invitedString = "";
				if(r.getManuscript().isInvite())
					invitedString  = "<span class='required'>*</span>(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
				String titleUrl = "<a onClick='viewManuscript(" + r.getManuscriptId() +  ", \"" + pageType + "\", \"summary\");'>" + invitedString + r.getManuscript().getTitle() + "</a>";
				dResponse.setAaData(i, index++, titleUrl);
			}
			
			if(pageType.equals("assigned")) { 
				if(r.getReviewEventDateTime(SystemConstants.reviewerA) != null)
					dateString = r.getReviewEventDateTime(SystemConstants.reviewerA).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
			} else if(pageType.equals("completed")) { 
				if(r.getStatus().equals(SystemConstants.reviewerC) && r.getReviewEventDateTime(SystemConstants.reviewerC) != null)
					dateString = r.getReviewEventDateTime(SystemConstants.reviewerC).getDate().toString();
				dResponse.setAaData(i, index++, dateString);
			} else if(pageType.equals("dismissed")) { 
				if(r.getStatus().equals(SystemConstants.reviewerM) && r.getReviewEventDateTime(SystemConstants.reviewerM) != null)
					dismissDateString = r.getReviewEventDateTime(SystemConstants.reviewerM).getDate().toString();
				else if(r.getStatus().equals(SystemConstants.reviewerT) && r.getReviewEventDateTime(SystemConstants.reviewerT) != null)
					dismissDateString = r.getReviewEventDateTime(SystemConstants.reviewerT).getDate().toString();
				
				dResponse.setAaData(i, index++, dismissDateString);
			}
			
			if(pageType.equals("assigned")) {
				if(r.getDueDate() != null)
					dResponse.setAaData(i, index++, r.getDueDate().toString());
				else
					dResponse.setAaData(i, index++, null);
			}
			
			if(pageType.equals("assigned")) {
				actionStringBuffer.append("<button type='button' class='btn btn-default btn-xs actionButton width70' onClick='viewManuscript(" + r.getManuscriptId() +  ", \"" + pageType + "\", \"reviewSheet\");'/>" +
						messageSource.getMessage("reviewer.review", null, locale) + "</button>");
				
				if(journal.isPaid())
					dResponse.setAaData(i, index++, actionStringBuffer.toString());
				else
					dResponse.setAaData(i, index++, null);
			} else if(pageType.equals("completed") || pageType.equals("dismissed")) {
				String status = null;
				switch (r.getStatus()) {
					case SystemConstants.reviewerA: 
						status = this.messageSource.getMessage("system.review.titleA", null, locale);
						break;	
					case SystemConstants.reviewerC: 
						status = this.messageSource.getMessage("system.review.titleC", null, locale);
						break;	
					case SystemConstants.reviewerM: 
						status = this.messageSource.getMessage("system.review.titleM", null, locale);
						break;
					case SystemConstants.reviewerT: 
						status = this.messageSource.getMessage("system.review.titleT", null, locale);
						break;
				}
				dResponse.setAaData(i, index++, status);
				if(pageType.equals("completed")) {
					String overall = this.messageSource.getMessage("reviewResult.score." + r.getOverall(), null, locale);
					dResponse.setAaData(i, index++, overall);
				}
			}
			actionStringBuffer.delete(0, actionStringBuffer.length());
			i++;
			number++;
			index = 0;
			
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/reviews/reviewSheet", method=RequestMethod.GET)
	public ModelAndView reviewSheet(Model model, HttpServletRequest request,
			@RequestParam(value="manuscriptId", required=true) int manuscriptId, Locale locale) {
		ModelAndView mav = new ModelAndView();
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		JournalConfiguration jc = journalConfigurationService.getByJournalId(journal.getId());
		mav.addObject("jc", jc);
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		Reviewer reviewer = journalRoleDao.findJournalReviewer(user.getId(), journal.getId());
		mav.addObject("reviewer", reviewer);
		List<Review> reviews = reviewerService.getReviews(user.getId(), manuscriptId, journal.getId(), m.getRevisionCount(), SystemConstants.reviewerA);
		Review review = reviews.get(0);
		List<Comment> comments = commentDao.findRelatedComments(manuscriptId, user.getId(), SystemConstants.roleReviewer, false);
		Comment commentToEditor = null;
		Comment commentToAuthor = null;
		if(comments !=  null) {
			for(Comment comment: comments) {
				if(comment.getRevisionCount() == m.getRevisionCount() && comment.getFromUserId() == user.getId() && comment.getFromRole().equals(SystemConstants.roleReviewer)) {
					
					if(m.getManuscriptTrackId() == 0) {
						if(comment.getToUserId() == m.getChiefEditorUserId() && comment.getToRole().equals(SystemConstants.roleCEditor))
							commentToEditor = comment;
					} else {
						if(comment.getToUserId() == m.getGuestEditorUserId() && comment.getToRole().equals(SystemConstants.roleGEditor))
							commentToEditor = comment;
					}
						
					if(comment.getToRole().equals(SystemConstants.roleMember))
						commentToAuthor = comment;
				}
			}
		}

		review.setCommentToAuthor(commentToAuthor);
		review.setCommentToEditor(commentToEditor);
		mav.addObject("commentToEditor", commentToEditor);
		mav.addObject("commentToAuthor", commentToAuthor);
		List<AdditionalReviewFileDesignation> additionalReviewFileDesignations = new LinkedList<AdditionalReviewFileDesignation>();
		additionalReviewFileDesignations.add(AdditionalReviewFileDesignation.getType(0));
		additionalReviewFileDesignations.add(AdditionalReviewFileDesignation.getType(1));
		model.addAttribute("additionalReviewfileDesignations", additionalReviewFileDesignations);
		
		mav.addObject("review", reviews.get(0));
		mav.addObject("manuscript", m);
		mav.setViewName("reviewer.reviews.reviewSheet");
		return mav;
	}
	
	@RequestMapping(value="/reviews/saveReviewSheet", method=RequestMethod.POST)
	public @ResponseBody Boolean saveReviewSheet(@ModelAttribute("review") Review review, 
		 	BindingResult result, 
		 	HttpServletRequest request, Model model, Locale locale,
		 	@PathVariable(value="jnid") String jnid,
		 	@RequestParam(value="manuscriptId", required=true) int manuscriptId) throws IllegalStateException, IOException {
		if (result.hasErrors()) {
			System.out.println("binding error: " + review);
			System.out.println(result.toString());
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			Comment toAuthor = review.getCommentToAuthor();
			toAuthor.setFromUserId(user.getId());
			toAuthor.setToUserId(m.getUserId());
			toAuthor.setFromRole(SystemConstants.roleReviewer);
			toAuthor.setToRole(SystemConstants.roleMember);
			toAuthor.setStatus(m.getStatus());
			toAuthor.setManuscriptId(manuscriptId);
			toAuthor.setJournalId(journal.getId());
			toAuthor.setRevisionCount(m.getRevisionCount());
			review.setCommentToAuthor(toAuthor);
			
			Comment toEditor = review.getCommentToEditor();
			toEditor.setFromUserId(user.getId());
			toEditor.setFromRole(SystemConstants.roleReviewer);
			if(m.getManuscriptTrackId() == 0) {
				toEditor.setToUserId(m.getChiefEditorUserId());
				toEditor.setToRole(SystemConstants.roleCEditor);
			} else {
				toEditor.setToUserId(m.getGuestEditorUserId());
				toEditor.setToRole(SystemConstants.roleGEditor);
			}
			toEditor.setStatus(m.getStatus());
			toEditor.setManuscriptId(manuscriptId);
			toEditor.setJournalId(journal.getId());
			toEditor.setRevisionCount(m.getRevisionCount());
			review.setCommentToEditor(toEditor);
			reviewerService.confirmReviewSheet(false, review, journal, request, locale);
			return true;
		}
	}
	
	@RequestMapping(value="/reviews/confirmReviewSheet", method=RequestMethod.POST)
	public @ResponseBody Boolean confirmReviewSheet(@ModelAttribute("review") Review review, 
		 	BindingResult result, 
		 	HttpServletRequest request, Locale locale, Model model, 
		 	@PathVariable(value="jnid") String jnid,
		 	@RequestParam(value="manuscriptId", required=true) int manuscriptId) throws IllegalStateException, IOException {
		if (result.hasErrors()) {
			System.out.println("binding error");
			return false;
		} else {
			Journal journal = (Journal)request.getSession().getAttribute("journal");
			SystemUser user = (SystemUser)request.getSession().getAttribute("user");
			Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			Comment toAuthor = review.getCommentToAuthor();
			toAuthor.setFromUserId(user.getId());
			toAuthor.setToUserId(m.getUserId());
			toAuthor.setFromRole(SystemConstants.roleReviewer);
			toAuthor.setToRole(SystemConstants.roleMember);
			toAuthor.setStatus(m.getStatus());
			toAuthor.setManuscriptId(manuscriptId);
			toAuthor.setJournalId(journal.getId());
			toAuthor.setRevisionCount(m.getRevisionCount());
			review.setCommentToAuthor(toAuthor);
			
			Comment toEditor = review.getCommentToEditor();
			toEditor.setFromUserId(user.getId());
			toEditor.setFromRole(SystemConstants.roleReviewer);
			if(m.getManuscriptTrackId() == 0) {
				toEditor.setToUserId(m.getChiefEditorUserId());
				toEditor.setToRole(SystemConstants.roleCEditor);
			} else {
				toEditor.setToUserId(m.getGuestEditorUserId());
				toEditor.setToRole(SystemConstants.roleGEditor);
			}
			toEditor.setStatus(m.getStatus());
			toEditor.setManuscriptId(manuscriptId);
			toEditor.setJournalId(journal.getId());
			toEditor.setRevisionCount(m.getRevisionCount());
			review.setCommentToEditor(toEditor);
			
			if(review.getOverall() > 3)
				review.setReReview(0);
			
			reviewerService.confirmReviewSheet(true, review, journal, request, locale);
			return true;
		}
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/reviews/uploadedFileTable", method=RequestMethod.GET)
	public String uploadedFileTable(HttpServletRequest request, Model model, @RequestParam(value="manuscriptId", required=true) int manuscriptId) {
		Manuscript m = manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<AdditionalReviewFileDesignation.values().length; i++)
			designations.add(AdditionalReviewFileDesignation.getType(i).name());
		List<UploadedFile> additionalReviewFiles = fileService.getFiles(manuscriptId, user.getId(), m.getRevisionCount(), designations);
		model.addAttribute("additionalReviewFiles", additionalReviewFiles);
		model.addAttribute("manuscript", m);
		return "reviewer.reviews.uploadedFileTable";
		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/reviews/uploadedFileCount", method=RequestMethod.GET)
	public String uploadedFileCount(HttpServletRequest request, Model model, @RequestParam(value="reviewId", required=true) int reviewId) {
		Review review = reviewerService.getReviewById(reviewId);
		List<String> designations = new ArrayList<String>();
		for(int i=0; i<AdditionalReviewFileDesignation.values().length; i++)
			designations.add(AdditionalReviewFileDesignation.getType(i).name());
		int fileUploadedCount = fileService.numFileUploadedCount(review.getManuscript(), designations);
		model.addAttribute("fileUploadedCount", fileUploadedCount);
		return Integer.toString(fileUploadedCount);
	}
	
	@RequestMapping(value="/reviews/upload", method = RequestMethod.POST, headers ={"Accept=application/json"})
	public @ResponseBody Boolean upload(HttpServletRequest request, 
			Principal principal, 
			MultipartHttpServletRequest req, 
			@PathVariable(value="jnid") String jnid,
			@RequestParam(value="fileDesignationId") int fileDesignationId,
			@RequestParam(value="reviewId", required=true) int reviewId) throws IllegalStateException, IOException {
		MultipartFile f = req.getFile("files");
		Review review = reviewerService.getReviewById(reviewId);
		String designation = AdditionalReviewFileDesignation.getType(fileDesignationId).name();
		try {
			fileService.processReviewFile(f, review, jnid, designation);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "reviewer";
	}

}
