package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.CoverLetter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class CoverLetterDaoImpl extends NamedParameterJdbcDaoSupport implements CoverLetterDao {
	@Autowired
	private CoverLetterRowMapper coverLetterRowMapper;

	@Override
	public void insert(CoverLetter coverLetter) {
		String sql = "INSERT INTO MANUSCRIPTS_COVERLETTER (MANUSCRIPT_ID, REVISION_COUNT, COVERLETTER) " +
				 "VALUES (:manuscriptId, :revisionCount, :coverLetter)";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(coverLetter);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}
	
	@Override
	public CoverLetter findById(int id) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COVERLETTER WHERE ID = ?";
			CoverLetter ma = this.getJdbcTemplate().queryForObject(sql, new Object[]{id}, coverLetterRowMapper);	
			return ma;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}

	@Override
	public CoverLetter findByRevisionCountAndManuscriptId(
			int revisionCount, int manuscriptId) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_COVERLETTER WHERE REVISION_COUNT = ? AND MANUSCRIPT_ID = ?";
			CoverLetter ma = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId}, coverLetterRowMapper);	
			return ma;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}

	@Override
	public List<CoverLetter> findByManuscriptId(
			int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_COVERLETTER WHERE MANUSCRIPT_ID = ?";
		List<CoverLetter> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, coverLetterRowMapper);	
		return list;
	}

	@Override
	public void update(CoverLetter coverLetter) {
		String sql = "UPDATE MANUSCRIPTS_COVERLETTER SET MANUSCRIPT_ID = ?, REVISION_COUNT = ?,  COVERLETTER = ? WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {coverLetter.getManuscriptId(), 
				coverLetter.getRevisionCount(), coverLetter.getCoverLetter(), 
				coverLetter.getId()});
	}

	@Override
	public void delete(CoverLetter coverLetter) {
		String sql = "DELETE FROM MANUSCRIPTS_COVERLETTER WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {coverLetter.getId()});
	}

}
