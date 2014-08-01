package link.thinkonweb.service.user;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;

public interface UserService {
	public void create(SystemUser user);
	public void createWithoutLogin(SystemUser user);
	public void delete(SystemUser user);
	public void update(SystemUser user);
	
	public SystemUser getById(int id);
	public SystemUser getByUsername(String username);
	public List<SystemUser> getByUsernameLike(String filterString);
	public List<SystemUser> getAll();
	
	public List<SystemUser> getUsers(int userId, int journalId, String role);
	public boolean isUniqueUsername(String username);
	public List<SystemUser> getSuperManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
	public List<SystemUser> getSuperManagerRoleList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
	public List<SystemUser> getEditorCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, List<String> preventEmailList);	
	public List<SystemUser> getReviewerCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, int member, int manuscriptId, List<String> preventEmailList);
	public List<SystemUser> getManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId);
	public void changeEnabled(boolean isEnabled, int userId);
	public void changeUsername(String newUsername, int userId);
	public void changePassword(String newPassword, int userId, String username);
	public void resetPassword(String username, HttpServletRequest request, Locale locale);
	public String generatePassword(int number);
}
