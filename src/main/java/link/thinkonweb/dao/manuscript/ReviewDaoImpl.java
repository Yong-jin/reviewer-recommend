package link.thinkonweb.dao.manuscript;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.util.DataTableClientRequest;

import javax.inject.Inject;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;


public class ReviewDaoImpl extends NamedParameterJdbcDaoSupport implements ReviewDao {
	@Inject
	private ReviewRowMapper reviewRowMapper;
	@Inject
	private ReviewManuscriptRowMapper reviewManuscriptRowMapper;

	@Override
	public int insert(Review review) {
		String sql = "INSERT INTO MANUSCRIPTS_REVIEW (ID, USER_ID, MANUSCRIPT_ID, JOURNAL_ID, SCORE1, SCORE2, SCORE3, SCORE4, SCORE5, SCORE6, SCORE7, SCORE8, SCORE9, SCORE10,"
				+ "NUMBER_OF_REVIEW_ITEMS, OVERALL, RE_REVIEW, CONFIRM, CREATED_MEMBER, TEMP_PW, REVISION_COUNT, DUE_DATE, DUE_TIME, STATUS, FIRST_STATUS, "
				+ "REVIEW_ITEM_ID1, REVIEW_ITEM_ID2, REVIEW_ITEM_ID3, REVIEW_ITEM_ID4, REVIEW_ITEM_ID5, REVIEW_ITEM_ID6, REVIEW_ITEM_ID7, REVIEW_ITEM_ID8, REVIEW_ITEM_ID9, REVIEW_ITEM_ID10) " +
				"VALUES (:id, :userId, :manuscriptId, :journalId, :score1, :score2, :score3, :score4, :score5, :score6, :score7, :score8, :score9, :score10, :numberOfReviewItems, :overall, :reReview, :confirm, :createdMember, :tempPw, "
				+ ":revisionCount, :dueDate, :dueTime, :status, :firstStatus, :reviewItemId1, :reviewItemId2, :reviewItemId3, :reviewItemId4, :reviewItemId5, :reviewItemId6, :reviewItemId7, :reviewItemId8, :reviewItemId9, :reviewItemId10 )";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(review);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}
	@Override
	public Review findById(int id) {
		Review review = this.getJdbcTemplate().queryForObject("SELECT * FROM MANUSCRIPTS_REVIEW WHERE ID = ?", new Object[] {id}, reviewRowMapper);
		return review;
	}
	@Override
	public int numReviews(int userId, int manuscriptId, int journalId, int revisionCount, List<String> status) {
		StringBuffer statusClause = new StringBuffer();
		if(status != null && status.size() > 0) {
			int index = 0;
			statusClause.append(" AND (");
			for(String s: status) {
				statusClause.append("STATUS = '");
				statusClause.append(s);
				statusClause.append("'");
				index ++;
				if(index < status.size())
					statusClause.append(" OR ");
			}
			statusClause.append(")");
		}
		StringBuffer revisionClause = new StringBuffer();
		if(revisionCount != -1) {
			revisionClause.append(" AND ");
			revisionClause.append("REVISION_COUNT = ");
			revisionClause.append(revisionCount);
		}
		
		if(userId == 0) {
			if (manuscriptId == 0 && journalId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE USER_ID > 0" + statusClause.toString() + revisionClause.toString(), new Object[] {status}, Integer.class);
			else if (manuscriptId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE JOURNAL_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {journalId}, Integer.class);
			else if (journalId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId}, Integer.class);
			else
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND JOURNAL_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, journalId}, Integer.class);
			
		} else {
			if (manuscriptId == 0 && journalId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {userId}, Integer.class);
			else if (manuscriptId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE JOURNAL_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {journalId, userId}, Integer.class);
			else if (journalId == 0)
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, userId}, Integer.class);
			else
				return this.getJdbcTemplate().queryForObject("SELECT COUNT(ID) FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND JOURNAL_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, journalId, userId}, Integer.class);
			
		}
	}
	@Override
	public List<Review> findReviews(int userId, int manuscriptId, int journalId, int revisionCount, String status) {
		StringBuffer statusClause = new StringBuffer();
		if(status != null) {
			statusClause.append(" AND ");
			statusClause.append("STATUS = '");
			statusClause.append(status);
			statusClause.append("'");
		}
		StringBuffer revisionClause = new StringBuffer();
		if(revisionCount != -1) {
			revisionClause.append(" AND ");
			revisionClause.append("REVISION_COUNT = ");
			revisionClause.append(revisionCount);
		}
		
		if(userId == 0) {
			if(manuscriptId == 0 && journalId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE USER_ID > 0" + statusClause.toString() + revisionClause.toString(), new Object[] {status}, reviewRowMapper);
				return reviews;
			} else if(manuscriptId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE JOURNAL_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {journalId}, reviewRowMapper);
				return reviews;
			} else if(journalId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId}, reviewRowMapper);
				return reviews;
			} else {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND JOURNAL_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, journalId}, reviewRowMapper);
				return reviews;
			}
		} else {
			if(manuscriptId == 0 && journalId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {userId}, reviewRowMapper);
				return reviews;
			} else if(manuscriptId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE JOURNAL_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {journalId, userId}, reviewRowMapper);
				return reviews;
			} else if(journalId == 0) {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, userId}, reviewRowMapper);
				return reviews;
			} else {
				List<Review> reviews = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_REVIEW WHERE MANUSCRIPT_ID = ? AND JOURNAL_ID = ? AND USER_ID = ?" + statusClause.toString() + revisionClause.toString(), new Object[] {manuscriptId, journalId, userId}, reviewRowMapper);
				return reviews;
			}
		}
	}
	
	public List<Review> findReviewManuscriptsForMyActivity(int userId) {
		String query = "SELECT * FROM MANUSCRIPTS_REVIEW AS A WHERE A.USER_ID = ? AND (A.STATUS = 'A' OR A.STATUS = 'C' OR A.STATUS = 'M' OR A.STATUS = 'T' OR A.STATUS = 'D') AND (A.MANUSCRIPT_ID, A.REVISION_COUNT) IN (SELECT B.MANUSCRIPT_ID, max(B.REVISION_COUNT) FROM MANUSCRIPTS_REVIEW AS B WHERE B.USER_ID = ? AND (B.STATUS = 'A' OR B.STATUS = 'C' OR B.STATUS = 'M' OR B.STATUS = 'T' OR A.STATUS = 'D') group by B.MANUSCRIPT_ID)";
		List<Review> reviews = this.getJdbcTemplate().query(query, new Object[] {userId, userId}, reviewRowMapper);
		return reviews;
	}
	@Override
	public List<Review> findAll(int journalId) {
		String query = "SELECT * FROM MANUSCRIPTS_REVIEW";
		if(journalId != 0)
			query += " WHERE JOURNAL_ID = " + journalId;
		List<Review> reviews = this.getJdbcTemplate().query(query, reviewRowMapper);
		return reviews;
	}
	@Override
	public int numReviewManuscriptsForMyActivity(int userId) {
		String query = "SELECT count(*) FROM MANUSCRIPTS_REVIEW AS A WHERE A.USER_ID = ? AND (A.STATUS = 'A' OR A.STATUS = 'C' OR A.STATUS = 'M' OR A.STATUS = 'T' OR A.STATUS = 'D') AND (A.MANUSCRIPT_ID, A.REVISION_COUNT) IN (SELECT B.MANUSCRIPT_ID, max(B.REVISION_COUNT) FROM MANUSCRIPTS_REVIEW AS B WHERE B.USER_ID = ? AND (B.STATUS = 'A' OR B.STATUS = 'C' OR B.STATUS = 'M' OR B.STATUS = 'T' OR B.STATUS = 'D') group by B.MANUSCRIPT_ID)";
		return this.getJdbcTemplate().queryForObject(query, new Object[] {userId, userId}, Integer.class);
	}
	@Override
	public List<Review> findReviews(int userId, int journalId, String status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer likeClause = new StringBuffer();
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer();
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("MR.EVENT_DATE"))
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
        
		StringBuffer limitClause = new StringBuffer();
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		if(journalId == 0) {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.STATUS = ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.STATUS = ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, status}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, status}, reviewRowMapper);
			
			return reviews;
		} else {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND MR.STATUS = ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND MR.STATUS = ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId, status}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, status}, reviewRowMapper);
			
			return reviews;
		}
	}
