package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.ManuscriptAbstract;

import org.springframework.jdbc.core.RowMapper;



public class AbstractRowMapper implements RowMapper<ManuscriptAbstract> {
	@Override
	public ManuscriptAbstract mapRow(ResultSet rs, int rowNum) throws SQLException {
		ManuscriptAbstract ma = new ManuscriptAbstract();
		ma.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		ma.setPaperAbstract(rs.getString("PAPER_ABSTRACT"));
		ma.setRevisionCount(rs.getInt("REVISION_COUNT"));
		return ma;
	}

}
