package link.thinkonweb.dao.manuscript.form;

import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.domain.manuscript.form.Comment;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;


public class CommentDaoImpl extends NamedParameterJdbcDaoSupport implements CommentDao {
	@Inject
	private CommentRowMapper commentRowMapper;

	@Override
	public void insert(Comment comment) {
		String sql = "INSERT INTO MANUSCRIPTS_COMMENTS (MANUSCRIPT_ID, FROM_USER_ID, TO_USER_ID, JOURNAL_ID, FROM_ROLE, TO_ROLE, SCOPE_MANAGER, STATUS, TEXT, REVISION_COUNT, DATE, TIME, CAMERA_READY_REVISION, GALLERY_PROOF_REVISION) " +
				 "VALUES (:manuscriptId, :fromUserId, :toUserId, :journalId, :fromRole, :toRole, :scopeManager, :status, :text, :revisionCount, UTC_DATE(), UTC_TIME(), :cameraReadyRevision, :galleryProofRevision)";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(comment);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}
	
	@Override
	public List<Comment> findRelatedComments(int manuscriptId, int userId, String role, boolean manager) {
		String scopeClause = "(FROM_USER_ID = ? OR TO_USER_ID = ?";
		if(manager)
			scopeClause += " OR SCOPE_MANAGER = 1)";
		else
			scopeClause += ")";
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE MANUSCRIPT_ID = ? AND " + scopeClause + " AND (FROM_ROLE = ? OR TO_ROLE = ?)";
			List<Comment> comments = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, userId, userId, role, role}, commentRowMapper);	
			return comments;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Comment> findAuthorComments(int manuscriptId, List<Integer> coAuthorIds) {
		StringBuffer usersClause = new StringBuffer();
		int index = 0;
		if(coAuthorIds != null && coAuthorIds.size() > 0) {
			usersClause.append(" AND (");
			for(Integer id: coAuthorIds) {
				usersClause.append("FROM_USER_ID = ");
				usersClause.append(id);
				usersClause.append(" OR ");
				usersClause.append("TO_USER_ID = ");
				usersClause.append(id);
				
				index++;
				if(index < coAuthorIds.size())
					usersClause.append(" OR ");
			}
			usersClause.append(")");
		}
		
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE MANUSCRIPT_ID = ?" + usersClause.toString() + " AND (FROM_ROLE = 'ROLE_MEMBER' OR TO_ROLE = 'ROLE_MEMBER' OR FROM_ROLE = 'ROLE_MANAGER' OR TO_ROLE = 'ROLE_MANAGER')";
			List<Comment> comments = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, commentRowMapper);	
			return comments;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Comment> findEditorialMessages(int manuscriptId, int userId, String role, boolean manager) {
		String scopeClause = "(FROM_USER_ID = ? OR TO_USER_ID = ?";
		if(manager)
			scopeClause += " OR SCOPE_MANAGER = 1)";
		else
			scopeClause += ")";
		try {
			String sql = null;
			if(role.equals(SystemConstants.roleManager))
				sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE MANUSCRIPT_ID = ? AND " + scopeClause + " AND (FROM_ROLE = ? OR TO_ROLE = ?) AND (FROM_ROLE != 'ROLE_REVIEWER' AND TO_ROLE != 'ROLE_REVIEWER')";
			else
				sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE MANUSCRIPT_ID = ? AND " + scopeClause + " AND (FROM_ROLE = ? OR TO_ROLE = ?) AND (FROM_ROLE != 'ROLE_REVIEWER' AND TO_ROLE != 'ROLE_REVIEWER' AND FROM_ROLE != 'ROLE_MEMBER' AND TO_ROLE != 'ROLE_MEMBER')";
			List<Comment> comments = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, userId, userId, role, role}, commentRowMapper);	
			return comments;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public Comment findComment(int fromUserId, int toUserId, String fromRole, String toRole, int manuscriptId, int revisionCount, String status) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE FROM_USER_ID = ? AND TO_USER_ID = ? AND FROM_ROLE = ? AND TO_ROLE = ? AND MANUSCRIPT_ID = ? AND REVISION_COUNT = ? AND STATUS = ?";
			Comment comment = this.getJdbcTemplate().queryForObject(sql, new Object[] {fromUserId, toUserId, fromRole, toRole, manuscriptId, revisionCount, status}, commentRowMapper);	
			return comment;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Comment> findByManuscriptId(int manuscriptId) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE MANUSCRIPT_ID = ?";
			return this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, commentRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Comment> findByScope(String scope) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COMMENTS WHERE SCOPE_" + scope + " = 1";
			List<Comment> comments = this.getJdbcTemplate().query(sql, commentRowMapper);	
			return comments;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public void update(Comment comment) {
		String sql = "UPDATE MANUSCRIPTS_COMMENTS SET MANUSCRIPT_ID = ?, FROM_USER_ID = ?, "
				+ "TO_USER_ID = ?, JOURNAL_ID = ?, FROM_ROLE = ?, TO_ROLE = ?, SCOPE_MANAGER = ?, "
				+ "STATUS = ?, TEXT = ?, REVISION_COUNT = ?, CAMERA_READY_REVISION = ?, GALLERY_PROOF_REVISION = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {comment.getManuscriptId(), comment.getFromUserId(), 
				comment.getToUserId(), comment.getJournalId(), comment.getFromRole(), comment.getToRole(), 
				comment.getScopeManager(), comment.getStatus(), comment.getText(), comment.getRevisionCount(), 
				comment.getCameraReadyRevision(), comment.getGalleryProofRevision(), comment.getId()});	
	}
}
