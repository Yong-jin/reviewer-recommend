package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum AssociateEditorDeclineReason {
	busy(0, null),
	notFamiliar(1, null);
	
    private int id;
    private String label;

    private static Map<Integer, AssociateEditorDeclineReason> idToEnumObjectMapping = new TreeMap<Integer, AssociateEditorDeclineReason>();
    
 	static {
 		for (AssociateEditorDeclineReason s : EnumSet.allOf(AssociateEditorDeclineReason.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private AssociateEditorDeclineReason(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static AssociateEditorDeclineReason getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
     
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("associateEditor.decline.reason." + getId(), null ,locale);
        return label;
    }
}