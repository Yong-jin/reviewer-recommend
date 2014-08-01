package link.thinkonweb.service.roles;

import java.util.Collections;
import java.util.List;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.journal.UserDivisionDao;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.UserDivision;
import link.thinkonweb.domain.roles.BoardMember;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;

public class BoardMemberServiceImpl implements BoardMemberService {
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserService userService;
	@Autowired
	private JournalService journalService;
	@Autowired
	private JournalRoleDao journalRoleDao;
	@Autowired
	private UserDivisionDao userDivisionDao;
	
	@Override
	public void createBoardMember(BoardMember bm) {
		Journal journal = journalService.getById(bm.getJournalId());
		SystemUser user = bm.getUser();
		userService.createWithoutLogin(user);
		SystemUser storedUser = userService.getByUsername(user.getUsername());
		List<UserDivision> userDivisions = bm.getUserDivisions();
		
		for(UserDivision u: userDivisions) {
			u.setUserId(storedUser.getId());
			userDivisionDao.insert(u);
		}
		authorityService.create(storedUser.getId(), journal.getId(), SystemConstants.roleBMember);
	}

	@Override
	public List<BoardMember> getBoardMembersByJournalId(int journalId) {
		List<BoardMember> bmAll = journalRoleDao.findJournalBoardMembers(0, journalId);
		for (BoardMember bm : bmAll) {
			SystemUser user = userService.getById(bm.getUserId());
			bm.setUser(user);
			List<UserDivision> userDivisions = userDivisionDao.findUserDivisions(bm.getUserId(), journalId, SystemConstants.roleBMember);
			if(userDivisions != null)
				Collections.sort(userDivisions);
			bm.setUserDivisions(userDivisions);
		}
		return bmAll;
	}

	@Override
	public void selectBoardMember(int userId, int journalId) {
		authorityService.create(userId, journalId, SystemConstants.roleBMember);
	}

	@Override
	public void deleteBoardMember(int userId, int journalId) {
		Authority authority = authorityService.getAuthority(userId, journalId, SystemConstants.roleBMember);
		authorityService.delete(authority);
	}

	@Override
	public String getDivisionString(int userId, int journalId) {
		List<UserDivision> userDivisions = userDivisionDao.findUserDivisions(userId, journalId, SystemConstants.roleBMember);
		if(userDivisions != null) {
			String divisionString = "";
			Collections.sort(userDivisions);
			int index = 0;
			for(UserDivision ud: userDivisions) {
				divisionString += ud.getDivision().getSymbol();
				index++;
				if(index < userDivisions.size())
					divisionString += ",";
			}
			return divisionString;
		} else
			return null;
	}
}
