package link.thinkonweb.service.email;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TimeZone;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.dao.email.EmailDeliveryDao;
import link.thinkonweb.dao.email.EmailMessageDao;
import link.thinkonweb.dao.journal.SpecialIssueDao;
import link.thinkonweb.dao.manuscript.EventDateTimeDao;
import link.thinkonweb.dao.manuscript.form.CommentDao;
import link.thinkonweb.dao.user.UserDao;
import link.thinkonweb.domain.constants.EmailDesignation;
import link.thinkonweb.domain.email.EmailDelivery;
import link.thinkonweb.domain.email.EmailDeliverySet;
import link.thinkonweb.domain.email.EmailMessage;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.JournalConfiguration;
import link.thinkonweb.domain.manuscript.CoAuthor;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.domain.manuscript.Review;
import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.roles.Manager;
import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.journal.JournalConfigurationService;
import link.thinkonweb.service.journal.JournalService;
import link.thinkonweb.service.manuscript.CoAuthorService;
import link.thinkonweb.service.manuscript.ManuscriptService;
import link.thinkonweb.service.roles.ManagerService;
import link.thinkonweb.service.roles.ReviewerService;
import link.thinkonweb.service.user.ContactService;
import link.thinkonweb.service.user.UserService;
import link.thinkonweb.util.SystemUtil;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceAsyncClient;
import com.amazonaws.services.simpleemail.model.Body;
import com.amazonaws.services.simpleemail.model.Content;
import com.amazonaws.services.simpleemail.model.Destination;
import com.amazonaws.services.simpleemail.model.Message;
import com.amazonaws.services.simpleemail.model.SendEmailRequest;
import com.amazonaws.services.simpleemail.model.SendEmailResult;

public class EmailServiceImpl implements EmailService {
	@Autowired
	private UserService userService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private EmailMessageDao emailMessageDao;
	@Autowired
	private EmailDeliveryDao emailDeliveryDao;
	@Autowired
	private SystemUtil systemUtil;
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private JournalService journalService;
	@Autowired
	private ManuscriptService manuscriptService;
	@Autowired
	private CoAuthorService coAuthorService;
	@Autowired
	private EventDateTimeDao eventTimeDao;
	@Autowired
	private ManagerService managerService;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private SpecialIssueDao specialIssueDao;
	@Autowired
	private ContactService contactService;
	@Autowired
	private ReviewerService reviewerService;
	@Autowired
	private JournalConfigurationService jcService;
	@Autowired
	private EventDateTimeDao eventDateTimeDao;
	@Autowired
	private VelocityEngine velocityEngine;

	
	@Autowired 
	private AmazonSimpleEmailServiceAsyncClient amazonSimpleEmailServiceAsyncClient;
		
