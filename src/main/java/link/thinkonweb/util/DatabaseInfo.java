package link.thinkonweb.util;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class DatabaseInfo extends NamedParameterJdbcDaoSupport{
	
	public int getTotalNumOfRows(String schemaName, String tableName) {
		String sql = "SELECT TABLE_ROWS FROM information_schema.TABLES WHERE TABLE_SCHEMA = ? and TABLE_NAME = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {schemaName, tableName}, Integer.class);
		} catch (EmptyResultDataAccessException e) {
			return -1;
		}
	}
}
