package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum ReviewerDeclineReason {
	busy(0, null),
	notFamiliar(1, null),
	notQualified(2, null);
	
    private int id;
    private String label;

    private static Map<Integer, ReviewerDeclineReason> idToEnumObjectMapping = new TreeMap<Integer, ReviewerDeclineReason>();
    
 	static {
 		for (ReviewerDeclineReason s : EnumSet.allOf(ReviewerDeclineReason.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private ReviewerDeclineReason(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static ReviewerDeclineReason getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
     
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("reviewer.decline.reason." + getId(), null ,locale);
        return label;
    }
}