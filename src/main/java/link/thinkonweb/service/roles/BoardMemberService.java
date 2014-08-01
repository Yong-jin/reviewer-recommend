package link.thinkonweb.service.roles;

import java.util.List;

import link.thinkonweb.domain.roles.BoardMember;

public interface BoardMemberService {
	public void createBoardMember(BoardMember bm);
	public List<BoardMember> getBoardMembersByJournalId(int journalId);
	public void selectBoardMember(int userId, int journalId);
	public void deleteBoardMember(int userId, int journalId);
	public String getDivisionString(int userId, int journalId);
}
