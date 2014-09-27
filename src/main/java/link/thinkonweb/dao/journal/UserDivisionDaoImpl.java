package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.UserDivision;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.annotation.Transactional;

public class UserDivisionDaoImpl extends NamedParameterJdbcDaoSupport implements UserDivisionDao {
	@Inject
	private UserDivisionRowMapper userDivisionRowMapper;

	@Inject
	private DivisionDao divisionDao;
	
	@Inject
	private UserDivisionDivisionRowMapper userDivisionDivisionRowMapper;

	@Override
	public int insert(UserDivision userDivision) {
		String sql = "INSERT INTO USER_DIVISIONS (JOURNAL_ID, USER_ID, DIVISION_ID, ROLE) " +
				"values (:journalId, :userId, :divisionId, :role)";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(userDivision);
		return this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}

	@Override
	public int insertAndReturningKey(UserDivision userDivision) {
		String sql = "INSERT INTO USER_DIVISIONS (JOURNAL_ID, USER_ID, DIVISION_ID, ROLE) " +
				"values (:journalId, :userId, :divisionId, :role)";		
		SqlParameterSource paramSource = new BeanPropertySqlParameterSource(userDivision);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, paramSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}

	@Override
	public UserDivision findById(int id) {
		String sql = "SELECT * FROM USER_DIVISIONS WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, userDivisionRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void update(UserDivision userDivision) {
		String sql = "UPDATE USER_DIVISIONS SET ID = ?, JOURNAL_ID = ?, USER_ID = ?, DIVISION_ID = ?, ROLE = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {userDivision.getId(), userDivision.getJournalId(), userDivision.getUserId(), userDivision.getDivisionId(), userDivision.getRole(), userDivision.getId()});	
		
	}
	
	@Override
	public void delete(int userDivisionId) {
		try {
			String sql = "DELETE FROM USER_DIVISIONS WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {userDivisionId});
		} catch(Exception e) {
			System.out.println("deleting error");
		}
	}
	
	@Override
	public List<UserDivision> findUserDivisions(int userId, int journalId, String role) {

		if(userId == 0 && journalId == 0) {
			try {
				String sql = "SELECT * FROM USER_DIVISIONS WHERE ROLE = ?";
				List<UserDivision> list = this.getJdbcTemplate().query(sql, new Object[] {role}, userDivisionRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		} else if(userId == 0) {
			try {
				String sql = "SELECT * FROM USER_DIVISIONS UD JOIN DIVISIONS D ON UD.DIVISION_ID = D.ID WHERE UD.JOURNAL_ID = ? AND UD.ROLE = ?";
				List<UserDivision> list = this.getJdbcTemplate().query(sql, new Object[] {journalId, role}, userDivisionDivisionRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
		} else if(journalId == 0) {
			try {
				String sql = "SELECT * FROM USER_DIVISIONS UD JOIN DIVISIONS D ON UD.DIVISION_ID = D.ID WHERE UD.USER_ID = ? AND UD.ROLE = ?";
				List<UserDivision> list = this.getJdbcTemplate().query(sql, new Object[] {userId, role}, userDivisionDivisionRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		} else {
			try {
				String sql = "SELECT * FROM USER_DIVISIONS UD JOIN DIVISIONS D ON UD.DIVISION_ID = D.ID WHERE UD.USER_ID = ? AND UD.JOURNAL_ID = ? AND UD.ROLE = ?";
				List<UserDivision> list = this.getJdbcTemplate().query(sql, new Object[] {userId, journalId, role}, userDivisionDivisionRowMapper);	
				return list;
			} catch(EmptyResultDataAccessException e) {
				return null;
			}
			
		}
	}

	@Override
	@Transactional
	public UserDivision create(int userId, int journalId, int divisionId, String role) {
		UserDivision userDivision = new UserDivision();
		userDivision.setUserId(userId);
		userDivision.setJournalId(journalId);
		userDivision.setDivisionId(divisionId);
		userDivision.setDivision(divisionDao.findById(divisionId));
		userDivision.setRole(role);
		int id = this.insertAndReturningKey(userDivision);
		userDivision.setId(id);
		return userDivision;
	}
	
	@Override
	public void delete(int userId, int journalId, int divisionId, String role) {
		try {
			String sql = "DELETE FROM USER_DIVISIONS WHERE USER_ID = ? AND JOURNAL_ID = ? AND DIVISION_ID = ? AND ROLE = ?";
			this.getJdbcTemplate().update(sql, new Object[] {userId, journalId, divisionId, role}, userDivisionRowMapper);
		} catch(Exception e) {
			System.out.println("deleting error");
		}
	}
}
