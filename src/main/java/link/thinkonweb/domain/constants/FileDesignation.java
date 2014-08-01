package link.thinkonweb.domain.constants;

import java.util.EnumSet;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.MessageSource;

public enum FileDesignation {
	mainDocument(0, null),
	replayLetter(1, null),
	tableDocument(2, null),
	supplementaryFile(3, null),
	figureImageDocument(4, null);
	
    private int id;
    private String label;

    private static Map<Integer, FileDesignation> idToEnumObjectMapping = new TreeMap<Integer, FileDesignation>();
    
 	static {
 		for (FileDesignation s : EnumSet.allOf(FileDesignation.class)) {
 			idToEnumObjectMapping.put(s.getId(), s);
        }
 	}
 	    
    private FileDesignation(int id, String label) {
        this.id = id;
        this.label = label;
    }
 
    public static FileDesignation getType(int id) {
        return idToEnumObjectMapping.get(id);
    }
     
    public int getId() {
        return id;
    }
 
    public String getLabel(MessageSource messageSource, Locale locale) {
    	this.label = messageSource.getMessage("author.newPaperSubmit.fileDesignation." + getId(), null ,locale);
        return label;
    }
}