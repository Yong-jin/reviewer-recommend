package link.thinkonweb.service.user;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.roles.JournalRoleDao;
import link.thinkonweb.dao.user.AuthorityDao;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.roles.Member;
import link.thinkonweb.domain.user.Authority;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalService;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.UserDetailsManager;

public class AuthorityServiceImpl implements AuthorityService {
	@Inject
	private AuthorityDao authorityDao;
	@Inject
	private JournalRoleDao journalRoleDao;
	@Inject
	private UserDetailsManager userDetailsManager;
	@Inject
	private UserService userService;
	@Inject
	private JournalService journalService;

	@Override
	public void create(int userId, int journalId, String role) {
		if (role == null) {
			return;
		}
		if (role.equals(SystemConstants.roleUser) || role.equals(SystemConstants.roleSuperManager)) {
			if (this.getAuthority(userId, 0, role) == null) {
				this.authorityDao.create(userId, journalId, role);
			}
		} else {
			if (this.getAuthority(userId, journalId, role) == null) {
				System.out.println("authority " + role + " not exist");
				this.authorityDao.create(userId, journalId, role);
				Authority authority = this.authorityDao.findAuthority(userId, journalId, role);
				if (this.journalRoleDao.findSpecificJournalRole(userId, journalId, role) == null) {
					System.out.println("journal role  " + role + " not exist");
					this.journalRoleDao.create(userId, journalId, authority.getId(), role);
				}
			}
		}
	}
	
	@Override
	public void create(int userId, int journalId, String role, Object roleType) {
		if (role == null) {
			return;
		}
		if (role.equals(SystemConstants.roleUser) || role.equals(SystemConstants.roleSuperManager)) {
			if (this.getAuthority(userId, 0, role) == null) {
				this.authorityDao.create(userId, journalId, role);
			}
		} else {
			if (this.getAuthority(userId, journalId, role) == null) {
				this.authorityDao.create(userId, journalId, role);
				Authority authority = this.authorityDao.findAuthority(userId, journalId, role);
				if (this.journalRoleDao.findSpecificJournalRole(userId, journalId, role) == null) {
					if(roleType != null) {
						if(roleType instanceof ChiefEditor) {
							
						} else if(roleType instanceof AssociateEditor) {
							AssociateEditor associateEditor = (AssociateEditor) roleType;
							this.journalRoleDao.create(userId, journalId, authority.getId(), associateEditor);
							
						} else if(roleType instanceof Manager) {
						} else if(roleType instanceof Member) {
						}
					} else 
						this.journalRoleDao.create(userId, journalId, authority.getId(), role);
				}
			}
		}
	}
	
	/*
	@Override
	public void delete(int userId, int journalId, String role) {
		if (userId == 0) {
			return;
		}
		
		this.journalRoleDao.delete(userId, journalId, role);
		
		List<Authority> authorities = this.findAuthorities(userId, journalId, role);
		Iterator<Authority> iteratorAuthorities = authorities.iterator();
		while (iteratorAuthorities.hasNext()) {				
			this.authorityDao.delete((Authority)iteratorAuthorities.next());
		}
	}
	*/
	
	@Override
	public void delete(Authority authority) {
		authorityDao.delete(authority);
	}
	
	@Override
	public void update(Authority Authority) {
		this.authorityDao.update(Authority);		
	}
	
	@Override
	public Authority getById(int id) {
		return this.authorityDao.findById(id);
	}
	
	@Override
	public List<Authority> getAuthorities(int userId, int jid, String role) {
		if (role != null && (role.equals(SystemConstants.roleUser) || role.equals(SystemConstants.roleSuperManager))) {
			jid = 0;
		}
		return authorityDao.findAuthorities(userId, jid, role);
	}
	
	@Override
	public Authority getAuthority(int userId, int jid, String role) {
		if (role != null && (role.equals(SystemConstants.roleUser) || role.equals(SystemConstants.roleSuperManager))) {
			jid = 0;
		}
		return authorityDao.findAuthority(userId, jid, role);
	}
	
