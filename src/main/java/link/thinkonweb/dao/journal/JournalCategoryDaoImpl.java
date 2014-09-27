package link.thinkonweb.dao.journal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import link.thinkonweb.domain.journal.JournalCategory;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class JournalCategoryDaoImpl extends NamedParameterJdbcDaoSupport implements JournalCategoryDao {
	@Inject
	private JournalCategoryRowMapper jcRowMapper;

	@Override
	public List<JournalCategory> findByJournalId(int journalId) {
		String sql = "SELECT * FROM JOURNAL_CATEGORIES WHERE JOURNAL_ID = ?";
		List<JournalCategory> list = this.getJdbcTemplate().query(sql, new Object[] {journalId}, jcRowMapper);	
		return list;
	}

	@Override
	public int insert(final JournalCategory jc) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
        this.getJdbcTemplate().update(new PreparedStatementCreator() {
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(
                        	"INSERT INTO JOURNAL_CATEGORIES (JOURNAL_ID, NAME) VALUES (?, ?)",
                        	new String[] { "ID" });
                ps.setInt(1, jc.getJournalId());
                ps.setString(2, jc.getName());
                return ps;
            }
        }, keyHolder);
        return keyHolder.getKey().intValue();
	}
	@Override
	public JournalCategory findById(int id) {
		String sql = "SELECT * FROM JOURNAL_CATEGORIES WHERE ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {id}, jcRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public void update(JournalCategory jc) {
		String sql = "UPDATE JOURNAL_CATEGORIES SET JOURNAL_ID = ?, NAME = ? WHERE ID=?";
		this.getJdbcTemplate().update(sql, new Object[] {jc.getJournalId(), jc.getName(), jc.getId()});			
	}
	
	@Override
	public void delete(int id) {
		try {
			String sql = "DELETE FROM JOURNAL_CATEGORIES WHERE ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {id});
		} catch(Exception e) {
			System.out.println("deleting error at special issue dao");
		}
	}
	
	@Override
	public void deleteByJournalId(int journalId) {
		try {
			String sql = "DELETE FROM JOURNAL_CATEGORIES WHERE JOURNAL_ID = ?";
			this.getJdbcTemplate().update(sql, new Object[] {journalId});
		} catch(Exception e) {
			System.out.println("deleting error at special issue dao");
		}
	}
	
	@Override
	public JournalCategory findByCategoryIdAndJournalId(int categoryId,
			int journalId) {
		String sql = "SELECT * FROM JOURNAL_CATEGORIES WHERE CATEGORY_ID = ? AND JOURNAL_ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {categoryId, journalId}, jcRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public JournalCategory findByNameAndJournalId(String name,
			int journalId) {
		String sql = "SELECT * FROM JOURNAL_CATEGORIES WHERE NAME = ? AND JOURNAL_ID = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {name, journalId}, jcRowMapper);	
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
}
