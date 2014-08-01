package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum ManuscriptTrack {
	normal(0, null), 
	specialIssue(1, null);
	 
    private int id;
    private String label;

    private static Map<Integer, ManuscriptTrack> idToEnumObjectMapping = new TreeMap<Integer, ManuscriptTrack>();
    
 	static {
 		for (ManuscriptTrack s : EnumSet.allOf(ManuscriptTrack.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private ManuscriptTrack(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static ManuscriptTrack getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
    
    public static Map<Integer, ManuscriptTrack> getIdToEnumObjectMapping() {
    	return idToEnumObjectMapping;
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("author.newPaperSubmit.manuscriptTrack." + getId(), null ,locale);
        return label;
    }
}