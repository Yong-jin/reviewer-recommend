package link.thinkonweb.dao.manuscript;

import java.util.ArrayList;
import java.util.List;

import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.ReviewEventDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class ReviewEventDateTimeDaoImpl extends NamedParameterJdbcDaoSupport implements ReviewEventDateTimeDao {
	@Autowired
	private ReviewEventDateTimeRowMapper reviewEventDateTimeRowMapper;
	
	public void setEventDateRowMapper(ReviewEventDateTimeRowMapper reviewEventDateTimeRowMapper) {
		this.reviewEventDateTimeRowMapper = reviewEventDateTimeRowMapper;
	}

	@Override
	public void insert(ReviewEventDateTime reviewEventDateTime) {
		String sql = "INSERT INTO MANUSCRIPTS_REVIEW_EVENT_DATE (MANUSCRIPT_ID, USER_ID, JOURNAL_ID, REVISION_COUNT, STATUS, EVENT_DATE, EVENT_TIME) " +
				 "VALUES (:manuscriptId, :userId, :journalId, :revisionCount, :status, UTC_DATE(), UTC_TIME())";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(reviewEventDateTime);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
		
	}
	
	@Override
	public ReviewEventDateTime findReviewEventDateTimeById(int id) {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, reviewEventDateTimeRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<ReviewEventDateTime> findReviewEventDateTimesByManuscriptId(int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE MANUSCRIPT_ID = ?";
		List<ReviewEventDateTime> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, reviewEventDateTimeRowMapper);	
		return list;
	}
	
	@Override
	public List<ReviewEventDateTime> findReviewEventDateTimes(int userId, int manuscriptId, int journalId, int revisionCount) {
		StringBuffer revisionClause = new StringBuffer();
		if(revisionCount != -1) {
			revisionClause.append(" AND ");
			revisionClause.append("REVISION_COUNT = ");
			revisionClause.append(revisionCount);
		}
		if(userId == 0) {
			if (manuscriptId == 0 && journalId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else if (manuscriptId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE JOURNAL_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {journalId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else if (journalId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE MANUSCRIPT_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {manuscriptId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE MANUSCRIPT_ID = ? AND JOURNAL_ID = ?";
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {manuscriptId, journalId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			}
		} else {
			if (manuscriptId == 0 && journalId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE USER_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {userId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else if (manuscriptId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE USER_ID = ? AND JOURNAL_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {userId, journalId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else if (journalId == 0) {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE USER_ID = ? AND MANUSCRIPT_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {userId, manuscriptId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			} else {
				String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE USER_ID = ? AND MANUSCRIPT_ID = ? AND JOURNAL_ID = ?";
				
				try {
					return this.getJdbcTemplate().query(sql + revisionClause.toString(), new Object[] {userId, manuscriptId, journalId}, reviewEventDateTimeRowMapper);	
				} catch(EmptyResultDataAccessException e) {
					e.printStackTrace();
					return null;
				}
			}
		}
	}
	
	@Override
	public int findLastReviewEventDateTimeId(int userId, int manuscriptId, String status) {
		String sql = "SELECT max(ID) FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE MANUSCRIPT_ID = ? and STATUS = ?";
		try {
			int id = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, status}, Integer.class);	
			return id;
		} catch(EmptyResultDataAccessException e) {
			return 0;
		}
	}

	@Override
	public void update(ReviewEventDateTime reviewEventDateTime) {
		String sql = "UPDATE MANUSCRIPTS_REVIEW_EVENT_DATE SET MANUSCRIPT_ID = ?, USER_ID = ?, JOURNAL_ID = ?, REVISION_COUNT = ?, STATUS = ?, WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {reviewEventDateTime.getManuscriptId(), reviewEventDateTime.getUserId(), reviewEventDateTime.getJournalId(), reviewEventDateTime.getRevisionCount(), reviewEventDateTime.getStatus(), reviewEventDateTime.getId()});	
	}

	@Override
	public void delete(ReviewEventDateTime reviewEventDateTime) {
		String sql = "DELETE FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {reviewEventDateTime.getId()});
		
	}
	@Override
	public int numReviewsBeforeSpecificDays(int userId, int days) {
		String sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE user_id=? and status = 'C' and event_date > date_add(UTC_DATE(), INTERVAL ? day)";
		List<ReviewEventDateTime> completed = this.getJdbcTemplate().query(sql, new Object[] {userId, days}, reviewEventDateTimeRowMapper);	
		sql = "SELECT * FROM MANUSCRIPTS_REVIEW_EVENT_DATE WHERE user_id=? and status = 'A' and event_date > date_add(UTC_DATE(), INTERVAL ? day)";
		List<ReviewEventDateTime> assigned = this.getJdbcTemplate().query(sql, new Object[] {userId, days}, reviewEventDateTimeRowMapper);	
		
		List<Integer> numReview = new ArrayList<Integer>(); //null;
		for(ReviewEventDateTime r: completed) {
			numReview.add(r.getManuscriptId());
		}
		for(ReviewEventDateTime r: assigned) {
			if( !(numReview.contains(r.getManuscriptId())) )
				numReview.add(r.getManuscriptId());
		}
		
		return numReview.size();
	}
}
