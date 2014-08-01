package link.thinkonweb.service.user;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;

public interface AuthorityService {
	public void 			create(int userId, int journalId, String role);
	public void 			create(int userId, int journalId, String role, Object roleType);
	//public void 			delete(int userId, int journalId, String role);
	public void 			delete(Authority authority);
	public void 			update(Authority authority);
	
	public Authority 		getById(int id);
	
	public List<Authority> 	getAuthorities(int userId, int journalId, String role);
	public Authority 		getAuthority(int userId, int journalId, String role);
	
	// 현재 로그인된 사용자에 대해 주어진 Role이 있는지 판단
	public boolean hasRole(String role);
	
	// 현재 로그인된 사용자에 대해 주어진 journal에 해당 Role이 있는지 판단 
	public boolean hasRole(String role, int journalId);
	
	//주어진 user가 주어진 role을 지니고 있는지 판단
	public boolean hasRole(SystemUser user, String role);
	
	// 주어진 user에 대해 주어진 journal에 해당 Role이 있는지 판단 
	public boolean hasRole(SystemUser user, int journalId, String role);
	
	// 현재 로그인된 사용자에 대한 UserDetails 객체를 얻어옴
	public UserDetails getUserDetails();
	
	//사용자 user에 대해 현재 설정된 Role을 Context (Session)에 설정
	public void authenticateUserAndSetSession(SystemUser user);
	public Collection<GrantedAuthority> getGrantedAuthorities(String username);
	
	public void changeRole(int userId, String jnid, String role, String action);
	public void changeRole(int userId, int jid, String role, String action);
}
