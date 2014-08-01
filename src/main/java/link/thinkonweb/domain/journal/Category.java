package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class Category implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6579322705323805755L;
	private int id;
	private String name;
	private int upperCategory;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getUpperCategory() {
		return upperCategory;
	}
	public void setUpperCategory(int upperCategory) {
		this.upperCategory = upperCategory;
	}
	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + ", upperCategory="
				+ upperCategory + "]";
	}
	

}
