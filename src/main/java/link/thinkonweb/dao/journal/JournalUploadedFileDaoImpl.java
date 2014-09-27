package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.JournalUploadedFile;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class JournalUploadedFileDaoImpl extends NamedParameterJdbcDaoSupport implements JournalUploadedFileDao {	
	@Inject
	private JournalUploadedFileRowMapper jufRowMapper;
	
	public int insert(JournalUploadedFile juf) {
		String sql = "INSERT INTO JOURNAL_UPLOADED_FILES (ID, USER_ID, JOURNAL_ID, NAME, DESIGNATION, ABSOLUTE_PATH, PATH, ORIGINAL_NAME, DATE, TIME) " +
				"VALUES (:id, :userId, :journalId, :name, :designation, :absolutePath, :path, :originalName, UTC_DATE(), UTC_TIME())";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(juf);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	} 

	public JournalUploadedFile findById(int id) {
		try{
			JournalUploadedFile uploadedFile = this.getJdbcTemplate().queryForObject("SELECT * FROM JOURNAL_UPLOADED_FILES WHERE ID = ?", new Object[] {id}, jufRowMapper);		
			return uploadedFile;
		}catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<JournalUploadedFile> findByJournalId(int journalId) {
		try{
			List<JournalUploadedFile> list = this.getJdbcTemplate().query("SELECT * FROM JOURNAL_UPLOADED_FILES WHERE JOURNAL_ID = ?", new Object[] {journalId}, jufRowMapper);		
			return list;
		}catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	public void update(JournalUploadedFile f) {
		this.getJdbcTemplate().update("UPDATE JOURNAL_UPLOADED_FILES SET " +
				"USER_ID=:userId," +
				"JOURNAL_ID=:journalId," +
				"NAME=:name," +
				"DESIGNATION=:designation," +
				"ABSOLUTE_PATH=:absolutePath," +
				"ORIGINAL_NAME=:originalName," +
				"PATH=:path," +
				"WHERE (ID=:id);", new BeanPropertySqlParameterSource(f));
	}
	public void deleteFileById(int id) {
		this.getJdbcTemplate().update("DELETE FROM JOURNAL_UPLOADED_FILES WHERE ID = ?", id);
	}
	
}
