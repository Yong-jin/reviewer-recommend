package link.thinkonweb.service.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import link.thinkonweb.dao.user.UserExpertiseDao;
import link.thinkonweb.domain.user.UserExpertise;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class UserExpertiseServiceImpl implements UserExpertiseService {
	@Inject
	private UserExpertiseDao userExpertiseDao;
	@Inject
	private ObjectMapper objectMapper;

	@Override
	public void insertExpertise(UserExpertise ue) {
		this.userExpertiseDao.insertExpertise(ue);
	}


	@Override
	public void deleteExpertise(UserExpertise ue) {
		this.userExpertiseDao.deleteExpertise(ue);
	}
	
	@Override
	public void deleteAllExpertises(int userId) {
		this.userExpertiseDao.deleteAllExpertises(userId);
	}
	
	@Override
	public UserExpertise getExpertise(int userId, String expertise) {
		return this.userExpertiseDao.findExpertise(userId, expertise);
	}

	@Override
	public List<UserExpertise> getExpertises(int userId) {
		return this.userExpertiseDao.findExpertises(userId);
	}
	
	@Override
	public String getExpertisesAsJSONString(int userId) {
		List<UserExpertise> ueList = this.userExpertiseDao.findExpertises(userId);
		List<String> ueStringList = new ArrayList<String>();
		for(UserExpertise ue: ueList)
			ueStringList.add(ue.getExpertise());
		
		String jsonString = null;
		try {
			jsonString = objectMapper.writeValueAsString(ueStringList);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonString;
	}
	
	@Override
	public String getAllUniqueExpertisesAsJSONString() {
		List<String> ueList = this.userExpertiseDao.findAllUniqueExpertisesAsStringList();
		
		String jsonString = null;
		try {
			jsonString = objectMapper.writeValueAsString(ueList);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonString;
	}
	
	@Override
	public String getAllUniqueExpertisesAsJSONStringByQuery(String query) {
		List<String> ueList = this.userExpertiseDao.findAllUniqueExpertisesAsStringListByQuery(query);
		
		String jsonString = null;
		try {
			jsonString = objectMapper.writeValueAsString(ueList);
			//System.out.println(jsonString);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonString;
	}
	
	@Override
	public boolean hasUserExpertise(int userId, String expertise) {
		return this.userExpertiseDao.hasUserExpertise(userId, expertise);
	}
}