package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.JournalCategory;

import org.springframework.jdbc.core.RowMapper;

public class JournalCategoryRowMapper implements RowMapper<JournalCategory> {
	
	@Override
	public JournalCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
		JournalCategory jc = new JournalCategory();
		jc.setId(rs.getInt("ID"));
		jc.setJournalId(rs.getInt("JOURNAL_ID"));
		jc.setName(rs.getString("NAME"));
		return jc;
	}
}
