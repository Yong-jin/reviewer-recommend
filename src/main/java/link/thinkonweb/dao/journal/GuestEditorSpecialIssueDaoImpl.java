package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class GuestEditorSpecialIssueDaoImpl extends NamedParameterJdbcDaoSupport implements GuestEditorSpecialIssueDao {
	@Inject
	private GuestEditorSpecialIssueRowMapper geSpecialIssueRowMapper;
	@Inject
	private SpecialIssueDao specialIssueDao;
	@Inject
	private GuestEditorSpecialIssueSpecialIssueRowMapper geSiSiRowMapper;

	@Override
	public int insert(GuestEditorSpecialIssue geSpecialIssue) {
		String sql = "INSERT INTO GUEST_EDITORS_SPECIAL_ISSUES (JOURNAL_ID, USER_ID, SPECIAL_ISSUE_ID) " +
				"values (:journalId, :userId, :specialIssueId)";		
		SqlParameterSource paramSource = new BeanPropertySqlParameterSource(geSpecialIssue);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, paramSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public GuestEditorSpecialIssue findById(int id) {
		String sql = "SELECT * FROM GUEST_EDITORS_SPECIAL_ISSUES WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, geSpecialIssueRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(GuestEditorSpecialIssue geSpecialIssue) {
		String sql = "UPDATE GUEST_EDITORS_SPECIAL_ISSUES SET ID = ?, JOURNAL_ID = ?, USER_ID = ?, SPECIAL_ISSUE_ID = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {geSpecialIssue.getId(), geSpecialIssue.getJournalId(), geSpecialIssue.getUserId(), geSpecialIssue.getSpecialIssueId(), geSpecialIssue.getId()});	
		
	}

	@Override
	public void delete(int geSpecialIssueId) {
		try {
			String sql = "DELETE FROM GUEST_EDITORS_SPECIAL_ISSUES WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {geSpecialIssueId});
		} catch(Exception e) {
			System.out.println("deleting error");
		}
	}

	@Override
	public void delete(int geUserId, int journalId, int specialIssueId) {
		try {
			String sql = "DELETE FROM GUEST_EDITORS_SPECIAL_ISSUES WHERE USER_ID = ? AND JOURNAL_ID = ? AND SPECIAL_ISSUE_ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {geUserId, journalId, specialIssueId}, geSpecialIssueRowMapper);
		} catch(Exception e) {
			System.out.println("deleting error");
		}
		
	}

	@Override
	public List<GuestEditorSpecialIssue> findGeSpecialIssue(int userId,
			int journalId) {

		if(userId == 0 && journalId == 0) {
			try {
				String sql = "SELECT * FROM  GUEST_EDITORS_SPECIAL_ISSUES";
				List<GuestEditorSpecialIssue> list = this.getJdbcTemplate().query(sql, geSpecialIssueRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		} else if(userId == 0) {
			try {
				String sql = "SELECT * FROM GUEST_EDITORS_SPECIAL_ISSUES GS JOIN SPECIAL_ISSUES SI ON GS.SPECIAL_ISSUE_ID = SI.ID WHERE GS.JOURNAL_ID = ?";
				List<GuestEditorSpecialIssue> list = this.getJdbcTemplate().query(sql, new Object[] {journalId}, geSiSiRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		} else if(journalId == 0) {
			try {
				String sql = "SELECT * FROM GUEST_EDITORS_SPECIAL_ISSUES GS JOIN SPECIAL_ISSUES SI ON GS.SPECIAL_ISSUE_ID = SI.ID WHERE GS.USER_ID = ?";
				List<GuestEditorSpecialIssue> list = this.getJdbcTemplate().query(sql, new Object[] {userId}, geSiSiRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		} else {
			try {
				String sql = "SELECT * FROM GUEST_EDITORS_SPECIAL_ISSUES GS JOIN SPECIAL_ISSUES SI ON GS.SPECIAL_ISSUE_ID = SI.ID WHERE GS.USER_ID = ? AND GS.JOURNAL_ID = ?";
				List<GuestEditorSpecialIssue> list = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, geSiSiRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		}
	}

	@Override
	public GuestEditorSpecialIssue create(int userId, int journalId,
			int specialIssueId) {
		GuestEditorSpecialIssue guestEditorSpecialIssue = new GuestEditorSpecialIssue();
		guestEditorSpecialIssue.setUserId(userId);
		guestEditorSpecialIssue.setJournalId(journalId);
		guestEditorSpecialIssue.setSpecialIssueId(specialIssueId);
		guestEditorSpecialIssue.setSpecialIssue(specialIssueDao.findById(specialIssueId));
		int id = this.insert(guestEditorSpecialIssue);
		guestEditorSpecialIssue.setId(id);
		return guestEditorSpecialIssue;
	}
	

}
