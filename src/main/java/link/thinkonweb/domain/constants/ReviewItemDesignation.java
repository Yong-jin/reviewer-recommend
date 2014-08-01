package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum ReviewItemDesignation {
	familiarity(1, null),
	clarity(2, null),
	significance(3, null),
	originality(4, null),
	quality(5, null),
	language(6, null),
	relevance(7, null);
	
	
    private int id;
    private String label;

    private static Map<Integer, ReviewItemDesignation> idToEnumObjectMapping = new TreeMap<Integer, ReviewItemDesignation>();
    
 	static {
 		for (ReviewItemDesignation s : EnumSet.allOf(ReviewItemDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private ReviewItemDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static ReviewItemDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("review.item." + getId(), null ,locale);
        return label;
    }
}