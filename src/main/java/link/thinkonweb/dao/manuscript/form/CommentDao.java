package link.thinkonweb.dao.manuscript.form;

import java.util.List;

import link.thinkonweb.domain.manuscript.form.Comment;


public interface CommentDao {
	public void insert(Comment comment);
	public Comment findComment(int fromUserId, int toUserId, String fromRole, String toRole, int manuscriptId, int revisionCount, String status);
	public List<Comment> findByManuscriptId(int manuscriptId);
	public List<Comment> findByScope(String scope);
	public List<Comment> findRelatedComments(int manuscriptId, int userId, String role, boolean manager);
	public List<Comment> findAuthorComments(int manuscriptId, List<Integer> coAuthorIds);
	public List<Comment> findEditorialMessages(int manuscriptId, int userId, String role, boolean manager);
	public void update(Comment comment);

}
