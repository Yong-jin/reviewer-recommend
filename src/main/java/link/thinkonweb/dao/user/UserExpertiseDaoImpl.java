package link.thinkonweb.dao.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import link.thinkonweb.domain.user.UserExpertise;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class UserExpertiseDaoImpl extends NamedParameterJdbcDaoSupport implements UserExpertiseDao {
	@Inject
	UserExpertiseRowMapper userExpertiseRowMapper;
	
	@Override
	public int insertExpertise(final int userId, final String expertise) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
        this.getJdbcTemplate().update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(
                        	"INSERT INTO USER_EXPERTISES (EXPERTISE, USER_ID) VALUES (?, ?)",
                        	new String[] { "ID" });
                ps.setString(1, expertise.trim());
                ps.setInt(2, userId);
                return ps;
            }
        }, keyHolder);
        return keyHolder.getKey().intValue();
	}

	@Override
	public int insertExpertise(final UserExpertise ue) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
        this.getJdbcTemplate().update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(
                        	"INSERT INTO USER_EXPERTISES (EXPERTISE, USER_ID) VALUES (?, ?)",
                        	new String[] { "ID" });
                ps.setString(1, ue.getExpertise().trim());
                ps.setInt(2, ue.getUserId());
                return ps;
            }
        }, keyHolder);
        return keyHolder.getKey().intValue();
	}

	@Override
	public void deleteExpertise(UserExpertise ue) {
		String sql = "DELETE FROM USER_EXPERTISES WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {ue.getId()});
	}
	
	@Override
	public void deleteAllExpertises(int userId) {
		String sql = "DELETE FROM USER_EXPERTISES WHERE USER_ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {userId});
	}
	
	@Override
	public UserExpertise findExpertise(int userId, String expertise) {
		String sql = "SELECT * FROM USER_EXPERTISES WHERE EXPERTISE = ? AND USER_ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {expertise.trim(), userId}, userExpertiseRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<String> findAllUniqueExpertisesAsStringList() {
		String sql = "SELECT DISTINCT EXPERTISE FROM USER_EXPERTISES";
		return this.getJdbcTemplate().queryForList(sql, String.class);
	}
	
	@Override
	public List<String> findAllUniqueExpertisesAsStringListByQuery(String query) {
		String sql = "SELECT DISTINCT EXPERTISE FROM USER_EXPERTISES WHERE EXPERTISE LIKE '%" + query + "%'";
		return this.getJdbcTemplate().queryForList(sql, String.class);
	}

	@Override
	public List<UserExpertise> findExpertises(int userId) {
		String sql = "SELECT * FROM USER_EXPERTISES WHERE USER_ID = ?";
		return this.getJdbcTemplate().query(sql, new Object[] {userId}, userExpertiseRowMapper);
	}
	
	@Override
	public boolean hasUserExpertise(int userId, String expertise) {
		String sql = "SELECT * FROM USER_EXPERTISES WHERE EXPERTISE = ? AND USER_ID = ?";
		UserExpertise ue = null;
		try {
			ue = this.getJdbcTemplate().queryForObject(sql, new Object[] {expertise.trim(), userId}, userExpertiseRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return false;
		}
		if (ue != null) {
			return true;
		} else {
			return false;
		}
	}
}