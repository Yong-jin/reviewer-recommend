package link.thinkonweb.dao.user;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.user.CountryCode;

import org.springframework.jdbc.core.RowMapper;

public class CountryCodeRowMapper implements RowMapper<CountryCode> {	
	@Override
	public CountryCode mapRow(ResultSet rs, int rowNum) throws SQLException {
		CountryCode countryCode = new CountryCode();
		countryCode.setAlpha2(rs.getString("ALPHA2"));
		countryCode.setName(rs.getString("NAME"));
		return countryCode;
	}
}