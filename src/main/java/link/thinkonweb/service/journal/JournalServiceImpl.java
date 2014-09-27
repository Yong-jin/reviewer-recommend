package link.thinkonweb.service.journal;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TimeZone;

import javax.inject.Inject;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.DivisionDao;
import link.thinkonweb.dao.journal.JournalDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.journal.Division;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

public class JournalServiceImpl implements JournalService {
	@Inject
	private JournalDao journalDao;
	@Inject
	private AuthorityService authorityService;
	@Inject
	private DivisionDao divisionDao;
	@Inject
	private JournalRoleDao journalRoleDao;
	@Inject
	private SystemUtil systemUtil;
	
	public JournalDao getJournalDao() {
		return journalDao;
	}

	public void setJournalDao(JournalDao journalDao) {
		this.journalDao = journalDao;
	}

	@Override
	public int create(Journal journal) {
		int journalId = journalDao.create(journal);
		return journalId;
	}
	
	@Override
	public int submit(Journal journal) {
	
		this.journalDao.updateRegisteredDate(journal);
		this.journalDao.update(journal);
		//Journal storedJournal = this.journalDao.findByJournalNameID(journal.getJournalNameId());
		
		this.authorityService.create(journal.getCreator().getId(), journal.getId(), SystemConstants.roleMember);
		this.authorityService.create(journal.getCreator().getId(), journal.getId(), SystemConstants.roleManager);	
		authorityService.authenticateUserAndSetSession(journal.getCreator());
		return journal.getId();
	}
	
	@Override
	public void delete(Journal journal) {
		//this.journalRoleDao.delete(0, journal.getId(), null);
		//Authorities 테이블의 JOURNAL_ID는 Foreign Key를 못만들었음 (이유: JOURNAL_ID = 0 할당)
		List<Authority> authorities = authorityService.getAuthorities(0, journal.getId(), null);
		
		for (Authority authority : authorities) {
			authorityService.delete(authority);
		}
		
		this.journalDao.delete(journal);
	}

	@Override
	public List<Journal> getAll() {
		return this.journalDao.findAll();
	}

	@Override
	public void update(Journal journal) {
		this.journalDao.update(journal);
	}

	@Override
	public Journal getById(int id) {
		return this.journalDao.findById(id);
	}
	
	@Override
	public Journal getByJournalNameId(String jnid) {
		return journalDao.findByJournalNameID(jnid);
	}

	@Override
	public List<Journal> getByTitle(String title) {
		return this.journalDao.findByTitle(title);
	}
	
	@Override
	public List<Journal> getByShortTitle(String shortTitle) {
		return this.journalDao.findByShortTitle(shortTitle);
	}
	
	@Override
	public List<Journal> getByCreator(SystemUser creator) {
		return this.journalDao.findByCreator(creator);
	}
	
	@Override
	public boolean isUniqueJournalNameID(String jnid) {
		if (journalDao.findByJournalNameID(jnid) == null) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public List<Division> getDivisionsById(int id) {
		List<Division> divisions = divisionDao.findByJournalId(id);
		Collections.sort(divisions);
		return divisions;
	}
	
	@Override
	public List<Journal> getBySuperManagerJournalList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale) {
		List<String> individualSearchList = new ArrayList<String>();

		if (!dRequest.getsSearch()[2].equals("")) {
			StringBuffer sb = new StringBuffer();
	    	StringTokenizer st = new StringTokenizer(dRequest.getsSearch()[2]);
	    	String nameKeyword = null;
	    	sb.append(" (");
	    	while (st.hasMoreElements()) {
	    		nameKeyword = (String)st.nextElement();
	    		sb.append("C.FIRST_NAME like '%" + nameKeyword + "%' OR C.LAST_NAME like '%" + nameKeyword + "%' OR ");
			}
	    	sb = sb.delete(sb.length()-4, sb.length());
	    	sb.append(")");
	    	individualSearchList.add(sb.toString());
	    }
		
		if (!dRequest.getsSearch()[0].equals("")) {
	    	individualSearchList.add(" J.JOURNAL_NAME_ID like '%" + dRequest.getsSearch()[0] + "%'");	    
	    }
	    if (!dRequest.getsSearch()[1].equals("")) {
	    	individualSearchList.add(" U.USERNAME like '%" + dRequest.getsSearch()[1] + "%'");
	    }
	    if (!dRequest.getsSearch()[3].equals("")) {
	    	individualSearchList.add(" J.SHORT_TITLE like '%" + dRequest.getsSearch()[3] + "%'");
	    }
	    if (!dRequest.getsSearch()[4].equals("")) {
	    	individualSearchList.add(" J.TITLE like '%" + dRequest.getsSearch()[4] + "%'");
	    }
	    if (!dRequest.getsSearch()[5].equals("")) {
	    	individualSearchList.add(" J.ORGANIZATION like '%" + dRequest.getsSearch()[5] + "%'");
	    }
	    if (!(dRequest.getsSearch()[6].equals("") || dRequest.getsSearch()[6].equals("Any"))) {
	    	individualSearchList.add(" J.LANGUAGE_CODE ='" + dRequest.getsSearch()[6] + "'");
	    }
	    if (!dRequest.getsSearch()[8].equals("")) {
	    	individualSearchList.add(" J.PUBLISHER_COUNTRY_CODE ='" + dRequest.getsSearch()[8] + "'");
	    }
	    if (!(dRequest.getsSearch()[11].equals("") || dRequest.getsSearch()[11].equals("Any"))) {
	    	if (dRequest.getsSearch()[11].equals("Enable")) {
	    		individualSearchList.add(" J.ENABLED = 1 ");
	    	} else {
	    		individualSearchList.add(" J.ENABLED = 0 ");
	    	}
	    }
	    
	    String fromUTCDate = null;
	    String toUTCDate = null;
	    StringTokenizer st = null;
	    Calendar cal = null;
		
		if (!dRequest.getsSearch()[9].equals("")) {
	    	String fromDateString = dRequest.getsSearch()[9];
	    	st = new StringTokenizer(fromDateString, "-");
	    	
	    	cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			cal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1, Integer.parseInt(st.nextToken())-1);
			fromUTCDate = systemUtil.getUTCDateFromClintLocalDateAsString(dRequest.getRequest(), cal);
			individualSearchList.add(" J.REGISTERED_DATE >= STR_TO_DATE('" + fromUTCDate + "', '%Y-%m-%d')");
	    }
		
