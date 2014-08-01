package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum EmailDesignation {
	ackNewManuscriptSubmissionToAuthor(0, null),
	notifyNewManuscriptSubmissionToManager(1, null),
	ackUpdatedManuscriptSubmissionToAuthor(2, null),
	notifyUpdatedManuscriptSubmissionToManager(3, null),
	returnBackNewManuscriptSubmissionToAuthor(4, null),
	returnBackUpdatedManuscriptSubmissionToAuthor(5, null),
	confirmNewManuscriptSubmissionToAuthor(6, null),
	confirmUpdatedManuscriptSubmissionToAuthor(7, null),
	notifyManuscriptSubmissionToCE_GE(8, null),
	notifyUpdatedManuscriptSubmissionToAE_GE(9, null),
	assignManuscriptToAE(10, null),
	assignRemindManuscriptToAE(11, null),
	assignManuscriptConfirmToCE(12, null),
	declineManuscriptAssignToCE(13, null),
	cancelManuscriptAssignToAE(14, null),
	autoCancelManuscriptAssignToAE(15, null),
	reviewInviteToReviewer(16, null),
	reviewInviteDeclineToAE_CE_GE(17, null),
	reviewAssignToReviewer(18, null),
	reviewAssignWithAccountInfoToReviewer(19, null),
	reviewAssignAfterInviteToReviewer(20, null),
	reviewAssignWithAccountInfoAfterInviteToReviewer(21, null),
	reviewInviteRemindToReviewer(22, null),	
	cancelReviewInviteToReviewer(23, null),
	autoCancelReviewInviteToReviewer(24, null),
	reviewCompleteThankToReviewer(25, null),
	dismissReviewerToReviewer(26, null),
	gentleRemindToReviewer(27, null),
	dueDatePassedRemindToReviewer(28, null),
	notifyReviewCompleteToAEorCE(29, null),
	reviewResultRecommendToCE(30, null),
	acceptManuscriptToAuthor(31, null),
	requestRevisionOfManuscriptToAuthor(32, null),
	rejectManuscriptToAuthor(33, null),	
	gentleRemindRevisionToAuthor(34, null),
	dueDatePassedRemindRevisionToAuthor(35, null),
	requestDeadlineExtensionRevisionToManager(36, null),
	confirmDeadlineExtensionRevisionToAuthor(37, null),
	rejectDeadlineExtensionRevisionToAuthor(38, null),
	forceRejectManuscriptToAuthor(39, null),
	gentleRemindCameraReadyPaperSubmitToAuthor(40, null),
	dueDatePassedRemindCameraReadyPaperSubmitToAuthor(41, null),
	ackCameraReadyPaperSubmitToAuthor(42, null),
	notifyCameraReadyPaperSubmitToManager(43, null),
	returnCameraReadyPaperToAuthor(44, null),
	confirmCameraReadyPaperToAuthor(45, null),
	notifyGalleryProofToAuthor(46, null),
	requestGalleryProofCorrectionsToManager(47, null),
	confirmGalleryProofToManager(48, null),
	notifyAccountCreation(49, null),
	notifyAccountCreationFromJournal(50, null),
	notifyAccountCreationFromJournalByOtherCoauthor(51, null),
	notifyAccountCreationFromJournalByOtherManager(52, null),
	notifyAccountCreationFromJournalByOtherEditor(53, null),
	renewPassword(54, null);
	 
    private int id;
    private String label;

    private static Map<Integer, EmailDesignation> idToEnumObjectMapping = new TreeMap<Integer, EmailDesignation>();
    
 	static {
 		for (EmailDesignation s : EnumSet.allOf(EmailDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private EmailDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static EmailDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }

    static public Map<Integer, EmailDesignation> getIdToEnumObjectMapping() {
    	return idToEnumObjectMapping;
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage(name() + ".subject", null ,locale);
        return label;
    }
}