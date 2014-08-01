package link.thinkonweb.service.user;

import java.util.List;

import link.thinkonweb.domain.user.UserExpertise;

public interface UserExpertiseService {
	public void insertExpertise(UserExpertise ue);
	public void deleteExpertise(UserExpertise ue);
	public void deleteAllExpertises(int userId);
	public UserExpertise getExpertise(int userId, String expertise);
	public List<UserExpertise> getExpertises(int userId);
	public String getExpertisesAsJSONString(int userId);
	public String getAllUniqueExpertisesAsJSONString();
	public String getAllUniqueExpertisesAsJSONStringByQuery(String query);
	public boolean hasUserExpertise(int userId, String expertise);
}