/*	@Override
	public List<Review> findReviewsByFirstStatus(int userId, int journalId, String firstStatus, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer likeClause = new StringBuffer();
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer();
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("MR.EVENT_DATE"))
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
        
		StringBuffer limitClause = new StringBuffer();
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		
		if(journalId == 0) {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.FIRST_STATUS = ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.FIRST_STATUS = ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, firstStatus}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, firstStatus}, reviewRowMapper);
			
			return reviews;
		} else {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND MR.FIRST_STATUS = ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND MR.FIRST_STATUS = ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId, firstStatus}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, firstStatus}, reviewRowMapper);
			
			return reviews;
		}
	}*/
	
	@Override
	public List<Review> findReviewsFromReviewerHistory(int userId, int journalId, String firstStatus, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer likeClause = new StringBuffer();
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer();
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("MR.EVENT_DATE"))
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
        
		StringBuffer limitClause = new StringBuffer();
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		
		if(journalId == 0) {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, userId, firstStatus}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, userId, firstStatus}, reviewRowMapper);
			
			return reviews;
		} else {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ? AND MR.JOURNAL_ID = ?";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ? AND MR.JOURNAL_ID = ?";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, userId, firstStatus, journalId}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, userId, firstStatus, journalId}, reviewRowMapper);
			
			return reviews;
		}
	}
	
	@Override
	public int numReviewsFromReviewerHistory(int userId, int journalId, String firstStatus) {
		if(journalId == 0) {
			String sql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ?";
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, userId, firstStatus}, Integer.class);
		} else {
			String sql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID AND MR.REVISION_COUNT = M.REVISION_COUNT JOIN MANUSCRIPTS_REVIEW_EVENT_DATE MRE ON M.ID = MRE.MANUSCRIPT_ID WHERE MR.USER_ID = ? AND MRE.USER_ID = ? AND MRE.STATUS= ? AND MR.JOURNAL_ID = ?";
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, userId, firstStatus, journalId}, Integer.class);
		}
	}
