package link.thinkonweb.dao.manuscript.form;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.form.Comment;

import org.springframework.jdbc.core.RowMapper;

public class CommentRowMapper implements RowMapper<Comment> {
	
	@Override
	public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
		Comment comment = new Comment();
		comment.setFromUserId(rs.getInt("FROM_USER_ID"));
		comment.setToUserId(rs.getInt("TO_USER_ID"));
		comment.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		comment.setJournalId(rs.getInt("JOURNAL_ID"));
		comment.setFromRole(rs.getString("FROM_ROLE"));
		comment.setToRole(rs.getString("TO_ROLE"));
		comment.setScopeManager(rs.getInt("SCOPE_MANAGER"));
		comment.setStatus(rs.getString("STATUS"));
		comment.setText(rs.getString("TEXT"));
		comment.setTextHtml(rs.getString("TEXT"));
		comment.setRevisionCount(rs.getInt("REVISION_COUNT"));
		comment.setDate(rs.getDate("DATE"));
		comment.setTime(rs.getTime("TIME"));
		comment.setCameraReadyRevision(rs.getInt("CAMERA_READY_REVISION"));
		comment.setGalleryProofRevision(rs.getInt("GALLERY_PROOF_REVISION"));
		return comment;
	}
}
