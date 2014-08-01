package link.thinkonweb.dao.journal;

import java.util.List;

import link.thinkonweb.domain.journal.Category;

public interface CategoryDao {
	public Category findById(int id);
	public List<Category> findByUpperCategory(int upperCategory);
	public Category findByName(String name);
	public List<Category> findAll();
}
