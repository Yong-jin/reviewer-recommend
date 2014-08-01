package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum JournalTypeDesignation {
	A(0, null),
	B(1, null),
	C(2, null),
	D(3, null);
	 
    private int id;
    private String label;

    private static Map<Integer, JournalTypeDesignation> idToEnumObjectMapping = new TreeMap<Integer, JournalTypeDesignation>();
    
 	static {
 		for (JournalTypeDesignation s : EnumSet.allOf(JournalTypeDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private JournalTypeDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static JournalTypeDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }

    public static Map<Integer, JournalTypeDesignation> getIdToEnumObjectMapping() {
    	return idToEnumObjectMapping;
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("system.type" + name(), null ,locale);
        return label;
    }
}