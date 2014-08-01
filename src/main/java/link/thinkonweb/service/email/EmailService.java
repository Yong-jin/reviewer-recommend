package link.thinkonweb.service.email;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.user.SystemUser;

public interface EmailService {
	public EmailMessage getGeneralEmailMessage(int mailId, Manuscript manuscript, Journal journal, String toEmail, HttpServletRequest request, Locale locale);
	public void sendEmail(int mailId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale);
	public void sendEmailOther(int mailId, String email, EmailMessage emailMessage, HttpServletRequest request, Locale locale);
	public void sendEmailToAuthorsWithMessageModification(int mailId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale);
	public void sendEmailToReviewerWithMessageModification(int mailId, SystemUser reviewerUser, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale);
	public void sendEmailAtAccountCreation(int mailId, SystemUser creator, SystemUser createe, Journal journal, String password, HttpServletRequest request, Locale locale);
}

