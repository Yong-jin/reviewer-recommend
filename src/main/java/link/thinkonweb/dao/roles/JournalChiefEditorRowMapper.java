package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.ChiefEditor;

public class JournalChiefEditorRowMapper extends JournalRoleRowMapper<ChiefEditor> {
	public JournalChiefEditorRowMapper() {
	}
	
	@Override
	public ChiefEditor instantiateEntityClass(final ResultSet rs, final int rowNum) throws SQLException {
		return new ChiefEditor();
	}
}