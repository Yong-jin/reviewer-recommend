package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.CoverLetter;

import org.springframework.jdbc.core.RowMapper;



public class CoverLetterRowMapper implements RowMapper<CoverLetter> {
	@Override
	public CoverLetter mapRow(ResultSet rs, int rowNum) throws SQLException {
		CoverLetter cl = new CoverLetter();
		cl.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		cl.setCoverLetter(rs.getString("COVERLETTER"));
		cl.setRevisionCount(rs.getInt("REVISION_COUNT"));
		return cl;
	}

}
