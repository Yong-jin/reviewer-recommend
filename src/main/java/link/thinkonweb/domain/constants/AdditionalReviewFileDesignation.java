package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum AdditionalReviewFileDesignation {
	additionalReviewResults(0, null),
	others(1, null);
	
    private int id;
    private String label;

    private static Map<Integer, AdditionalReviewFileDesignation> idToEnumObjectMapping = new TreeMap<Integer, AdditionalReviewFileDesignation>();
    
 	static {
 		for (AdditionalReviewFileDesignation s : EnumSet.allOf(AdditionalReviewFileDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private AdditionalReviewFileDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static AdditionalReviewFileDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("reviewer.additionalReviewResult.fileDesignation." + getId(), null ,locale);
        return label;
    }
}