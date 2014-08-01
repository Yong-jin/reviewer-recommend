package link.thinkonweb.domain.user;

import java.io.Serializable;
import java.sql.Date;

public class ChangePasswordCode implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5642479870172567082L;

	private int id;
	private String email;
	private String maskCode;
	private Date registerDate;
	private Date expirationDate;
	private boolean expired;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMaskCode() {
		return maskCode;
	}
	public void setMaskCode(String maskCode) {
		this.maskCode = maskCode;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Date getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}
	public boolean isExpired() {
		return expired;
	}
	public void setExpired(boolean expired) {
		this.expired = expired;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "ChangePasswordCode [id=" + id + ", email=" + email
				+ ", maskCode=" + maskCode + ", registerDate=" + registerDate
				+ ", expirationDate=" + expirationDate + ", expired=" + expired
				+ "]";
	}
	
}
