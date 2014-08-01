package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.util.DataTableClientRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;


public class CoAuthorDaoImpl extends NamedParameterJdbcDaoSupport implements CoAuthorDao {
	@Autowired
	private CoAuthorRowMapper coAuthorRowMapper;
	public void setCoAuthorRowMapper(CoAuthorRowMapper coAuthorRowMapper) {
		this.coAuthorRowMapper = coAuthorRowMapper;
	}
	@Override
	public void insert(CoAuthor coAuthor) {
		String sql = "INSERT INTO MANUSCRIPTS_COAUTHORS (MANUSCRIPT_ID, USER_ID, REVISION_COUNT, CORRESPONDING, AUTHOR_ORDER, CREATED_MEMBER, TEMP_PW) " +
				 "VALUES (:manuscriptId, :userId, :revisionCount, :corresponding, :authorOrder, :createdMember, :temporaryPassword)";
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(coAuthor);
		this.getNamedParameterJdbcTemplate().update(sql, parameterSource);
	}

	@Override
	public List<CoAuthor> findCoAuthors(int manuscriptId, int revisionCount, int authorOrder, boolean needTobeCorresponding) {
		String correspondingClause = "";
		if(needTobeCorresponding)
			correspondingClause = " AND CORRESPONDING = 1";
		
		String revisionClause = "";
		if(revisionCount != -1)
			revisionClause = " AND REVISION_COUNT = " + revisionCount;
		
		String authorOrderClause = "";
		if(authorOrder != 0)
			authorOrderClause = " AND AUTHOR_ORDER = " + authorOrder;
		
		try{
			String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ?" + correspondingClause + revisionClause + authorOrderClause;
			List<CoAuthor> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, coAuthorRowMapper);	
			return list;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<Integer> findCoAuthorIds(int manuscriptId, int revisionCount, int authorOrder, boolean needTobeCorresponding) {
		String correspondingClause = "";
		if(needTobeCorresponding)
			correspondingClause = " AND CORRESPONDING = 1";
		
		String revisionClause = "";
		if(revisionCount != -1)
			revisionClause = " AND REVISION_COUNT = " + revisionCount;
		
		String authorOrderClause = "";
		if(authorOrder != 0)
			authorOrderClause = " AND AUTHOR_ORDER = " + authorOrder;
		
		try{
			String sql = "SELECT USER_ID FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ?" + correspondingClause + revisionClause + authorOrderClause;
			List<Integer> list = this.getJdbcTemplate().queryForList(sql, new Object[] {manuscriptId}, Integer.class);	
			return list;
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<CoAuthor> findAll(int manuscriptId) {
		String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ?";
		List<CoAuthor> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId},coAuthorRowMapper);	
		return list;
	}

	@Override
	public void update(CoAuthor coAuthor) {
		String sql = "UPDATE MANUSCRIPTS_COAUTHORS SET MANUSCRIPT_ID = ?, USER_ID = ?, REVISION_COUNT = ?, CORRESPONDING = ?, CREATED_MEMBER = ?, AUTHOR_ORDER = ?, TEMP_PW = ? WHERE MANUSCRIPT_ID = ? AND USER_ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {coAuthor.getManuscriptId(), coAuthor.getUserId(), coAuthor.getRevisionCount(), 
				coAuthor.isCorresponding(), coAuthor.isCreatedMember(), coAuthor.getAuthorOrder(), coAuthor.getTemporaryPassword(), coAuthor.getManuscriptId(), coAuthor.getUserId()});	
	}

	@Override
	public void delete(CoAuthor coAuthor) {
		String sql = "DELETE FROM MANUSCRIPTS_COAUTHORS WHERE USER_ID = ? AND MANUSCRIPT_ID = ?";
		this.getJdbcTemplate().update(sql, new Object[] {coAuthor.getUserId(), coAuthor.getManuscriptId()});
	}

	@Override
	public int getNumOfRecordsByCustomSql(String sql) {
		return this.getJdbcTemplate().queryForObject(sql, Integer.class);
	}
	
	@Override
	public List<Integer> findManuscriptIdsByUserCoAuthorsFromMyActivity(int userId, DataTableClientRequest dRequest) {
		StringBuffer searchSqlSB = new StringBuffer();
	    searchSqlSB.append("SELECT M.ID FROM MANUSCRIPTS M JOIN MANUSCRIPTS_COAUTHORS C ON M.ID = C.MANUSCRIPT_ID WHERE C.USER_ID = " + userId);
	            
        String sql = searchSqlSB.toString();
		List<Integer> manuscriptIds = this.getJdbcTemplate().queryForList(sql, Integer.class);
		return manuscriptIds;
	}

	@Override
	public CoAuthor findCoAuthor(int manuscriptId, int userId, int revisionCount, int authorOrder, boolean corresponding) {
		if(corresponding) {
			if(authorOrder == 0 && userId == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ? AND CORRESPONDING = 1";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(authorOrder == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND USER_ID = ? AND REVISION_COUNT = ? AND CORRESPONDING = 1";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, userId, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND AUTHOR_ORDER = ? AND REVISION_COUNT = ? AND CORRESPONDING = 1";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, authorOrder, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND USER_ID = ? AND REVISION_COUNT = ? AND AUTHOR_ORDER = ? AND CORRESPONDING = 1";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, userId, revisionCount, authorOrder}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			}
		} else {
			if(authorOrder == 0 && userId == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(authorOrder == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND USER_ID = ? AND REVISION_COUNT = ?";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, userId, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else if(userId == 0) {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND AUTHOR_ORDER = ? AND REVISION_COUNT = ?";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, authorOrder, revisionCount}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			} else {
				try {
					String sql = "SELECT * FROM MANUSCRIPTS_COAUTHORS WHERE MANUSCRIPT_ID = ? AND USER_ID = ? AND REVISION_COUNT = ? AND AUTHOR_ORDER = ?";
					CoAuthor coAuthor = this.getJdbcTemplate().queryForObject(sql, new Object[] {manuscriptId, userId, revisionCount, authorOrder}, coAuthorRowMapper);	
					return coAuthor;
				} catch(EmptyResultDataAccessException e) {
					return null;
				}
			}
		}

	}
}
