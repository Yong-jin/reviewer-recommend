package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.Keyword;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class KeywordDaoImpl extends NamedParameterJdbcDaoSupport implements KeywordDao {
	@Inject
	private KeywordRowMapper keywordRowMapper;
	
	@Override
	public void setKeywordRowMapper(
			KeywordRowMapper keywordRowMapper) {
		this.keywordRowMapper = keywordRowMapper;
	}

	@Override
	public void insert(Keyword manuscriptKeyword) {
		String sql = "INSERT INTO MANUSCRIPTS_KEYWORD (KEYWORD, MANUSCRIPT_ID, USER_ID, JOURNAL_ID, REVISION_COUNT) VALUES (:keyword, :manuscriptId, :userId, :journalId, :revisionCount)";			
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(manuscriptKeyword);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}

	@Override
	public List<Keyword> findByManuscriptId(int manuscriptId) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_KEYWORD WHERE MANUSCRIPT_ID = ?";
			List<Keyword> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, keywordRowMapper);	
			return list;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Keyword> findByManuscriptIdAndRevisionCount(int manuscriptId, int revisionCount) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_KEYWORD WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
			List<Keyword> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, revisionCount}, keywordRowMapper);	
			return list;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public void update(Keyword manuscriptKeyword) {
		String sql = "UPDATE MANUSCRIPTS_KEYWORD SET KEYWORD = ? AND REVISION_COUNT = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscriptKeyword.getKeyword(), manuscriptKeyword.getRevisionCount(), manuscriptKeyword.getId()});	
	}

	@Override
	public void delete(Keyword manuscriptKeyword) {
		String sql = "DELETE FROM MANUSCRIPTS_KEYWORD WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscriptKeyword.getId()});
	}

	@Override
	public Keyword findKeyword(String keyword, int manuscriptId, int revisionCount) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_KEYWORD WHERE KEYWORD = ? AND MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
			Keyword mk = this.getJdbcTemplate().queryForObject(sql, new Object[] {keyword, manuscriptId, revisionCount}, keywordRowMapper);
			return mk;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public void deleteByManuscriptIdAndRevisionCount(int manuscriptId, int revisionCount) {
		String sql = "DELETE FROM MANUSCRIPTS_KEYWORD WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscriptId, revisionCount});
	}
	
}
