package link.thinkonweb.dao.user;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.util.DataTableClientRequest;

public interface UserDao {
	public int create(SystemUser user);
	public void delete(SystemUser user);
	public SystemUser findById(int id);
	public SystemUser findByUsername(String username);
	public List<SystemUser> findUsers(int userId, int journalId, String role);
	public List<SystemUser> findByUsernameLike(String filterString);
	public List<SystemUser> findAll();
	public List<SystemUser> findUsersByParams(List<String> emailList, List<String> emailPreventList, Map<String, String> contactAcceptParams, Map<String, String> contactPreventParams);
	public List<SystemUser> findManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId);
	public List<SystemUser> findEditorCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, List<String> preventEmailList);
	public List<SystemUser> findReviewerCandidateUsers(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, Locale locale, int journalId, int member, int manuscriptId, List<String> preventEmailList);
	public List<SystemUser> findByCustomSql(String sql);
	public List<SystemUser> findSuperManagerRoleList(int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
	public List<SystemUser> findSuperManagerAccountList(DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder);
	public int getNumOfRecordsByCustomSql(String sql);
	
	public void changeEnabled(boolean isEnabled, int userId);
	public void changeUsername(String newUsername, int userId);
	public void changePassword(String newPassword, int userId);
	public void update(SystemUser user);
}