	// 현재 로그인된 사용자에 대해 주어진 Role이 있는지 판단
	@Override
	public boolean hasRole(String role) {
		boolean hasRole = false;
		UserDetails userDetails = getUserDetails();
		if (userDetails != null) {
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) userDetails.getAuthorities();
			for (GrantedAuthority grantedAuthority : authorities) {
				hasRole = grantedAuthority.getAuthority().equals(role);
				if (hasRole) break;
			}
		} 
		return hasRole;
	}
	
	// 현재 로그인된 사용자에 대해 주어진 journal에 해당 Role이 있는지 판단
	@Override
	public boolean hasRole(String role, int jid) {
		boolean hasRole = false;
		UserDetails userDetails = getUserDetails();
		if (userDetails != null) {
			int userId = this.userService.getByUsername(userDetails.getUsername()).getId();
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) userDetails.getAuthorities();
			for (GrantedAuthority grantedAuthority : authorities) {
				if (grantedAuthority.getAuthority().equals(role) && this.getAuthority(userId, jid, role) != null) {
					hasRole = true;
				}
				if (hasRole) break;
			}			
		}
		return hasRole;
	}
		
	//주어진 user가 주어진 role을 지니고 있는지 판단
	@Override
	public boolean hasRole(SystemUser user, String role) {
		boolean hasRole = false;
		UserDetails userDetails = userDetailsManager.loadUserByUsername(user.getUsername());
		if (userDetails != null) {
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) userDetails.getAuthorities();
			for (GrantedAuthority grantedAuthority : authorities) {
				hasRole = grantedAuthority.getAuthority().equals(role);
				if (hasRole) break;
			}
		} 
		return hasRole;
	}
	
	// 주어진 user에 대해 주어진 journal에 해당 Role이 있는지 판단
	@Override
	public boolean hasRole(SystemUser user, int jid, String role) {
		boolean hasRole = false;
		UserDetails userDetails = userDetailsManager.loadUserByUsername(user.getUsername());
		if (userDetails != null) {
			int userId = this.userService.getByUsername(userDetails.getUsername()).getId();
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) userDetails.getAuthorities();
			for (GrantedAuthority grantedAuthority : authorities) {
				if (grantedAuthority.getAuthority().equals(role) && this.getAuthority(userId, jid, role) != null) {
					hasRole = true;
				}
				if (hasRole) break;
			}
		} 
		return hasRole;
	}
	

	@Override
	public Collection<GrantedAuthority> getGrantedAuthorities(String username) {
		UserDetails userDetails = userDetailsManager.loadUserByUsername(username);
		if (userDetails != null) {
			@SuppressWarnings("unchecked")
			Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) userDetails.getAuthorities();
			return authorities;
		} else {
			System.out.println("ga null");
		}
		return null;
	}

	// 현재 로그인된 사용자에 대한 UserDetails 객체를 얻어옴
	@Override
	public UserDetails getUserDetails() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = null;
		if (principal instanceof UserDetails)
			userDetails = (UserDetails) principal;
		else if(principal.equals("anonymousUser") && principal instanceof String)
			return null;
		else
			userDetails = new User((String)principal, "", true, true, true, true, this.getGrantedAuthorities((String)principal));
		
		return userDetails;
	}	
	
	//사용자 user에 대해 현재 설정된 Role을 Context (Session)에 설정
	@Override
	public void authenticateUserAndSetSession(SystemUser user) {
        UserDetails userDetails = userDetailsManager.loadUserByUsername(user.getUsername());
        Authentication auth = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(auth);
	}
	
	@Override
	public void changeRole(int userId, String jnid, String role, String action) {
		int jid = 0;
		if (!(jnid == null || jnid.equals("0"))) {
			jid = this.journalService.getByJournalNameId(jnid).getId();
			changeRole(userId, jid, role, action);
		}
	}
	
	@Override
	public void changeRole(int userId, int jid, String role, String action) {
		if (userId == 0 || jid == 0 || role == null) {
			return;
		}
		if (action.equals(SystemConstants.addRole)) {
			if (role.equals(SystemConstants.roleSuperManager)) {
				this.create(userId, 0, SystemConstants.roleSuperManager);
			} else {
				if (role.equals(SystemConstants.roleMember)) {
					this.create(userId, jid, SystemConstants.roleMember);
				} else {
					this.create(userId, jid, role);
					this.create(userId, jid, SystemConstants.roleMember);
				}
			}
		} else if (action.equals(SystemConstants.deleteRole)) {
			Authority authority = getAuthority(userId, jid, role);
			if (authority != null) {
				this.delete(authority);
			}
			if (role.equals(SystemConstants.roleMember)) {
				List<Authority> authorities = this.getAuthorities(userId, jid, null);
				
				Iterator<Authority> iterator = authorities.iterator();
				while(iterator.hasNext()) {
					this.delete((Authority)iterator.next());	
				}
			}
		}
	}

}