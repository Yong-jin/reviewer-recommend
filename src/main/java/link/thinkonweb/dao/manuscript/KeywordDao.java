package link.thinkonweb.dao.manuscript;

import java.util.List;

import javax.sql.DataSource;

import link.thinkonweb.domain.manuscript.Keyword;


public interface KeywordDao {
	public void insert(Keyword manuscriptKeyword);
	public Keyword findKeyword(String keyword, int manuscriptId, int revisionCount);
	public List<Keyword> findByManuscriptId(int manuscriptId);
	public List<Keyword> findByManuscriptIdAndRevisionCount(int manuscriptId, int revisionCount);
	public void update(Keyword manuscriptKeyword);
	public void delete(Keyword manuscriptKeyword);
	public void deleteByManuscriptIdAndRevisionCount(int manuscriptId, int revisionCount);
	void setDataSource(DataSource dataSource);
	void setKeywordRowMapper(KeywordRowMapper keywordRowMapper);
}