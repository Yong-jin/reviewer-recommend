package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.SpecialIssue;
import link.thinkonweb.util.DataTableClientRequest;

public interface SpecialIssueDao {
	public int insert(SpecialIssue specialIssue);
	public SpecialIssue findById(int id);
	public void update(SpecialIssue specialIssue);
	public void delete(int id);
	public List<SpecialIssue> findByJournalId(int journalId);
	public List<SpecialIssue> findByJournalId(int journalId, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<SpecialIssue> findAll();
}
