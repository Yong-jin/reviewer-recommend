package link.thinkonweb.controller.home;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.email.EmailDeliveryDao;
import link.thinkonweb.dao.manuscript.CoAuthorDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.domain.email.EmailDelivery;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalActivity;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.ManuscriptActivity;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Transactional
@RequestMapping("/activity/*")
public class MyActivityController {	
	@Autowired
	private UserService userService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private CoAuthorDao coAuthorsDao;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private ContactService contactService;
	@Autowired
	private CoAuthorDao coAuthorDao;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private EmailDeliveryDao emailDeliveryDao;

	@Transactional(readOnly = true)
	@RequestMapping(value="/myActivity", method=RequestMethod.GET)
	public String myActivity(Locale locale, Model model, HttpServletRequest request) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		SystemUser loginUser = this.userService.getByUsername(username);
		
		//System.out.println("loginUser.getSignupTime()" + loginUser.getSignupTime());
		
		model.addAttribute("user", loginUser);
		model.addAttribute("numberOfjournalsInMember", this.journalService.numJournalsByUser(loginUser, SystemConstants.roleMember));
		model.addAttribute("numberOfCoWrittenManuscriptsInMember", this.manuscriptService.numCoWrittenManuscripts(loginUser.getId(), 0, null, true));
		model.addAttribute("numberOfReviewMenuscriptsInMember", this.reviewerService.numReviewManuscriptsForMyActivity(loginUser.getId()));
		model.addAttribute("numberOfFeeds", emailDeliveryDao.numEmails(loginUser.getId()));
		model.addAttribute("statusTooltipData", systemUtil.getStatusTooltipData(locale));
		return "home.myActivity";
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/journalListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String journalList(HttpServletRequest request, Locale locale) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		
		SystemUser user = this.userService.getByUsername(request.getParameter("username"));
		int iTotalRecords = Integer.parseInt(request.getParameter("numberOfjournalsInMember"));
		
		int[] iTotalDisplayRecords = new int[1]; //placeHolder (call by reference) trick!
		
		List<Journal> journals = this.journalService.getJournalsByUserFromMyActivity(user, dRequest, iTotalDisplayRecords);
		//System.out.println(journals);
		
