package link.thinkonweb.util;

import link.thinkonweb.domain.user.CountryCode;

import org.springframework.core.convert.ConversionFailedException;
import org.springframework.core.convert.TypeDescriptor;
import org.springframework.core.convert.converter.Converter;

public class CountryCodeToStringConverter implements Converter<CountryCode, String> {

	public CountryCodeToStringConverter() {
	}

	@Override
	public String convert(CountryCode countryCode) {
		if (countryCode == null){
			throw new ConversionFailedException(TypeDescriptor.valueOf(CountryCode.class),
			TypeDescriptor.valueOf(String.class), countryCode, null);
		}
		return String.valueOf(countryCode.getAlpha2());
	}

}