		if (!dRequest.getsSearch()[10].equals("")) {
	    	String fromDateString = dRequest.getsSearch()[10];
	    	st = new StringTokenizer(fromDateString, "-");
	    	
	    	cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			cal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1, Integer.parseInt(st.nextToken()));
			toUTCDate = systemUtil.getUTCDateFromClintLocalDateAsString(dRequest.getRequest(), cal);
			individualSearchList.add(" J.REGISTERED_DATE <= STR_TO_DATE('" + toUTCDate + "', '%Y-%m-%d')");
	    }
	    
	    StringBuffer individualSearchSB = new StringBuffer();
	    if (individualSearchList.size() == 1){
	    	individualSearchSB.append(individualSearchList.get(0));
	    } else if (individualSearchList.size() > 1) {
	        for (int i=0 ; i < individualSearchList.size() - 1 ; i++) {
	        	individualSearchSB.append(individualSearchList.get(i)).append(" AND ");
	        }
	        individualSearchSB.append(individualSearchList.get(individualSearchList.size()-1));
	    }

        String sGlobalTerm = dRequest.getsSearchGlobal();
        
	    StringBuffer searchSqlSB = new StringBuffer();
	    searchSqlSB.append("SELECT COUNT(J.ID) FROM JOURNALS J JOIN USERS U ON U.ID = J.CREATOR_ID JOIN CONTACTS C ON U.ID = C.USER_ID");
	    
        if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
        	if(individualSearchList.size() != 0){
 			    searchSqlSB.append(" WHERE").append(individualSearchSB.toString());
	        }
        } else {
		    searchSqlSB.append(" WHERE (J.JOURNAL_NAME_ID LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR U.USERNAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR J.SHORT_TITLE like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR J.TITLE like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR J.ORGANIZATION like '%").append(sGlobalTerm).append("%')");
		    
		    if(individualSearchList.size() != 0){
			    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
	        }
        }
        
        String searchSql = searchSqlSB.toString();
	    
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(this.journalDao.getNumOfRecordsByCustomSql(searchSql));
	  
	    searchSqlSB.replace(7, 18, "J.*, U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
	    
	    
	    String[] sortableCoName = null;
	    if (locale.getCountry().equals("KR")) {
	    	sortableCoName = new String[]{null, "J.JOURNAL_NAME_ID", "U.USERNAME", "C.FIRST_NAME", "J.SHORT_TITLE", "J.TITLE", "J.ORGANIZATION", "J.LANGUAGE_CODE", "J.PUBLISHER_COUNTRY_CODE", "J.REGISTERED_DATE", "J.REGISTERED_TIME", null, "J.ENABLED"};
		} else {
			sortableCoName = new String[]{null, "J.JOURNAL_NAME_ID", "U.USERNAME", "C.LAST_NAME", "J.SHORT_TITLE", "J.TITLE", "J.ORGANIZATION", "J.LANGUAGE_CODE", "J.PUBLISHER_COUNTRY_CODE", "J.REGISTERED_DATE", "J.REGISTERED_TIME", null, "J.ENABLED"};
		}
        
        if (dRequest.getiSortingCols() != 0) {
        	searchSqlSB.append(" ORDER BY ");
        	int i = 0;
	        for (; i < dRequest.getiSortingCols()-1 ; i++) {
	        	searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        }
	        
	        searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]);
        }
        if(dRequest.getiDisplayLength() != -1)
        	searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        
        searchSql = searchSqlSB.toString();
		return this.journalDao.findByCustomJournalUserContactSql(searchSql);
	}
	
	@Override
	public Set<Journal> getJournalsByUser(SystemUser user, String role) {
		return this.journalRoleDao.getJournalsByUser(user.getId(), role);
	}

	@Override
	public int numJournalsByUser(SystemUser user, String role) {
		return this.journalRoleDao.numJournalsByUser(user.getId(), role);
	}
	
	@Override
	public Set<SystemUser> getUsersByJournal(Journal journal, String role) {
		return this.journalRoleDao.getUsersByJournal(journal.getId(), role);
	}
	
	@Override
	public int numUsersByJournal(Journal journal, String role) {
		return this.journalRoleDao.numUsersByJournal(journal.getId(), role);
	}
	
	@Override
	public List<Journal> getJournalsByUserFromMyActivity(SystemUser user, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder){
		return this.journalDao.findJournalsByUserFromMyActivity(user, dRequest, iTotalDisplayRecordsPlaceHolder);
	}
	
	@Override
	public boolean isMemberOfNonEnglishJournal(SystemUser user) {
		boolean isMemberOfNonEnglishJournal = false;
		Set<Journal> journals = this.getJournalsByUser(user, SystemConstants.roleMember);
		for (Journal journal : journals) {
			if (journal.getLanguageCode().equals(SystemConstants.koreanLanguageCode)) {
				isMemberOfNonEnglishJournal = true;
				break;
			}
		}
		return isMemberOfNonEnglishJournal;		
	}

	@Override
	public Journal getBeingCreated(int creatorId) {
		return journalDao.findBeingCreated(creatorId);
	}

	@Override
	public List<String> getAllStatus(Journal journal) {
		List<String> allStatus = new ArrayList<String>();
		if(journal.getType().equals(SystemConstants.journalTypeA)) {
			allStatus.add(SystemConstants.statusB);
			allStatus.add(SystemConstants.statusI);
			allStatus.add(SystemConstants.statusO);
			allStatus.add(SystemConstants.statusR);
			allStatus.add(SystemConstants.statusE);
			allStatus.add(SystemConstants.statusD);
			allStatus.add(SystemConstants.statusV);
			allStatus.add(SystemConstants.statusA);
			allStatus.add(SystemConstants.statusM);
			allStatus.add(SystemConstants.statusG);
			allStatus.add(SystemConstants.statusP);
			allStatus.add(SystemConstants.statusJ);
			allStatus.add(SystemConstants.statusW);
		} else if(journal.getType().equals(SystemConstants.journalTypeB)) {
			allStatus.add(SystemConstants.statusB);
			allStatus.add(SystemConstants.statusI);
			allStatus.add(SystemConstants.statusO);
			allStatus.add(SystemConstants.statusR);
			allStatus.add(SystemConstants.statusE);
			allStatus.add(SystemConstants.statusA);
			allStatus.add(SystemConstants.statusM);
			allStatus.add(SystemConstants.statusG);
			allStatus.add(SystemConstants.statusP);
			allStatus.add(SystemConstants.statusJ);
			allStatus.add(SystemConstants.statusW);
		} else if(journal.getType().equals(SystemConstants.journalTypeC)) {
			allStatus.add(SystemConstants.statusB);
			allStatus.add(SystemConstants.statusI);
			allStatus.add(SystemConstants.statusR);
			allStatus.add(SystemConstants.statusE);
			allStatus.add(SystemConstants.statusD);
			allStatus.add(SystemConstants.statusV);
			allStatus.add(SystemConstants.statusA);
			allStatus.add(SystemConstants.statusM);
			allStatus.add(SystemConstants.statusG);
			allStatus.add(SystemConstants.statusP);
			allStatus.add(SystemConstants.statusJ);
			allStatus.add(SystemConstants.statusW);
		} else if(journal.getType().equals(SystemConstants.journalTypeD)) {
			allStatus.add(SystemConstants.statusB);
			allStatus.add(SystemConstants.statusI);
			allStatus.add(SystemConstants.statusR);
			allStatus.add(SystemConstants.statusE);
			allStatus.add(SystemConstants.statusA);
			allStatus.add(SystemConstants.statusM);
			allStatus.add(SystemConstants.statusG);
			allStatus.add(SystemConstants.statusP);
			allStatus.add(SystemConstants.statusJ);
			allStatus.add(SystemConstants.statusW);
		}
		
		return allStatus;
	}
}