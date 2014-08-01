package link.thinkonweb.dao.roles;

import java.sql.ResultSet;

import link.thinkonweb.domain.roles.GuestEditor;

public class JournalGuestEditorRowMapper extends JournalRoleRowMapper<GuestEditor> {
	public JournalGuestEditorRowMapper() {
	}
	
	@Override
	public GuestEditor instantiateEntityClass(final ResultSet rs, final int rowNum) {
		return new GuestEditor();
	}
}