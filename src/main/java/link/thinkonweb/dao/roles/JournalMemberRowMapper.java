package link.thinkonweb.dao.roles;

import java.sql.ResultSet;

import link.thinkonweb.domain.roles.Member;

public class JournalMemberRowMapper extends JournalRoleRowMapper<Member> {
	public JournalMemberRowMapper() {
	}
	
	@Override
	public Member instantiateEntityClass(final ResultSet rs, final int rowNum) {
		return new Member();
	}
}