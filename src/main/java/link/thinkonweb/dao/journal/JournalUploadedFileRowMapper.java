package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.JournalUploadedFile;

import org.springframework.jdbc.core.RowMapper;



public class JournalUploadedFileRowMapper implements RowMapper<JournalUploadedFile> {
	@Override
	public JournalUploadedFile mapRow(ResultSet rs, int rowNum) throws SQLException {
		JournalUploadedFile uf = new JournalUploadedFile();
		uf.setId(rs.getInt("ID"));
		uf.setAbsolutePath(rs.getString("ABSOLUTE_PATH"));
		uf.setDate(rs.getDate("DATE"));
		uf.setTime(rs.getTime("TIME"));
		uf.setDesignation(rs.getString("DESIGNATION"));
		uf.setName(rs.getString("NAME"));
		uf.setOriginalName(rs.getString("ORIGINAL_NAME"));
		uf.setPath(rs.getString("PATH"));
		//uf.setRole(rs.getString("ROLE"));
		uf.setUserId(rs.getInt("USER_ID"));
		uf.setJournalId(rs.getInt("JOURNAL_ID"));
		return uf;
	}

}
