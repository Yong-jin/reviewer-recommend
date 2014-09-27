package link.thinkonweb.dao.journal;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TimeZone;

import javax.sql.DataSource;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class JournalDaoImpl extends NamedParameterJdbcDaoSupport implements JournalDao {
	@Inject
	private UserDao userDao;
	
	@Inject
	private JournalRowMapper journalRowMapper;
	
	@Inject
	private JournalUserContactRowMapper journalUserContactRowMapper;

	@Inject
	private SystemUtil systemUtil;

	@Inject
	private DataSource dataSource;

	@Override
	public int create(Journal journal) {
		String sql = "INSERT INTO JOURNALS (TITLE, SHORT_TITLE, HOMEPAGE, CREATOR_ID, JOURNAL_NAME_ID, ORGANIZATION, LANGUAGE_CODE, PUBLISHER_COUNTRY_CODE, REGISTERED_DATE, REGISTERED_TIME, COVER_IMAGE_FILENAME, ENABLED, PAID) " +
					 "VALUES (:title, :shortTitle, :homepage, :creatorID, :journalnameID, :organization, :languageCode, :publisherCountryCode, :registeredDate, :registeredTime, :coverImageFilename, :enabled, :paid)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		String title = null;
		String shortTitle = null;
		String homepage = null;
		String journalNameId = null;
		String organization = null;
		String languageCode = null;
		String publisherCountryCode = null;
		String coverImageFilename = null;
		
		if(journal.getTitle() != null)
			title = journal.getTitle().trim();
		if(journal.getShortTitle() != null)
			shortTitle = journal.getShortTitle().trim();
		if(journal.getHomepage() != null)
			homepage = journal.getHomepage().trim();
		if(journal.getJournalNameId() != null)
			journalNameId = journal.getJournalNameId().trim();
		if(journal.getOrganization() != null)
			organization = journal.getOrganization().trim();
		if(journal.getLanguageCode() != null)
			languageCode = journal.getLanguageCode().trim();
		if(journal.getCountryCode() != null)
			publisherCountryCode =journal.getCountryCode().trim();
		if(journal.getCoverImageFilename() != null)
			coverImageFilename = journal.getCoverImageFilename().trim();
		
		argMap.put("title", title);
		argMap.put("shortTitle", shortTitle);
		argMap.put("homepage", homepage);
		argMap.put("creatorID", journal.getCreator().getId());
		argMap.put("journalnameID", journalNameId);		
		argMap.put("organization", organization);
		argMap.put("languageCode", languageCode);
		argMap.put("publisherCountryCode", publisherCountryCode);
		argMap.put("registeredDate", journal.getRegisteredDate());
		argMap.put("registeredTime", journal.getRegisteredTime());
		argMap.put("coverImageFilename", coverImageFilename);
		argMap.put("enabled", journal.isEnabled());		
		argMap.put("paid", journal.isPaid());
		
		return this.getNamedParameterJdbcTemplate().update(sql, argMap);
	}

	@Override
	public void update(Journal journal) {
		String sql = "UPDATE JOURNALS SET JOURNAL_NAME_ID=?, TITLE=?, SHORT_TITLE=?, HOMEPAGE=?, CREATOR_ID=?, ORGANIZATION=?, LANGUAGE_CODE=?, PUBLISHER_COUNTRY_CODE=?, COVER_IMAGE_FILENAME=?, TYPE=?, ABOUT=?, ISSN=?, ENABLED=?, PAID = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {journal.getJournalNameId(),
														 journal.getTitle(), 
														 journal.getShortTitle(), 
														 journal.getHomepage(),
														 journal.getCreator().getId(), 
														 journal.getOrganization(), 
														 journal.getLanguageCode(),
														 journal.getCountryCode(),
														 journal.getCoverImageFilename(),
														 journal.getType(),
														 journal.getAbout(),
														 journal.getIssn(),
														 journal.isEnabled(),
														 journal.isPaid(),
														 journal.getId()});
	}

	@Override
	public void delete(Journal journal) {
		String sql = "DELETE FROM JOURNALS WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {journal.getId()});
	}

	@Override
	public List<Journal> findAll() {
		String sql = "SELECT * FROM JOURNALS WHERE ENABLED = 1 ORDER BY JOURNAL_NAME_ID ASC";
		List<Journal> journals = this.getJdbcTemplate().query(sql, journalRowMapper);
		return journals;
	}

	@Override
	public Journal findById(int id) {
		String sql = "SELECT * FROM JOURNALS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, journalRowMapper);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}	
	@Override
	public Journal findBeingCreated(int creatorId) {
		String sql = "SELECT * FROM JOURNALS WHERE CREATOR_ID = ? AND ENABLED = 0";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {creatorId}, journalRowMapper);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}
	@Override
	public List<Journal> findByTitle(String title) {
		String sql = "SELECT * FROM JOURNALS WHERE TITLE LIKE ? COLLATE UTF8_GENERAL_CI ORDER BY TITLE ASC";
		title = "%" + title.trim() + "%";
		List<Journal> journals = this.getJdbcTemplate().query(sql, new Object[] {title}, journalRowMapper);	
		return journals;
	}

	@Override
	public List<Journal> findByShortTitle(String shortTitle) {
		String sql = "SELECT * FROM JOURNALS WHERE SHORT_TITLE = ? COLLATE UTF8_GENERAL_CI ORDER BY SHORT_TITLE ASC";
		shortTitle = "%" + shortTitle.trim() + "%";
		List<Journal> journals = this.getJdbcTemplate().query(sql, new Object[] {shortTitle}, journalRowMapper);
		return journals;
	}

	@Override
	public List<Journal> findByCreator(SystemUser creator) {
		String sql = "SELECT * FROM JOURNALS WHERE CREATOR_ID = ? ORDER BY JOURNAL_NAME_ID ASC";
		List<Journal> journals = this.getJdbcTemplate().query(sql, new Object[] {creator.getId()}, journalRowMapper);
		return journals;
	}
	
	@Override
	public Journal findByJournalNameID(String jnid) {
		String sql = "SELECT * FROM JOURNALS WHERE JOURNAL_NAME_ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {jnid}, journalRowMapper);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Journal> findByCustomJournalUserContactSql(String sql) {
		return this.getJdbcTemplate().query(sql, journalUserContactRowMapper);
	}
	
	@Override	
	public List<Journal> findByCustomJournalSql(String sql) {
		return this.getJdbcTemplate().query(sql, journalRowMapper);
	}

	@Override
	public int getNumOfRecordsByCustomSql(String sql) {
		return this.getJdbcTemplate().queryForObject(sql, Integer.class);
	}
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public List<Journal> findBySuperManagerJournalList(
			DataTableClientRequest dRequest,
			int[] iTotalDisplayRecordsPlaceHolder, Locale locale) {
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
	    searchSqlSB.append("SELECT J.*, U.*, C.* FROM JOURNALS J JOIN USERS U ON U.ID = J.CREATOR_ID JOIN CONTACTS C ON U.ID = C.USER_ID");
	    
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
	    
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(this.getNumOfRecordsByCustomSql(searchSql));
	  
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
	    
	    
		return this.findByCustomJournalUserContactSql(searchSql);
	}
	
	@Override
	
	public List<Journal> findJournalsByUserFromMyActivity(SystemUser user, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder) {
		StringBuffer searchSqlSB = new StringBuffer();
	    searchSqlSB.append("SELECT COUNT(J.ID) FROM JOURNALS J JOIN JOURNAL_MEMBERS JM ON J.ID = JM.JOURNAL_ID WHERE JM.USER_ID = " + user.getId());
        
	    String sGlobalTerm = dRequest.getsSearchGlobal();
	    
	    if (!(sGlobalTerm == null ||sGlobalTerm.equals(""))) {
		    searchSqlSB.append(" AND (J.TITLE LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR J.ORGANIZATION like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR J.TITLE like '%").append(sGlobalTerm);
		    
		    if (SystemConstants.englishLanguageName.contains(sGlobalTerm)) {
		    	searchSqlSB.append("%' OR J.LANGUAGE_CODE = '" + SystemConstants.englishLanguageCode + "') ");
		    } else if (SystemConstants.koreanLanguageName.contains(sGlobalTerm)) {
		    	searchSqlSB.append("%' OR J.LANGUAGE_CODE = '" + SystemConstants.koreanLanguageCode + "') ");
		    } else {
		    	searchSqlSB.append("%') ");
		    }
        }
	    
	    String searchSql = searchSqlSB.toString();
	        
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(this.getNumOfRecordsByCustomSql(searchSql));
	  
	    searchSqlSB.replace(7, 18, "J.*");
        searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        
        searchSql = searchSqlSB.toString();
	    
		return this.findByCustomJournalSql(searchSql);
	}

	@Override
	public void updateRegisteredDate(Journal journal) {
		String sql = "UPDATE JOURNALS SET REGISTERED_DATE = UTC_DATE(), REGISTERED_TIME= UTC_TIME() WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] { journal.getId()});	
	}
}