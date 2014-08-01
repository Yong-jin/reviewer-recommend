package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.GuestEditorSpecialIssue;


public interface GuestEditorSpecialIssueDao {
	public int insert(GuestEditorSpecialIssue geSpecialIssue);
	public GuestEditorSpecialIssue findById(int id);
	public void update(GuestEditorSpecialIssue geSpecialIssue);
	public void delete(int geSpecialIssueId);
	public void delete(int geUserId, int journalId, int specialIssueId);
	public List<GuestEditorSpecialIssue> findGeSpecialIssue(int geUserId, int journalId);
	public GuestEditorSpecialIssue create(int geId, int journalId, int specialIssueId);
}
