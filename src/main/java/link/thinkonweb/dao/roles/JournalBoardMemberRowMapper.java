package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.BoardMember;

public class JournalBoardMemberRowMapper extends JournalRoleRowMapper<BoardMember> {
	public JournalBoardMemberRowMapper() {
	}
	
	@Override
	public BoardMember instantiateEntityClass(final ResultSet rs, final int rowNum) throws SQLException {
		return new BoardMember();
	}
}