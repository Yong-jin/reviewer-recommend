package link.thinkonweb.service.roles;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.FinalDecision;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.roles.GuestEditor;
import link.thinkonweb.domain.user.SystemUser;

public interface GuestEditorService {
	public int createFinalDecision(FinalDecision fd);
	public void createGuestEditor(GuestEditor ae);
	public void update(GuestEditor ae);
	public void selectGuestEditor(int userId, int journalId);
	public void deleteGuestEditor(int userId, int journalId);
	public void forceToRejectAction(EmailMessage emailMessage, String comments, SystemUser guestEditorUser, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public void finalDecisionAction(FinalDecision finalDecision, String postCommentToAuthor, String postCommentToManager, EmailMessage emailMessage, Manuscript manuscript, Journal journal, HttpServletRequest request, Locale locale);
	public GuestEditor getGuestEditor(int userId, int journalId);
	public List<GuestEditor> getGuestEditorsByJournalId(int journalId);
	public FinalDecision getFinalDecision(int manuscriptId, int revisionCount);
	
}
