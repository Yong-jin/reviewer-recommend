package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.ManuscriptAbstract;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class AbstractDaoImpl extends NamedParameterJdbcDaoSupport implements AbstractDao {
	@Inject
	private AbstractRowMapper maRowMapper;

	@Override
	public void insert(ManuscriptAbstract manuscriptAbstract) {
		String sql = "INSERT INTO MANUSCRIPTS_ABSTRACT (MANUSCRIPT_ID, REVISION_COUNT, PAPER_ABSTRACT) " +
				 "VALUES (:manuscriptId, :revisionCount, :paperAbstract)";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(manuscriptAbstract);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}
	
	@Override
	public ManuscriptAbstract findById(int id) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_ABSTRACT WHERE ID = ?";
			ManuscriptAbstract ma = this.getJdbcTemplate().queryForObject(sql, new Object[]{id}, maRowMapper);	
			return ma;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}

	@Override
	public ManuscriptAbstract findByRevisionCountAndManuscriptId(
			int revisionCount, int manuscriptId) {
		try {
			String sql = "SELECT * FROM MANUSCRIPTS_ABSTRACT WHERE REVISION_COUNT = ? AND MANUSCRIPT_ID = ?";
			ManuscriptAbstract ma = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId}, maRowMapper);	
			return ma;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
	}

	@Override
	public List<ManuscriptAbstract> findByManuscriptId(
			int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_ABSTRACT WHERE MANUSCRIPT_ID = ?";
		List<ManuscriptAbstract> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, maRowMapper);	
		return list;
	}

	@Override
	public void update(ManuscriptAbstract manuscriptAbstract) {
		String sql = "UPDATE MANUSCRIPTS_ABSTRACT SET MANUSCRIPT_ID = ?, REVISION_COUNT = ?, PAPER_ABSTRACT = ? WHERE MANUSCRIPT_ID=? AND REVISION_COUNT = ?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscriptAbstract.getManuscriptId(), 
				manuscriptAbstract.getRevisionCount(), manuscriptAbstract.getPaperAbstract(), 
				manuscriptAbstract.getManuscriptId(), manuscriptAbstract.getRevisionCount()});
	}

	@Override
	public void delete(ManuscriptAbstract manuscriptAbstract) {
		String sql = "DELETE FROM MANUSCRIPTS_ABSTRACT WHERE ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {manuscriptAbstract.getId()});
	}

}
