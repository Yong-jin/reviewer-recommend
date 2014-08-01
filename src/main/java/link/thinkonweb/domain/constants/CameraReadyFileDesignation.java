package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum CameraReadyFileDesignation {
	cameraReadyPaper(0, null),
	copyright(1, null),
	biography(2, null);
	
    private int id;
    private String label;

    private static Map<Integer, CameraReadyFileDesignation> idToEnumObjectMapping = new TreeMap<Integer, CameraReadyFileDesignation>();
    
 	static {
 		for (CameraReadyFileDesignation s : EnumSet.allOf(CameraReadyFileDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private CameraReadyFileDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static CameraReadyFileDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
 
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("cameraReady.fileDesignation." + getId(), null ,locale);
        return label;
    }
}