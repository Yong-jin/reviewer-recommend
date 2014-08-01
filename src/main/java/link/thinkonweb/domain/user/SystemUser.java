package link.thinkonweb.domain.user;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

import org.springframework.context.annotation.Scope;

@Scope(value="session")
public class SystemUser implements Serializable {
	private static final long serialVersionUID = 4449360657035384941L;
	
	private int id;
	private String username;
	private String password;
	
	private Date signupDate;
	private Time signupTime;
	
	private Contact contact;
	private boolean enabled;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getSignupDate() {
		return signupDate;
	}

	public void setSignupDate(Date date) {
		this.signupDate = date;
	}
	
	public Time getSignupTime() {
		return signupTime;
	}

	public void setSignupTime(Time signupTime) {
		this.signupTime = signupTime;
	}

	public Contact getContact() {
		return contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}
	
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((contact == null) ? 0 : contact.hashCode());
		result = prime * result + (enabled ? 1231 : 1237);
		result = prime * result + id;
		result = prime * result
				+ ((password == null) ? 0 : password.hashCode());
		result = prime * result
				+ ((signupDate == null) ? 0 : signupDate.hashCode());
		result = prime * result
				+ ((signupTime == null) ? 0 : signupTime.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof SystemUser)) {
			return false;
		}
		SystemUser other = (SystemUser) obj;
		if (contact == null) {
			if (other.contact != null) {
				return false;
			}
		} else if (!contact.equals(other.contact)) {
			return false;
		}
		if (enabled != other.enabled) {
			return false;
		}
		if (id != other.id) {
			return false;
		}
		if (password == null) {
			if (other.password != null) {
				return false;
			}
		} else if (!password.equals(other.password)) {
			return false;
		}
		if (signupDate == null) {
			if (other.signupDate != null) {
				return false;
			}
		} else if (!signupDate.equals(other.signupDate)) {
			return false;
		}
		if (signupTime == null) {
			if (other.signupTime != null) {
				return false;
			}
		} else if (!signupTime.equals(other.signupTime)) {
			return false;
		}
		if (username == null) {
			if (other.username != null) {
				return false;
			}
		} else if (!username.equals(other.username)) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "SystemUser [id=" + id + ", username=" + username
				+ ", password=" + password + ", signupDate=" + signupDate
				+ ", signupTime=" + signupTime + ", contact=" + contact
				+ ", enabled=" + enabled + "]";
	}
	
	
}