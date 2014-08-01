package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class JournalCategory implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1369105104225789215L;
	private int id;
	private int journalId;
	private String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getJournalId() {
		return journalId;
	}
	public void setJournalId(int journalId) {
		this.journalId = journalId;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "JournalCategory [id=" + id + ", journalId=" + journalId
				+ ", name=" + name + "]";
	}
	
}
