package link.thinkonweb.dao.user;

import java.util.List;

import link.thinkonweb.domain.user.Authority;

public interface AuthorityDao {
	public void 		create(int userId, int journalId, String role);
	public void 		delete(Authority authority);
	public void 		update(Authority authority);

	public Authority 	findById(int id);
	
	public List<Authority> findAuthorities(int userId, int journalId, String role);
	public Authority findAuthority(int userId, int journalId, String role); 
}