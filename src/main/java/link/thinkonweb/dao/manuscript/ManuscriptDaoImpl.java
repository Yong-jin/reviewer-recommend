package link.thinkonweb.dao.manuscript;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.util.DataTableClientRequest;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class ManuscriptDaoImpl extends NamedParameterJdbcDaoSupport implements ManuscriptDao {
	@Inject
	private ManuscriptRowMapper manuscriptRowMapper;

	@Inject
	private ManuscriptStatisticsRowMapper manuscriptStatisticsRowMapper;

	@Override
	public int insert(Manuscript manuscript) {
		String sql = "INSERT INTO MANUSCRIPTS (JOURNAL_ID, STATUS,AE_USER_ID, GE_USER_ID, REVISION_COUNT,"
				+ "COVERLETTER,SUBMIT_ID,USER_ID,DIVISION_ID,SPECIAL_ISSUE_ID,SUBMIT_STEP,TITLE,RUNNINGHEAD,PAPER_ABSTRACT,CHIEF_USER_ID,MANAGER_USER_ID,"
				+ "INVITE, CONFIRM3, CONFIRM4, CONFIRM1, CONFIRM2, CONFIRM5, EDITOR_STATUS, CAMERA_READY_REVISION, GALLERY_PROOF_REVISION, CAMERA_READY_CONFIRM, GALLERY_PROOF_CONFIRM,"
				+ "TYPE_ID, TRACK_ID, AE_ASSIGN_DATE, AE_ASSIGN_TIME, REVISION_DUE_DATE, REVISION_DUE_TIME, CAMERA_DUE_DATE, CAMERA_DUE_TIME, DUE_DATE_EXTEND_REQUEST) " +
				"values (:journalId, :status, :associateEditorUserId, :guestEditorUserId, :revisionCount, "
				+ ":coverLetter, :submitId, :userId, :divisionId, :specialIssueId, :submitStep, :title, :runningHead, :paperAbstract, :chiefEditorUserId, :managerUserId, "
				+ ":invite, :confirm3, :confirm4, :confirm1, :confirm2, :confirm5, :editorStatus, :cameraReadyRevision, :galleryProofRevision, "
				+ ":cameraReadyConfirm, :galleryProofConfirm, :manuscriptTypeId, :manuscriptTrackId, :aeAssignDate, :aeAssignTime, :revisionDueDate, :revisionDueTime,"
				+ ":cameraDueDate, :cameraDueTime, :dueDateExtendRequest)";
		
		SqlParameterSource paramSource = new BeanPropertySqlParameterSource(manuscript);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, paramSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public Manuscript findById(int id) {
		String sql = "SELECT * FROM MANUSCRIPTS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, manuscriptRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<Manuscript> findSubmittedManuscripts(int userId, int journalId, String status) {
		List<Manuscript> manuscripts = null;
		String sql = null;
		if(status == null) {
			if (userId == 0 && journalId == 0) { // for all users and for all journals
				sql = "SELECT * FROM MANUSCRIPTS";
				manuscripts = this.getJdbcTemplate().query(sql, manuscriptRowMapper);	
				return manuscripts;
			} else if (userId == 0) { // for all users
				sql = "SELECT * FROM MANUSCRIPTS WHERE JOURNAL_ID = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {journalId}, manuscriptRowMapper);	
				return manuscripts;
			} else if (journalId == 0) { // for all journals
				sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId}, manuscriptRowMapper);	
				return manuscripts;
			} else {
				sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ? AND JOURNAL_ID = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, manuscriptRowMapper);	
				return manuscripts;
			}
		} else {
			if (userId == 0 && journalId == 0) { // for all users and for all journals
				sql = "SELECT * FROM MANUSCRIPTS WHERE STATUS = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {status}, manuscriptRowMapper);	
				return manuscripts;
			} else if (userId == 0) { // for all users
				sql = "SELECT * FROM MANUSCRIPTS WHERE JOURNAL_ID = ? AND STATUS = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {journalId, status}, manuscriptRowMapper);	
				return manuscripts;
			} else if (journalId == 0) { // for all journals
				sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ? AND STATUS = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, status}, manuscriptRowMapper);	
				return manuscripts;
			} else {
				sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ? AND JOURNAL_ID = ? AND STATUS = ?";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, status}, manuscriptRowMapper);	
				return manuscripts;
			}
		}
	}
	
	@Override
	public List<Manuscript> findSubmittedManuscripts(int journalId, String status, int revisionCount) {
		List<Manuscript> manuscripts = null;
		String revisionClause;
		if(revisionCount == -1)
			revisionClause = "";
		else if(revisionCount == 0)
			revisionClause = " AND REVISION_COUNT = 0";
		else if(revisionCount == Integer.MAX_VALUE)
			revisionClause = " AND REVISION_COUNT > 0";
		else
			revisionClause = " AND REVISION_COUNT = " + revisionCount;
		
		String sql = "SELECT * FROM MANUSCRIPTS WHERE JOURNAL_ID = ? AND STATUS = ?" + revisionClause;
		manuscripts = this.getJdbcTemplate().query(sql, new Object[] {journalId, status}, manuscriptRowMapper);	
		return manuscripts;


	}

	@Override
	public List<Manuscript> findSubmittedManuscripts(int userId, int journalId, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Manuscript> manuscripts = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer statusClause = new StringBuffer("");
		if(status != null && status.size() > 0) {
			int index = 0;
			statusClause.append(" (");
			for(String s: status) {
				statusClause.append("STATUS = '");
				statusClause.append(s);
				statusClause.append("'");
				index ++;
				if(index < status.size())
					statusClause.append(" OR ");
			}
			statusClause.append(") ");
		}
		
		StringBuffer likeClause = new StringBuffer("");
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%' OR STATUS like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer("");
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("EVENT_DATE"))
        				orderByDate = true;
        			else
        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
        		}
        			
        	}
        	if(orderClauseStrings.size() > 0) {
        		orderClause.append(" ORDER BY ");
        		int index = 0;
        		for(String key: orderClauseStrings.keySet()) {
        			orderClause.append(key);
        			orderClause.append(" ");
        			orderClause.append(orderClauseStrings.get(key));
        			index ++;
        			if(index < orderClauseStrings.size())
        				orderClause.append(", ");
        		}
        	}
        }
        
		StringBuffer limitClause = new StringBuffer("");
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		String sql = null;
		if (userId == 0 && journalId == 0) { // for all users and for all journals
			sql = "SELECT * FROM MANUSCRIPTS WHERE ";
			if(status != null) sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, manuscriptRowMapper);
			
			return manuscripts;
		} else if (userId == 0) { // for all users
			sql = "SELECT * FROM MANUSCRIPTS WHERE JOURNAL_ID = ? AND ";
			if(status != null) sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {journalId}, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {journalId}, manuscriptRowMapper);
			
			return manuscripts;
		} else if (journalId == 0) { // for all journals
			sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ? AND";
			if(status != null) sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId}, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId}, manuscriptRowMapper);
			
			return manuscripts;
		} else {
			sql = "SELECT * FROM MANUSCRIPTS WHERE USER_ID = ? AND JOURNAL_ID = ? AND";
			if(status != null) sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId}, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, manuscriptRowMapper);
			
			return manuscripts;
		}
	}
	
	@Override
	public List<Manuscript> findSubmittedManuscriptsFromManagerConfiguration(Journal journal, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, List<String> indexNames) {
		
		List<Manuscript> manuscripts = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer statusClause = new StringBuffer("");
		StringBuffer likeClause = new StringBuffer("");
		boolean orderByDate = false;
		
		if(!dRequest.getsSearch()[0].equals("")) {	//Status
			String searchQuery = dRequest.getsSearch()[0];
			String[] statusStrings = searchQuery.split(",");
			if(statusStrings.length > 0) {
				int index = 0;
				statusClause.append(" (");
				for(String s: statusStrings) {
					statusClause.append("M.STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < statusStrings.length)
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
		} else {
			if(status != null && status.size() > 0) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("M.STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
		}
		int temporaryIdIndex = -1;
		int submitIdIndex = -1;
		int submitterIndex = -1;
		int institutionIndex = -1;
		int titleIndex = -1;
		int submitDateIndex = -1;
		int acceptDateIndex = -1;
		for(int i=0; i<indexNames.size(); i++) {	//Search Form Filter
			if(indexNames.get(i).equals("temporaryId"))
				temporaryIdIndex = i;
			
			if(indexNames.get(i).equals("submitId"))
				submitIdIndex = i;
			
			if(indexNames.get(i).equals("submitter"))
				submitterIndex = i;
			
			if(indexNames.get(i).equals("institution"))
				institutionIndex = i;
			
			if(indexNames.get(i).equals("title"))
				titleIndex = i;
			
			if(indexNames.get(i).equals("submitDate"))
				submitDateIndex = i;
			
			if(indexNames.get(i).equals("acceptDate"))
				acceptDateIndex = i;
		}
		
		if(temporaryIdIndex != -1 && !dRequest.getsSearch()[temporaryIdIndex].equals(""))
			likeClause.append(" M.ID = ").append(dRequest.getsSearch()[temporaryIdIndex]);
		else if(submitIdIndex != -1 && !dRequest.getsSearch()[submitIdIndex].equals("")) {
			likeClause.append(" M.SUBMIT_ID like '%").append(dRequest.getsSearch()[submitIdIndex]);
			likeClause.append("%'");
		} else if(submitterIndex != -1 && !dRequest.getsSearch()[submitterIndex].equals("")) {
			likeClause.append(" C.FIRST_NAME like '%").append(dRequest.getsSearch()[submitterIndex]);
			likeClause.append("%' OR");
			likeClause.append(" C.LAST_NAME like '%").append(dRequest.getsSearch()[submitterIndex]);
			likeClause.append("%' OR");
			likeClause.append(" C.LOCAL_FULL_NAME like '%").append(dRequest.getsSearch()[submitterIndex]);
			likeClause.append("%'");
		} else if(institutionIndex != -1 && !dRequest.getsSearch()[institutionIndex].equals("")) {
			likeClause.append(" C.LOCAL_INSTITUTION like '%").append(dRequest.getsSearch()[institutionIndex]);
			likeClause.append("%' OR");
			likeClause.append(" C.INSTITUTION like '%").append(dRequest.getsSearch()[institutionIndex]);
			likeClause.append("%'");
		}else if(titleIndex != -1 && !dRequest.getsSearch()[titleIndex].equals("")) {
			likeClause.append(" M.TITLE like '%").append(dRequest.getsSearch()[titleIndex]);
			likeClause.append("%'");
		} else if((submitDateIndex != -1 && !dRequest.getsSearch()[submitDateIndex].equals("")) || (acceptDateIndex != -1 && !dRequest.getsSearch()[acceptDateIndex].equals(""))) {	//Submission Date
			orderByDate = true;
		}  else {
			if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
				likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
				likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
				likeClause.append("%' OR M.STATUS like '%").append(sGlobalTerm);
				likeClause.append("%' OR C.FIRST_NAME like '%").append(sGlobalTerm);
				likeClause.append("%' OR C.LAST_NAME like '%").append(sGlobalTerm);
				likeClause.append("%' OR C.LOCAL_INSTITUTION like '%").append(sGlobalTerm);
				likeClause.append("%' OR C.INSTITUTION like '%").append(sGlobalTerm);
				likeClause.append("%')");
			}
		}

		StringBuffer orderClause = new StringBuffer("");
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
		if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("M.EVENT_DATE"))
        				orderByDate = true;
        			else {
        				if(sortableColumnName.equals("C.FIRST_NAME")) {
        					if(journal.getLanguageCode().equals("ko")) {
        						orderClauseStrings.put("C.LOCAL_FULL_NAME", dRequest.getsSortDir()[i]);
        						orderClauseStrings.put("C.FIRST_NAME", dRequest.getsSortDir()[i]);
            					orderClauseStrings.put("C.LAST_NAME", dRequest.getsSortDir()[i]);
        					} else {
	        					orderClauseStrings.put("C.FIRST_NAME", dRequest.getsSortDir()[i]);
	        					orderClauseStrings.put("C.FIRST_NAME", dRequest.getsSortDir()[i]);
        					}
        				} else if(sortableColumnName.equals("C.INSTITUTION")) {
        					if(journal.getLanguageCode().equals("ko")) {
        						orderClauseStrings.put("C.LOCAL_INSTITUTION", dRequest.getsSortDir()[i]);
        						orderClauseStrings.put("C.INSTITUTION", dRequest.getsSortDir()[i]);
        					} else
        						orderClauseStrings.put("C.INSTITUTION", dRequest.getsSortDir()[i]);
        					
        				} else
        					orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
        			}
        		}
        	}
        	if(orderClauseStrings.size() > 0) {
        		orderClause.append(" ORDER BY ");
        		int index = 0;
        		for(String key: orderClauseStrings.keySet()) {
        			orderClause.append(key);
        			orderClause.append(" ");
        			orderClause.append(orderClauseStrings.get(key));
        			index ++;
        			if(index < orderClauseStrings.size())
        				orderClause.append(", ");
        		}
        	}
        }
        
		StringBuffer limitClause = new StringBuffer("");
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		String sql = "SELECT * FROM MANUSCRIPTS M JOIN CONTACTS C ON M.USER_ID = C.USER_ID WHERE M.JOURNAL_ID = ? AND";
		if(status != null) sql += statusClause.toString();
		if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
		String countSql = sql.replace("*", "COUNT(M.ID)");
		iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {journal.getId()}, Integer.class);	
		sql += orderClause.toString();
		sql += limitClause.toString();
		manuscripts = this.getJdbcTemplate().query(sql, new Object[] {journal.getId()}, manuscriptStatisticsRowMapper);
		
		return manuscripts;
		
	}
	
	@Override
	public int numSubmittedManuscripts(int userId, int journalId, List<String> status) {
		int count = -1;
		String sql = null;
		StringBuffer statusClause = new StringBuffer("");
		if(status != null && status.size() > 0) {
			int index = 0;
			statusClause.append(" (");
			for(String s: status) {
				statusClause.append("STATUS = '");
				statusClause.append(s);
				statusClause.append("'");
				index ++;
				if(index < status.size())
					statusClause.append(" OR ");
			}
			statusClause.append(") ");
		}

		if (userId == 0 && journalId == 0) { // for all users and for all journals
			sql = "SELECT count(*) FROM MANUSCRIPTS";
			if(status != null) sql += " WHERE " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {status}, Integer.class);	
			return count;
		} else if (userId == 0) { // for all users
			sql = "SELECT count(*) FROM MANUSCRIPTS WHERE JOURNAL_ID = ?";
			if(status != null) sql += " AND " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId}, Integer.class);	
			return count;
		} else if (journalId == 0) { // for all journals
			sql = "SELECT count(*) FROM MANUSCRIPTS WHERE USER_ID = ?";
			if(status != null) sql += " AND " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);	
			return count;
		} else {
			sql = "SELECT count(*) FROM MANUSCRIPTS WHERE USER_ID = ? AND JOURNAL_ID = ?";
			if(status != null) sql += " AND " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, Integer.class);	
			return count;
		}
	}
	
	@Override
	public int numSubmittedManuscripts(int journalId, String status) {
		try {
			String sql = "SELECT count(*) FROM MANUSCRIPTS WHERE JOURNAL_ID = ? AND STATUS = ?";
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId, status}, Integer.class);	
		} catch(Exception e) {
			return 0;
		}
	}
	
	@Override
	public int numSubmittedManuscripts(int journalId, String status, int revisionCount) {
		try {
			String revisionClause;
			if(revisionCount == -1)
				revisionClause = "";
			else if(revisionCount == 0)
				revisionClause = " AND REVISION_COUNT = 0";
			else if(revisionCount == Integer.MAX_VALUE)
				revisionClause = " AND REVISION_COUNT > 0";
			else
				revisionClause = " AND REVISION_COUNT = " + revisionCount;
			String sql = "SELECT count(*) FROM MANUSCRIPTS WHERE JOURNAL_ID = ? AND STATUS = ?" + revisionClause;
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {journalId, status}, Integer.class);	
		} catch(Exception e) {
			return 0;
		}
	}
	
	@Override
	public List<Manuscript> findCoWrittenManuscripts(int userId, int journalId, String status, boolean includeWrittenByMe) {
		List<Manuscript> manuscripts = null;
		String sql = null;
		if(status == null) {
			if (userId == 0 && journalId == 0) // for all users and for all journals - not meaningful query	
				return null;
			else if (userId == 0) // for all users - not meaningful query
				return null;
			else if (journalId == 0) { // for all journals
				sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID WHERE C.USER_ID = ?";
				if(!includeWrittenByMe)
					sql += " AND C.AUTHOR_ORDER != 1";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId}, manuscriptRowMapper);
				return manuscripts;
			} else {
				sql = "SELECT * FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID WHERE C.USER_ID = ? AND JOURNAL_ID = ?";
				if(!includeWrittenByMe)
					sql += " AND C.AUTHOR_ORDER != 1";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, manuscriptRowMapper);	
				return manuscripts;
			}
		} else {
			if (userId == 0 && journalId == 0) // for all users and for all journals - not meaningful query
				return null;
			else if (userId == 0) // for all users - not meaningful query
				return null;
			else if (journalId == 0) { // for all journals
				sql = "SELECT * FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID WHERE C.USER_ID = ? AND STATUS = ?";
				if(!includeWrittenByMe)
					sql += " AND C.AUTHOR_ORDER != 1";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, status}, manuscriptRowMapper);	
				return manuscripts;

			} else {
				sql = "SELECT * FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID WHERE C.USER_ID = ? AND JOURNAL_ID = ? AND STATUS = ?";
				if(!includeWrittenByMe)
					sql += " AND C.AUTHOR_ORDER != 1";
				manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, status}, manuscriptRowMapper);	
				return manuscripts;

			}
		}
	}
	
	@Override
	public List<Manuscript> findCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Manuscript> manuscripts = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer statusClause = new StringBuffer("");
		if(status != null && status.size() > 0) {
			int index = 0;
			statusClause.append(" (");
			for(String s: status) {
				statusClause.append("M.STATUS = '");
				statusClause.append(s);
				statusClause.append("'");
				index ++;
				if(index < status.size())
					statusClause.append(" OR ");
			}
			statusClause.append(") ");
		}
		
		StringBuffer likeClause = new StringBuffer("");
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%' OR M.STATUS like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer("");
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("EVENT_DATE"))
        				orderByDate = true;
        			else
        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
        		}
        			
        	}
        	if(orderClauseStrings.size() > 0) {
        		orderClause.append(" ORDER BY ");
        		int index = 0;
        		for(String key: orderClauseStrings.keySet()) {
        			orderClause.append("M.");
        			orderClause.append(key);
        			orderClause.append(" ");
        			orderClause.append(orderClauseStrings.get(key));
        			index ++;
        			if(index < orderClauseStrings.size())
        				orderClause.append(", ");
        		}
        	}
        }
        
		StringBuffer limitClause = new StringBuffer("");
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		
		String sql = null;
		if (userId == 0 && journalId == 0) // for all users and for all journals - not meaningful query
			return null;
		else if (userId == 0) // for all users - not meaningful query
			return null;
		else if (journalId == 0) { // for all journals
			sql = "SELECT * FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID AND M.REVISION_COUNT = C.REVISION_COUNT WHERE C.USER_ID = ?";
			if(!includeWrittenByMe) sql += " AND C.AUTHOR_ORDER != 1";
			if(status != null) sql += " AND " + statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(M.ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId}, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId}, manuscriptRowMapper);	
			return manuscripts;

		} else {
			sql = "SELECT * FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID AND M.REVISION_COUNT = C.REVISION_COUNT WHERE C.USER_ID = ? AND M.JOURNAL_ID = ?";
			if(!includeWrittenByMe) sql += " AND C.AUTHOR_ORDER != 1";
			if(status != null) sql += " AND " + statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(M.ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId}, Integer.class);	
			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, manuscriptRowMapper);	
			return manuscripts;

		}
	}

	@Override
	public int numCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe) {
		int count = -1;
		String sql = null;
		StringBuffer statusClause = new StringBuffer("");
		if(status != null) {
			int index = 0;
			statusClause.append(" (");
			for(String s: status) {
				statusClause.append("M.STATUS = '");
				statusClause.append(s);
				statusClause.append("'");
				index ++;
				if(index < status.size())
					statusClause.append(" OR ");
			}
			statusClause.append(") ");
		}

		if (userId == 0 && journalId == 0) // for all users and for all journals - not meaningful query
			return count;
		else if (userId == 0) // for all users - not meaningful query
			return count;
		else if (journalId == 0) { // for all journals
			sql = "SELECT COUNT(M.ID) FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID AND M.REVISION_COUNT = C.REVISION_COUNT WHERE C.USER_ID = ?";
			if(!includeWrittenByMe) sql += " AND C.AUTHOR_ORDER != 1";
			if(status != null) sql += " AND " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);	
			return count;
		} else {
			sql = "SELECT COUNT(M.ID) FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID AND M.REVISION_COUNT = C.REVISION_COUNT WHERE C.USER_ID = ? AND JOURNAL_ID = ?";
			if(!includeWrittenByMe) sql += " AND C.AUTHOR_ORDER != 1";
			if(status != null) sql += " AND " + statusClause.toString();
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, Integer.class);	
			return count;
		}
	}
	
	@Override
	public void delete(int manuscriptId) {
		try {
			String sql = "DELETE FROM MANUSCRIPTS WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {manuscriptId});
		} catch(Exception e) {
		}
	}
	
	@Override
	public List<Manuscript> findManuscriptsExceptSpecificStatus(List<String> status, int journalId) {
		StringBuffer buf = new StringBuffer();
		buf.append(" WHERE ");
		int i=0;
		for(String s: status) {
			buf.append("STATUS != '");
			buf.append(s);
			buf.append("'");
			i++;
			if(i < status.size())
				buf.append(" and ");
		}
		buf.append(" AND JOURNAL_ID = ");
		buf.append(journalId);
		String likeClause = buf.toString();
		
		String sql = "SELECT * FROM MANUSCRIPTS" + likeClause;
		List<Manuscript> list = this.getJdbcTemplate().query(sql, manuscriptRowMapper);	
		return list;
	}
	
	@Override
	public List<Manuscript> findManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		try {
			List<Manuscript> manuscripts = null;
			String sGlobalTerm = dRequest.getsSearchGlobal();
			String roleClause = null;
			if(role.equals(SystemConstants.roleManager))
				roleClause = "MANAGER_USER_ID = ?";
			else if(role.equals(SystemConstants.roleCEditor))
				roleClause = "CHIEF_USER_ID = ?";
			else if(role.equals(SystemConstants.roleGEditor))
				roleClause = "GE_USER_ID = ?";
			else if(role.equals(SystemConstants.roleAEditor))
				roleClause = "AE_USER_ID = ?";
					
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			StringBuffer likeClause = new StringBuffer("");
			if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
				likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
				likeClause.append("%' OR SUBMIT_ID like '%").append(sGlobalTerm);
				likeClause.append("%' OR STATUS like '%").append(sGlobalTerm);
				likeClause.append("%')");
			}

			boolean orderByDate = false;
			StringBuffer orderClause = new StringBuffer("");
			Map<String, String> orderClauseStrings = new HashMap<String, String>();
	        if (dRequest.getiSortingCols() != 0) {
	        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
	        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
	        		if(sortableColumnName != null) {
	        			if(sortableColumnName.equals("EVENT_DATE"))
	        				orderByDate = true;
	        			else
	        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
	        		}
	        			
	        	}
	        	
	        	if(orderClauseStrings.size() > 0) {
	        		orderClause.append(" ORDER BY ");
	        		int index = 0;
	        		for(String key: orderClauseStrings.keySet()) {
	        			orderClause.append(key);
	        			orderClause.append(" ");
	        			orderClause.append(orderClauseStrings.get(key));
	        			index ++;
	        			if(index < orderClauseStrings.size())
	        				orderClause.append(", ");
	        		}
	        	}
	        }
	        
			StringBuffer limitClause = new StringBuffer("");
			if(!orderByDate && dRequest.getiDisplayLength() != -1) {
				limitClause.append(" LIMIT ");
				limitClause.append(dRequest.getiDisplayStart());
				limitClause.append(" , ");
				limitClause.append(dRequest.getiDisplayLength());
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT * FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT * FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT * FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			
			sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId}, Integer.class);	

			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, manuscriptRowMapper);
			
			return manuscripts;

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		} 
	}
	
	@Override
	public int numManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount) {
		try {
			String roleClause = null;
			if(role.equals(SystemConstants.roleManager))
				roleClause = "MANAGER_USER_ID = ?";
			else if(role.equals(SystemConstants.roleCEditor))
				roleClause = "CHIEF_USER_ID = ?";
			else if(role.equals(SystemConstants.roleGEditor))
				roleClause = "GE_USER_ID = ?";
			else if(role.equals(SystemConstants.roleAEditor))
				roleClause = "AE_USER_ID = ?";
			
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE " + roleClause + " AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			sql += statusClause.toString();
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId}, Integer.class);

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return 0;
		} 
	}
	
	@Override
	public List<Manuscript> findManuscriptsByChiefEditorUserId(int editorUserId, int journalId, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		try {
			List<Manuscript> manuscripts = null;
			String sGlobalTerm = dRequest.getsSearchGlobal();
			
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			StringBuffer likeClause = new StringBuffer("");
			if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
				likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
				likeClause.append("%' OR SUBMIT_ID like '%").append(sGlobalTerm);
				likeClause.append("%' OR STATUS like '%").append(sGlobalTerm);
				likeClause.append("%')");
			}

			boolean orderByDate = false;
			StringBuffer orderClause = new StringBuffer("");
			Map<String, String> orderClauseStrings = new HashMap<String, String>();
	        if (dRequest.getiSortingCols() != 0) {
	        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
	        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
	        		if(sortableColumnName != null) {
	        			if(sortableColumnName.equals("EVENT_DATE"))
	        				orderByDate = true;
	        			else
	        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
	        		}
	        			
	        	}
	        	
	        	if(orderClauseStrings.size() > 0) {
	        		orderClause.append(" ORDER BY ");
	        		int index = 0;
	        		for(String key: orderClauseStrings.keySet()) {
	        			orderClause.append(key);
	        			orderClause.append(" ");
	        			orderClause.append(orderClauseStrings.get(key));
	        			index ++;
	        			if(index < orderClauseStrings.size())
	        				orderClause.append(", ");
	        		}
	        	}
	        }
	        
			StringBuffer limitClause = new StringBuffer("");
			if(!orderByDate && dRequest.getiDisplayLength() != -1) {
				limitClause.append(" LIMIT ");
				limitClause.append(dRequest.getiDisplayStart());
				limitClause.append(" , ");
				limitClause.append(dRequest.getiDisplayLength());
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT * FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT * FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT * FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			
			sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {editorUserId, journalId}, Integer.class);	

			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {editorUserId, journalId}, manuscriptRowMapper);
			
			return manuscripts;

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		} 
	}
	
	@Override
	public int numManuscriptsByChiefEditorUserId(int editorUserId, int journalId, List<String> status, int revisionCount) {
		try {
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE CHIEF_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			sql += statusClause.toString();
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {editorUserId, journalId}, Integer.class);

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return 0;
		} 
	}

	@Override
	public List<Manuscript> findManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		try {
			List<Manuscript> manuscripts = null;
			String sGlobalTerm = dRequest.getsSearchGlobal();
			String editorStatusClause = "";
			if(editorStatus != null)
				editorStatusClause = " EDITOR_STATUS = '" + editorStatus + "' AND";
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			StringBuffer likeClause = new StringBuffer("");
			if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
				likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
				likeClause.append("%' OR SUBMIT_ID like '%").append(sGlobalTerm);
				likeClause.append("%' OR STATUS like '%").append(sGlobalTerm);
				likeClause.append("%')");
			}

			boolean orderByDate = false;
			StringBuffer orderClause = new StringBuffer("");
			Map<String, String> orderClauseStrings = new HashMap<String, String>();
	        if (dRequest.getiSortingCols() != 0) {
	        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
	        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
	        		if(sortableColumnName != null) {
	        			if(sortableColumnName.equals("EVENT_DATE"))
	        				orderByDate = true;
	        			else
	        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
	        		}
	        			
	        	}
	        	
	        	if(orderClauseStrings.size() > 0) {
	        		orderClause.append(" ORDER BY ");
	        		int index = 0;
	        		for(String key: orderClauseStrings.keySet()) {
	        			orderClause.append(key);
	        			orderClause.append(" ");
	        			orderClause.append(orderClauseStrings.get(key));
	        			index ++;
	        			if(index < orderClauseStrings.size())
	        				orderClause.append(", ");
	        		}
	        	}
	        }
	        
			StringBuffer limitClause = new StringBuffer("");
			if(!orderByDate && dRequest.getiDisplayLength() != -1) {
				limitClause.append(" LIMIT ");
				limitClause.append(dRequest.getiDisplayStart());
				limitClause.append(" , ");
				limitClause.append(dRequest.getiDisplayLength());
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT * FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT * FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT * FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			sql += editorStatusClause;
			sql += statusClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {editorUserId, journalId}, Integer.class);	

			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {editorUserId, journalId}, manuscriptRowMapper);
			
			return manuscripts;

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		} 
	}
	
	@Override
	public int numManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount) {
		try {
			String editorStatusClause = "";
			if(editorStatus != null)
				editorStatusClause = " EDITOR_STATUS = '" + editorStatus + "' AND";
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE AE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			sql += editorStatusClause;
			sql += statusClause.toString();
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {editorUserId, journalId}, Integer.class);

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return 0;
		} 
	}
	
	@Override
	public List<Manuscript> findManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		try {
			List<Manuscript> manuscripts = null;
			String sGlobalTerm = dRequest.getsSearchGlobal();
			
			StringBuffer siClause = new StringBuffer();
			if(specialIssueIds != null && specialIssueIds.size() > 0) {
				int index = 0;
				siClause.append("AND (");
				for(Integer s: specialIssueIds) {
					siClause.append("SPECIAL_ISSUE_ID = ");
					siClause.append(s);
					index ++;
					if(index < specialIssueIds.size())
						siClause.append(" OR ");
				}
				siClause.append(") ");
			}
			
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			StringBuffer likeClause = new StringBuffer("");
			if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
				likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
				likeClause.append("%' OR SUBMIT_ID like '%").append(sGlobalTerm);
				likeClause.append("%' OR STATUS like '%").append(sGlobalTerm);
				likeClause.append("%')");
			}

			boolean orderByDate = false;
			StringBuffer orderClause = new StringBuffer("");
			Map<String, String> orderClauseStrings = new HashMap<String, String>();
	        if (dRequest.getiSortingCols() != 0) {
	        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
	        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
	        		if(sortableColumnName != null) {
	        			if(sortableColumnName.equals("EVENT_DATE"))
	        				orderByDate = true;
	        			else
	        				orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
	        		}
	        			
	        	}
	        	
	        	if(orderClauseStrings.size() > 0) {
	        		orderClause.append(" ORDER BY ");
	        		int index = 0;
	        		for(String key: orderClauseStrings.keySet()) {
	        			orderClause.append(key);
	        			orderClause.append(" ");
	        			orderClause.append(orderClauseStrings.get(key));
	        			index ++;
	        			if(index < orderClauseStrings.size())
	        				orderClause.append(", ");
	        		}
	        	}
	        }
	        
			StringBuffer limitClause = new StringBuffer("");
			if(!orderByDate && dRequest.getiDisplayLength() != -1) {
				limitClause.append(" LIMIT ");
				limitClause.append(dRequest.getiDisplayStart());
				limitClause.append(" , ");
				limitClause.append(dRequest.getiDisplayLength());
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT * FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT * FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT * FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			
			sql += statusClause.toString();
			sql += siClause.toString();
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = sql.replace("*", "COUNT(ID)");
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {editorUserId, journalId}, Integer.class);	

			sql += orderClause.toString();
			sql += limitClause.toString();
			manuscripts = this.getJdbcTemplate().query(sql, new Object[] {editorUserId, journalId}, manuscriptRowMapper);
			
			return manuscripts;

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		} 
	}
	
	@Override
	public int numManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount) {
		try {
			StringBuffer siClause = new StringBuffer();
			if(specialIssueIds != null && specialIssueIds.size() > 0) {
				int index = 0;
				siClause.append("AND (");
				for(Integer s: specialIssueIds) {
					siClause.append("SPECIAL_ISSUE_ID = ");
					siClause.append(s);
					index ++;
					if(index < specialIssueIds.size())
						siClause.append(" OR ");
				}
				siClause.append(") ");
			}
			
			StringBuffer statusClause = new StringBuffer("");
			if(status != null) {
				int index = 0;
				statusClause.append(" (");
				for(String s: status) {
					statusClause.append("STATUS = '");
					statusClause.append(s);
					statusClause.append("'");
					index ++;
					if(index < status.size())
						statusClause.append(" OR ");
				}
				statusClause.append(") ");
			}
			
			String sql = null;
			if (revisionCount == -1)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND";
			else if(revisionCount == 0)
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT = 0 AND";
			else
				sql = "SELECT COUNT(*) FROM MANUSCRIPTS WHERE GE_USER_ID = ? AND JOURNAL_ID = ? AND REVISION_COUNT > 0 AND";
			sql += statusClause.toString();
			sql += siClause.toString();
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {editorUserId, journalId}, Integer.class);

		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return 0;
		} 
	}
	
	@Override
	public int getNumOfRecordsByCustomSql(String sql) {
		return this.getJdbcTemplate().queryForObject(sql, Integer.class);
	}
	
	@Override
	public void update(Manuscript manuscript) {
		String sql = "UPDATE MANUSCRIPTS SET JOURNAL_ID = ?, STATUS = ?, AE_USER_ID = ?, GE_USER_ID = ?,"
				+ "REVISION_COUNT = ?, COVERLETTER = ?, SUBMIT_ID = ?, USER_ID = ?, DIVISION_ID = ?, SPECIAL_ISSUE_ID = ?, SUBMIT_STEP = ?,"
				+ "TITLE = ?, RUNNINGHEAD = ?, PAPER_ABSTRACT = ?, CHIEF_USER_ID = ?, MANAGER_USER_ID = ?,"
				+ "INVITE = ?, CONFIRM1 = ?, CONFIRM2 = ?, CONFIRM3 = ?, CONFIRM4 = ?, CONFIRM5 = ?, EDITOR_STATUS = ?, CAMERA_READY_REVISION = ?, "
				+ "GALLERY_PROOF_REVISION = ?, CAMERA_READY_CONFIRM = ?, GALLERY_PROOF_CONFIRM = ?, TYPE_ID = ?, TRACK_ID = ?, AE_ASSIGN_DATE = ?, AE_ASSIGN_TIME = ?,"
				+ "REVISION_DUE_DATE = ?, REVISION_DUE_TIME = '23:59:59', CAMERA_DUE_DATE = ?, CAMERA_DUE_TIME = '23:59:59', DUE_DATE_EXTEND_REQUEST = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscript.getJournalId(), manuscript.getStatus(), 
				manuscript.getAssociateEditorUserId(), manuscript.getGuestEditorUserId(), manuscript.getRevisionCount(), 
				manuscript.getCoverLetter(), manuscript.getSubmitId(), manuscript.getUserId(), manuscript.getDivisionId(), 
				manuscript.getSpecialIssueId(), manuscript.getSubmitStep(), manuscript.getTitle(), manuscript.getRunningHead(), 
				manuscript.getPaperAbstract(), manuscript.getChiefEditorUserId(), manuscript.getManagerUserId(), manuscript.isInvite(), 
				manuscript.isConfirm1(), manuscript.isConfirm2(), manuscript.isConfirm3(), manuscript.isConfirm4(), manuscript.isConfirm5(),
				manuscript.getEditorStatus(), manuscript.getCameraReadyRevision(), manuscript.getGalleryProofRevision(),
				manuscript.isCameraReadyConfirm(), manuscript.isGalleryProofConfirm(), manuscript.getManuscriptTypeId(), manuscript.getManuscriptTrackId(),
				manuscript.getAeAssignDate(), manuscript.getAeAssignTime(), manuscript.getRevisionDueDate(), 
				manuscript.getCameraDueDate(), manuscript.isDueDateExtendRequest(), manuscript.getId()});	
	}
	
	@Override
	public void setCurrentDate(Manuscript manuscript, String dateColumnName, String timeColumnName) {
		String sql = "UPDATE MANUSCRIPTS SET " + dateColumnName + " = UTC_DATE(), " + timeColumnName + "= '23:59:59' WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] { manuscript.getId()});	
	}
	
	@Override
	public void updateDate(Manuscript manuscript, String dateColumnName, String timeColumnName, int addedDate) {
		this.getJdbcTemplate().update("UPDATE MANUSCRIPTS SET " + dateColumnName + " = UTC_DATE(), " + timeColumnName + "= '23:59:59' WHERE ID = ?", new Object[] { manuscript.getId()});	
		String sql = "UPDATE MANUSCRIPTS SET " + dateColumnName + " = DATE_ADD(" + dateColumnName + ", INTERVAL " + addedDate + " DAY), " + timeColumnName + "= '23:59:59' WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] { manuscript.getId()});	
	}
}
