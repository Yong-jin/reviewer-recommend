package link.thinkonweb.dao.journal;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.journal.SubmittedManuscripts;


public interface SubmittedManuscriptDao {
	public void insert(SubmittedManuscripts submittedManuscript);
	public List<SubmittedManuscripts> getSubmittedManuscriptByYear(int journalId, int year);
	public SubmittedManuscripts getSubmittedManuscript(int journalId, int year, int month);
	public void update(SubmittedManuscripts submittedManuscript);
	public void setDataSource(DataSource dataSource);
}
