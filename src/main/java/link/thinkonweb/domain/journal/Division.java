package link.thinkonweb.domain.journal;

import java.io.Serializable;

public class Division implements Serializable, Comparable<Division> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7803440903467432823L;
	private int id;
	private int journalId;
	private String name;
	private String symbol;
	private String description;
	
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
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public int compareTo(Division o) {
		return this.symbol.compareTo(o.getSymbol());
	}
	@Override
	public String toString() {
		return "Division [id=" + id + ", journalId=" + journalId + ", name="
				+ name + ", symbol=" + symbol + ", description=" + description
				+ "]";
	}

}
