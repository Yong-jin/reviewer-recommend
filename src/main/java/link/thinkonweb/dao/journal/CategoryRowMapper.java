package link.thinkonweb.dao.journal;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.journal.Category;

import org.springframework.jdbc.core.RowMapper;

public class CategoryRowMapper implements RowMapper<Category> {
	
	@Override
	public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
		Category category = new Category();
		category.setId(rs.getInt("ID"));
		category.setName(rs.getString("NAME"));
		category.setUpperCategory(rs.getInt("UPPER_CATEGORY"));
		return category;
	}
}
