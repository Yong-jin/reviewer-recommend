package link.thinkonweb.util;

import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import javax.inject.Inject;

import link.thinkonweb.dao.journal.SubmittedManuscriptDao;
import link.thinkonweb.dao.manuscript.ManuscriptDao;
import link.thinkonweb.domain.journal.Journal;
import link.thinkonweb.domain.journal.SubmittedManuscripts;
import link.thinkonweb.domain.manuscript.Manuscript;
import link.thinkonweb.service.journal.JournalService;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;


@Controller
public class SubmitIdGenerator {
	private String id;
	@Inject
	private ManuscriptDao manuscriptDao;
	@Inject
	private SubmittedManuscriptDao submittedManuscriptDao;
	@Inject
	private JournalService journalService;
	
	public void setSubmittedManuscriptDao(SubmittedManuscriptDao submittedManuscriptDao) {
		this.submittedManuscriptDao = submittedManuscriptDao;
	}
	public void setManuscriptDao(ManuscriptDao manuscriptDao) {
		this.manuscriptDao = manuscriptDao;	
	}
	public void setManuscriptSubmitId(int manuscriptId) {
		Manuscript m = manuscriptDao.findById(manuscriptId);
		String submitId = this.generate(m.getJournalId());
		m.setSubmitId(submitId);
		manuscriptDao.update(m);
	}
	
	@Transactional
	public String generate(int journalId) {
		Journal journal = journalService.getById(journalId);
		id = "";
		Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		int year = calendar.get(Calendar.YEAR);
		year = year % 100;
		id += year;
		if(journal.getJournalNameId().equals("jips"))
			id += "E";
		else
			id += "M-";
		int month = calendar.get(Calendar.MONTH)+1;
		if (month < 10)
			id += '0';
		
		id += month;
		
		id += '-';
		SubmittedManuscripts submittedManuscript = new SubmittedManuscripts();
		submittedManuscript.setYear(year);
		submittedManuscript.setMonth(month);
		submittedManuscript.setJournalId(journalId);
		SubmittedManuscripts submittedManuscriptsByYearAndMonth = submittedManuscriptDao.getSubmittedManuscript(journalId, year, month);
		
		if (submittedManuscriptsByYearAndMonth == null)
			submittedManuscriptDao.insert(submittedManuscript);				
		
		List<SubmittedManuscripts> submittedManuscriptsByYear = submittedManuscriptDao.getSubmittedManuscriptByYear(journalId, year);
		int counts = 0;
		for (SubmittedManuscripts sm : submittedManuscriptsByYear)
			counts += sm.getManuscriptCount();
		
		counts += 1;

		if (counts < 10)
			id += "00";
		else if (counts < 100)
			id += "0";

		id += counts;
		SubmittedManuscripts newSubmittedManuscriptsByYearAndMonth = submittedManuscriptDao.getSubmittedManuscript(journalId, year, month);
		submittedManuscript.setManuscriptCount(newSubmittedManuscriptsByYearAndMonth.getManuscriptCount() + 1);
		submittedManuscriptDao.update(submittedManuscript);

		return id;
	}
}
