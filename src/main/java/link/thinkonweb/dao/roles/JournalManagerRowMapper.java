package link.thinkonweb.dao.roles;

import java.sql.ResultSet;

import link.thinkonweb.domain.roles.Manager;

public class JournalManagerRowMapper extends JournalRoleRowMapper<Manager> {
	public JournalManagerRowMapper() {
	}
	
	@Override
	public Manager instantiateEntityClass(final ResultSet rs, final int rowNum) {
		return new Manager();
	}
}