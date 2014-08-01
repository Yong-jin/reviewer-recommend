package link.thinkonweb.dao.email;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import link.thinkonweb.domain.email.EmailDelivery;
import link.thinkonweb.util.DataTableClientRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;


public class EmailDeliveryDaoImpl extends NamedParameterJdbcDaoSupport implements EmailDeliveryDao {
	@Autowired
	private EmailDeliveryRowMapper emailRowMapper;
	@Autowired
	private EmailDeliveryEmailMessageRowMapper feedRowMapper;
	
	public void setEmmailRowMapper(EmailDeliveryRowMapper emailRowMapper) {
		this.emailRowMapper = emailRowMapper;
	}
	
	@Override
	public void insert(final EmailDelivery emailDelivery) {
		String sql = "INSERT INTO EMAIL_DELIVERY (SENDER_USER_ID, RECEIVER_USER_ID, DATE, TIME, JOURNAL_ID, MANUSCRIPT_ID, MESSAGE_ID, IS_CC) VALUES (:sender, :receiver, UTC_DATE(), UTC_TIME(), :journalId, :manuscriptId, :messageId, :isCc)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("sender", emailDelivery.getSenderUserId());
		argMap.put("receiver", emailDelivery.getReceiverUserId());
		argMap.put("journalId", emailDelivery.getJournalId());
		argMap.put("manuscriptId", emailDelivery.getManuscriptId());
		argMap.put("messageId", emailDelivery.getMessageId());
		argMap.put("isCc", emailDelivery.isCc());
		this.getNamedParameterJdbcTemplate().update(sql, argMap);
	}

	@Override
	public void update(final EmailDelivery emailDelivery) {
		String sql = "UPDATE EMAIL_DELIVERY SET SENDER_USER_ID = ?, RECEIVER_USER_ID = ?, JOURNAL_ID = ?, MANUSCRIPT_ID = ?, MESSAGE_ID = ? IS_CC = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {
												emailDelivery.getSenderUserId(), 
												emailDelivery.getReceiverUserId(),
												emailDelivery.getJournalId(),
												emailDelivery.getManuscriptId(),
												emailDelivery.getMessageId(),
												emailDelivery.isCc(),
												emailDelivery.getId()});	
	}

	@Override
	public void delete(final EmailDelivery emailDelivery) {
		String sql = "DELETE EMAIL_DELIVERY WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {emailDelivery.getId()});
	}

	@Override
	public List<EmailDelivery> findEmails(int userId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames) {
		List<EmailDelivery> emails = null;
		String sGlobalTerm = dRequest.getsSearchGlobal();
		
		StringBuffer likeClause = new StringBuffer("");
		if (sGlobalTerm != null && !sGlobalTerm.equals("")) {
			likeClause.append(" (EM.SUBJECT LIKE '%").append(sGlobalTerm);
			likeClause.append("%' OR EM.BODY like '%").append(sGlobalTerm);
			likeClause.append("%')");
		}

		StringBuffer orderClause = new StringBuffer("");
		Map<String, String> orderClauseStrings = new HashMap<String, String>();
        if (dRequest.getiSortingCols() != 0) {
        	for(int i=0; i<dRequest.getiSortingCols(); i++) {
        		String sortableColumnName = sortableColumnNames.get(dRequest.getiSortCol()[i]);
        		if(sortableColumnName != null)
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
		if(dRequest.getiDisplayLength() != -1) {
			limitClause.append(" LIMIT ");
			limitClause.append(dRequest.getiDisplayStart());
			limitClause.append(" , ");
			limitClause.append(dRequest.getiDisplayLength());
		}
		String sql = "SELECT * FROM EMAIL_DELIVERY ED JOIN EMAIL_MESSAGES EM ON ED.MESSAGE_ID = EM.ID WHERE ED.RECEIVER_USER_ID = ?";
		if(likeClause.length() > 0) sql += " AND " + likeClause.toString();
		String countSql = sql.replace("*", "COUNT(ED.ID)");
		iTotalDisplayRecordsPlaceHolder[0] = this.getJdbcTemplate().queryForObject(countSql, new Object[] {userId}, Integer.class);	
		sql += orderClause.toString();
		sql += limitClause.toString();
		emails = this.getJdbcTemplate().query(sql, new Object[] {userId}, feedRowMapper);
		return emails;

	}
	
	@Override
	public int numEmails(int userId) {
		int count = 0;
		try {
		String sql = "SELECT COUNT(ED.ID) FROM EMAIL_DELIVERY ED JOIN EMAIL_MESSAGES EM ON ED.MESSAGE_ID = EM.ID WHERE ED.RECEIVER_USER_ID = ?";
			count = this.getJdbcTemplate().queryForObject(sql, new Object[] {userId}, Integer.class);	
		} catch(EmptyResultDataAccessException e) {
			return 0;
		}
		return count;
	}

	@Override
	public EmailDelivery findById(int id) {
		try {
			String sql = "SELECT * FROM EMAIL_DELIVERY ED JOIN EMAIL_MESSAGES EM ON ED.MESSAGE_ID = EM.ID WHERE ED.ID = ?";
			EmailDelivery ed = this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, feedRowMapper);	
			return ed;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
}
