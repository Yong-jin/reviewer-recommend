package link.thinkonweb.dao.user;

import java.util.List;

import link.thinkonweb.domain.user.UserExpertise;

public interface UserExpertiseDao {
	public int insertExpertise(int userId, String expertise);
	public int insertExpertise(UserExpertise ue);
	public void deleteExpertise(UserExpertise ue);
	public void deleteAllExpertises(int userId);
	public UserExpertise findExpertise(int userId, String expertise);
	public List<String> findAllUniqueExpertisesAsStringList();
	public List<String> findAllUniqueExpertisesAsStringListByQuery(String query);
	public List<UserExpertise> findExpertises(int userId);
	public boolean hasUserExpertise(int userId, String expertise);
}