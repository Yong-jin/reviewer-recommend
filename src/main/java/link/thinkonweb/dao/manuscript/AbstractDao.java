package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.ManuscriptAbstract;


public interface AbstractDao {
	public void insert(ManuscriptAbstract manuscriptAbstract);
	public ManuscriptAbstract findById(int id);
	public ManuscriptAbstract findByRevisionCountAndManuscriptId(int revisionCount, int manuscriptId);
	public List<ManuscriptAbstract> findByManuscriptId(int manuscriptId);
	public void update(ManuscriptAbstract manuscriptAbstract);
	public void delete(ManuscriptAbstract manuscriptAbstract);
	void setDataSource(DataSource dataSource);
}
