package link.thinkonweb.dao.journal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.util.DataTableClientRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class SpecialIssueDaoImpl extends NamedParameterJdbcDaoSupport implements SpecialIssueDao {
	@Autowired
	private SpecialIssueRowMapper specialIssueRowMapper;
	public int insert(SpecialIssue specialIssue) {
		String sql = "INSERT INTO SPECIAL_ISSUES (JOURNAL_ID, TITLE, DESCRIPTION, SUBMIT_DUE_DATE, SUBMIT_DUE_TIME, CREATE_DATE, CREATE_TIME, STATUS, GE_USER_ID) " +
				"VALUES (:journalId, :title, :description, :submissionDueDate, '23:59:59', UTC_DATE(), UTC_TIME(), :status, :guestEditorUserId)";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(specialIssue);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public SpecialIssue findById(int id) {
		String sql = "SELECT * FROM SPECIAL_ISSUES WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, specialIssueRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(SpecialIssue specialIssue) {
		String sql = "UPDATE SPECIAL_ISSUES SET JOURNAL_ID = ?, TITLE = ?, DESCRIPTION = ?, STATUS = ?, GE_USER_ID = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {specialIssue.getJournalId(), specialIssue.getTitle(), specialIssue.getDescription(), specialIssue.getStatus(), specialIssue.getGuestEditorUserId(), specialIssue.getId()});			
	}
	
	@Override
	public void delete(int id) {
		try {
			String sql = "DELETE FROM SPECIAL_ISSUES WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {id});
		} catch(Exception e) {
			System.out.println("deleting error at special issue dao");
		}
	}
	@Override
	public List<SpecialIssue> findByJournalId(int journalId) {
		String sql = "SELECT * FROM SPECIAL_ISSUES WHERE JOURNAL_ID = ?";
		List<SpecialIssue> list = this.getJdbcTemplate().query(sql, new Object[] {journalId}, specialIssueRowMapper);	
		return list;
	}

	@Override
	public List<SpecialIssue> findByJournalId(int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<SpecialIssue> specialIssues = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		
		StringBuffer likeClause = new StringBuffer("");
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" AND");
			likeClause.append(" (TITLE LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR DESCRIPTION like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		boolean orderByDate = false;
		StringBuffer orderClause = new StringBuffer("");
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		orderClauseStrings.put(sortableColumnName, dRequest.getsSortDir()[i]);
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
		String sql = "SELECT * FROM SPECIAL_ISSUES WHERE JOURNAL_ID = ?";
		sql += likeClause.toString();
		String countSql = sql.replace("*", "COUNT(ID)");
		iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {journalId}, Integer.class);	
		sql += orderClause.toString();
		sql += limitClause.toString();
		specialIssues = this.getJdbcTemplate().query(sql, new Object[] {journalId}, specialIssueRowMapper);
		return specialIssues;
	}

	@Override
	public List<SpecialIssue> findAll() {
		String sql = "SELECT * FROM SPECIAL_ISSUES";
		List<SpecialIssue> list = this.getJdbcTemplate().query(sql, specialIssueRowMapper);	
		return list;
	}
}