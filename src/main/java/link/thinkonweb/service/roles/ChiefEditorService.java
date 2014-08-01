package link.thinkonweb.service.roles;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.roles.ChiefEditor;
import link.thinkonweb.domain.user.SystemUser;

public interface ChiefEditorService {
	public int createFinalDecision(FinalDecision fd);
	public void createChiefEditor(ChiefEditor ce);
	public List<ChiefEditor> getChiefEditorsByJournalId(int journalId);
	public void forceToRejectAction(EmailMessage emailMessage, String comments, SystemUser chiefUser, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void selectAssociateEditor(int editorUserId, int manuscriptId);
	public void cancelAssignedEditor(Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void assignAssociateEditor(EmailMessage emailMessage, AssociateEditor ae, Manuscript manuscript, SystemUser chief, String comments, int scopeToManager, Journal journal, HttpServletRequest request, Locale locale);
	public void selectChiefEditor(int userId, int journalId);
	public void deleteChiefEditor(int userId, int journalId);
	public FinalDecision getFinalDecision(int manuscriptId, int revisionCount);
	public void finalDecisionAction(FinalDecision finalDecision, String postCommentToAuthor, String postCommentToEditorAndManager, EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	
	/*
	
	public List<ReviewedManuscript> getReviewedManuscript();
	public List<ReviewedManuscript> getReReviewedManuscript();
	public int calculateFinalDecision(List<Integer> overallList);
	public Manuscript setFinalDecision(int manuscriptID, int decision);
	

	
	public List<List<Reviewer>> getReviewersByManuscriptId(int manuscriptId);
	public FinalDecisionForm makeFinalDecisionForm(int manuscriptId, int suggestDecision);
	public boolean setFinalDecision(FinalDecisionForm finalDecisionForm);
	public boolean setProvisionalDecision(FinalDecisionForm finalDecisionForm);
	
	*/
}
