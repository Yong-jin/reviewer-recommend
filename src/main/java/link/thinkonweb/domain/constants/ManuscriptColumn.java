package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum ManuscriptColumn {
	num(0, null), 
	temporaryId(1, null), 
	submitId(2, null),
	submitter(3, null),
	institution(4, null),
	revision(5, null),
	title(6, null),
	submitDate(7, null),
	acceptDate(8, null),
	reviewResult(9, null),
	reviewers(10, null),
	chiefEditor(11, null),
	manager(12, null),
	associateEditor(13, null),
	guestEditor(14, null),
	status(15, null);
	
    private int id;
    private String label;

    private static Map<Integer, ManuscriptColumn> idToEnumObjectMapping = new TreeMap<Integer, ManuscriptColumn>();
    
 	static {
 		for (ManuscriptColumn s : EnumSet.allOf(ManuscriptColumn.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        } 		
 	}
 	    
    private ManuscriptColumn(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static ManuscriptColumn getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
    
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("manager.backup.column." + getId(), null ,locale);
        return label;
    }
}