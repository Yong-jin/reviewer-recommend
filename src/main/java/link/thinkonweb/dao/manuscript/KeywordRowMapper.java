package link.thinkonweb.dao.manuscript;
import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.Keyword;

import org.springframework.jdbc.core.RowMapper;

public class KeywordRowMapper implements RowMapper<Keyword> {
	
	@Override
	public Keyword mapRow(ResultSet rs, int rowNum) throws SQLException {
		Keyword mk = new Keyword();
		mk.setId(rs.getInt("ID"));
		mk.setKeyword(rs.getString("KEYWORD"));
		mk.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		mk.setJournalId(rs.getInt("JOURNAL_ID"));
		mk.setUserId(rs.getInt("USER_ID"));
		mk.setRevisionCount(rs.getInt("REVISION_COUNT"));
		return mk;
	}
}
