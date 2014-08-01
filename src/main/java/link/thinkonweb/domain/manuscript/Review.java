package link.thinkonweb.domain.manuscript;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import link.thinkonweb.domain.manuscript.form.Comment;
import link.thinkonweb.domain.user.SystemUser;

public class Review implements Serializable, Comparable<Review> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6988778035997589871L;
	private int id;
	private int manuscriptId;
	private int userId;
	private int journalId;
	
	private String firstStatus;
	private String status;
	private Date dueDate;
	private Time dueTime;
	
	private int score1;
	private int score2;
	private int score3;
	private int score4;
	private int score5;
	private int score6;
	private int score7;
	private int score8;
	private int score9;
	private int score10;
	
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
	private int numberOfReviewItems;
	private int overall;
	
	private Comment commentToAuthor;
	private Comment commentToEditor;
	
	private int revisionCount;
	private int reReview;
	
	private Manuscript manuscript;
	private FinalDecision finalDecision;
	private SystemUser user;
	
    private List<UploadedFile> additionalReviews;
	
    private int dueDatePassedWeek;
    
	private List<ReviewEventDateTime> reviewEventDateTimes;
	private List<ReviewEventDateTime> lastReviewEventDateTimes;
	
	private boolean confirm;
	private boolean createdMember;
	private String tempPw;
	private String reviewerToolTipData;
	private Date inviteExpirationDate;

    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getManuscriptId() {
		return manuscriptId;
	}
	public void setManuscriptId(int manuscriptId) {
		this.manuscriptId = manuscriptId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDueDate() {
		return dueDate;
	}
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
	public Time getDueTime() {
		return dueTime;
	}
	public void setDueTime(Time dueTime) {
		this.dueTime = dueTime;
	}
	
	public int getScore1() {
		return score1;
	}
	public void setScore1(int score1) {
		this.score1 = score1;
	}
	public int getScore2() {
		return score2;
	}
	public void setScore2(int score2) {
		this.score2 = score2;
	}
	public int getScore3() {
		return score3;
	}
	public void setScore3(int score3) {
		this.score3 = score3;
	}
	public int getScore4() {
		return score4;
	}
	public void setScore4(int score4) {
		this.score4 = score4;
	}
	public int getScore5() {
		return score5;
	}
	public void setScore5(int score5) {
		this.score5 = score5;
	}
	public int getScore6() {
		return score6;
	}
	public void setScore6(int score6) {
		this.score6 = score6;
	}
	public int getScore7() {
		return score7;
	}
	public void setScore7(int score7) {
		this.score7 = score7;
	}
	public int getScore8() {
		return score8;
	}
	public void setScore8(int score8) {
		this.score8 = score8;
	}
	public int getScore9() {
		return score9;
	}
	public void setScore9(int score9) {
		this.score9 = score9;
	}
	public int getScore10() {
		return score10;
	}
	public void setScore10(int score10) {
		this.score10 = score10;
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
	
	public int getScore(int id) {
		switch(id) {
		case 1:
			return score1;
		case 2:
			return score2;
		case 3:
			return score3;
		case 4:
			return score4;
		case 5:
			return score5;
		case 6:
			return score6;
		case 7:
			return score7;
		case 8:
			return score8;
		case 9:
			return score9;
		case 10:
			return score10;
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
	public int getNumberOfReviewItems() {
		return numberOfReviewItems;
	}
	public void setNumberOfReviewItems(int numberOfReviewItems) {
		this.numberOfReviewItems = numberOfReviewItems;
	}
	public int getOverall() {
		return overall;
	}
	public void setOverall(int overall) {
		this.overall = overall;
	}
	public Comment getCommentToAuthor() {
		return commentToAuthor;
	}
	public void setCommentToAuthor(Comment commentToAuthor) {
		this.commentToAuthor = commentToAuthor;
	}
	public Comment getCommentToEditor() {
		return commentToEditor;
	}
	public void setCommentToEditor(Comment commentToEditor) {
		this.commentToEditor = commentToEditor;
	}
	
	public boolean isConfirm() {
		return confirm;
	}
	public void setConfirm(boolean confirm) {
		this.confirm = confirm;
	}
	public String getFirstStatus() {
		return firstStatus;
	}
	public void setFirstStatus(String firstStatus) {
		this.firstStatus = firstStatus;
	}
	public int getRevisionCount() {
		return revisionCount;
	}
	public void setRevisionCount(int revisionCount) {
		this.revisionCount = revisionCount;
	}
	public Manuscript getManuscript() {
		return manuscript;
	}
	public void setManuscript(Manuscript manuscript) {
		this.manuscript = manuscript;
	}
	public SystemUser getUser() {
		return user;
	}
	public void setUser(SystemUser user) {
		this.user = user;
	}
	public int getReReview() {
		return reReview;
	}
	public void setReReview(int reReview) {
		this.reReview = reReview;
	}
	public List<UploadedFile> getAdditionalReviews() {
		return additionalReviews;
	}
	public void setAdditionalReviews(List<UploadedFile> additionalReviews) {
		this.additionalReviews = additionalReviews;
	}
	public int getDueDatePassedWeek() {
		return dueDatePassedWeek;
	}
	public void setDueDatePassedWeek(int dueDatePassedWeek) {
		this.dueDatePassedWeek = dueDatePassedWeek;
	}
	public String getTempPw() {
		return tempPw;
	}
	public void setTempPw(String tempPw) {
		this.tempPw = tempPw;
	}
	
	public String getReviewerToolTipData() {
		return reviewerToolTipData;
	}
	public void setReviewerToolTipData(String reviewerToolTipData) {
		this.reviewerToolTipData = reviewerToolTipData;
	}
	public boolean isCreatedMember() {
		return createdMember;
	}
	public void setCreatedMember(boolean createdMember) {
		this.createdMember = createdMember;
	}
	public Date getInviteExpirationDate() {
		return inviteExpirationDate;
	}
	public void setInviteExpirationDate(Date inviteExpirationDate) {
		this.inviteExpirationDate = inviteExpirationDate;
	}
	public List<ReviewEventDateTime> getReviewEventDateTimes() {
		return reviewEventDateTimes;
	}
	public void setReviewEventDateTimes(List<ReviewEventDateTime> reviewEventDateTimes) {
		this.reviewEventDateTimes = reviewEventDateTimes;
	}
	public List<ReviewEventDateTime> getLastReviewEventDateTimes() {
		return lastReviewEventDateTimes;
	}
	public void setLastReviewEventDateTimes(List<ReviewEventDateTime> lastReviewEventDateTimes) {
		this.lastReviewEventDateTimes = lastReviewEventDateTimes;
	}
	
	public FinalDecision getFinalDecision() {
		return finalDecision;
	}
	public void setFinalDecision(FinalDecision finalDecision) {
		this.finalDecision = finalDecision;
	}
	public ReviewEventDateTime getReviewEventDateTime(String status) {
		if (reviewEventDateTimes !=  null)
			for (ReviewEventDateTime reviewEventDateTime: reviewEventDateTimes)
				if (reviewEventDateTime.getStatus().equals(status))
					return reviewEventDateTime;
		return null;
	}
	public ReviewEventDateTime getReviewEventDateTime(String status, int revisionCount) {
		if (reviewEventDateTimes !=  null)
			for (ReviewEventDateTime reviewEventDateTime: reviewEventDateTimes)
				if (reviewEventDateTime.getStatus().equals(status) && reviewEventDateTime.getRevisionCount() == revisionCount)
					return reviewEventDateTime;
		return null;
	}
	public ReviewEventDateTime getLastReviewEventDateTime(String status) {
		if (lastReviewEventDateTimes !=  null)
			for (ReviewEventDateTime reviewEventDateTime: lastReviewEventDateTimes)
				if (reviewEventDateTime.getStatus().equals(status))
					return reviewEventDateTime;
		return null;
	}

	@Override
	public int compareTo(Review o) {
		String compare = o.getManuscript().getSubmitId();
		String mine = this.getManuscript().getSubmitId();
		if (compare == null) compare = "";
		if (mine == null) mine = "";
		int result = mine.compareTo(compare);
		
		if(result == 0) {
			int revisionResult = Integer.toString(this.revisionCount).compareTo(Integer.toString(o.revisionCount));
			if(revisionResult == 0) {
				try {
					ReviewEventDateTime edt = this.getReviewEventDateTime(this.status, this.revisionCount);
					ReviewEventDateTime edt2 = o.getReviewEventDateTime(o.status, o.revisionCount);
					int edtResult = 0;
					if(edt != null && edt2 != null)
						edtResult = edt.compareTo(edt2);
					else if(edt != null && edt2 == null)
						edtResult = -1;
					else if(edt == null && edt2 != null)
						edtResult = 1;
					else
						edtResult = 0;
					return edtResult;
				} catch(Exception e) {
					e.printStackTrace();
					return 0;
				}
			} else
				return revisionResult;

		} else
			return mine.compareTo(compare);
	}
	@Override
	public String toString() {
		return "Review [id=" + id + ", manuscriptId=" + manuscriptId
				+ ", userId=" + userId + ", journalId=" + journalId
				+ ", firstStatus=" + firstStatus + ", status=" + status
				+ ", dueDate=" + dueDate + ", dueTime=" + dueTime + ", score1="
				+ score1 + ", score2=" + score2 + ", score3=" + score3
				+ ", score4=" + score4 + ", score5=" + score5 + ", score6="
				+ score6 + ", score7=" + score7 + ", score8=" + score8
				+ ", score9=" + score9 + ", score10=" + score10
				+ ", reviewItemId1=" + reviewItemId1 + ", reviewItemId2="
				+ reviewItemId2 + ", reviewItemId3=" + reviewItemId3
				+ ", reviewItemId4=" + reviewItemId4 + ", reviewItemId5="
				+ reviewItemId5 + ", reviewItemId6=" + reviewItemId6
				+ ", reviewItemId7=" + reviewItemId7 + ", reviewItemId8="
				+ reviewItemId8 + ", reviewItemId9=" + reviewItemId9
				+ ", reviewItemId10=" + reviewItemId10
				+ ", numberOfReviewItems=" + numberOfReviewItems + ", overall="
				+ overall + ", commentToAuthor=" + commentToAuthor
				+ ", commentToEditor=" + commentToEditor + ", revisionCount="
				+ revisionCount + ", reReview=" + reReview + ", manuscript="
				+ manuscript + ", finalDecision=" + finalDecision + ", user="
				+ user + ", additionalReviews=" + additionalReviews
				+ ", dueDatePassedWeek=" + dueDatePassedWeek
				+ ", reviewEventDateTimes=" + reviewEventDateTimes
				+ ", lastReviewEventDateTimes=" + lastReviewEventDateTimes
				+ ", confirm=" + confirm + ", createdMember=" + createdMember
				+ ", tempPw=" + tempPw + "]";
	}
	
}
