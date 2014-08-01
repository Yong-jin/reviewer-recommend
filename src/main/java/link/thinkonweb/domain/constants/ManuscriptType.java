package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum ManuscriptType {
	researchPaper(0, null), 
	editorial(1, null), 
	reviewOrComments(2, null);
	 
    private int id;
    private String label;

    private static Map<Integer, ManuscriptType> idToEnumObjectMapping = new TreeMap<Integer, ManuscriptType>();
    
 	static {
 		for (ManuscriptType s : EnumSet.allOf(ManuscriptType.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        } 		
 	}
 	    
    private ManuscriptType(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static ManuscriptType getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
    
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("author.newPaperSubmit.manuscriptType." + getId(), null ,locale);
        return label;
    }
}