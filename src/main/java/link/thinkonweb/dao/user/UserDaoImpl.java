package link.thinkonweb.dao.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TimeZone;

import javax.sql.DataSource;

import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.util.DataTableClientRequest;
import link.thinkonweb.util.SystemUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class UserDaoImpl extends NamedParameterJdbcDaoSupport implements UserDao {
	@Autowired
	private UserRowMapper userRowMapper;
	
	@Autowired
	private UserContactRowMapper userContactRowMapper;
	
	@Autowired
	private ContactService contactService;
	
	@Autowired
	private DataSource dataSource;

	@Autowired
	private SystemUtil systemUtil;
			
	@Override
	public int create(final SystemUser user) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
        this.getJdbcTemplate().update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(
                        	"INSERT INTO USERS (USERNAME, PASSWORD, SIGNUP_DATE, SIGNUP_TIME, ENABLED) VALUES (?, ?, ?, ?, ?)",
                        	new String[] { "ID" });
                ps.setString(1, user.getUsername().trim());
                ps.setString(2, user.getPassword().trim());
                ps.setDate(3, user.getSignupDate());
                ps.setTime(4, user.getSignupTime());
                ps.setBoolean(5, user.isEnabled());
                return ps;
            }
        }, keyHolder);
        return keyHolder.getKey().intValue();
	}
	
	@Override
	public void changeEnabled(boolean isEnabled, int userId) {
		String sql = "UPDATE USERS SET ENABLED=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {isEnabled, userId});	
	}
	
	@Override
	public void changeUsername(String newUsername, int userId) {
		String sql = "UPDATE USERS SET USERNAME=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {newUsername, userId});	
	}
	
	@Override
	public void changePassword(String newPassword, int userId) {
		String sql = "UPDATE USERS SET PASSWORD=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {newPassword, userId});	
	}

	@Override
	public void delete(SystemUser user) {
		contactService.delete(user.getContact());
		
		String sql = "DELETE FROM USERS WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {user.getId()});
	}

	@Override
	public SystemUser findById(int id) {
		String sql = "SELECT * FROM USERS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, userRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public SystemUser findByUsername(String username) throws EmptyResultDataAccessException {
		String sql = "SELECT * FROM USERS WHERE USERNAME = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {username}, userRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<SystemUser> findByUsernameLike(String filterString) {
		String sql = "SELECT * FROM USERS WHERE USERNAME LIKE ?";
		filterString = "%" + filterString.trim() + "%";
		return this.getJdbcTemplate().query(sql, new Object[] {filterString}, userRowMapper);
	}
	
	@Override
	public List<SystemUser> findAll() {
		String sql = "SELECT * FROM USERS";
		return this.getJdbcTemplate().query(sql, userRowMapper);
	}

	@Override
	public List<SystemUser> findUsersByParams(List<String> emailList, List<String> emailPreventList, Map<String, String> contactAcceptParams, Map<String, String> contactPreventParams) {
		
		String sql = "SELECT * FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID";
		
		StringBuffer buf = new StringBuffer();
		int index = 0;
		int i;
		int totalLength = 0;
		if(emailList != null)
			totalLength += emailList.size();
		if(emailPreventList != null)
			totalLength += emailPreventList.size();
		if(contactAcceptParams != null)
			totalLength += contactAcceptParams.size();
		if(contactPreventParams != null)
			totalLength += contactPreventParams.size();
		
		if(totalLength > 0) {
			buf.append(" WHERE ");

			if(emailPreventList != null) {
				buf.append("(");
				i=0;
				for(String email: emailPreventList) {
					buf.append("U.USERNAME != '");
					buf.append(email);
					buf.append("'");
					i++;
					index++;
					if(i != emailPreventList.size())
						buf.append(" AND ");
				}
				buf.append(")");
				if(index != totalLength)
					buf.append(" AND ");
			}
			if(emailList != null) {
				buf.append("(");
				i = 0;
				for(String email: emailList) {
					buf.append("U.USERNAME LIKE '%");
					buf.append(email);
					buf.append("%'");
					i++;
					index++;
					if(i != emailList.size())
						buf.append(" OR ");
				}
				if(contactAcceptParams == null) {
					buf.append(")");
					if(index != totalLength)
						buf.append(" AND ");
				}
			}
			if(contactAcceptParams != null) {
				if(emailList == null)
					buf.append("(");
				else
					buf.append(" OR ");
				i = 0;
				for(String key: contactAcceptParams.keySet()) {
					buf.append("C.");
					buf.append(key);
					buf.append(" LIKE '%");
					buf.append(contactAcceptParams.get(key));
					buf.append("%'");
					i++;
					index++;
					if(i!= contactAcceptParams.size())
						buf.append(" OR ");
				}
				buf.append(")");
				if(index != totalLength)
					buf.append(" AND ");
			}
			if(contactPreventParams != null) {
				buf.append("(");
				i = 0;
				for(String key: contactPreventParams.keySet()) {
					buf.append("C.");
					buf.append(key);
					buf.append(" != '");
					buf.append(contactPreventParams.get(key));
					buf.append("'");
					i++;
					index++;
					if(i != contactPreventParams.size())
						buf.append(" AND ");
				}
				buf.append(")");
				if(index != totalLength)
					buf.append(" AND ");
			}
			sql  = sql + buf.toString() + " AND USER_ID > 2";
		}
		

		return this.getJdbcTemplate().query(sql, userContactRowMapper);

	}
	
	public List<SystemUser> findUsers(int userId, int journalId, String role) {
		if(role == null) {
			if(userId == 0 && journalId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID";
				try {
					return this.getJdbcTemplate().query(sql, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE A.JOURNAL_ID = ? ";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {journalId}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(journalId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE U.ID = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			} else {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE U.ID = ? AND A.JOURNAL_ID = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			}
		} else {
			if(userId == 0 && journalId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE A.ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {role}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE A.JOURNAL_ID = ? AND A.ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {journalId, role}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(journalId == 0) {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE U.ID = ? AND A.ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, role}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			} else {
				String sql = "SELECT * FROM USERS U JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE U.ID = ? AND A.JOURNAL_ID = ? AND A.ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, role}, userRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			}
			
		}
	}
	
	@Override
	public List<SystemUser> findEditorCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, List<String> preventEmailList) {
		String baseSqlWithoutMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID LEFT JOIN JOURNAL_MEMBERS JM ON U.ID = JM.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND (JM.JOURNAL_ID = " + journalId + ") IS NULL ";
		String baseSqlWithMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND A.ROLE = 'ROLE_MEMBER' AND U.ENABLED = 1 AND A.JOURNAL_ID = " + journalId + " "; 
		StringBuffer searchSqlSB = new StringBuffer();
		List<String> individualSearchList = new ArrayList<String>();
		
	    if (!dRequest.getsSearch()[6].equals("")) {		//select2
	    	if (dRequest.getsSearch()[6].equals("true")) {
	    		searchSqlSB.append(baseSqlWithMember);
	    	} else {
	    		searchSqlSB.append(baseSqlWithoutMember);
	    	}
	    } else
	    	searchSqlSB.append(baseSqlWithMember);
	    
	    if (!dRequest.getsSearch()[0].equals("")) {
	    	individualSearchList.add(" U.USERNAME like '%" + dRequest.getsSearch()[0] + "%'");	    
	    }
		if (!dRequest.getsSearch()[1].equals("")) {
			StringBuffer sb = new StringBuffer();
	    	StringTokenizer st = new StringTokenizer(dRequest.getsSearch()[1]);
	    	String nameKeyword = null;
	    	sb.append(" (");
	    	while (st.hasMoreElements()) {
	    		nameKeyword = (String)st.nextElement();
	    		sb.append("C.FIRST_NAME like '%" + nameKeyword + "%' OR C.LAST_NAME like '%" + nameKeyword + "%' OR C.LOCAL_FULL_NAME like '%" + nameKeyword + "%' OR ");
			}
	    	sb = sb.delete(sb.length()-4, sb.length());
	    	sb.append(")");
	    	individualSearchList.add(sb.toString());
	    }
	    if (!dRequest.getsSearch()[2].equals("")) {
	    	individualSearchList.add(" (C.INSTITUTION like '%" + dRequest.getsSearch()[2] + "%' OR C.LOCAL_INSTITUTION like '%" + dRequest.getsSearch()[2] + "%')");
	    }
	    if (!dRequest.getsSearch()[4].equals("")) {
	    	individualSearchList.add(" C.COUNTRY_CODE ='" + dRequest.getsSearch()[4] + "'");	//select2
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
	    
        if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
        	if(individualSearchList.size() != 0){
 			    searchSqlSB.append(" AND").append(individualSearchSB.toString());
	        }
        } else {
		    searchSqlSB.append(" AND (U.USERNAME LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_FULL_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_INSTITUTION like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.INSTITUTION like '%").append(sGlobalTerm).append("%')");
		    
		    if(individualSearchList.size() != 0){
			    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
	        }
        }
        int index = 0;
        if(preventEmailList != null && preventEmailList.size() > 0) {
        	searchSqlSB.append(" AND ");
        
	        for(String s: preventEmailList) {
	        	searchSqlSB.append(" U.USERNAME != '");
	        	searchSqlSB.append(s);
	        	searchSqlSB.append("'");
	        	index ++;
	        	if(index != preventEmailList.size())
	        		searchSqlSB.append(" AND ");
	        }
        }
        String searchSql = searchSqlSB.toString();
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(getNumOfRecordsByCustomSql(searchSql));
	    searchSqlSB.replace(7, 18, "U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
        
        String[] sortableCoName = null;
	    if (locale.getCountry().equals("KR")) {
	    	sortableCoName = new String[]{null, "U.USERNAME", "C.LOCAL_FULL_NAME", "C.LOCAL_INSTITUTION", "C.COUNTRY_CODE"};
		} else {
			sortableCoName = new String[]{null, "U.USERNAME", "C.FIRST_NAME", "C.INSTITUTION", "C.COUNTRY_CODE"};
		}
        
        if (dRequest.getiSortingCols() != 0) {
        	searchSqlSB.append(" ORDER BY ");
        	int i;
	        for (i=0; i < dRequest.getiSortingCols()-1 ; i++) {
	        	searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        }
	        searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]);
        }
        if(dRequest.getiDisplayLength() != -1)
        	searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        
        searchSql = searchSqlSB.toString();
	    
	    return findByCustomSql(searchSql);
	}
	
	@Override
	public List<SystemUser> findReviewerCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, int member, int manuscriptId, List<String> preventEmailList) {
		String baseSqlWithBoardMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID JOIN JOURNAL_BOARD_MEMBERS JM ON U.ID = JM.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND JM.JOURNAL_ID = " + journalId;
		String baseSqlWithMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID JOIN JOURNAL_MEMBERS JM ON U.ID = JM.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND JM.JOURNAL_ID = " + journalId;
		String baseSqlWithoutMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID LEFT JOIN JOURNAL_MEMBERS JM ON U.ID = JM.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND (JM.JOURNAL_ID = " + journalId + ") IS NULL";
		String baseSqlWithRp = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID LEFT JOIN MANUSCRIPTS_REVIEW_PREFERENCES RP ON U.ID = RP.USER_ID WHERE RP.MANUSCRIPT_ID = " + manuscriptId + " AND RP.USER_ID != 0 AND (U.ID != 1 AND U.ID != 2)";
		
		StringBuffer searchSqlSB = new StringBuffer();
		if(member == 1)
			searchSqlSB.append(baseSqlWithBoardMember);
		else if (member == 2)
	    	searchSqlSB.append(baseSqlWithMember);
	    else if(member == 3)
	    	searchSqlSB.append(baseSqlWithoutMember);
	    else if(member == 4)
	    	searchSqlSB.append(baseSqlWithRp);
	    
        String sGlobalTerm = dRequest.getsSearchGlobal();
	    
        if (sGlobalTerm != null  && !sGlobalTerm.equals("")) {
		    searchSqlSB.append(" AND (U.USERNAME LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_FULL_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_INSTITUTION like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.INSTITUTION like '%").append(sGlobalTerm).append("%')");
        }
        
        int index = 0;
        if(preventEmailList != null && preventEmailList.size() > 0) {
        	searchSqlSB.append(" AND ");
	        
	        for(String s: preventEmailList) {
	        	searchSqlSB.append(" U.USERNAME != '");
	        	searchSqlSB.append(s);
	        	searchSqlSB.append("'");
	        	index ++;
	        	if(index != preventEmailList.size())
	        		searchSqlSB.append(" AND ");
	        }
        }
        
        String searchSql = searchSqlSB.toString();
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(getNumOfRecordsByCustomSql(searchSql));
	    searchSqlSB.replace(7, 18, "U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
        String[] sortableCoName = null;
	    if (locale.getCountry().equals("KR"))
	    	sortableCoName = new String[]{null, "U.USERNAME", "C.LOCAL_FULL_NAME", "C.LOCAL_INSTITUTION", null, null, null};
		else
			sortableCoName = new String[]{null, "U.USERNAME", "C.FIRST_NAME", "C.INSTITUTION", null, null, null};
        
        if (dRequest.getiSortingCols() != 0) {
        	searchSqlSB.append(" ORDER BY ");
        	int i;
	        for (i=0; i < dRequest.getiSortingCols()-1 ; i++) {
	        	searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        }
	        searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]);
        }
        if(dRequest.getiDisplayLength() != -1)
        	searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        
        searchSql = searchSqlSB.toString();
	    
	    return findByCustomSql(searchSql);
	}
	
	@Override
	public List<SystemUser> findManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId) {
		String baseSqlWithMember = "SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID JOIN AUTHORITIES A ON U.ID = A.USER_ID WHERE (U.ID != 1 AND U.ID != 2) AND A.ROLE = 'ROLE_MEMBER' AND U.ENABLED = 1 AND A.JOURNAL_ID = " + journalId + " "; 
		StringBuffer searchSqlSB = new StringBuffer();
		List<String> individualSearchList = new ArrayList<String>();
		searchSqlSB.append(baseSqlWithMember);

		for(int i=0; i<dRequest.getiColumns(); i++) {
			if(!dRequest.getsSearch()[i].equals(""))
				System.out.println("i : " + i + ", " + dRequest.getsSearch()[i]);
		}
	    if (!dRequest.getsSearch()[0].equals("")) {
	    	individualSearchList.add(" U.USERNAME like '%" + dRequest.getsSearch()[0] + "%'");	    
	    }
		if (!dRequest.getsSearch()[1].equals("")) {
			StringBuffer sb = new StringBuffer();
	    	StringTokenizer st = new StringTokenizer(dRequest.getsSearch()[1]);
	    	String nameKeyword = null;
	    	sb.append(" (");
	    	while (st.hasMoreElements()) {
	    		nameKeyword = (String)st.nextElement();
	    		sb.append("C.FIRST_NAME like '%" + nameKeyword + "%' OR C.LAST_NAME like '%" + nameKeyword + "%' OR C.LOCAL_FULL_NAME like '%" + nameKeyword + "%' OR ");
			}
	    	sb = sb.delete(sb.length()-4, sb.length());
	    	sb.append(")");
	    	individualSearchList.add(sb.toString());
	    }
	    if (!dRequest.getsSearch()[2].equals("")) {
	    	individualSearchList.add(" (C.INSTITUTION like '%" + dRequest.getsSearch()[2] + "%' OR C.LOCAL_INSTITUTION like '%" + dRequest.getsSearch()[2] + "%')");
	    }
	    if (!dRequest.getsSearch()[3].equals("")) {
	    	individualSearchList.add(" (C.DEPARTMENT like '%" + dRequest.getsSearch()[3] + "%' OR C.LOCAL_DEPARTMENT like '%" + dRequest.getsSearch()[3] + "%')");
	    }
	    if (!dRequest.getsSearch()[5].equals("")) {
	    	individualSearchList.add(" C.COUNTRY_CODE ='" + dRequest.getsSearch()[5] + "'");	//select2
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
	    
        if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
        	if(individualSearchList.size() != 0){
 			    searchSqlSB.append(" AND").append(individualSearchSB.toString());
	        }
        } else {
		    searchSqlSB.append(" AND (U.USERNAME LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_FULL_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_INSTITUTION like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_DEPARTMENT like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.DEPARTMENT like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.INSTITUTION like '%").append(sGlobalTerm).append("%')");
		    
		    if(individualSearchList.size() != 0){
			    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
	        }
        }

        String searchSql = searchSqlSB.toString();
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(getNumOfRecordsByCustomSql(searchSql));
	    searchSqlSB.replace(7, 18, "U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
        
        String[] sortableCoName = new String[]{null, "U.USERNAME", "C.LOCAL_FULL_NAME", "C.LOCAL_INSTITUTION", "C.LOCAL_DEPARTMENT", "C.COUNTRY_CODE"};
        
        if (dRequest.getiSortingCols() != 0) {
        	searchSqlSB.append(" ORDER BY ");
        	int i;
	        for (i=0; i < dRequest.getiSortingCols()-1 ; i++) {
	        	searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        	if(i == 2) {
	        		searchSqlSB.append("C.FIRST_NAME").append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        		searchSqlSB.append("C.LAST_NAME").append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        	} else if(i == 3)
	        		searchSqlSB.append("C.INSTITUTION").append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        	else if(i == 4)
	        		searchSqlSB.append("C.DEPARTMENT").append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        }
	        searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]);
        }
        if(dRequest.getiDisplayLength() != -1)
        	searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        
        searchSql = searchSqlSB.toString();
	    
	    return findByCustomSql(searchSql);
	}
	
	@Override
	
	public List<SystemUser> findSuperManagerRoleList(int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder) {
		List<String> individualSearchList = new ArrayList<String>();
	    if (!dRequest.getsSearch()[0].equals("")) {
	    	individualSearchList.add(" U.USERNAME like '%" + dRequest.getsSearch()[0] + "%'");	    
	    }
	    if (!dRequest.getsSearch()[1].equals("")) {
	    	individualSearchList.add(" C.FIRST_NAME like '%" + dRequest.getsSearch()[1] + "%'");
	    }
	    if (!dRequest.getsSearch()[2].equals("")) {
	    	individualSearchList.add(" C.LAST_NAME like '%" + dRequest.getsSearch()[2] + "%'");
	    }
	    if (!(dRequest.getsSearch()[3].equals("") || dRequest.getsSearch()[3].equals("Any"))) {
	    	if (dRequest.getsSearch()[3].equals("Enabled")) {
	    		individualSearchList.add(" U.ENABLED = 1 ");
	    	} else {
	    		individualSearchList.add(" U.ENABLED = 0 ");
	    	}
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
	    searchSqlSB.append("SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID");
	    
	    if (dRequest.getRequest().getParameter("jnid").equals("any")) {
	    	if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
	        	if(individualSearchList.size() != 0) {
	 			    searchSqlSB.append(" WHERE " + individualSearchSB.toString());
	        	}
	        } else {
			    searchSqlSB.append(" WHERE (U.USERNAME LIKE '%").append(sGlobalTerm);
			    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
			    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm).append("%')");
			    
			    if(individualSearchList.size() != 0){
				    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
		        }
	        }
	    } else {
	    	searchSqlSB.append(", AUTHORITIES A WHERE A.USER_ID = U.ID AND A.ROLE = 'ROLE_MEMBER' AND A.JOURNAL_ID = '" + journalId + "' ");
	    	if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
	        	if(individualSearchList.size() != 0) {
	 			    searchSqlSB.append("AND " + individualSearchSB.toString());
	        	}
	        } else {
			    searchSqlSB.append("AND (U.USERNAME LIKE '%").append(sGlobalTerm);
			    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
			    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm).append("%')");
			    
			    if(individualSearchList.size() != 0){
				    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
		        }
	        }
	    }
        
        String searchSql = searchSqlSB.toString();
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(this.getNumOfRecordsByCustomSql(searchSql));
	    
	    //
	    
	    searchSqlSB.replace(7, 18, "U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
        String[] sortableCoName = {null, "U.USERNAME", "C.FIRST_NAME", "C.LAST_NAME", "U.ENABLED", "A.ROLE", "A.ROLE", "A.ROLE", "A.ROLE", "A.ROLE", "A.ROLE", "A.ROLE", "A.ROLE"};
        
        if (dRequest.getiSortingCols() != 0 && dRequest.getiSortCol()[0] <= 4) {
        	searchSqlSB.append(" ORDER BY ");
        	int i = 0;
	        for (; i < dRequest.getiSortingCols()-1 ; i++) {
	        	searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]).append(" ").append(dRequest.getsSortDir()[i]).append(", ");
	        }
	        searchSqlSB.append(sortableCoName[dRequest.getiSortCol()[i]]);
	        if(dRequest.getiDisplayLength() != -1) 
	        	searchSqlSB.append(" ").append(dRequest.getsSortDir()[i]).append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());
        } else {
        	if(dRequest.getiDisplayLength() != -1) 
        		searchSqlSB.append(" LIMIT ").append(dRequest.getiDisplayStart()).append(", ").append(dRequest.getiDisplayLength());	
        }
        
        searchSql = searchSqlSB.toString();
        //
	    return this.findByCustomSql(searchSql);
	}
	
	@Override
	
	public List<SystemUser> findSuperManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder) {
		List<String> individualSearchList = new ArrayList<String>();
	    if (!dRequest.getsSearch()[0].equals("")) {
	    	individualSearchList.add(" U.USERNAME like '%" + dRequest.getsSearch()[0] + "%'");	    
	    }
	    if (!dRequest.getsSearch()[1].equals("")) {
	    	individualSearchList.add(" C.FIRST_NAME like '%" + dRequest.getsSearch()[1] + "%'");
	    }
	    if (!dRequest.getsSearch()[2].equals("")) {
	    	individualSearchList.add(" C.LAST_NAME like '%" + dRequest.getsSearch()[2] + "%'");
	    }
	    if (!dRequest.getsSearch()[3].equals("")) {
	    	individualSearchList.add(" C.INSTITUTION like '%" + dRequest.getsSearch()[3] + "%'");
	    }
	    if (!dRequest.getsSearch()[5].equals("")) {
	    	individualSearchList.add(" C.COUNTRY_CODE ='" + dRequest.getsSearch()[5] + "'");
	    }
	    if (!(dRequest.getsSearch()[6].equals("") || dRequest.getsSearch()[6].equals("Any"))) {
	    	individualSearchList.add(" C.DEGREE ='" + dRequest.getsSearch()[6] + "'");
	    }
	    if (!(dRequest.getsSearch()[9].equals("") || dRequest.getsSearch()[9].equals("Any"))) {
	    	if (dRequest.getsSearch()[9].equals("Enabled")) {
	    		individualSearchList.add(" U.ENABLED = 1 ");
	    	} else {
	    		individualSearchList.add(" U.ENABLED = 0 ");
	    	}
	    }
	    
	    String fromUTCDate = null;
	    String toUTCDate = null;
	    StringTokenizer st = null;
	    Calendar cal = null;
		
		if (!dRequest.getsSearch()[7].equals("")) {
	    	String fromDateString = dRequest.getsSearch()[7];
	    	st = new StringTokenizer(fromDateString, "-");
	    	
	    	cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			cal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1, Integer.parseInt(st.nextToken())-1);
			fromUTCDate = systemUtil.getUTCDateFromClintLocalDateAsString(dRequest.getRequest(), cal);
			individualSearchList.add(" U.SIGNUP_DATE >= STR_TO_DATE('" + fromUTCDate + "', '%Y-%m-%d')");
	    }
		
		if (!dRequest.getsSearch()[8].equals("")) {
	    	String fromDateString = dRequest.getsSearch()[8];
	    	st = new StringTokenizer(fromDateString, "-");
	    	
	    	cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			cal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1, Integer.parseInt(st.nextToken()));
			toUTCDate = systemUtil.getUTCDateFromClintLocalDateAsString(dRequest.getRequest(), cal);
			individualSearchList.add(" U.SIGNUP_DATE <= STR_TO_DATE('" + toUTCDate + "', '%Y-%m-%d')");
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
	    searchSqlSB.append("SELECT COUNT(U.ID) FROM USERS U JOIN CONTACTS C ON U.ID = C.USER_ID");
	    
        if (sGlobalTerm == null ||sGlobalTerm.equals("")) {
        	if(individualSearchList.size() != 0){
 			    searchSqlSB.append(" WHERE").append(individualSearchSB.toString());
	        }
        } else {
		    searchSqlSB.append(" WHERE (U.USERNAME LIKE '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_FULL_NAME like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.LOCAL_INSTITUTION like '%").append(sGlobalTerm);
		    searchSqlSB.append("%' OR C.INSTITUTION like '%").append(sGlobalTerm).append("%')");
		    
		    if(individualSearchList.size() != 0){
			    searchSqlSB.append(" AND ").append(individualSearchSB.toString());
	        }
        }
        
        String searchSql = searchSqlSB.toString();
	    
	    iTotalDisplayRecordsPlaceHolder[0] = Integer.valueOf(this.getNumOfRecordsByCustomSql(searchSql));
	  
	    searchSqlSB.replace(7, 18, "U.*, C.*");
	    searchSql = searchSqlSB.toString();
	    
        String[] sortableCoName = {"U.USERNAME", "C.FIRST_NAME", "C.LAST_NAME", "C.INSTITUTION", "C.COUNTRY_CODE", "C.DEGREE", null, "U.SIGNUP_DATE", "U.SIGNUP_TIME", "U.ENABLED"};
        
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
		return this.findByCustomSql(searchSql);
	}
	
	@Override
	public List<SystemUser> findByCustomSql(String sql) {
		try {
			return this.getJdbcTemplate().query(sql, userContactRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public int getNumOfRecordsByCustomSql(String sql) {
		return this.getJdbcTemplate().queryForObject(sql, Integer.class);
	}
	
	@Override
	public void update(SystemUser user) {
		String sql = "UPDATE USERS SET PASSWORD=?, SIGNUP_DATE=?, SIGNUP_TIME=?, USERNAME=?, ENABLED=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {user.getPassword(), user.getSignupDate(), user.getSignupTime(), user.getUsername(), user.isEnabled(), user.getId()});
	}
}