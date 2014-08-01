package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.UserDivision;


public interface UserDivisionDao {
	public int insert(UserDivision userDivision);
	public int insertAndReturningKey(UserDivision userDivision);
	public UserDivision findById(int id);
	public void update(UserDivision userDivision);
	public void delete(int userDivisionId);
	public void delete(int userId, int journalId, int divisionId, String role);
	public List<UserDivision> findUserDivisions(int userId, int journalId, String role);
	public UserDivision create(int userId, int journalId, int divisionId, String role);
}
