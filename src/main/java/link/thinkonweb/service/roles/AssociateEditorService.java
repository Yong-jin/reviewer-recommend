package link.thinkonweb.service.roles;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.roles.AssociateEditor;
import link.thinkonweb.domain.user.SystemUser;

public interface AssociateEditorService {
	public AssociateEditor getAssociateEditor(int userId, int journalId);
	public void update(AssociateEditor ae);
	public void createAssociateEditor(AssociateEditor ae);
	public void selectAssociateEditor(int userId, int journalId);
	public void deleteAssociateEditor(int userId, int journalId);
	public List<AssociateEditor> getAssociateEditorsByJournalId(int journalId);
	public List<AssociateEditor> getAssociateEditorsAll();
	public void sendReviewResultToChief(Manuscript manuscript, int recommend, String commentToChief, String commentToAuthor, int scopeToChief, Journal journal, HttpServletRequest request, Locale locale);
	public void take(Manuscript manuscript, SystemUser user, Journal journal, HttpServletRequest request, Locale locale);
	public void decline(Manuscript manuscript, EmailMessage emailMessage, String comments, Journal journal, HttpServletRequest request, Locale locale);
	public void checkAssignedAssociateEditor();
	
	/*
	public void selectReviewer(int accountId, int manuscriptID);
	public void selectReviewer(Account account, int manuscriptID);
	public void selectReviewer(ReviewerSelectCriteria criteria, int manuscriptID);
	public void deleteReviewer(ReviewerSelectCriteria criteria, int manuscriptId);
	public void dismissReviewer(ReviewerSelectCriteria criteria, int manuscriptId, int dismissStatus);
	public void inviteRequestRecord(int manuscriptID, int aeID, int reviewerID, String randomQuery);
	public String generateRandomQuery();
	public List<Reviewer> getCurrentReviewerList(int manuscriptId, int decisionCount);
	public List<List<Reviewer>> getPastReviewerList(int manuscriptId, int decisionCount);
	public List<List<Reviewer>> getMultiReviewerList(int manuscriptID);	
	public List<Reviewer> getReviewerList(int manuscriptID, int decisionCount);
	public List<Reviewer> deleteReviewer(int reviewerID, int manuscriptID, int decisionCount);
	public Reviewer getReviewerByID(int reviewerID);
	public Decline getDeclineInfoByReviewerId(int getDeclineInfoReviewerID);
	public void reviewerInit(int assignReviewerID, int manuscriptID);
	public String assignAction(int manuscriptID, Account assignReviewerAccount, int assignReviewerID, AssignReviewerEmailNotifyForm assignReviewerEmailNotifyForm, RequestContext context);
	public String inviteAction(int manuscriptID, Account inviteReviewerAccount, int aeAccountID, int inviteReviewerID, InviteReviewerEmailNotifyForm inviteReviewerEmailNotifyForm, String randomQuery);
	
	
	public List<Manuscript> getManuscriptForReviewerAssign(int accountId);
	public List<Manuscript> getManuscriptForReReviewerAssign(int accountId);
	public List<Manuscript> getManuscriptForAe(int aeId);
	
	public List<Account> getBoardMember(Manuscript manuscript);
	
	public void createReviewerAndSelect(Contact contact, int manuscriptId);
	public int calculateSuggestDecision(int manuscriptId);
	public boolean checkDuplicateReviewer(int accountId, int manuscriptId, int decisionCount);
	public List<Account> getAllAccountForReviewerCandidateByManuscriptId(int manuscriptId);
	public void cancelInviteReviewer(int cancelInviteReviewerId);
	public void checkExpiredInviteReviewer();
	public void preFilteringManuscript(ManuscriptAEComment manuscriptAEComment);
	public void forceRecommendManuscript(ManuscriptAEComment manuscriptAEComment);
	*/
}
