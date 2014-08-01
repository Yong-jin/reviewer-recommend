package link.thinkonweb.dao.manuscript;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.manuscript.Review;

import org.springframework.jdbc.core.RowMapper;

public class ReviewRowMapper implements RowMapper<Review> {
	
	@Override
	public Review mapRow(ResultSet rs, int rowNum) throws SQLException {
		Review review = new Review();
		review.setId(rs.getInt("ID"));
		review.setUserId(rs.getInt("USER_ID"));
		review.setManuscriptId(rs.getInt("MANUSCRIPT_ID"));
		review.setJournalId(rs.getInt("JOURNAL_ID"));
		review.setScore1(rs.getInt("SCORE1"));
		review.setScore2(rs.getInt("SCORE2"));
		review.setScore3(rs.getInt("SCORE3"));
		review.setScore4(rs.getInt("SCORE4"));
		review.setScore5(rs.getInt("SCORE5"));
		review.setScore6(rs.getInt("SCORE6"));
		review.setScore7(rs.getInt("SCORE7"));
		review.setScore8(rs.getInt("SCORE8"));
		review.setScore9(rs.getInt("SCORE9"));
		review.setScore10(rs.getInt("SCORE10"));
		
		review.setReviewItemId1(rs.getInt("REVIEW_ITEM_ID1"));
		review.setReviewItemId2(rs.getInt("REVIEW_ITEM_ID2"));
		review.setReviewItemId3(rs.getInt("REVIEW_ITEM_ID3"));
		review.setReviewItemId4(rs.getInt("REVIEW_ITEM_ID4"));
		review.setReviewItemId5(rs.getInt("REVIEW_ITEM_ID5"));
		review.setReviewItemId6(rs.getInt("REVIEW_ITEM_ID6"));
		review.setReviewItemId7(rs.getInt("REVIEW_ITEM_ID7"));
		review.setReviewItemId8(rs.getInt("REVIEW_ITEM_ID8"));
		review.setReviewItemId9(rs.getInt("REVIEW_ITEM_ID9"));
		review.setReviewItemId10(rs.getInt("REVIEW_ITEM_ID10"));

		review.setNumberOfReviewItems(rs.getInt("NUMBER_OF_REVIEW_ITEMS"));
		review.setOverall(rs.getInt("OVERALL"));
		review.setReReview(rs.getInt("RE_REVIEW"));
		review.setConfirm(rs.getBoolean("CONFIRM"));
		review.setCreatedMember(rs.getBoolean("CREATED_MEMBER"));
		review.setTempPw(rs.getString("TEMP_PW"));
		review.setRevisionCount(rs.getInt("REVISION_COUNT"));
		review.setDueDate(rs.getDate("DUE_DATE"));
		review.setDueTime(rs.getTime("DUE_TIME"));
		review.setStatus(rs.getString("STATUS"));
		review.setFirstStatus(rs.getString("FIRST_STATUS"));
		review.setInviteExpirationDate(rs.getDate("INVITE_EXPIRATION_DATE"));
		return review;
	}
}
