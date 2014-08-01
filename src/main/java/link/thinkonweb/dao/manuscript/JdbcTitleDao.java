package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.Title;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

public class JdbcTitleDao implements TitleDao {
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert insert;
	private String tableName;
	@Override
	public void setDataSource(DataSource dataSource) {
		this.simpleJdbcTemplate = new SimpleJdbcTemplate(dataSource);
		tableName = "manuscripts_title";
		this.insert = new SimpleJdbcInsert(dataSource).withTableName(tableName);
	}
	@Override
	public void insert(Title manuscriptTitle) {
		insert.execute(new BeanPropertySqlParameterSource(manuscriptTitle));

	}
	
	@Override
	public Title findById(int id) {
		Title result = simpleJdbcTemplate.queryForObject("SELECT * FROM "+tableName+" WHERE ID = ?", new BeanPropertyRowMapper<Title>(Title.class), id);
		return result;
	}
	
	@Override
	public List<Title> findByManuscriptId(
			int manuscriptId) {
		List<Title> result = simpleJdbcTemplate.query("SELECT * FROM "+tableName+" WHERE MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<Title>(Title.class), manuscriptId);
		return result;
	}

	@Override
	public void update(Title manuscriptTitle) {
		simpleJdbcTemplate.update("UPDATE "+tableName+" SET " +
				"title=:title " +
				"WHERE (MANUSCRIPT_ID=:manuscriptId and REVISION_COUNT=:revisionCount);", new BeanPropertySqlParameterSource(manuscriptTitle));
	}

	@Override
	public void delete(Title manuscriptTitle) {
		simpleJdbcTemplate.update("DELETE FROM "+tableName+" WHERE ID = ?", manuscriptTitle.getId());

	}
	@Override
	public Title findByRevisionCountAndManuscriptId(
			int revisionCount, int manuscriptId) {
		try {
			Title result = simpleJdbcTemplate.queryForObject("SELECT * FROM "+tableName+" WHERE REVISION_COUNT = ? and MANUSCRIPT_ID = ?", new BeanPropertyRowMapper<Title>(Title.class), revisionCount, manuscriptId);
			return result;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}

}