	@Override
	public EmailMessage getGeneralEmailMessage(int mailId, Manuscript manuscript, Journal journal, String toEmail, HttpServletRequest request, Locale locale) {
		String subject = null;
		String body = null;
		String velocityTemplate = null;
		String closingRole = null;
		String receiverRolesString = null;
		String toRole = null;
		String journalTitle = null;
		String journalShortTitle = null;
		String journalShortTitleOrTitle = null;
		int journalTypeId = 0;		
		
		Locale journalLocale = null;
		if (journal == null) {
			if (locale.getCountry().equals("KR")) {
				velocityTemplate = "/emails/email_kr.vm";
				journalLocale = Locale.KOREAN;
			} else {
				velocityTemplate = "/emails/email_en.vm";
				journalLocale = Locale.ENGLISH;
			}
			
		} else {
			if (journal.getLanguageCode().equals("ko")) {
				velocityTemplate = "/emails/email_kr.vm";
				journalLocale = Locale.KOREAN;
			} else {
				velocityTemplate = "/emails/email_en.vm";
				journalLocale = Locale.ENGLISH;
			}
			switch(journal.getType()) {
				case "A":
					journalTypeId = 0;
					break;
				case "B":
					journalTypeId = 1;
					break;
				case "C":
					journalTypeId = 2;
					break;
				case "D":
					journalTypeId = 3;
					break;
			}
			closingRole = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscript.getManuscriptTrackId()][0];
	    	
	    	receiverRolesString = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscript.getManuscriptTrackId()][1];
	    	journalTitle = journal.getTitle();
	    	journalShortTitle = journal.getShortTitle();
	    	journalShortTitleOrTitle = journalShortTitle != null ? journalShortTitle : journalTitle;
		}
		
    	if (receiverRolesString != null) {    		
	    	StringTokenizer st = new StringTokenizer(receiverRolesString, "/");
	    	while (st.hasMoreElements()) {
	    		toRole = (String)st.nextElement();
	    		break;
	    	}
    	}
    	
    	

    	//String journalTitleAndShortTitleInPaParentheses = journalShortTitle != null && !journalShortTitle.equals(journalTitle) ? journalTitle + " (" + journalShortTitle + ")" : journalTitle;
    	
	    if (mailId == 0 || mailId == 1 || mailId == 4 || mailId == 50 || mailId == 51 || mailId == 52) {
	    	subject = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{journalShortTitleOrTitle}, journalLocale);
	    } else if (mailId == 49 || mailId == 54) {
	    	subject = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", null, journalLocale);
	    } else {
	    	subject = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{manuscript.getSubmitId(), journalShortTitleOrTitle}, journalLocale);
	    }
	    
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("mailId", mailId);
		model.put("closingRole", closingRole);
    	model.put("toRole", toRole);
    	if(mailId != 54) {
	        model.put("journal", journal);
	        model.put("manuscript", manuscript);
	        model.put("manuscriptTrackId", manuscript.getManuscriptTrackId());
	        if(manuscript.getManuscriptTrackId() != 0)
	        	model.put("specialIssueTitle", specialIssueDao.findById(manuscript.getSpecialIssueId()).getTitle());
	        model.put("journalUrl", SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId());
	        model.put("userService", userService);
	    	model.put("coAuthorService", coAuthorService);
	    	model.put("contactService", contactService);
	    	model.put("reviewerService", reviewerService);
	    	model.put("systemUtil", systemUtil);
	    	model.put("request", request);
	    	model.put("locale", locale);
	    	model.put("toEmail", toEmail);
	    	model.put("journalType", journal.getType());
	    	model.put("journalConfigurationService", jcService);
    	}
    	model.put("messageSource", messageSource);
    	
        body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, velocityTemplate, "UTF-8", model);
        if(mailId == 31 || mailId == 32 || mailId == 33 || mailId == 39) {
        	JournalConfiguration jc = jcService.getByJournalId(journal.getId());
        	if(mailId == 31) {
        		
        		Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
        		dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getCameraSubmitDuration());
        		java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
    			SimpleDateFormat sdf = null;
    			if(journal.getLanguageCode().equals("ko"))
    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
    			else
    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
        		body = body.replace("[cameraReadySubmitDate]", sdf.format(dueDate));
        	} else if(mailId == 32) {
        		Calendar dueDateCalendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
        		dueDateCalendar.add(Calendar.DAY_OF_YEAR, jc.getResubmitDuration());
        		java.sql.Date dueDate = new java.sql.Date(dueDateCalendar.getTimeInMillis());
    			SimpleDateFormat sdf = null;
    			if(journal.getLanguageCode().equals("ko"))
    				sdf = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREAN);
    			else
    				sdf = new java.text.SimpleDateFormat("MMMMM dd, yyyy", Locale.US);
        		body = body.replace("[updatedManuscriptSubmitDate]", sdf.format(dueDate));
        	}
        	
    		int manuscriptId = manuscript.getId();
    		List<Comment> comments = commentDao.findByManuscriptId(manuscriptId);
    		int reviewerCount = 1;
    		StringBuffer reviewResultBuffer = new StringBuffer();
    		String commentByAE = "";
    		String reviewResults = "";
    		for(Comment comment : comments) {
    			if(comment.getFromRole().equals(SystemConstants.roleAEditor) && comment.getToRole().equals(SystemConstants.roleMember) && comment.getRevisionCount() == manuscript.getRevisionCount())
    				commentByAE = comment.getText();
    			
    			if(comment.getFromRole().equals(SystemConstants.roleReviewer) && comment.getToRole().equals(SystemConstants.roleMember) && comment.getRevisionCount() == manuscript.getRevisionCount()) {
    				reviewResultBuffer.append("Reviewer #" + reviewerCount + "\n\n");
    				int reviewerUserId = comment.getFromUserId();
    				List<Review> reviews = reviewerService.getReviews(reviewerUserId, manuscriptId, journal.getId(), comment.getRevisionCount(), SystemConstants.reviewerC);
    				if(reviews != null && reviews.size() > 0) {
	    				Review review = reviews.get(0);
	    				int reviewItemCount = review.getNumberOfReviewItems();
	    				for(int i=1; i<=reviewItemCount; i++) {
	    					int reviewItemId = review.getReviewItemId(i);
	    					String reviewItemString = messageSource.getMessage("review.item." + reviewItemId, null, journalLocale);
	    					reviewResultBuffer.append(reviewItemString + ": ");
	    					int score = review.getScore(i);
	    					if(reviewItemId != 1) {
								switch(score) {
									case 1:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.poor", null, journalLocale));
										break;
									case 2:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.weak", null, journalLocale));
										break;
									case 3:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.average", null, journalLocale));
										break;
									case 4:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.good", null, journalLocale));
										break;
									case 5:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.excellent", null, journalLocale));
										break;
								}
							
	    					} else if(reviewItemId == 1) {
	    						switch(score) {
									case 1:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.low", null, journalLocale));
										break;
									case 2:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.medium", null, journalLocale));
										break;
									case 3:
										reviewResultBuffer.append(messageSource.getMessage("reviewResult.high", null, journalLocale));
										break;
	    						}
	    					}
	    					reviewResultBuffer.append("\n");
	    				}

						reviewResultBuffer.append(messageSource.getMessage("reviewResult.overall", null, journalLocale) + ": ");
						reviewResultBuffer.append(messageSource.getMessage("reviewResult.score." + review.getOverall(), null, journalLocale));

	    				reviewResultBuffer.append("\n\n");
	    				reviewResultBuffer.append(comment.getText());
	    				reviewResultBuffer.append("\n\n");
	    				reviewerCount++;
    				}
    			}
    		}
    		reviewResults = reviewResultBuffer.toString().trim();

    		if(manuscript.getManuscriptTrackId() == 0)
    			body = body.replace("[reviewResultByEditorTitle]", messageSource.getMessage("email.reviewResultByChiefEditorTitle", null, journalLocale));
    		else
    			body = body.replace("[reviewResultByEditorTitle]", messageSource.getMessage("email.reviewResultByGuestEditorTitle", null, journalLocale));

    		if(manuscript.getManuscriptTrackId() == 1 || commentByAE.equals("")) {
    			int startIndex = body.indexOf("[reviewResultByAssociateEditorTitle]");
    			int endIndex = body.indexOf("[reviewResultByReviewersTitle]");
    			String removable = body.substring(startIndex, endIndex);
    			body = body.replace(removable, "");
    		} else {
    			body = body.replace("[reviewResultByAssociateEditorTitle]", messageSource.getMessage("email.reviewResultByAssociateEditorTitle", null, journalLocale));
    			body = body.replace("[reviewResultByAssociateEditor]", commentByAE + "\n");
    		}
    		if(reviewResults.equals("") || reviewResults.length() == 0) {
    			int startIndex = body.indexOf("[reviewResultByReviewersTitle]");
    			int endIndex = body.indexOf("[reviewResultByReviewers]") + "[reviewResultByReviewers]".length();
    			body = body.substring(0, startIndex) + body.substring(endIndex).replaceFirst(System.getProperty("line.separator"), "").replaceFirst(System.getProperty("line.separator"), "");
    		} else {
    			body = body.replace("[reviewResultByReviewersTitle]", messageSource.getMessage("email.reviewResultByReviewerTitle", null, journalLocale));
    			body = body.replace("[reviewResultByReviewers]", reviewResults);
    		}
        }
     
        return new EmailMessage(subject, body);
	}
	
	@Override //Only mailId = 49, 50, 51, 52, 53
	public void sendEmailAtAccountCreation(int mailId, SystemUser creator, SystemUser createe, Journal journal, String randomPassword, HttpServletRequest request, Locale locale) {
		if (mailId < 49 || mailId > 53) {
			return;
		}
		String velocityTemplate = null;
		Locale journalLocale = null;
		if (journal == null) {
			if (locale.getCountry().equals("KR")) {
				velocityTemplate = "/emails/email_kr.vm";
				journalLocale = Locale.KOREAN;
			} else {
				velocityTemplate = "/emails/email_en.vm";
				journalLocale = Locale.ENGLISH;
				
			}
		} else {
			if (journal.getLanguageCode().equals("ko")) {
				velocityTemplate = "/emails/email_kr.vm";
				journalLocale = Locale.KOREAN;
			} else {
				velocityTemplate = "/emails/email_en.vm";
				journalLocale = Locale.ENGLISH;
			}
		}
		String closingRole = "ML";
		
		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
		Map<String, Object> model = null;
		String subject = null;
		String body = null;
		
		if (mailId == 50 || mailId == 51 || mailId == 52 || mailId == 53) {
			String journalTitle = journal.getTitle();
	    	String journalShortTitle = journal.getShortTitle();
	    	String journalShortTitleOrTitle = journalShortTitle != null ? journalShortTitle : journalTitle;
	    	subject = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", new String[]{journalShortTitleOrTitle}, journalLocale);
	    } else if (mailId == 49) {
	    	subject = messageSource.getMessage(EmailDesignation.getType(mailId).name() + ".subject", null, journalLocale);
	    }
		
		model = new HashMap<String, Object>();
		model.put("mailId", mailId);
		model.put("closingRole", closingRole);
    	model.put("systemUtil", systemUtil);
    	model.put("request", request);
    	model.put("locale", locale);
    	model.put("messageSource", messageSource);
    	
		if (mailId == 49) {
			emailDeliveries.add(new EmailDelivery(creator.getUsername(), creator.getId(), 0, 0, false));
			emailDeliverySet.setEmailDeliveries(emailDeliveries);
	    	model.put("toRole", "OW");
			model.put("accountCreator", creator);
	    	model.put("toEmail", creator.getUsername());
		} else if (mailId == 50) {
			emailDeliveries.add(new EmailDelivery(creator.getUsername(), creator.getId(), journal.getId(), 0, false));
			emailDeliverySet.setEmailDeliveries(emailDeliveries);
			model.put("toRole", "OW");
			model.put("accountCreator", creator);
	    	model.put("toEmail", creator.getUsername());
	    	model.put("journal", journal);
	        model.put("journalUrl", SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId());
		} else if (mailId == 51) {
			emailDeliveries.add(new EmailDelivery(createe.getUsername(), createe.getId(), journal.getId(), 0, false));
			emailDeliverySet.setEmailDeliveries(emailDeliveries);
			model.put("toRole", "TE");
			model.put("accountCreator", creator);
			model.put("accountCreatee", createe);
	    	model.put("toEmail", createe.getUsername());
	    	model.put("randomPassword", randomPassword);
	    	model.put("journal", journal);
	        model.put("journalUrl", SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId());
		} else if (mailId == 52) {
			emailDeliveries.add(new EmailDelivery(createe.getUsername(), createe.getId(), journal.getId(), 0, false));
			emailDeliverySet.setEmailDeliveries(emailDeliveries);
			model.put("toRole", "TE");
			model.put("accountCreator", creator);
			model.put("accountCreatee", createe);
	    	model.put("toEmail", createe.getUsername());
	    	model.put("randomPassword", randomPassword);
	    	model.put("journal", journal);
	        model.put("journalUrl", SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId());
		} else if (mailId == 53) {
			emailDeliveries.add(new EmailDelivery(createe.getUsername(), createe.getId(), journal.getId(), 0, false));
			emailDeliverySet.setEmailDeliveries(emailDeliveries);
			model.put("toRole", "TE");
			model.put("accountCreator", creator);
			model.put("accountCreatee", createe);
	    	model.put("toEmail", createe.getUsername());
	    	model.put("randomPassword", randomPassword);
	    	model.put("journal", journal);
	        model.put("journalUrl", SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId());
		}
        body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, velocityTemplate, "UTF-8", model);
		emailDeliverySet.setEmailMessage(new EmailMessage(subject, body));

		this.sendAmazonEmail(mailId, emailDeliverySet);
	}
	
	
	@Override
	public void sendEmailToAuthorsWithMessageModification(int mailId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale) {
		
		String originalBody = emailMessage.getBody();
		String toRole = null;
    	ArrayList<String> receiverRolesList = new ArrayList<String>();
    	String receiverRolesString = null;
    	String[] ccRoles = null;
    	int journalTypeId = 0;
		
		switch(journal.getType()) {
			case "A":
				journalTypeId = 0;
				break;
			case "B":
				journalTypeId = 1;
				break;
			case "C":
				journalTypeId = 2;
				break;
			case "D":
				journalTypeId = 3;
				break;
		}
		
    	receiverRolesString = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscript.getManuscriptTrackId()][1];

    	if (receiverRolesString != null) {    		
	    	StringTokenizer st = new StringTokenizer(receiverRolesString, "/");
	    	int i = 0;
	    	while (st.hasMoreElements()) {
	    		receiverRolesList.add(i, (String)st.nextElement());
	    		i++;
	    	}
	    	toRole = receiverRolesList.get(0);
	    	receiverRolesList.remove(0);
	    	ccRoles = (String[])receiverRolesList.toArray(new String[receiverRolesList.size()]);
	    	
	    	String journalUrl = SystemConstants.baseUrl + "/journals/" + journal.getJournalNameId();
	    	
	    	if (toRole.equals(SystemConstants.rAuthors)) { //모든 Manager들에게 동일한 emailMessage 및 서로 다른 toEmail 값과 함께 메일 보내기
	    		// submitter에게 CC 추가하여 먼저 이메일 보내기
	    		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
	    		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
	    		SystemUser submitter = userService.getById(manuscript.getUserId());
	    		emailDeliveries.add(new EmailDelivery(submitter.getUsername(), submitter.getId(), journal.getId(), manuscript.getId(), false));
	    		
	    		for (String ccRole : ccRoles) {
	    			switch (ccRole) {
	    				case SystemConstants.rMember:
		    				SystemUser managerUser = manuscript.getManager();
		    				emailDeliveries.add(new EmailDelivery(managerUser.getUsername(), managerUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
	    				case SystemConstants.rCEditor:
		    				SystemUser chiefEditorUser = manuscript.getChiefEditor();
		    				emailDeliveries.add(new EmailDelivery(chiefEditorUser.getUsername(), chiefEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			case SystemConstants.rAEditor:
		    				if(manuscript.getAssociateEditor() != null) {
		    					SystemUser associateEditorUser = manuscript.getAssociateEditor();
		    					emailDeliveries.add(new EmailDelivery(associateEditorUser.getUsername(), associateEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				}
		    				break;
		    			case SystemConstants.rGEditor:
			    			SystemUser guestEditorUser = manuscript.getGuestEditor();
		    				emailDeliveries.add(new EmailDelivery(guestEditorUser.getUsername(), guestEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			default:
		    				System.out.println("Oopps!!!!!!! - additional cc should be added at sending Authors! - sendEmailToAuthorsWithMessageModification");
	    			}
	    		}
	    		emailDeliverySet.setEmailDeliveries(emailDeliveries);
	    		
	    		String body = new String(originalBody);
	    		
	    		if (journal.getLanguageCode().equals("ko")) {
	    			if (submitter.getContact().getLocalFullName() != null && !submitter.getContact().getLocalFullName().equals("")) {
	    				body = body.replace("논문 저자분께,", submitter.getContact().getLocalFullName() + " 논문 저자분께,");
	    			} else {
	    				body = body.replace("논문 저자분께,", messageSource.getMessage("signin.salutationDesignation." + submitter.getContact().getSalutation(), null, locale) + " " + submitter.getContact().getFirstName() + " " + submitter.getContact().getLastName() + " 논문 저자분께,");
	    			}
	    			body = body.replace("* 온라인 시스템 URL: " + journalUrl, "* 온라인 시스템 URL: " + journalUrl + "?id=" + submitter.getUsername());
	    		} else {
	    			String salutation = "";
	    			if(submitter.getContact().getSalutation() != null && !submitter.getContact().getSalutation().equals("-1"))
	    				salutation = messageSource.getMessage("signin.salutationDesignation." + submitter.getContact().getSalutation(), null, locale);
	    			body = body.replace("Dear Author,", salutation + " " + submitter.getContact().getFirstName() + " " + submitter.getContact().getLastName() + ",");
	    			body = body.replace("* Online System URL: " + journalUrl, "* Online System URL: " + journalUrl + "?id=" + submitter.getUsername());
	    		}
	    		
	    		

	    		emailMessage.setBody(body);
	    		emailDeliverySet.setEmailMessage(emailMessage);
	    		
	    		this.sendAmazonEmail(mailId, emailDeliverySet);
	    		
	    		// submitter를 제외한 나머지 저자에게 CC 추가하지 않고 이메일 보내기
	    		List<CoAuthor> coAuthors = manuscript.getCoAuthors();	
				for (CoAuthor coAuthor: coAuthors) {
					SystemUser otherAuthor = coAuthor.getUser();
					if (otherAuthor.getId() != submitter.getId()) { 
						emailDeliverySet = new EmailDeliverySet();
						emailDeliveries = new LinkedList<EmailDelivery>();
						emailDeliveries.add(new EmailDelivery(otherAuthor.getUsername(), otherAuthor.getId(), journal.getId(), manuscript.getId(), false));
						emailDeliverySet.setEmailDeliveries(emailDeliveries);
						
						String body2 = new String(originalBody);
			    		if (journal.getLanguageCode().equals("ko")) {
			    			if (otherAuthor.getContact().getLocalFullName() != null && !otherAuthor.getContact().getLocalFullName().equals("")) {
			    				body2 = body.replace("논문 저자분께,", submitter.getContact().getLocalFullName() + " 논문 저자분께,");
			    			} else {
			    				body2 = body.replace("논문 저자분께,", messageSource.getMessage("signin.salutationDesignation." + otherAuthor.getContact().getSalutation(), null, locale) + " " + otherAuthor.getContact().getFirstName() + " " + otherAuthor.getContact().getLastName() + " 논문 저자분께,");
			    			}
			    			body2 = body2.replace("* 온라인 시스템 URL: " + journalUrl, "* 온라인 시스템 URL: " + journalUrl + "?id=" + submitter.getUsername());
			    		} else {
			    			body2 = body2.replace("Dear Author,", messageSource.getMessage("signin.salutationDesignation." + otherAuthor.getContact().getSalutation(), null, locale) + " " + otherAuthor.getContact().getFirstName() + " " + otherAuthor.getContact().getLastName() + ",");
			    			body2 = body2.replace("* Online System URL: " + journalUrl, "* Online System URL: " + journalUrl + "?id=" + otherAuthor.getUsername());
			    		}

			    		emailMessage.setBody(body2);
			    		emailDeliverySet.setEmailMessage(emailMessage);
			    		
			    		this.sendAmazonEmail(mailId, emailDeliverySet);
					}
				}
	    	} else {
	    		System.out.println("In sendEmailToAuthorsWithMessageModication, toRole problem -- sent no email");
	    		return;
	    	}
    	} else {
    		System.out.println("In sendEmailToAuthorsWithMessageModication, receiverRolesString problem -- sent no email");
    		return;
    	}
	}
	@Override
	public void sendEmail(int mailId, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale) {
    	String toRole = null;
    	ArrayList<String> receiverRolesList = new ArrayList<String>();
    	String receiverRolesString = null;
    	String[] ccRoles = null;
    	int journalTypeId = 0;
		
		switch(journal.getType()) {
			case "A":
				journalTypeId = 0;
				break;
			case "B":
				journalTypeId = 1;
				break;
			case "C":
				journalTypeId = 2;
				break;
			case "D":
				journalTypeId = 3;
				break;
		}
		
    	receiverRolesString = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscript.getManuscriptTrackId()][1];

    	if (receiverRolesString != null) {
	    	StringTokenizer st = new StringTokenizer(receiverRolesString, "/");
	    	int i = 0;
	    	while (st.hasMoreElements()) {
	    		receiverRolesList.add(i, (String)st.nextElement());
	    		i++;
	    	}
	    	toRole = receiverRolesList.get(0);
	    	receiverRolesList.remove(0);
	    	ccRoles = (String[])receiverRolesList.toArray(new String[receiverRolesList.size()]);
	    	
	    	//System.out.println();
	    	//System.out.println("mailId: " + mailId + ", mailKey: " + EmailDesignation.getType(mailId).name());
	    	//System.out.println("TO ROLE: " + toRole);
	    	//System.out.println("CLOSING ROLE: " + closingRole);
	    	//System.out.println("CC ROLES: " + ccRoles);
	    	
	    	if (toRole.equals(SystemConstants.rAuthors)) { //모든 Manager들에게 동일한 emailMessage 및 서로 다른 toEmail 값과 함께 메일 보내기
	    		// submitter에게 CC 추가하여 먼저 이메일 보내기
	    		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
	    		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
	    		SystemUser submitter = userService.getById(manuscript.getUserId());
	    		emailDeliveries.add(new EmailDelivery(submitter.getUsername(), submitter.getId(), journal.getId(), manuscript.getId(), false));
	    		
	    		for (String ccRole : ccRoles) {
	    			switch (ccRole) {
	    				case SystemConstants.rMember:
		    				SystemUser managerUser = manuscript.getManager();
		    				emailDeliveries.add(new EmailDelivery(managerUser.getUsername(), managerUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
	    				case SystemConstants.rCEditor:
		    				SystemUser chiefEditorUser = manuscript.getChiefEditor();
		    				emailDeliveries.add(new EmailDelivery(chiefEditorUser.getUsername(), chiefEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			case SystemConstants.rAEditor:
		    				SystemUser associateEditorUser = manuscript.getAssociateEditor();
		    				emailDeliveries.add(new EmailDelivery(associateEditorUser.getUsername(), associateEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			case SystemConstants.rGEditor:
			    			SystemUser guestEditorUser = manuscript.getGuestEditor();
		    				emailDeliveries.add(new EmailDelivery(guestEditorUser.getUsername(), guestEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			default:
		    				System.out.println("Oopps!!!!!!! - additional cc should be added at sending Authors!");
	    			}
	    		}
	    		emailDeliverySet.setEmailDeliveries(emailDeliveries);
	    		
	    		if(emailMessage == null) {
	    			EmailMessage localEmailMessage = this.getGeneralEmailMessage(mailId, manuscript, journal, submitter.getUsername(), request, locale);
	    			emailDeliverySet.setEmailMessage(localEmailMessage);
	    		} else {
	    			emailDeliverySet.setEmailMessage(emailMessage);
	    		}
	    		
	    		this.sendAmazonEmail(mailId, emailDeliverySet);
	    		
	    		// submitter를 제외한 나머지 저자에게 CC 추가하지 않고 이메일 보내기
	    		List<CoAuthor> coAuthors = manuscript.getCoAuthors();	
				for (CoAuthor coAuthor: coAuthors) {
					SystemUser otherAuthor = coAuthor.getUser();
					if (otherAuthor.getId() != submitter.getId()) { 
						emailDeliverySet = new EmailDeliverySet();
						emailDeliveries = new LinkedList<EmailDelivery>();
						emailDeliveries.add(new EmailDelivery(otherAuthor.getUsername(), otherAuthor.getId(), journal.getId(), manuscript.getId(), false));
						emailDeliverySet.setEmailDeliveries(emailDeliveries);
			    		
			    		if(emailMessage == null) {
			    			EmailMessage localEmailMessage = this.getGeneralEmailMessage(mailId, manuscript, journal, otherAuthor.getUsername(), request, locale);
			    			emailDeliverySet.setEmailMessage(localEmailMessage);
			    		} else {
			    			emailDeliverySet.setEmailMessage(emailMessage);
			    		}
			    		
			    		this.sendAmazonEmail(mailId, emailDeliverySet);
					}
				}
	    	} else if (toRole.equals(SystemConstants.rMembers)) {//모든 Manager들에게 동일한 emailMessage 및 서로 다른 toEmail 값과 함께 메일 보내기, cc는 존재하지 않음
	    		List<Manager> managers = managerService.getManagersByJournalId(manuscript.getJournalId());
	    		for (Manager manager : managers) {
	    			EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
	    			List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
	    			SystemUser managerUser = manager.getUser();
	    			emailDeliveries.add(new EmailDelivery(managerUser.getUsername(), managerUser.getId(), journal.getId(), manuscript.getId(), false));
	    			emailDeliverySet.setEmailDeliveries(emailDeliveries);
		    		if(emailMessage == null) {
		    			EmailMessage localEmailMessage = this.getGeneralEmailMessage(mailId, manuscript, journal, managerUser.getUsername(), request, locale);
		    			emailDeliverySet.setEmailMessage(localEmailMessage);
		    		} else {
		    			emailDeliverySet.setEmailMessage(emailMessage);
		    		}
		    		
		    		
		    		this.sendAmazonEmail(mailId, emailDeliverySet);
	    		}
	    	} else {
	    		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
	    		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
	    		SystemUser toSystemUser = null;
	    		switch (toRole) {
	    			case SystemConstants.rMember:
	    				toSystemUser = manuscript.getManager();
	    				break;
	    			case SystemConstants.rCEditor:
	    				toSystemUser = manuscript.getChiefEditor();
	    				break;
	    			case SystemConstants.rAEditor:
	    				toSystemUser = manuscript.getAssociateEditor();
	    				break;
	    			case SystemConstants.rGEditor:
	    				toSystemUser = manuscript.getGuestEditor();
	    				break;
	    			case SystemConstants.rReviewer:
	    				break;
	    		}
	    		emailDeliveries.add(new EmailDelivery(toSystemUser.getUsername(), toSystemUser.getId(), journal.getId(), manuscript.getId(), false));
	    		for (String ccRole : ccRoles) {
	    			switch (ccRole) {
	    				case SystemConstants.rMember:
		    				SystemUser managerUser = manuscript.getManager();
		    				emailDeliveries.add(new EmailDelivery(managerUser.getUsername(), managerUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
	    				case SystemConstants.rCEditor:
		    				SystemUser chiefEditorUser = manuscript.getChiefEditor();
		    				emailDeliveries.add(new EmailDelivery(chiefEditorUser.getUsername(), chiefEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			case SystemConstants.rAEditor:
		    				SystemUser associateEditorUser = manuscript.getAssociateEditor();
		    				emailDeliveries.add(new EmailDelivery(associateEditorUser.getUsername(), associateEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			case SystemConstants.rGEditor:
			    			SystemUser guestEditorUser = manuscript.getGuestEditor();
		    				emailDeliveries.add(new EmailDelivery(guestEditorUser.getUsername(), guestEditorUser.getId(), journal.getId(), manuscript.getId(), true));
		    				break;
		    			default:
		    				System.out.println("Oopps!!!!!!! - additional cc should be added at sending " + toRole + "!");
	    			}
	    		}
	    		emailDeliverySet.setEmailDeliveries(emailDeliveries);
	    		if(emailMessage == null) {
	    			EmailMessage localEmailMessage = this.getGeneralEmailMessage(mailId, manuscript, journal, toSystemUser.getUsername(), request, locale);
	    			emailDeliverySet.setEmailMessage(localEmailMessage);
	    		} else {
	    			emailDeliverySet.setEmailMessage(emailMessage);
	    		}
	    		
	    		this.sendAmazonEmail(mailId, emailDeliverySet);
	    	}
    	}
	}
	
	@Override
	public void sendEmailOther(int mailId, String email, EmailMessage emailMessage, HttpServletRequest request, Locale locale) {
		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
		SystemUser user = userService.getByUsername(email);
		emailDeliveries.add(new EmailDelivery(email, user.getId(), 0, 0, false));
		emailDeliverySet.setEmailDeliveries(emailDeliveries);
		emailDeliverySet.setEmailMessage(emailMessage);
		this.sendAmazonEmail(mailId, emailDeliverySet);
	}
	
	@Override
	
	public void sendEmailToReviewerWithMessageModification(int mailId, SystemUser reviewerUser, Manuscript manuscript, Journal journal, EmailMessage emailMessage, HttpServletRequest request, Locale locale) {
    	String toRole = null;
    	ArrayList<String> receiverRolesList = new ArrayList<String>();
    	String receiverRolesString = null;
    	String[] ccRoles = null;
    	int journalTypeId = 0;
		
		switch(journal.getType()) {
			case "A":
				journalTypeId = 0;
				break;
			case "B":
				journalTypeId = 1;
				break;
			case "C":
				journalTypeId = 2;
				break;
			case "D":
				journalTypeId = 3;
				break;
		}
		
    	receiverRolesString = SystemConstants.EMAIL_ROLES[mailId][journalTypeId][manuscript.getManuscriptTrackId()][1];

    	if (receiverRolesString != null) {
	    	StringTokenizer st = new StringTokenizer(receiverRolesString, "/");
	    	int i = 0;
	    	while (st.hasMoreElements()) {
	    		receiverRolesList.add(i, (String)st.nextElement());
	    		i++;
	    	}
	    	toRole = receiverRolesList.get(0);
	    	receiverRolesList.remove(0);
	    	ccRoles = (String[])receiverRolesList.toArray(new String[receiverRolesList.size()]);
    		EmailDeliverySet emailDeliverySet = new EmailDeliverySet();
    		List<EmailDelivery> emailDeliveries = new LinkedList<EmailDelivery>();
    		SystemUser toSystemUser = reviewerUser;
    		emailDeliveries.add(new EmailDelivery(toSystemUser.getUsername(), toSystemUser.getId(), journal.getId(), manuscript.getId(), false));
    		for (String ccRole : ccRoles) {
    			switch (ccRole) {
    				case SystemConstants.rMember:
	    				SystemUser managerUser = manuscript.getManager();
	    				emailDeliveries.add(new EmailDelivery(managerUser.getUsername(), managerUser.getId(), journal.getId(), manuscript.getId(), true));
	    				break;
    				case SystemConstants.rCEditor:
	    				SystemUser chiefEditorUser = manuscript.getChiefEditor();
	    				emailDeliveries.add(new EmailDelivery(chiefEditorUser.getUsername(), chiefEditorUser.getId(), journal.getId(), manuscript.getId(), true));
	    				break;
	    			case SystemConstants.rAEditor:
	    				SystemUser associateEditorUser = manuscript.getAssociateEditor();
	    				emailDeliveries.add(new EmailDelivery(associateEditorUser.getUsername(), associateEditorUser.getId(), journal.getId(), manuscript.getId(), true));
	    				break;
	    			case SystemConstants.rGEditor:
		    			SystemUser guestEditorUser = manuscript.getGuestEditor();
	    				emailDeliveries.add(new EmailDelivery(guestEditorUser.getUsername(), guestEditorUser.getId(), journal.getId(), manuscript.getId(), true));
	    				break;
	    			default:
	    				System.out.println("Oopps!!!!!!! - additional cc should be added at sending " + toRole + "!");
    			}
    		}
    		emailDeliverySet.setEmailDeliveries(emailDeliveries);
    		if(emailMessage == null) {
    			EmailMessage localEmailMessage = this.getGeneralEmailMessage(mailId, manuscript, journal, toSystemUser.getUsername(), request, locale);
    			emailDeliverySet.setEmailMessage(localEmailMessage);
    		} else {
    			emailDeliverySet.setEmailMessage(emailMessage);
    		}
    		
    		this.sendAmazonEmail(mailId, emailDeliverySet);
    	}
	}
	
	private void sendAmazonEmail(int mailId, EmailDeliverySet emailDeliverySet) {
		EmailMessage emailMessage = emailDeliverySet.getEmailMessage();

		int emailMessageId = this.emailMessageDao.insert(emailMessage);
		emailMessage.setId(emailMessageId);
		
		ArrayList<String> emailTo = new ArrayList<String>();
		ArrayList<String> emailCc = new ArrayList<String>();
		
		List<EmailDelivery> emailDeliveries = emailDeliverySet.getEmailDeliveries();
		for (EmailDelivery emailDelivery : emailDeliveries) {

			emailDelivery.setMessageId(emailMessageId);
			
			if (emailDelivery.isCc()) {
				emailCc.add(emailDelivery.getReceiverUsername());
			} else {
				emailTo.add(emailDelivery.getReceiverUsername());
			}
		}
		
		try {
			Destination destination = null;
			if (SystemConstants.TEST_MODE) {
				destination = new Destination().withToAddresses(SystemConstants.EMAIL_TEST_TO).withCcAddresses(SystemConstants.EMAIL_TEST_CC);
				StringBuffer testEmailPrefix = new StringBuffer();
				String testBody = emailDeliverySet.getEmailMessage().getBody();
				
				testEmailPrefix.append("TO: ");
				for (String emailToString : emailTo) {
					testEmailPrefix.append(emailToString).append(", ");
				}
				testEmailPrefix.append("\nCC: ");
				for (String emailCcString : emailCc) {
					testEmailPrefix.append(emailCcString).append(", ");
				}
				testEmailPrefix.append("\n*****위와 같은 TO, CC 구성으로 아래 메일 내용이 전달됩니다.*****\n");
				testBody = testEmailPrefix.toString() + testBody;
				emailDeliverySet.getEmailMessage().setBody(testBody);
				System.out.println(testBody);
			} else {
				destination = new Destination().withToAddresses((String[])emailTo.toArray()).withCcAddresses((String[])emailCc.toArray());
			}
	        Content subject = new Content().withData(emailDeliverySet.getEmailMessage().getSubject());
	        Body body = new Body().withText(new Content().withData(emailDeliverySet.getEmailMessage().getBody()));      
	        Message message = new Message().withSubject(subject).withBody(body);
	        
			SendEmailRequest emailRequest = new SendEmailRequest()
												.withSource(SystemConstants.EMAIL_FROM_USERNAME)
												.withDestination(destination)
												.withMessage(message);
			boolean send = false;
			if(send) {
				Future<SendEmailResult> sendEmailResult = amazonSimpleEmailServiceAsyncClient.sendEmailAsync(emailRequest);
				if (sendEmailResult != null) {
					for (EmailDelivery emailDelivery : emailDeliveries) {
						//if(emailDelivery.getManuscriptId() != 0 && emailDelivery.getJournalId() != 0)
						this.emailDeliveryDao.insert(emailDelivery);
					}				
				} else {
					this.emailMessageDao.delete(emailMessage);
				}
			}
			
		} catch (Exception e) {
			System.out.println("sendAmazonEmail Error!!!"); 
			System.out.println("mailId: " + mailId);
			System.out.println("emailDeliverySet:" + emailDeliverySet);
			e.printStackTrace();
		}
	}
}
