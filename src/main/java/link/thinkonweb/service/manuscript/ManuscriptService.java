package link.thinkonweb.service.manuscript;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.EventDateTime;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.util.DataTableClientRequest;

public interface ManuscriptService {
	
	public int 					init(int userId, int journalId);
	public void 				setStep(Manuscript manuscript, int step);
	public void 				withdrawManuscript(int manuscriptId);
	public void 				cameraReadyConfirm(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void 				submitAction(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void					publishAction(Manuscript manuscript);
	public void 				updateKeyword(Manuscript manuscript);
	public void					update(Manuscript manuscript);
	public void 				setCurrentDate(Manuscript manuscript, String dateColumnName, String timeColumnName);
	public void 				updateDate(Manuscript manuscript, String dateColumnName, String timeColumnName, int addedDate);
	public void					checkResubmitDuration();
	public void					checkCameraReadyDuration();
	public void					extendDueDate(EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale, String dateString);
	
	public Manuscript			updateRevision(Manuscript manuscript, int nextRevision);
	public Manuscript 			getManuscriptById(int id, int level);
	
	public List<FinalDecision>	getFinalDecisionsByManuscriptId(int manuscriptId);
	
	
	public List<Manuscript> 	getSubmittedManuscripts(int userId, int journalId, String status);
	public List<Manuscript> 	getSubmittedManuscripts(int journalId, String status, int revisionCount);
	public List<Manuscript> 	getSubmittedManuscripts(int userId, int journalId, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel);
	public List<Manuscript> 	getSubmittedManuscriptsFromManagerConfiguration(Journal journal, List<String> status, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, List<String> indexNames, int buildLevel);
	public int 					numSubmittedManuscripts(int userId, int journalId, List<String> status);
	public int 					numSubmittedManuscripts(int journalId, String status);
	public int 					numSubmittedManuscripts(int journalId, String status, int revisionCount);
	public List<Manuscript> 	getCoWrittenManuscripts(int userId, int journalId, String status, boolean includeWrittenByMe);
	public List<Manuscript> 	getCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel);
	public int 					numCoWrittenManuscripts(int userId, int journalId, List<String> status, boolean includeWrittenByMe);
	public List<Manuscript>		getManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel);
	public int					numManuscriptsByRoleUserId(int userId, int journalId, String role, List<String> status, int revisionCount);
	
	public List<Manuscript>		getManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel);
	public int					numManuscriptsByAssociateEditorUserId(int editorUserId, int journalId, String editorStatus, List<String> status, int revisionCount);
	
	public List<Manuscript>		getManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount, DataTableClientRequest dRequest, int[] iTotalDisplayRecordsPlaceHolder, List<String> sortableColumnNames, int buildLevel);
	public int					numManuscriptsByGuestEditorUserId(int editorUserId, int journalId, List<Integer> specialIssueIds, List<String> status, int revisionCount);
	
	public List<Integer> 		getCoWrittenManuscriptIdsByUserFromMyActivity(int userId, DataTableClientRequest dRequest);  // by yhhan
	public EventDateTime 		generateEventDateTime(Manuscript manuscript);
}
