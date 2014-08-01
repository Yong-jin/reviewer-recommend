package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.RunningHead;


public interface RunningHeadDao {
	public void insert(RunningHead manuscriptRunningHead);
	public RunningHead findById(int id);
	public RunningHead findByRevisionCountAndManuscriptId(int revisionCount, int manuscriptId);
	public List<RunningHead> findByManuscriptId(int manuscriptId);
	public void update(RunningHead manuscriptRunningHead);
	public void delete(RunningHead manuscriptRunningHead);
	void setDataSource(DataSource dataSource);
}
