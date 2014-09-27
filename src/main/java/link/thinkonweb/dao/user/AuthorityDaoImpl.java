package link.thinkonweb.dao.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import link.thinkonweb.domain.user.Authority;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class AuthorityDaoImpl extends NamedParameterJdbcDaoSupport implements AuthorityDao {
	@Inject
	private AuthorityRowMapper authorityRowMapper;
	
	@Override
	public void create(int userId, int journalId, String role) {
		String sql = "INSERT INTO AUTHORITIES (USER_ID, JOURNAL_ID, ROLE) VALUES (:userid, :journalid, :role)";
		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("userid", userId);
		argMap.put("journalid", journalId);
		argMap.put("role", role);
		this.getNamedParameterJdbcTemplate().update(sql, argMap);
	}
	
	@Override
	public void delete(Authority authority) {
		String sql = "DELETE FROM AUTHORITIES WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {authority.getId()});
	}

	@Override
	public void update(Authority authority) {
		String sql = "UPDATE AUTHORITIES SET USER_ID=?, JOURNAL_ID=?, ROLE=? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {authority.getUserId(), authority.getJournalId(), authority.getRole(), authority.getId()});
	}

	@Override
	public Authority findById(int id) {
		String sql = "SELECT * FROM AUTHORITIES WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, authorityRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Authority> findAuthorities(int userId, int journalId, String role) {
		if (role == null) {
			if (userId == 0 && journalId == 0) {
				String sql = "SELECT * FROM AUTHORITIES";
				try {
					return this.getJdbcTemplate().query(sql, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				String sql = "SELECT * FROM AUTHORITIES WHERE JOURNAL_ID = ? ";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {journalId}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(journalId == 0) {
				String sql = "SELECT * FROM AUTHORITIES WHERE USER_ID = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			} else {
				String sql = "SELECT * FROM AUTHORITIES WHERE USER_ID = ? AND JOURNAL_ID = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, journalId}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			}
		} else {
			if(userId == 0 && journalId == 0) {
				String sql = "SELECT * FROM AUTHORITIES WHERE ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {role}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				String sql = "SELECT * FROM AUTHORITIES WHERE JOURNAL_ID = ? AND ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {journalId, role}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(journalId == 0) {
				String sql = "SELECT * FROM AUTHORITIES WHERE USER_ID = ? AND ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, role}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			} else {
				String sql = "SELECT * FROM AUTHORITIES WHERE USER_ID = ? AND JOURNAL_ID = ? AND ROLE = ?";
				try {
					return this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, role}, authorityRowMapper);
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
				
			}
		}
	}
	
	@Override
	public Authority findAuthority(int userId, int journalId, String role) {
		if (userId == 0 || role == null) {
			return null;
		} else {
			String sql = "SELECT * FROM AUTHORITIES WHERE USER_ID = ? AND JOURNAL_ID = ? AND ROLE = ?";
			try {
				return this.getJdbcTemplate().queryForObject(sql, new Object[] {userId, journalId, role}, authorityRowMapper);
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		}
	}
}