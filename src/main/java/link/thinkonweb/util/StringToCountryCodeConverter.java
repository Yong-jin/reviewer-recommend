package link.thinkonweb.util;

import javax.inject.Inject;

import link.thinkonweb.dao.user.CountryCodeDao;
import link.thinkonweb.domain.user.CountryCode;

import org.springframework.core.convert.converter.Converter;

public class StringToCountryCodeConverter implements Converter<String, CountryCode> {
	@Inject
    private CountryCodeDao countryCodeDao;
	
	public StringToCountryCodeConverter(CountryCodeDao countryCodeDao) {
		this.countryCodeDao = countryCodeDao;
	}

	@Override
	public CountryCode convert(String text) {
		return countryCodeDao.findByAlpha2(text);
	}

}
