package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class CategoryDaoImpl extends NamedParameterJdbcDaoSupport implements CategoryDao {
	@Autowired
	private CategoryRowMapper categoryRowMapper;

	@Override
	public List<Category> findByUpperCategory(int upperCategory) {
		String sql = "SELECT * FROM CATEGORIES WHERE UPPER_CATEGORY = ?";
		List<Category> list = this.getJdbcTemplate().query(sql, new Object[] {upperCategory}, categoryRowMapper);	
		return list;
	}
	
	@Override
	public Category findByName(String name) {
		String sql = "SELECT * FROM CATEGORIES WHERE NAME = ?";
		try {
			Category category = this.getJdbcTemplate().queryForObject(sql, new Object[] {name}, categoryRowMapper);	
			return category;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public Category findById(int id) {
		String sql = "SELECT * FROM CATEGORIES WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, categoryRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public List<Category> findAll() {
		String sql = "SELECT * FROM CATEGORIES";
		List<Category> list = this.getJdbcTemplate().query(sql, categoryRowMapper);	
		return list;
	}

}
