package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.UploadedFile;

import javax.inject.Inject;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

public class UploadedFileDaoImpl extends NamedParameterJdbcDaoSupport implements UploadedFileDao {
	@Inject
	private UploadedFileRowMapper ufRowMapper;

	public UploadedFile findById(int id) {
		try {
			UploadedFile uploadedFile = this.getJdbcTemplate().queryForObject("SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE ID = ?", new Object[] {id}, ufRowMapper);		
			return uploadedFile;
		}catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<UploadedFile> getFilesByManuscriptId(int manuscriptId) {
		try {
			List<UploadedFile> list = this.getJdbcTemplate().query("SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ?", new Object[] {manuscriptId}, ufRowMapper);		
			return list;
		}catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	public List<UploadedFile> getUploadedFiles(int manuscriptId, List<Integer> userIds, int revisionCount, List<String> designations) {
		StringBuffer userIdClause = new StringBuffer("");
		if(userIds != null && userIds.size() > 0) {
			int index = 0;
			userIdClause.append(" AND (");
			for(Integer id: userIds) {
				userIdClause.append("USER_ID = '");
				userIdClause.append(id);
				userIdClause.append("'");
				index ++;
				if(index < userIds.size())
					userIdClause.append(" OR ");
			}
			userIdClause.append(") ");
		}
		
		StringBuffer designationsClause = new StringBuffer("");
		if(designations != null && designations.size() > 0) {
			int index = 0;
			designationsClause.append(" AND (");
			for(String s: designations) {
				designationsClause.append("DESIGNATION = '");
				designationsClause.append(s);
				designationsClause.append("'");
				index ++;
				if(index < designations.size())
					designationsClause.append(" OR ");
			}
			designationsClause.append(") ");
		}
		if(revisionCount == -1) {
			try{
				String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ?";
				sql += userIdClause.toString();
				sql += designationsClause.toString();
				List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, ufRowMapper);
				return list;
			}catch(EmptyResultDataAccessException e) {
				return null;
			}

		} else {
			try{
				String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
				sql += userIdClause.toString();
				sql += designationsClause.toString();
				List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, revisionCount}, ufRowMapper);		
				return list;
			}catch(EmptyResultDataAccessException e) {
				return null;
			}
		}
	}
	
	public List<UploadedFile> getUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations) {
		StringBuffer designationsClause = new StringBuffer("");
		if(designations != null && designations.size() > 0) {
			int index = 0;
			designationsClause.append(" AND (");
			for(String s: designations) {
				designationsClause.append("DESIGNATION = '");
				designationsClause.append(s);
				designationsClause.append("'");
				index ++;
				if(index < designations.size())
					designationsClause.append(" OR ");
			}
			designationsClause.append(") ");
		}
		
		if(userId == 0) {
			if(revisionCount == -1) {
				try{
					String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ?";
					sql += designationsClause.toString();
					List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId}, ufRowMapper);		
					return list;
				}catch(EmptyResultDataAccessException e) {
					return null;
				}
	
			} else {
				try{
					String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ? AND REVISION_COUNT = ?";
					sql += designationsClause.toString();
					List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, revisionCount}, ufRowMapper);		
					return list;
				}catch(EmptyResultDataAccessException e) {
					return null;
				}
			}
		} else {
			if(revisionCount == -1) {
				try{
					String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] {manuscriptId, userId}, ufRowMapper);		
					return list;
				}catch(EmptyResultDataAccessException e) {
					return null;
				}
	
			} else {
				try{
					String sql = "SELECT * FROM MANUSCRIPTS_UPLOADED_FILES WHERE MANUSCRIPT_ID = ? AND USER_ID = ? AND REVISION_COUNT = ?";
					sql += designationsClause.toString();
					List<UploadedFile> list = this.getJdbcTemplate().query(sql, new Object[] { manuscriptId, userId, revisionCount}, ufRowMapper);		
					return list;
				}catch(EmptyResultDataAccessException e) {
					return null;
				}
			}
		}
	}
	

	
	public int numUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations) {
		StringBuffer designationsClause = new StringBuffer("");
		if(designations != null && designations.size() > 0) {
			int index = 0;
			designationsClause.append(" AND (");
			for(String s: designations) {
				designationsClause.append("DESIGNATION = '");
				designationsClause.append(s);
				designationsClause.append("'");
				index ++;
				if(index < designations.size())
					designationsClause.append(" OR ");
			}
			designationsClause.append(") ");
		}
		
		if(manuscriptId == 0) {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE REVISION_COUNT = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount}, Integer.class);		
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE REVISION_COUNT = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, userId}, Integer.class);		
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		} else {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE REVISION_COUNT = ? AND MANUSCRIPT_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId}, Integer.class);		
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE REVISION_COUNT = ? AND MANUSCRIPT_ID = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId, userId}, Integer.class);		
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		}
	}
		
	public int numGalleryProofUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations) {
		StringBuffer designationsClause = new StringBuffer("");
		if(designations != null && designations.size() > 0) {
			int index = 0;
			designationsClause.append(" AND (");
			for(String s: designations) {
				designationsClause.append("DESIGNATION = '");
				designationsClause.append(s);
				designationsClause.append("'");
				index ++;
				if(index < designations.size())
					designationsClause.append(" OR ");
			}
			designationsClause.append(") ");
		}
		
		if(manuscriptId == 0) {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE GALLERY_PROOF_REVISION = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE GALLERY_PROOF_REVISION = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, userId}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		} else {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE GALLERY_PROOF_REVISION = ? AND MANUSCRIPT_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE GALLERY_PROOF_REVISION = ? AND MANUSCRIPT_ID = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId, userId}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		}
	}

	public int numCameraReadyUploadedFiles(int manuscriptId, int userId, int revisionCount, List<String> designations) {
		StringBuffer designationsClause = new StringBuffer("");
		if(designations != null && designations.size() > 0) {
			int index = 0;
			designationsClause.append(" AND (");
			for(String s: designations) {
				designationsClause.append("DESIGNATION = '");
				designationsClause.append(s);
				designationsClause.append("'");
				index ++;
				if(index < designations.size())
					designationsClause.append(" OR ");
			}
			designationsClause.append(") ");
		}
		
		if(manuscriptId == 0) {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE CAMERA_READY_REVISION = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE CAMERA_READY_REVISION = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, userId}, Integer.class);	
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		} else {
			if(userId == 0) {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE CAMERA_READY_REVISION = ? AND MANUSCRIPT_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			} else {
				try{
					String sql = "SELECT COUNT(ID) FROM MANUSCRIPTS_UPLOADED_FILES WHERE CAMERA_READY_REVISION = ? AND MANUSCRIPT_ID = ? AND USER_ID = ?";
					sql += designationsClause.toString();
					int count = this.getJdbcTemplate().queryForObject(sql, new Object[] {revisionCount, manuscriptId, userId}, Integer.class);
					return count;
				}catch(EmptyResultDataAccessException e) {
					return 0;
				}
			}
		}
	}

	public void update(UploadedFile uf) {
		this.getJdbcTemplate().update("UPDATE MANUSCRIPTS_UPLOADED_FILES SET MANUSCRIPT_ID = ?," +
				"USER_ID = ?," +
				"NAME = ?," +
				"DESIGNATION = ?," +
				"ABSOLUTE_PATH = ?," +
				"PATH = ?," +
				"ORIGINAL_NAME = ?," +
				"CONFIRM = ?," +
				"REVISION_COUNT = ?, " +
				"GALLERY_PROOF_REVISION = ?," +
				"CAMERA_READY_REVISION = ? " + 
				"WHERE ID = ?", new Object[] {uf.getManuscriptId(), uf.getUserId(), uf.getName(), uf.getDesignation(), uf.getAbsolutePath(), uf.getPath(), 
				uf.getOriginalName(), uf.isConfirm(), uf.getRevisionCount(), uf.getGalleryProofRevision(), uf.getCameraReadyRevision(), uf.getId()});
	}
	public void deleteFileById(int id) {
		this.getJdbcTemplate().update("DELETE FROM MANUSCRIPTS_UPLOADED_FILES WHERE ID = ?", id);
	}
	@Override
	public int insert(UploadedFile uf) {
		String sql = "INSERT INTO MANUSCRIPTS_UPLOADED_FILES (ID, USER_ID, MANUSCRIPT_ID, NAME, DESIGNATION, ABSOLUTE_PATH, PATH, ORIGINAL_NAME, CONFIRM, REVISION_COUNT,"
				+ "GALLERY_PROOF_REVISION, CAMERA_READY_REVISION, DATE, TIME) " +
				"VALUES (:id, :userId, :manuscriptId, :name, :designation, :absolutePath, :path, :originalName, :confirm, :revisionCount, :galleryProofRevision, :cameraReadyRevision, UTC_DATE(), UTC_TIME())";		
		
		SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(uf);
		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getNamedParameterJdbcTemplate().update(sql, parameterSource, generatedKeyHolder);
		return generatedKeyHolder.getKey().intValue();
	}
	
}
