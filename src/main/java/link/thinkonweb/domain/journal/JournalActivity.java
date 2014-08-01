package link.thinkonweb.domain.journal;


public class JournalActivity {
	private Journal journal;
	private int numManuscriptsStatusR;
	private int numManuscriptsStatusAny;
	private int numReviewManuscriptsStatusR;
	private int numReviewManuscriptsStatusAny;
	
	public JournalActivity() {
		
	}
	
	public JournalActivity(Journal journal, int numManuscriptsStatusR,
			int numManuscriptsStatusAny, int numReviewManuscriptsStatusR,
			int numReviewManuscriptsStatusAny) {
		super();
		this.journal = journal;
		this.numManuscriptsStatusR = numManuscriptsStatusR;
		this.numManuscriptsStatusAny = numManuscriptsStatusAny;
		this.numReviewManuscriptsStatusR = numReviewManuscriptsStatusR;
		this.numReviewManuscriptsStatusAny = numReviewManuscriptsStatusAny;
	}
	
	public Journal getJournal() {
		return journal;
	}
	public void setJournal(Journal journal) {
		this.journal = journal;
	}
	public int getNumManuscriptsStatusR() {
		return numManuscriptsStatusR;
	}
	public void setNumManuscriptsStatusR(int numManuscriptsStatusR) {
		this.numManuscriptsStatusR = numManuscriptsStatusR;
	}
	public int getNumManuscriptsStatusAny() {
		return numManuscriptsStatusAny;
	}
	public void setNumManuscriptsStatusAny(int numManuscriptsStatusAny) {
		this.numManuscriptsStatusAny = numManuscriptsStatusAny;
	}
	public int getNumReviewManuscriptsStatusR() {
		return numReviewManuscriptsStatusR;
	}
	public void setNumReviewManuscriptsStatusR(int numReviewManuscriptsStatusR) {
		this.numReviewManuscriptsStatusR = numReviewManuscriptsStatusR;
	}
	public int getNumReviewManuscriptsStatusAny() {
		return numReviewManuscriptsStatusAny;
	}
	public void setNumReviewManuscriptsStatusAny(int numReviewManuscriptsStatusAny) {
		this.numReviewManuscriptsStatusAny = numReviewManuscriptsStatusAny;
	}
}