/*	@Override
	public List<Integer> findCompletedAndDismissedReviews(int userId, int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Integer> reviews = null;
		List<Integer> removableIds = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer likeClause = new StringBuffer();
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer();
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("MR.EVENT_DATE"))
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
        
		StringBuffer limitClause = new StringBuffer();
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		
		StringBuffer removableIdsClause = new StringBuffer();
		
		String sql = "SELECT MR.MANUSCRIPT_ID FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID= ? AND MR.JOURNAL_ID = ? AND (MR.STATUS = 'A' OR MR.STATUS = 'I')";
		removableIds = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, reviewManuscriptRowMapper);
		if(removableIds != null && removableIds.size() > 0) {
			int index = 0;
			removableIdsClause.append(" AND (");
			for(Integer id: removableIds) {
				
				removableIdsClause.append("MR.MANUSCRIPT_ID != ");
				removableIdsClause.append(id);
				index ++;
    			if(index < removableIds.size())
    				removableIdsClause.append(" AND ");
			}
			removableIdsClause.append(") ");
		}
		
		sql = "SELECT DISTINCT MR.MANUSCRIPT_ID FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE (MR.STATUS = 'C' OR MR.STATUS = 'T' OR MR.STATUS = 'M') AND MR.USER_ID = ? AND MR.JOURNAL_ID = ?";
		if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
		sql += removableIdsClause.toString();
		String countSql = sql.replace("SELECT DISTINCT MR.MANUSCRIPT_ID", "SELECT COUNT(MR.MANUSCRIPT_ID)");
		iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId}, Integer.class);
		sql += orderClause.toString();
		sql += limitClause.toString();
		reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, reviewManuscriptRowMapper);
		
		return reviews;
		
	}*/
	
	@Override
	public List<Review> findDismissedReviews(int userId, int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<Review> reviews = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		StringBuffer likeClause = new StringBuffer();
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (M.TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR M.SUBMIT_ID like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer();
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null) {
        			if(sortableColumnName.equals("MR.EVENT_DATE"))
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
        
		StringBuffer limitClause = new StringBuffer();
		if(!orderByDate && dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		if(journalId == 0) {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND (MR.STATUS = 'M' or MR.STATUS = 'T')";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND (MR.STATUS = 'M' or MR.STATUS = 'T')";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId}, reviewRowMapper);
			
			return reviews;
		} else {
			String sql = "SELECT * FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND (MR.STATUS = 'M' or MR.STATUS = 'T')";
			if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
			String countSql = "SELECT COUNT(MR.ID) FROM MANUSCRIPTS_REVIEW MR JOIN MANUSCRIPTS M ON MR.MANUSCRIPT_ID = M.ID WHERE MR.USER_ID = ? AND MR.JOURNAL_ID = ? AND (MR.STATUS = 'M' or MR.STATUS = 'T')";
			iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId, journalId}, Integer.class);
			sql += orderClause.toString();
			sql += limitClause.toString();
			reviews = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, reviewRowMapper);
			
			return reviews;
		}
		
	}
	
	@Override
	public void update(Review review) {
		this.getJdbcTemplate().update("UPDATE MANUSCRIPTS_REVIEW SET " +
				"USER_ID = ?," +
				"MANUSCRIPT_ID = ?," +
				"JOURNAL_ID = ?," +
				"SCORE1 = ?," +
				"SCORE2 = ?," +
				"SCORE3 = ?," +
				"SCORE4 = ?," +
				"SCORE5 = ?," +
				"SCORE6 = ?," +
				"SCORE7 = ?," +
				"SCORE8 = ?," +
				"SCORE9 = ?," +
				"SCORE10 = ?," +
				
				"REVIEW_ITEM_ID1 = ?," +
				"REVIEW_ITEM_ID2 = ?," +
				"REVIEW_ITEM_ID3 = ?," +
				"REVIEW_ITEM_ID4 = ?," +
				"REVIEW_ITEM_ID5 = ?," +
				"REVIEW_ITEM_ID6 = ?," +
				"REVIEW_ITEM_ID7 = ?," +
				"REVIEW_ITEM_ID8 = ?," +
				"REVIEW_ITEM_ID9 = ?," +
				"REVIEW_ITEM_ID10 = ?," +
				"NUMBER_OF_REVIEW_ITEMS = ?," +
				
				"OVERALL = ?," +
				"RE_REVIEW = ?," +
				"CONFIRM = ?," +
				"CREATED_MEMBER = ?," +
				"TEMP_PW = ?," +
				"REVISION_COUNT = ?," +
				"STATUS = ?, " +
				"FIRST_STATUS = ?, " +
				"DUE_DATE = ?, " +
				"DUE_TIME = '23:59:59' " +
				"WHERE ID = ?", new Object[]{review.getUserId(), review.getManuscriptId(), review.getJournalId(), review.getScore1(), review.getScore2(), review.getScore3(),
				review.getScore4(), review.getScore5(), review.getScore6(), review.getScore7(), review.getScore8(), review.getScore9(), review.getScore10(),
				review.getReviewItemId1(), review.getReviewItemId2(), review.getReviewItemId3(), review.getReviewItemId4(), review.getReviewItemId5(), review.getReviewItemId6(), 
				review.getReviewItemId7(), review.getReviewItemId8(), review.getReviewItemId9(), review.getReviewItemId10(), review.getNumberOfReviewItems(), 
				review.getOverall(), review.getReReview(), review.isConfirm(), review.isCreatedMember(), review.getTempPw(), review.getRevisionCount(), review.getStatus(),
				review.getFirstStatus(), review.getDueDate(), review.getId()});
	}
	
	@Override
	public void delete(int id) {
		this.getJdbcTemplate().update("DELETE FROM MANUSCRIPTS_REVIEW WHERE ID = ?", id);
	}
	
	@Override
	public void updateInviteExpirationDate(int reviewId, int day) {
		this.getJdbcTemplate().update("UPDATE MANUSCRIPTS_REVIEW SET INVITE_EXPIRATION_DATE = UTC_DATE() WHERE ID = ?", reviewId);	//7
		String sql = "UPDATE MANUSCRIPTS_REVIEW SET INVITE_EXPIRATION_DATE = DATE_ADD(INVITE_EXPIRATION_DATE, INTERVAL " + day + " DAY) WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] { reviewId});	
	}

}
