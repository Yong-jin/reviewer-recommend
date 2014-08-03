package link.thinkonweb.dao.manuscript;

import java.util.List;

import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.util.DataTableClientRequest;


public interface ManuscriptDao {

	public int 				insert(Manuscript manuscript);
	public Manuscript 		findById(int id);
	
	
	// Reading용 핵심 메소드 - start
	public List<Manuscript> findSubmittedManuscripts(int userId, int journalId, String status);
	public List<Manuscript> findSubmittedManuscripts(int userId, int journalId, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public List<Manuscript> findSubmittedManuscriptsFromManagerConfiguration(Journal journal, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, List<String> indexNames);
	public int 				numSubmittedManuscripts(int userId, int journalId, List<String> status);
	public int 				numSubmittedManuscripts(int journalId, String status);
	public List<Manuscript> findSubmittedManuscripts(int journalId, String status, int revisionCount);
	public int numSubmittedManuscripts(int journalId, String status, int revisionCount);
	
	public List<Manuscript> findCoWrittenManuscripts(int userId, int journalId, String status, boolean includeWrittenByMe);
	public List<Manuscript> findCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int 				numCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe);
	// Reading용 핵심 메소드 - end
	
	public void 			update(Manuscript manuscript);
	public void 			delete(int manuscriptId);
	public void				setCurrentDate(Manuscript manuscript, String dateColumnName, String timeColumnName);
	public void				updateDate(Manuscript manuscript, String dateColumnName, String timeColumnName, int addedDate);
	
	
	public List<Manuscript> findManuscriptsExceptSpecificStatus(List<String> status, int journalId);
	
	public List<Manuscript> findManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int				numManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount);
	
	
	public List<Manuscript> findManuscriptsByChiefEditorUserId(int editorUserId, int journalId, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int				numManuscriptsByChiefEditorUserId(int editorUserId, int journalId, List<String> status, int revisionCount);
	
	
	public List<Manuscript> findManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int				numManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount);
	
	public List<Manuscript> findManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames);
	public int				numManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount);
	
	public int 				getNumOfRecordsByCustomSql(String sql);	
}
