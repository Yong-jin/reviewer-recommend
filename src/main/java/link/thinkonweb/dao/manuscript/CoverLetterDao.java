package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.CoverLetter;


public interface CoverLetterDao {
	public void insert(CoverLetter coverLetter);
	public CoverLetter findById(int id);
	public CoverLetter findByRevisionCountAndManuscriptId(int revisionCount, int manuscriptId);
	public List<CoverLetter> findByManuscriptId(int manuscriptId);
	public void update(CoverLetter coverLetter);
	public void delete(CoverLetter coverLetter);
	void setDataSource(DataSource dataSource);
}
