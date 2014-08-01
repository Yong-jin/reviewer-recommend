package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.Title;


public interface TitleDao {
	public void insert(Title manuscriptTitle);
	public Title findById(int id);
	public Title findByRevisionCountAndManuscriptId(int revisionCount, int manuscriptId);
	public List<Title> findByManuscriptId(int manuscriptId);
	public void update(Title manuscriptTitle);
	public void delete(Title manuscriptTitle);
	void setDataSource(DataSource dataSource);
}