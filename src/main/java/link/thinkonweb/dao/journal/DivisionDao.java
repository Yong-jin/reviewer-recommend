package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.Division;


public interface DivisionDao {
	public void setDivisionRowMapper(DivisionRowMapper divisionRowMapper);
	public int insert(Division division);
	public Division findById(int id);
	public void update(Division division);
	public void delete(int divisionId);
	public List<Division> findByJournalId(int journalId);

}
