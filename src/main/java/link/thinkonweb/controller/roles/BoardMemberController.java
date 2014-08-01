package link.thinkonweb.controller.roles;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.FileService;
import link.thinkonweb.service.manuscript.ManuscriptBuilder;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.manuscript.ReviewPreferenceService;
import link.thinkonweb.service.roles.AssociateEditorService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.DataTableServerResponse;
import link.thinkonweb.util.DatabaseInfo;
import link.thinkonweb.util.SystemUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/journals/{jnid}/boardMember/*")
public class BoardMemberController {
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(BoardMemberController.class);
	@Autowired
	private JournalService journalService;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private DatabaseInfo databaseInfo;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private ReviewPreferenceService rpService;
	@Autowired
	private AssociateEditorService aeService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private ManuscriptBuilder manuscriptBuilder;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private MessageSource messageSource;
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView home(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		RedirectView rv = new RedirectView("manuscripts");
		rv.setExposeModelAttributes(false);
		mav.setView(rv);
		return mav;
	}

	@RequestMapping(value="/manuscripts/getPapers/{pageType}", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody String getPapers(Model model, HttpServletRequest request, Locale locale, 
			@PathVariable(value="pageType") String pageType) {
		final DataTableClientRequest dRequest = new DataTableClientRequest(request);
		int iTotalRecords = databaseInfo.getTotalNumOfRows("jms", "manuscripts");
		int[] iTotalDisplayRecords = new int[1];
		Journal journal = (Journal)request.getSession().getAttribute("journal");
		List<String> sortableColumnNames = new ArrayList<String>();
		List<String> status = new ArrayList<String>();
		sortableColumnNames.add(null);
		sortableColumnNames.add("SUBMIT_ID");
		sortableColumnNames.add("TITLE");
		sortableColumnNames.add("EVENT_DATE");
		sortableColumnNames.add("STATUS");
		
		if(pageType.equals("accepted")) {
			status.add(SystemConstants.statusA);
			status.add(SystemConstants.statusM);
			status.add(SystemConstants.statusG);
			status.add(SystemConstants.statusP);
		} else if(pageType.equals("rejected")) {
			status.add(SystemConstants.statusJ);
			status.add(SystemConstants.statusW);
		}
		
		List<Manuscript> manuscripts = manuscriptService.getSubmittedManuscripts(0, journal.getId(), status, dRequest, iTotalDisplayRecords, sortableColumnNames, SystemConstants.TABLE_BUILD);
		List<Manuscript> filteredManuscripts = null;
		
		if(dRequest.getiSortCol()[0] == 3) {
			Collections.sort(manuscripts, new Comparator<Manuscript>() {
				@Override
				public int compare(Manuscript o1, Manuscript o2) {
					if (dRequest.getsSortDir()[0].equals("asc")) {
						if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
							return o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
						else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
							return -1;
						else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
							return 1;
						else
							return 0;

					} else {
						if(o1.getLastEventDateTime(SystemConstants.statusI) != null && o2.getLastEventDateTime(SystemConstants.statusI) != null)
							return -1 * o1.getLastEventDateTime(SystemConstants.statusI).compareTo(o2.getLastEventDateTime(SystemConstants.statusI));
						else if(o1.getLastEventDateTime(SystemConstants.statusI) == null)
							return 1;
						else if(o2.getLastEventDateTime(SystemConstants.statusI) == null)
							return -1;
						else
							return 0;
					}
				}
			});
		}

		if(manuscripts.size() <= dRequest.getiDisplayLength() || dRequest.getiDisplayLength() == -1)
			filteredManuscripts = manuscripts;
		else
			filteredManuscripts = manuscripts.subList(dRequest.getiDisplayStart(), 
					dRequest.getiDisplayStart() + dRequest.getiDisplayLength() > manuscripts.size() 
					? dRequest.getiDisplayStart() + (manuscripts.size() - dRequest.getiDisplayStart())
					: dRequest.getiDisplayStart() + dRequest.getiDisplayLength());
		
		DataTableServerResponse dResponse = new DataTableServerResponse(dRequest, iTotalRecords, iTotalDisplayRecords[0], filteredManuscripts.size());
		
		int i = 0, index;
		int number = dRequest.getiDisplayStart() + 1;
		for (Manuscript m: filteredManuscripts) {
			index = 0;
			dResponse.setAaData(i, index++, Integer.toString(number));
			
			if(m.getSubmitId() != null)
				dResponse.setAaData(i, index++, m.getSubmitId());
			else
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.beingAssigned", null , locale));

			if(m.getTitle() == null)
				dResponse.setAaData(i, index++, messageSource.getMessage("manuscript.titleNotYetSetup", null , locale));
			else {
				String invitedString = "";
				if(m.isInvite())
					invitedString  = "<span class='required'>*</span>(" + messageSource.getMessage("manuscript.inviteManuscript2", null , locale) + ") ";
				String titleUrl = "<a onClick='viewManuscript(" + m.getId() +  ", \"" + pageType + "\", \"summary\");'>" + invitedString + m.getTitle() + "</a>";

				dResponse.setAaData(i, index++, titleUrl);
			}
			
			if(m.getLastEventDateTime(SystemConstants.statusI) != null)
				dResponse.setAaData(i, index++, m.getLastEventDateTime(SystemConstants.statusI).getDate().toString());
			else
				dResponse.setAaData(i, index++, null);

			dResponse.setAaData(i, index++, systemUtil.getStatusDatatableLabel(m.getStatus(), locale));
			
			i++;
			number++;
		}
		
		return DataTableServerResponse.toJSONString(dResponse);		
	}
	
	@ModelAttribute("jnid")
	public String getJournalNameId(@PathVariable(value="jnid") String jnid) {
		return jnid;
	}
	
	@ModelAttribute("currentPageRole")
	public String getCurrentPageRole() {
		return "boardMember";
	}
}
