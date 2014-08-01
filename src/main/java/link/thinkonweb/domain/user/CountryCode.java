package link.thinkonweb.domain.user;

import java.io.Serializable;

public class CountryCode implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4449360657035384945L;
	
	private String alpha2;
	private String name;
	
	public CountryCode() {
		
	}

	public void setAlpha2(String alpha2) {
		this.alpha2 = alpha2;
	}
	public String getAlpha2() {
		return alpha2;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((alpha2 == null) ? 0 : alpha2.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		if (!(obj instanceof CountryCode)) {
			return false;
		}
		CountryCode other = (CountryCode) obj;
		if (alpha2 == null) {
			if (other.alpha2 != null) {
				return false;
			}
		} else if (!alpha2.equals(other.alpha2)) {
			return false;
		}
		if (name == null) {
			if (other.name != null) {
				return false;
			}
		} else if (!name.equals(other.name)) {
			return false;
		}
		return true;
	}
}