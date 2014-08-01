package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class JournalConfiguration implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6975462067791119663L;
	private int id;
	private int journalId;
	private int setupStep;
	private int reviewCompleteCount;
	private int reviewDueDuration;
	private int assignRemindDuration;
	private int assignCancelDuration;
	private int inviteRemindDuration;
	private int inviteCancelDuration;
	private int resubmitDuration;
	private int cameraSubmitDuration;
	private int gentleRemindReviewer;
	private int gentleRemindResubmit;
	private int gentleRemindCameraSubmit;
	private int remindReviewer;
	private int remindResubmit;
	private int remindCameraSubmit;
	private String cameraReadyTemplateUrl;
	private String copyrightFormUrl;
	private int numberOfConfirms;
	private String confirm1;
	private String confirm2;
	private String confirm3;
	private String confirm4;
	private String confirm5;
	private String frontCoverUrl;
	private String checkListUrl;
	private String textBasicInfo;
	private String textCoAuthor;
	private String textRp;
	private String textCoverLetter;
	private String textFiles;
	private int numberOfReviewItems;
	private int reviewItemId1;
	private int reviewItemId2;
	private int reviewItemId3;
	private int reviewItemId4;
	private int reviewItemId5;
	private int reviewItemId6;
	private int reviewItemId7;
	private int reviewItemId8;
	private int reviewItemId9;
	private int reviewItemId10;
	private boolean changeAuthor;
	private boolean changeKeyword;
	private boolean changeInvited;
	private boolean changeDivision;
	private boolean changeRp;
	private boolean changeAdditionalFiles;
	
	private boolean requiredRunninghead;
	private boolean requiredKeyword;
	private boolean requiredCoverletter;
	private boolean requiredRp;
	private boolean requiredAdditionalFiles;
	private boolean reviewerViewAuthor;
	
	private boolean manageDivision;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getSetupStep() {
		return setupStep;
	}
	public void setSetupStep(int setupStep) {
		this.setupStep = setupStep;
	}
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}
	public int getReviewCompleteCount() {
		return reviewCompleteCount;
	}
	public void setReviewCompleteCount(int reviewCompleteCount) {
		this.reviewCompleteCount = reviewCompleteCount;
	}
	public int getReviewDueDuration() {
		return reviewDueDuration;
	}
	public void setReviewDueDuration(int reviewDueDuration) {
		this.reviewDueDuration = reviewDueDuration;
	}
	public int getAssignRemindDuration() {
		return assignRemindDuration;
	}
	public void setAssignRemindDuration(int assignRemindDuration) {
		this.assignRemindDuration = assignRemindDuration;
	}
	public int getAssignCancelDuration() {
		return assignCancelDuration;
	}
	public void setAssignCancelDuration(int assignCancelDuration) {
		this.assignCancelDuration = assignCancelDuration;
	}
	public int getInviteRemindDuration() {
		return inviteRemindDuration;
	}
	public void setInviteRemindDuration(int inviteRemindDuration) {
		this.inviteRemindDuration = inviteRemindDuration;
	}
	public int getInviteCancelDuration() {
		return inviteCancelDuration;
	}
	public void setInviteCancelDuration(int inviteCancelDuration) {
		this.inviteCancelDuration = inviteCancelDuration;
	}
	public int getResubmitDuration() {
		return resubmitDuration;
	}
	public void setResubmitDuration(int resubmitDuration) {
		this.resubmitDuration = resubmitDuration;
	}
	public int getCameraSubmitDuration() {
		return cameraSubmitDuration;
	}
	public void setCameraSubmitDuration(int cameraSubmitDuration) {
		this.cameraSubmitDuration = cameraSubmitDuration;
	}
	public int getGentleRemindReviewer() {
		return gentleRemindReviewer;
	}
	public void setGentleRemindReviewer(int gentleRemindReviewer) {
		this.gentleRemindReviewer = gentleRemindReviewer;
	}
	public int getGentleRemindResubmit() {
		return gentleRemindResubmit;
	}
	public void setGentleRemindResubmit(int gentleRemindResubmit) {
		this.gentleRemindResubmit = gentleRemindResubmit;
	}
	public int getGentleRemindCameraSubmit() {
		return gentleRemindCameraSubmit;
	}
	public void setGentleRemindCameraSubmit(int gentleRemindCameraSubmit) {
		this.gentleRemindCameraSubmit = gentleRemindCameraSubmit;
	}
	public int getRemindReviewer() {
		return remindReviewer;
	}
	public void setRemindReviewer(int remindReviewer) {
		this.remindReviewer = remindReviewer;
	}
	public int getRemindResubmit() {
		return remindResubmit;
	}
	public void setRemindResubmit(int remindResubmit) {
		this.remindResubmit = remindResubmit;
	}
	public int getRemindCameraSubmit() {
		return remindCameraSubmit;
	}
	public void setRemindCameraSubmit(int remindCameraSubmit) {
		this.remindCameraSubmit = remindCameraSubmit;
	}
	
	public String getCameraReadyTemplateUrl() {
		return cameraReadyTemplateUrl;
	}
	public void setCameraReadyTemplateUrl(String cameraReadyTemplateUrl) {
		this.cameraReadyTemplateUrl = cameraReadyTemplateUrl;
	}
	public String getCopyrightFormUrl() {
		return copyrightFormUrl;
	}
	public void setCopyrightFormUrl(String copyrightFormUrl) {
		this.copyrightFormUrl = copyrightFormUrl;
	}
	
	public int getNumberOfConfirms() {
		return numberOfConfirms;
	}
	public void setNumberOfConfirms(int numberOfConfirms) {
		this.numberOfConfirms = numberOfConfirms;
	}
	public String getConfirm(int id) {
		switch(id) {
		case 1:
			return confirm1;
		case 2:
			return confirm2;
		case 3:
			return confirm3;
		case 4:
			return confirm4;
		case 5:
			return confirm5;
		default:
			return null;
		}
	}
	
	public String getConfirm1() {
		return confirm1;
	}
	public void setConfirm1(String confirm1) {
		this.confirm1 = confirm1;
	}
	public String getConfirm2() {
		return confirm2;
	}
	public void setConfirm2(String confirm2) {
		this.confirm2 = confirm2;
	}
	public String getConfirm3() {
		return confirm3;
	}
	public void setConfirm3(String confirm3) {
		this.confirm3 = confirm3;
	}
	public String getConfirm4() {
		return confirm4;
	}
	public void setConfirm4(String confirm4) {
		this.confirm4 = confirm4;
	}
	public String getConfirm5() {
		return confirm5;
	}
	public void setConfirm5(String confirm5) {
		this.confirm5 = confirm5;
	}
	
	public String getFrontCoverUrl() {
		return frontCoverUrl;
	}
	public void setFrontCoverUrl(String frontCoverUrl) {
		this.frontCoverUrl = frontCoverUrl;
	}
	public String getCheckListUrl() {
		return checkListUrl;
	}
	public void setCheckListUrl(String checkListUrl) {
		this.checkListUrl = checkListUrl;
	}
	
	public String getTextBasicInfo() {
		return textBasicInfo;
	}
	public void setTextBasicInfo(String textBasicInfo) {
		this.textBasicInfo = textBasicInfo;
	}
	public String getTextCoAuthor() {
		if(textCoAuthor != null)
			textCoAuthor = textCoAuthor.replace("\n", "<br/>");
		return textCoAuthor;
	}
	public void setTextCoAuthor(String textCoAuthor) {
		this.textCoAuthor = textCoAuthor;
	}
	public String getTextRp() {
		if(textRp != null)
			textRp = textRp.replace("\n", "<br/>");
		return textRp;
	}
	public void setTextRp(String textRp) {
		this.textRp = textRp;
	}
	public String getTextCoverLetter() {
		if(textCoverLetter != null)
			textCoverLetter = textCoverLetter.replace("\n", "<br/>");
		return textCoverLetter;
	}
	public void setTextCoverLetter(String textCoverLetter) {
		this.textCoverLetter = textCoverLetter;
	}
	public String getTextFiles() {
		if(textFiles != null)
			textFiles = textFiles.replace("\n", "<br/>");
		return textFiles;
	}
	public void setTextFiles(String textFiles) {
		this.textFiles = textFiles;
	}
	
	
	public int getNumberOfReviewItems() {
		return numberOfReviewItems;
	}
	public void setNumberOfReviewItems(int numberOfReviewItems) {
		this.numberOfReviewItems = numberOfReviewItems;
	}
	public int getReviewItemId(int id) {
		switch(id) {
		case 1:
			return reviewItemId1;
		case 2:
			return reviewItemId2;
		case 3:
			return reviewItemId3;
		case 4:
			return reviewItemId4;
		case 5:
			return reviewItemId5;
		case 6:
			return reviewItemId6;
		case 7:
			return reviewItemId7;
		case 8:
			return reviewItemId8;
		case 9:
			return reviewItemId9;
		case 10:
			return reviewItemId10;
		default:
			return 0;
		}
	}
	
	public int getReviewItemId1() {
		return reviewItemId1;
	}
	public void setReviewItemId1(int reviewItemId1) {
		this.reviewItemId1 = reviewItemId1;
	}
	public int getReviewItemId2() {
		return reviewItemId2;
	}
	public void setReviewItemId2(int reviewItemId2) {
		this.reviewItemId2 = reviewItemId2;
	}
	public int getReviewItemId3() {
		return reviewItemId3;
	}
	public void setReviewItemId3(int reviewItemId3) {
		this.reviewItemId3 = reviewItemId3;
	}
	public int getReviewItemId4() {
		return reviewItemId4;
	}
	public void setReviewItemId4(int reviewItemId4) {
		this.reviewItemId4 = reviewItemId4;
	}
	public int getReviewItemId5() {
		return reviewItemId5;
	}
	public void setReviewItemId5(int reviewItemId5) {
		this.reviewItemId5 = reviewItemId5;
	}
	public int getReviewItemId6() {
		return reviewItemId6;
	}
	public void setReviewItemId6(int reviewItemId6) {
		this.reviewItemId6 = reviewItemId6;
	}
	public int getReviewItemId7() {
		return reviewItemId7;
	}
	public void setReviewItemId7(int reviewItemId7) {
		this.reviewItemId7 = reviewItemId7;
	}
	public int getReviewItemId8() {
		return reviewItemId8;
	}
	public void setReviewItemId8(int reviewItemId8) {
		this.reviewItemId8 = reviewItemId8;
	}
	public int getReviewItemId9() {
		return reviewItemId9;
	}
	public void setReviewItemId9(int reviewItemId9) {
		this.reviewItemId9 = reviewItemId9;
	}
	public int getReviewItemId10() {
		return reviewItemId10;
	}
	public void setReviewItemId10(int reviewItemId10) {
		this.reviewItemId10 = reviewItemId10;
	}
	public boolean isChangeKeyword() {
		return changeKeyword;
	}
	public void setChangeKeyword(boolean changeKeyword) {
		this.changeKeyword = changeKeyword;
	}
	public boolean isChangeAuthor() {
		return changeAuthor;
	}
	public void setChangeAuthor(boolean changeAuthor) {
		this.changeAuthor = changeAuthor;
	}
	public boolean isChangeInvited() {
		return changeInvited;
	}
	public void setChangeInvited(boolean changeInvited) {
		this.changeInvited = changeInvited;
	}
	public boolean isChangeDivision() {
		return changeDivision;
	}
	public void setChangeDivision(boolean changeDivision) {
		this.changeDivision = changeDivision;
	}
	public boolean isChangeRp() {
		return changeRp;
	}
	public void setChangeRp(boolean changeRp) {
		this.changeRp = changeRp;
	}
	public boolean isChangeAdditionalFiles() {
		return changeAdditionalFiles;
	}
	public void setChangeAdditionalFiles(boolean changeAdditionalFiles) {
		this.changeAdditionalFiles = changeAdditionalFiles;
	}
	public boolean isRequiredRunninghead() {
		return requiredRunninghead;
	}
	public void setRequiredRunninghead(boolean requiredRunninghead) {
		this.requiredRunninghead = requiredRunninghead;
	}
	public boolean isRequiredKeyword() {
		return requiredKeyword;
	}
	public void setRequiredKeyword(boolean requiredKeyword) {
		this.requiredKeyword = requiredKeyword;
	}
	public boolean isRequiredCoverletter() {
		return requiredCoverletter;
	}
	public void setRequiredCoverletter(boolean requiredCoverletter) {
		this.requiredCoverletter = requiredCoverletter;
	}
	public boolean isRequiredRp() {
		return requiredRp;
	}
	public void setRequiredRp(boolean requiredRp) {
		this.requiredRp = requiredRp;
	}
	public boolean isReviewerViewAuthor() {
		return reviewerViewAuthor;
	}
	public void setReviewerViewAuthor(boolean reviewerViewAuthor) {
		this.reviewerViewAuthor = reviewerViewAuthor;
	}
	public boolean isManageDivision() {
		return manageDivision;
	}
	public void setManageDivision(boolean manageDivision) {
		this.manageDivision = manageDivision;
	}
	public boolean isRequiredAdditionalFiles() {
		return requiredAdditionalFiles;
	}
	public void setRequiredAdditionalFiles(boolean requiredAdditionalFiles) {
		this.requiredAdditionalFiles = requiredAdditionalFiles;
	}
	@Override
	public String toString() {
		return "JournalConfiguration [id=" + id + ", journalId=" + journalId
				+ ", setupStep=" + setupStep + ", reviewCompleteCount="
				+ reviewCompleteCount + ", reviewDueDuration="
				+ reviewDueDuration + ", assignRemindDuration="
				+ assignRemindDuration + ", assignCancelDuration="
				+ assignCancelDuration + ", inviteRemindDuration="
				+ inviteRemindDuration + ", inviteCancelDuration="
				+ inviteCancelDuration + ", resubmitDuration="
				+ resubmitDuration + ", cameraSubmitDuration="
				+ cameraSubmitDuration + ", gentleRemindReviewer="
				+ gentleRemindReviewer + ", gentleRemindResubmit="
				+ gentleRemindResubmit + ", gentleRemindCameraSubmit="
				+ gentleRemindCameraSubmit + ", remindReviewer="
				+ remindReviewer + ", remindResubmit=" + remindResubmit
				+ ", remindCameraSubmit=" + remindCameraSubmit
				+ ", cameraReadyTemplateUrl=" + cameraReadyTemplateUrl
				+ ", copyrightFormUrl=" + copyrightFormUrl
				+ ", numberOfConfirms=" + numberOfConfirms + ", confirm1="
				+ confirm1 + ", confirm2=" + confirm2 + ", confirm3="
				+ confirm3 + ", confirm4=" + confirm4 + ", confirm5="
				+ confirm5 + ", frontCoverUrl=" + frontCoverUrl
				+ ", checkListUrl=" + checkListUrl + ", textBasicInfo="
				+ textBasicInfo + ", textCoAuthor=" + textCoAuthor
				+ ", textRp=" + textRp + ", textCoverLetter=" + textCoverLetter
				+ ", textFiles=" + textFiles + ", numberOfReviewItems="
				+ numberOfReviewItems + ", reviewItemId1=" + reviewItemId1
				+ ", reviewItemId2=" + reviewItemId2 + ", reviewItemId3="
				+ reviewItemId3 + ", reviewItemId4=" + reviewItemId4
				+ ", reviewItemId5=" + reviewItemId5 + ", reviewItemId6="
				+ reviewItemId6 + ", reviewItemId7=" + reviewItemId7
				+ ", reviewItemId8=" + reviewItemId8 + ", reviewItemId9="
				+ reviewItemId9 + ", reviewItemId10=" + reviewItemId10
				+ ", changeAuthor=" + changeAuthor + ", changeKeyword="
				+ changeKeyword + ", changeInvited=" + changeInvited
				+ ", changeDivision=" + changeDivision + ", changeRp="
				+ changeRp + ", changeAdditionalFiles=" + changeAdditionalFiles
				+ ", requiredRunninghead=" + requiredRunninghead
				+ ", requiredKeyword=" + requiredKeyword
				+ ", requiredCoverletter=" + requiredCoverletter
				+ ", requiredRp=" + requiredRp + ", requiredAdditionalFiles="
				+ requiredAdditionalFiles + ", reviewerViewAuthor="
				+ reviewerViewAuthor + ", manageDivision=" + manageDivision
				+ "]";
	}
	
}
