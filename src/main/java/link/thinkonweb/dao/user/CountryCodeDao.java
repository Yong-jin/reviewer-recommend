package link.thinkonweb.dao.user;

import java.util.List;

import link.thinkonweb.domain.user.CountryCode;

public interface CountryCodeDao {
	//public void insert(CountryCode countryCode);
	//public void update(CountryCode countryCode);
	//public void delete(CountryCode countryCode);
	public CountryCode findByAlpha2(String alpha2);	
	public List<CountryCode> findAll();
	public List<CountryCode> findCountriesLikeSpecificName(String specificName);
}