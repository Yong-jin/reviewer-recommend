package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum SalutationDesignation {
	Professor(0, null), 
	Doctor(1, null), 
	Mr(2, null),
	Ms(3, null);

    private int id;
    private String label;

    private static Map<Integer, SalutationDesignation> idToEnumObjectMapping = new TreeMap<Integer, SalutationDesignation>();
    
 	static {
 		for (SalutationDesignation s : EnumSet.allOf(SalutationDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        } 		
 	}
 	    
    private SalutationDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static SalutationDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("signin.salutationDesignation." + getId(), null ,locale);
        return label;
    }
}