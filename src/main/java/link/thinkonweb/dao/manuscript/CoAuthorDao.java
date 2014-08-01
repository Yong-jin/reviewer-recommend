package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.util.DataTableClientRequest;



public interface CoAuthorDao {
	public void insert(CoAuthor coAuthor);
	public void update(CoAuthor coAuthor);
	public void delete(CoAuthor coAuthor);
	public int getNumOfRecordsByCustomSql(String sql);
	public CoAuthor findCoAuthor(int manuscriptId, int userId, int revisionCount, int authorOrder, boolean corresponding);
	public List<CoAuthor> findCoAuthors(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding);
	public List<Integer> findCoAuthorIds(int manuscriptId, int revisionCount, int authorOrder, boolean corresponding);
	public List<CoAuthor> findAll(int manuscriptId);
	public List<Integer> findManuscriptIdsByUserCoAuthorsFromMyActivity(int userId, DataTableClientRequest dRequest);
}