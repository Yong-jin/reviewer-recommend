package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.UploadedFile;

import org.springframework.jdbc.core.RowMapper;



public class UploadedFileRowMapper implements RowMapper<UploadedFile> {
	@Override
	public UploadedFile mapRow(ResultSet rs, int rowNum) throws SQLException {
		UploadedFile uf = new UploadedFile();
		uf.setId(rs.getInt("ID"));
		uf.setAbsolutePath(rs.getString("ABSOLUTE_PATH"));
		uf.setCameraReadyRevision(rs.getInt("CAMERA_READY_REVISION"));
		uf.setConfirm(rs.getBoolean("CONFIRM"));
		uf.setDate(rs.getDate("DATE"));
		uf.setTime(rs.getTime("TIME"));
		uf.setDesignation(rs.getString("DESIGNATION"));
		uf.setGalleryProofRevision(rs.getInt("GALLERY_PROOF_REVISION"));
		uf.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		uf.setName(rs.getString("NAME"));
		uf.setOriginalName(rs.getString("ORIGINAL_NAME"));
		uf.setPath(rs.getString("PATH"));
		uf.setRevisionCount(rs.getInt("REVISION_COUNT"));
		//uf.setRole(rs.getString("ROLE"));
		uf.setUserId(rs.getInt("USER_ID"));
		return uf;
	}

}
