package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum DegreeDesignation {
	Doctor(0, null), 
	DoctorCandidate(1, null), 
	Master(2, null),
	Bachelor(3, null);
	 
    private int id;
    private String label;
    
    private static Map<Integer, DegreeDesignation> idToEnumObjectMapping = new TreeMap<Integer, DegreeDesignation>();
    
 	static {
 		for (DegreeDesignation s : EnumSet.allOf(DegreeDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        } 		
 	}
 	    
    private DegreeDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static DegreeDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("signin.degreeDesignation." + getId(), null ,locale);
        return label;
    }
}