		List<JournalActivity> journalActivities = new LinkedList<JournalActivity>();
		List<String> status = new ArrayList<String>();
		status.add(SystemConstants.statusR);
		List<String> assignStatus = new ArrayList<String>();
		assignStatus.add(SystemConstants.reviewerA);
		List<String> allStatus = new ArrayList<String>();
		allStatus.add(SystemConstants.reviewerA);
		allStatus.add(SystemConstants.reviewerM);
		allStatus.add(SystemConstants.reviewerD);
		allStatus.add(SystemConstants.reviewerC);
		allStatus.add(SystemConstants.reviewerT);
		for (Journal journal : journals) {
			JournalActivity journalActivity = new JournalActivity(journal, 
												  this.manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), status, true),
												  this.manuscriptService.numCoWrittenManuscripts(user.getId(), journal.getId(), null, true),
												  this.reviewerService.numReviewManuscripts(user.getId(), 0, journal.getId(), -1, assignStatus),
												  this.reviewerService.numReviewManuscripts(user.getId(), 0, journal.getId(), -1, allStatus));
			journalActivities.add(journalActivity);
		}
		
		switch(dRequest.getiSortCol()[0]) {
			case 1:
				Collections.sort(journalActivities, new Comparator<JournalActivity>() {
					@Override
					public int compare(JournalActivity o1, JournalActivity o2){
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getJournal().getTitle().compareTo(o2.getJournal().getTitle());
						} else {
							return o2.getJournal().getTitle().compareTo(o1.getJournal().getTitle());
						}
					}
				});
				break;
			case 2:
				Collections.sort(journalActivities, new Comparator<JournalActivity>() {
					@Override
					public int compare(JournalActivity o1, JournalActivity o2){
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getJournal().getOrganization().compareTo(o2.getJournal().getOrganization());
						} else {
							return o2.getJournal().getOrganization().compareTo(o1.getJournal().getOrganization());
						}
					}
				});
				break;
			case 3:
				Collections.sort(journalActivities, new Comparator<JournalActivity>() {
					@Override
					public int compare(JournalActivity o1, JournalActivity o2){
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getJournal().getLanguageCode().compareTo(o2.getJournal().getLanguageCode());
						} else {
							return o2.getJournal().getLanguageCode().compareTo(o1.getJournal().getLanguageCode());
						}
					}
				});
				break;
			case 4:
				Collections.sort(journalActivities, new Comparator<JournalActivity>() {
					@Override
					public int compare(JournalActivity o1, JournalActivity o2){
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if (o1.getNumManuscriptsStatusR() > o2.getNumManuscriptsStatusR() ||
								(o1.getNumManuscriptsStatusR() == o2.getNumManuscriptsStatusR() && o1.getNumManuscriptsStatusAny() > o2.getNumManuscriptsStatusAny())) {
								return -1;
							}
							if (o1.getNumManuscriptsStatusR() < o2.getNumManuscriptsStatusR() ||
								(o1.getNumManuscriptsStatusR() == o2.getNumManuscriptsStatusR() && o1.getNumManuscriptsStatusAny() < o2.getNumManuscriptsStatusAny())) {
								return 1; 
							}
							return 0;
						} else {
							if (o1.getNumManuscriptsStatusR() < o2.getNumManuscriptsStatusR() ||
								(o1.getNumManuscriptsStatusR() == o2.getNumManuscriptsStatusR() && o1.getNumManuscriptsStatusAny() < o2.getNumManuscriptsStatusAny())) {
								return -1;
							}
							if (o1.getNumManuscriptsStatusR() > o2.getNumManuscriptsStatusR() ||
								(o1.getNumManuscriptsStatusR() == o2.getNumManuscriptsStatusR() && o1.getNumManuscriptsStatusAny() > o2.getNumManuscriptsStatusAny())) {
								return 1; 
							}
							return 0;
						}
					}
				});
				break;
			case 5:
				Collections.sort(journalActivities, new Comparator<JournalActivity>() {
					@Override
					public int compare(JournalActivity o1, JournalActivity o2){
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if (o1.getNumReviewManuscriptsStatusR() > o2.getNumReviewManuscriptsStatusR() ||
								(o1.getNumReviewManuscriptsStatusR() == o2.getNumReviewManuscriptsStatusR() && o1.getNumReviewManuscriptsStatusAny() > o2.getNumReviewManuscriptsStatusAny())) {
								return -1;
							}
							if (o1.getNumReviewManuscriptsStatusR() < o2.getNumReviewManuscriptsStatusR() ||
								(o1.getNumReviewManuscriptsStatusR() == o2.getNumReviewManuscriptsStatusR() && o1.getNumReviewManuscriptsStatusAny() < o2.getNumReviewManuscriptsStatusAny())) {
								return 1; 
							}
							return 0;
						} else {
							if (o1.getNumReviewManuscriptsStatusR() < o2.getNumReviewManuscriptsStatusR() ||
								(o1.getNumReviewManuscriptsStatusR() == o2.getNumReviewManuscriptsStatusR() && o1.getNumReviewManuscriptsStatusAny() < o2.getNumReviewManuscriptsStatusAny())) {
								return -1;
							}
							if (o1.getNumReviewManuscriptsStatusR() > o2.getNumReviewManuscriptsStatusR() ||
								(o1.getNumReviewManuscriptsStatusR() == o2.getNumReviewManuscriptsStatusR() && o1.getNumReviewManuscriptsStatusAny() > o2.getNumReviewManuscriptsStatusAny())) {
								return 1; 
							}
							return 0;
						}
					}
				});
				break;
		}
				
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], journals.size());
		
		int i = 0;
		int number = dRequest.getiDisplayStart() + 1;
		StringBuffer sb = new StringBuffer();
		String language = null;
		for (JournalActivity journalActivity : journalActivities) {
			if (this.authorityService.hasRole(SystemConstants.roleManager, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/manager/").append("'> <i class='fa fa-tasks'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_manager", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleMember, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/author/").append("'><i class='fa fa-book'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_member", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleCEditor, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/chiefEditor").append("'> <i class='fa fa-gavel'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_c-editor", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleAEditor, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/associateEditor").append("'> <i class='fa fa-briefcase'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_a-editor", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleGEditor, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/guestEditor").append("'> <i class='fa fa-suitcase'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_g-editor", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleBMember, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/boardMember").append("'> <i class='fa fa-group'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_b-member", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a> ");
			};
			if (this.authorityService.hasRole(SystemConstants.roleReviewer, journalActivity.getJournal().getId())) {
				sb.append("<a class='btn btn-xs' href='journals/" + journalActivity.getJournal().getJournalNameId() + "/gatethrough/reviewer").append("'> <i class='fa fa-file-text-o'></i> ")
					.append(this.messageSource.getMessage("user.role.journal_reviewer", null, locale)).append(" <i class='fa fa-arrow-circle-o-right'></i></a>");
			};
			
			
			dResponse.setAaData(i, 0, Integer.toString(number));
			dResponse.setAaData(i, 1, "<a href='" + journalActivity.getJournal().getHomepage() + "'>" + "<i class='fa fa-home'></i></a> <a href='journals/" + journalActivity.getJournal().getJournalNameId() + "'>" + journalActivity.getJournal().getTitle() + "</a>");
			dResponse.setAaData(i, 2, journalActivity.getJournal().getOrganization());
			
			language = journalActivity.getJournal().getLanguageCode();
			if (language.equals(SystemConstants.englishLanguageCode)) {
				language = this.messageSource.getMessage("system.english2", null, locale);
			} else if (language.equals(SystemConstants.koreanLanguageCode)) {
				language = this.messageSource.getMessage("system.korean2", null, locale);
			}
			dResponse.setAaData(i, 3, language);
			dResponse.setAaData(i, 4, journalActivity.getNumManuscriptsStatusR() + "/" + journalActivity.getNumManuscriptsStatusAny());
			dResponse.setAaData(i, 5, journalActivity.getNumReviewManuscriptsStatusR() + "/" + journalActivity.getNumReviewManuscriptsStatusAny());

			dResponse.setAaData(i, 6, sb.toString());
			sb.delete(0, sb.length());
			i++;
			number++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscriptListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String manuscriptList(HttpServletRequest request, Locale locale) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		SystemUser user = null;
		
		//System.out.println(dRequest);
		
		if (request.getParameter("username") != null || !request.getParameter("username").trim().equals("")) {
			user = this.userService.getByUsername(request.getParameter("username"));
		} else {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			user = this.userService.getByUsername(auth.getName());
		}
		
		int iTotalRecords = Integer.parseInt(request.getParameter("numberOfCoWrittenManuscriptsInMember"));
		List<Integer> manuscriptIds = this.manuscriptService.getCoWrittenManuscriptIdsByUserFromMyActivity(user.getId(), dRequest);
		
		List<ManuscriptActivity> manuscriptActivities = new LinkedList<ManuscriptActivity>();
		Manuscript manuscript = null;
		for (Integer manuscriptId : manuscriptIds) {
			ManuscriptActivity manuscriptActivity = new ManuscriptActivity();
			manuscript = this.manuscriptService.getManuscriptById(manuscriptId, SystemConstants.NONE_BUILD);
			manuscriptActivity.setManuscript(manuscript);
			manuscriptActivity.setManuscriptTitle(manuscript.getTitle());
			
			
			List<CoAuthor> coAuthors = coAuthorDao.findCoAuthors(manuscriptId, manuscript.getRevisionCount(), 0, false);
			if (coAuthors != null) {
				Collections.sort(coAuthors);
				for (CoAuthor c: coAuthors) {
					c.setUser(userService.getById(c.getUserId()));
				}
				manuscript.setCoAuthors(coAuthors);
				
				CoAuthor corresAuthor = coAuthorDao.findCoAuthor(manuscriptId, 0, manuscript.getRevisionCount(), 0, true);
				corresAuthor.setUser(userService.getById(corresAuthor.getUserId()));
				manuscript.setCorresAuthor(corresAuthor);
			}
			
			List<EventDateTime> manuscriptEventDates = eventDateTimeDao.findEventDatesByManuscriptId(manuscriptId);
			if (manuscriptEventDates != null) {
				manuscript.setEventDateTimes(manuscriptEventDates);
				
				List<EventDateTime> manuscriptLastEventDates = new ArrayList<EventDateTime>();
				Set<String> statusSet = new HashSet<String>();
				for (EventDateTime eventDate: manuscriptEventDates) {
					String status = eventDate.getStatus();
					statusSet.add(status);
				}
				
				for (String status: statusSet) {
					int eventDateId = eventDateTimeDao.findLastEventDateIdByManuscriptIdAndStatus(manuscriptId, status);
					EventDateTime eventDate = eventDateTimeDao.findEventDateById(eventDateId);
					manuscriptLastEventDates.add(eventDate);
				}
				manuscript.setLastEventDateTimes(manuscriptLastEventDates);
			}
			
			coAuthors = manuscript.getCoAuthors();
			StringBuffer sbCoAuthorNames = new StringBuffer();
			Journal journal = this.journalService.getById(manuscript.getJournalId());
			int authorOrder = 0;
			for (CoAuthor coAuthor : coAuthors) {
				if (journal.getLanguageCode().equals(SystemConstants.koreanLanguageCode)) {
					if (coAuthor.getUser().getContact().getLocalFullName() != null) {
						sbCoAuthorNames.append(coAuthor.getUser().getContact().getLocalFullName()).append(", ");
					} else {
						sbCoAuthorNames.append(coAuthor.getUser().getContact().getLastName()).append(" ").append(coAuthor.getUser().getContact().getFirstName()).append(", ");
					}
				} else {
					sbCoAuthorNames.append(coAuthor.getUser().getContact().getFirstName()).append(" ").append(coAuthor.getUser().getContact().getLastName()).append(", ");
				}
				
				if (coAuthor.getUserId() == user.getId()) {
					authorOrder = coAuthor.getAuthorOrder();
				}
			}
			manuscriptActivity.setCoAuthorsNames(sbCoAuthorNames.substring(0, sbCoAuthorNames.length()-2));
			manuscriptActivity.setAuthorOrder(String.valueOf(authorOrder));
			
			if (journal.getLanguageCode().equals(SystemConstants.koreanLanguageCode)) {
				if (this.contactService.getByUserId(manuscript.getUserId()).getLocalFullName() != null) {
					manuscriptActivity.setSubmitter(this.contactService.getByUserId(manuscript.getUserId()).getLocalFullName());
				} else {
					manuscriptActivity.setSubmitter(this.contactService.getByUserId(manuscript.getUserId()).getFirstName() + " " + this.contactService.getByUserId(manuscript.getUserId()).getLastName());
				}
			} else {
				manuscriptActivity.setSubmitter(this.contactService.getByUserId(manuscript.getUserId()).getLastName() + " " + this.contactService.getByUserId(manuscript.getUserId()).getFirstName());
			}
			
			if (journal.getLanguageCode().equals(SystemConstants.koreanLanguageCode)) {
				if (manuscript.getCorresAuthor().getUser().getContact().getLocalFullName() != null) {
					manuscriptActivity.setCorrespondingAuthor(manuscript.getCorresAuthor().getUser().getContact().getLocalFullName());
				} else {
					manuscriptActivity.setCorrespondingAuthor(manuscript.getCorresAuthor().getUser().getContact().getLastName() + " " + manuscript.getCorresAuthor().getUser().getContact().getFirstName());
				}
			} else {
				manuscriptActivity.setCorrespondingAuthor(manuscript.getCorresAuthor().getUser().getContact().getFirstName() + " " + manuscript.getCorresAuthor().getUser().getContact().getLastName());
			}
			
			manuscriptActivity.setJournalTitle(journal.getTitle());
			
			if (manuscript.getStatus().equals(SystemConstants.statusB)) {
				manuscriptActivity.setLocalSubmissionDate("-");
			} else {
				EventDateTime eventDateTime = manuscript.getLastEventDateTime(SystemConstants.statusI);
				if (eventDateTime == null) {
					manuscriptActivity.setLocalSubmissionDate("-");
				} else {
					manuscriptActivity.setLocalSubmissionDate(eventDateTime.getDate().toString());
				}
			}
			
			manuscriptActivity.setStatusMessage(systemUtil.getStatusDatatableLabel(manuscript.getStatus(), locale));
			
			manuscriptActivities.add(manuscriptActivity);
		}
		
		if (!(dRequest.getsSearchGlobal() == null || dRequest.getsSearchGlobal().equals(""))) { 
		    for (ManuscriptActivity manuscriptActivity : manuscriptActivities) {
		    	if (manuscriptActivity.getManuscriptTitle().contains(dRequest.getsSearchGlobal()) 
						|| manuscriptActivity.getCoAuthorsNames().contains(dRequest.getsSearchGlobal())
						|| manuscriptActivity.getJournalTitle().contains(dRequest.getsSearchGlobal()) 
						|| manuscriptActivity.getStatusMessage().contains(dRequest.getsSearchGlobal())) {
		    		manuscriptActivity.setChecked(true);
		    	} else {
		    		manuscriptActivity.setChecked(false);
		    	}
		    }
	    }
		
		int iTotalDisplayRecords = 0;
		List<ManuscriptActivity> filteredManuscriptActivities = new LinkedList<ManuscriptActivity>();
		for (ManuscriptActivity manuscriptActivity : manuscriptActivities) { 
			if (manuscriptActivity.isChecked()) {
				filteredManuscriptActivities.add(manuscriptActivity);
				iTotalDisplayRecords++;
			}
		}
		
		switch (dRequest.getiSortCol()[0]) {
			case 1:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getManuscriptTitle().compareToIgnoreCase(o2.getManuscriptTitle());
						} else {
							return o2.getManuscriptTitle().compareToIgnoreCase(o1.getManuscriptTitle());
						}
					}
				});
				break;
			case 2:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getCoAuthorsNames().compareToIgnoreCase(o2.getCoAuthorsNames());
						} else {
							return o2.getCoAuthorsNames().compareToIgnoreCase(o1.getCoAuthorsNames());
						}
					}
				});
				break;
			case 3:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getAuthorOrder().compareTo(o2.getAuthorOrder());
						} else {
							return o2.getAuthorOrder().compareTo(o1.getAuthorOrder());
						}
					}
				});
				break;
			case 4:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getSubmitter().compareToIgnoreCase(o2.getSubmitter());
						} else {
							return o2.getSubmitter().compareToIgnoreCase(o1.getSubmitter());
						}
					}
				});
				break;
			case 5:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getCorrespondingAuthor().compareToIgnoreCase(o2.getCorrespondingAuthor());
						} else {
							return o2.getCorrespondingAuthor().compareToIgnoreCase(o1.getCorrespondingAuthor());
						}
					}
				});
				break;
			case 6:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getJournalTitle().compareToIgnoreCase(o2.getJournalTitle()); 
						} else {
							return o2.getJournalTitle().compareToIgnoreCase(o1.getJournalTitle()); 
						}
					}
				});
				break;
			case 7:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getLocalSubmissionDate().compareTo(o2.getLocalSubmissionDate());
						} else {
							return o2.getLocalSubmissionDate().compareTo(o1.getLocalSubmissionDate());							
						}
					}
				});
				break;
			default:
				Collections.sort(filteredManuscriptActivities, new Comparator<ManuscriptActivity>() {
					@Override
					public int compare(ManuscriptActivity o1, ManuscriptActivity o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getManuscript().getStatus().compareTo(o2.getManuscript().getStatus());
						} else {
							return o2.getManuscript().getStatus().compareTo(o1.getManuscript().getStatus());
						}
					}
				});
				break;	
		}
	    
	    filteredManuscriptActivities = filteredManuscriptActivities.subList(dRequest.getiDisplayStart(), 
	    																	dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > filteredManuscriptActivities.size() 
	    																	? filteredManuscriptActivities.size() 
	    																	: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords, filteredManuscriptActivities.size());
		
		int i = 0;
		StringBuffer buttonString = new StringBuffer();
		StringBuffer titleLink = new StringBuffer();
		for (ManuscriptActivity manuscriptActivity : filteredManuscriptActivities) {
			dResponse.setAaData(i, 0, Integer.toString(dRequest.getiDisplayStart() + 1 + i));
			Journal journal = this.journalService.getById(manuscript.getJournalId());
			manuscript = manuscriptActivity.getManuscript();
			
			switch (manuscriptActivity.getManuscript().getStatus()) {
				case SystemConstants.statusB:
					titleLink.append(request.getContextPath()).append("/journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=beingSubmitted&v=summary&manuscriptId=" + manuscript.getId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='submit(\"" + journal.getJournalNameId() + "\", " + manuscript.getId() + ");'>").append(messageSource.getMessage("author.action.composeAndSubmit", null, locale)).append("</button>");
					break;
				case SystemConstants.statusI:
				case SystemConstants.statusV:
				case SystemConstants.statusO:
				case SystemConstants.statusR:
				case SystemConstants.statusE:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=submitted&v=summary&manuscriptId=" + manuscript.getId());
					break;
				case SystemConstants.statusD:
					titleLink.append(request.getContextPath()).append("/journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=submitted&v=summary&manuscriptId=" + manuscript.getId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='submit(\"" + journal.getJournalNameId() + "\", " + manuscript.getId() + ");'>").append(messageSource.getMessage("author.action.composeAndSubmit", null, locale)).append("</button>");
					break;
				case SystemConstants.statusA:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=accepted&v=summary&manuscriptId=" + manuscript.getId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='moveTo(\"" + journal.getJournalNameId() + "\", \"author\", " +   manuscript.getId() +  ", \"accepted\", \"cameraReady\");'/>").append(messageSource.getMessage("author.action.submitCameraReady", null, locale)).append("</button>");
					break;					
				case SystemConstants.statusG:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=accepted&v=summary&manuscriptId=" + manuscript.getId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='moveTo(\"" + journal.getJournalNameId() + "\", \"author\", " + manuscript.getId() +  ", \"accepted\", \"galleryProof\");'/>").append(messageSource.getMessage("author.action.checkGalleryProof", null, locale)).append("</button>");
					break;
				case SystemConstants.statusM:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=accepted&v=summary&manuscriptId=" + manuscript.getId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width135' onClick='moveTo(\"" + journal.getJournalNameId() + "\", \"author\", " + manuscript.getId() +  ", \"accepted\", \"cameraReady\");'/>").append(messageSource.getMessage("author.action.viewCameraReady", null, locale)).append("</button>");
					break;
				case SystemConstants.statusP:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=published&v=summary&manuscriptId=" + manuscript.getId());
					break;
				default:
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/author?pageType=withdrawn&v=summary&manuscriptId=" + manuscript.getId());
			}
			
			if(manuscriptActivity.getManuscriptTitle() == null)
				dResponse.setAaData(i, 1, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else
				dResponse.setAaData(i, 1, "<a href='" + titleLink.toString() + "'>" + manuscriptActivity.getManuscriptTitle() + "</a>");
			dResponse.setAaData(i, 2, manuscriptActivity.getCoAuthorsNames());
			dResponse.setAaData(i, 3, manuscriptActivity.getAuthorOrder());
			dResponse.setAaData(i, 4, manuscriptActivity.getSubmitter());
			dResponse.setAaData(i, 5, manuscriptActivity.getCorrespondingAuthor());
			dResponse.setAaData(i, 6, "<a href='journals/" + this.journalService.getById(manuscriptActivity.getManuscript().getJournalId()).getJournalNameId() + "'>" + manuscriptActivity.getJournalTitle() + "</a>");
			dResponse.setAaData(i, 7, manuscriptActivity.getLocalSubmissionDate());
			dResponse.setAaData(i, 8, manuscriptActivity.getStatusMessage());
			dResponse.setAaData(i, 9, buttonString.toString());
			
			buttonString.delete(0, buttonString.length());
			titleLink.delete(0, titleLink.length());
			i++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/manuscriptReviewListAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody String manuscriptReviewList(HttpServletRequest request, Locale locale) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		SystemUser user = null;
		
		//System.out.println(dRequest);
		
		if (request.getParameter("username") != null || !request.getParameter("username").trim().equals("")) {
			user = this.userService.getByUsername(request.getParameter("username"));
		} else {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			user = this.userService.getByUsername(auth.getName());
		}
				
		int iTotalRecords = Integer.parseInt(request.getParameter("numberOfReviewMenuscriptsInMember"));
		int[] iTotalDisplayRecords = new int[1];
		
		List<Review> reviews = reviewerService.getReviewManuscriptsForMyActivity(user.getId());
		iTotalDisplayRecords[0] = reviews.size();
		
		List<Review> filteredReviews = null;
		switch (dRequest.getiSortCol()[0]) {
			case 1:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getManuscript().getTitle().compareToIgnoreCase(o2.getManuscript().getTitle());
						} else {
							return o2.getManuscript().getTitle().compareToIgnoreCase(o1.getManuscript().getTitle());
						}
					}
				});
				break;
			case 2:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return journalService.getById(o1.getJournalId()).getTitle().compareToIgnoreCase(journalService.getById(o2.getJournalId()).getTitle());
						} else {
							return journalService.getById(o2.getJournalId()).getTitle().compareToIgnoreCase(journalService.getById(o1.getJournalId()).getTitle());
						}
					}
				});
				break;
			case 3:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if (o1.getRevisionCount() > o2.getRevisionCount()) {
								return 1;
							} else if (o1.getRevisionCount() < o2.getRevisionCount()) {
								return -1;
							} else {
								return 0;
							}
						} else {
							if (o1.getRevisionCount() < o2.getRevisionCount()) {
								return 1;
							} else if (o1.getRevisionCount() > o2.getRevisionCount()) {
								return -1;
							} else {
								return 0;
							}
						}
					}
				});
				break;
			case 4:
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
				break;
			case 5:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getDueDate().compareTo(o2.getDueDate());
						} else {
							return o2.getDueDate().compareTo(o1.getDueDate());
						}
					}
				});
				break;
				/*
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if (o1.getDueDate() == null)
								return -1;
							else if (o2.getDueDate() == null)
								return 1;
							else
								return 0;
						} else {
							if (o1.getDueDate() == null)
								return 1;
							else if (o2.getDueDate() == null)
								return -1;
							else
								return 0;
						}
					}
				});
				*/
			case 6:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else
								return 0;
						} else {
							if(o1.getReviewEventDateTime(SystemConstants.reviewerC) != null && o2.getReviewEventDateTime(SystemConstants.reviewerC) != null)
								return -1 * o1.getReviewEventDateTime(SystemConstants.reviewerC).compareTo(o2.getReviewEventDateTime(SystemConstants.reviewerC));
							else if(o1.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return 1;
							else if(o2.getReviewEventDateTime(SystemConstants.reviewerC) == null)
								return -1;
							else
								return 0;
						}
					}
				});
				break;
			default:
				Collections.sort(reviews, new Comparator<Review>() {
					@Override
					public int compare(Review o1, Review o2) {
						if (dRequest.getsSortDir()[0].equals("asc")) {
							return o1.getStatus().compareTo(o2.getStatus());
						} else {
							return o2.getStatus().compareTo(o1.getStatus());
						}
					}
				});
		}
		
		if(reviews.size() < dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1) {
			filteredReviews = reviews;
		} else {
			filteredReviews = reviews.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > reviews.size() 
					? dRequest.getiDisplayStart() + (reviews.size() - dRequest.getiDisplayStart()) 
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		}
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredReviews.size());
		
		int i = 0;
		StringBuffer buttonString = new StringBuffer();
		StringBuffer titleLink = new StringBuffer();
		
		for (Review r: filteredReviews) {
			String status = "<strong>Status " + r.getStatus() + "</strong><br/>";
			
			dResponse.setAaData(i, 0, Integer.toString(dRequest.getiDisplayStart() + 1 + i));
			Journal journal = this.journalService.getById(r.getJournalId());
			switch (r.getStatus()) {
				case SystemConstants.reviewerA: 
					status = status + this.messageSource.getMessage("system.review.titleA", null, locale);
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/reviewer?pageType=assigned&v=summary&manuscriptId=" + r.getManuscriptId());
					buttonString.append("<button type='button' class='btn btn-default btn-xs actionButton width70' onClick='moveTo(\"" + journal.getJournalNameId() + "\", \"reviewer\", " +   r.getManuscriptId() +  ", \"assigned\", \"reviewSheet\");'/>").append(messageSource.getMessage("reviewer.review", null , locale)).append("</button>");
					break;	
				
				case SystemConstants.reviewerC: 
					status = status + this.messageSource.getMessage("system.review.titleC", null, locale);
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/reviewer?pageType=other&v=summary&manuscriptId=" + r.getManuscriptId());
					break;	
				
				case SystemConstants.reviewerM: 
					status = status + this.messageSource.getMessage("system.review.titleM", null, locale);
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/reviewer?pageType=other&v=summary&manuscriptId=" + r.getManuscriptId());
					break;
				
				case SystemConstants.reviewerT: 
					status = status + this.messageSource.getMessage("system.review.titleT", null, locale);
					titleLink.append("journals/")
							 .append(journal.getJournalNameId())
							 .append("/gatethrough/reviewer?pageType=other&v=summary&manuscriptId=" + r.getManuscriptId());
					break;
			}
			
			dResponse.setAaData(i, 1, "<a href='" + titleLink.toString() + "'>" + r.getManuscript().getTitle() + "</a>");
			dResponse.setAaData(i, 2, "<a href='journals/" + journal.getJournalNameId() + "'>" + journal.getTitle() + "</a>");
			String version = r.getRevisionCount() == 0 ? this.messageSource.getMessage("system.original", null, locale) 
													   : this.messageSource.getMessage("system.revision", null, locale) + " #" + r.getRevisionCount();
			dResponse.setAaData(i, 3, version);

			String assignDate = r.getReviewEventDateTime(SystemConstants.reviewerA) == null ? "-" 
								: r.getReviewEventDateTime(SystemConstants.reviewerA).getDate().toString();
			dResponse.setAaData(i, 4, assignDate);
			
			String dueDate = (r.getDueDate() == null || r.getDueTime() == null) ? "-" 
								: r.getDueDate().toString();
			dResponse.setAaData(i, 5, dueDate);
			
			String completeDate = r.getReviewEventDateTime(SystemConstants.reviewerC) == null ? "-" 
								: r.getReviewEventDateTime(SystemConstants.reviewerC).getDate().toString();
			dResponse.setAaData(i, 6, completeDate);
			dResponse.setAaData(i, 7, status);
			dResponse.setAaData(i, 8, buttonString.toString());
			
			buttonString.delete(0, buttonString.length());
			titleLink.delete(0, titleLink.length());
			i++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value = "/feedsListAjax", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String feedsListAjax(Model model, HttpServletRequest request, Locale locale) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		SystemUser user = (SystemUser)request.getSession().getAttribute("user");
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "EMAIL_MESSAGES");
		int[] iTotalDisplayRecords = new int[1];
		List<String> sortableColumnNames = new ArrayList<String>();
		List<EmailDelivery> emails = null;
		sortableColumnNames.add(null);
		sortableColumnNames.add("EM.SUBJECT");
		sortableColumnNames.add("ED.DATE");
		sortableColumnNames.add("ED.TIME");
		emails = emailDeliveryDao.findEmails(user.getId(), dRequest, iTotalDisplayRecords, sortableColumnNames);

		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], emails.size());
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		for (EmailDelivery ed: emails) {
			index = 0;
			EmailMessage em = ed.getEmailMessage();
			dResponse.setAaData(i, index++, Integer.toString(number));
			String subjectString = "<a onClick='viewFeed(" + ed.getId() +  ");'>" + em.getSubject() + "</a>";
			dResponse.setAaData(i, index++, subjectString);
			dResponse.setAaData(i, index++, ed.getDate().toString());
			dResponse.setAaData(i, index++, ed.getTime().toString());		
			i++;
			number++;
		}
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@Transactional(readOnly = true)
	@RequestMapping(value="/viewFeed", method=RequestMethod.GET)
	public ModelAndView extendDueDate(Model model, HttpServletRequest request, Locale locale,
			@RequestParam(value="emailDeliveryId", required=true) int emailDeliveryId) {
		ModelAndView mav = new ModelAndView();
		EmailDelivery ed = emailDeliveryDao.findById(emailDeliveryId);
		mav.addObject("emailDelivery", ed);
		mav.setViewName("myActivity.viewFeedForm");
		return mav;
	}
}