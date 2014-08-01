package link.thinkonweb.dao.user;

import javax.sql.DataSource;

import link.thinkonweb.domain.user.ChangePasswordCode;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;



public class ChangePasswordCodeDao {
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert rpInsert;
	public void setDataSource(DataSource dataSource) {	
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		this.rpInsert = new SimpleJdbcInsert(dataSource).withTableName("change_password_code").usingGeneratedKeyColumns("id");
	}
	
	public int add(ChangePasswordCode code) {
		int key = rpInsert.executeAndReturnKey(new BeanPropertySqlParameterSource(code)).intValue();
		return key;
	}

	public ChangePasswordCode getChangePasswordCodeByCode(String code) {
		try {
			ChangePasswordCode cpc = simpleJdbcTemplate.queryForObject("SELECT * FROM change_password_code WHERE maskCode = ? and expired = false", new BeanPropertyRowMapper<ChangePasswordCode>(ChangePasswordCode.class), code);
			return cpc;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	public void update(ChangePasswordCode cpc) {
		simpleJdbcTemplate.update("UPDATE change_password_code SET email=:email," +
				"maskCode=:maskCode," +
				"EXPIRATION_DATE=:expirationDate," +
				"REGISTER_DATE=:registerDate," +
				"expired=:expired " +
				"WHERE (id=:id);", new BeanPropertySqlParameterSource(cpc));
		
	}
}
