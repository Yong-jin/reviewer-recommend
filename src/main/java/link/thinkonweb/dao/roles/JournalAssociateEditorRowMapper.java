package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.AssociateEditor;

public class JournalAssociateEditorRowMapper extends JournalRoleRowMapper<AssociateEditor> {
	public JournalAssociateEditorRowMapper() {
	}
	
	@Override
	public AssociateEditor instantiateEntityClass(final ResultSet rs, final int rowNum)  throws SQLException {
		return new AssociateEditor();
	}
}