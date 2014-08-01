package link.thinkonweb.service.journal;

import java.beans.PropertyEditorSupport;

import link.thinkonweb.domain.user.SystemUser;
import link.thinkonweb.service.user.UserService;

public class JournalUserEditor extends PropertyEditorSupport {
	UserService userService;
	
	public JournalUserEditor() {
	}

	public JournalUserEditor(UserService userService) {
		this.userService = userService;
	}
	
	public void setAsText(String username) throws IllegalArgumentException {
		SystemUser user = this.userService.getByUsername(username);
		setValue(user);
	}
	
	public String getAsText() {
		SystemUser user = (SystemUser)getValue();
		return user.getUsername();
	}
}