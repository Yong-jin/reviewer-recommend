package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum LocalJobTitleDesignation {
	Professor(0, null), 
	Doctor(1, null), 
	PrincipalResearcher(2, null),
	SeniorResearcher(3, null),
	GeneralResearcher(4, null),
	AssociateResearcher(5, null),
	Researcher(6, null),
	Director(7, null),
	GeneralManager(8, null),
	GeneralSilManager(9, null),
	Manager(10, null),
	AssistantManager(11, null),
	Employee(12, null);
	
    private int id;
    private String label;

    private static Map<Integer, LocalJobTitleDesignation> idToEnumObjectMapping = new TreeMap<Integer, LocalJobTitleDesignation>();
    
 	static {
 		for (LocalJobTitleDesignation s : EnumSet.allOf(LocalJobTitleDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        } 		
 	}
 	    
    private LocalJobTitleDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static LocalJobTitleDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("signin.localJobTitleDesignation." + getId(), null ,locale);
        return label;
    }
}