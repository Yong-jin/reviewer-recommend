package link.thinkonweb.dao.user;

import java.util.List;

import link.thinkonweb.domain.user.CountryCode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

public class CountryCodeDaoImpl extends NamedParameterJdbcDaoSupport implements CountryCodeDao {
	@Autowired
	private CountryCodeRowMapper countryCodeRowMapper;

	@Override
	public CountryCode findByAlpha2(String alpha2) {
		String sql = "SELECT * FROM COUNTRY WHERE ALPHA2 = ?";
		try {
			return this.getJdbcTemplate().queryForObject(sql, new Object[] {alpha2}, countryCodeRowMapper);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public List<CountryCode> findAll() {
		String sql = "SELECT * FROM COUNTRY";
		return this.getJdbcTemplate().query(sql, countryCodeRowMapper);		
	}
	
	@Override
	public List<CountryCode> findCountriesLikeSpecificName(String specificName) {
		StringBuffer buf = new StringBuffer();
		buf.append("WHERE ");
		
		buf.append("NAME like '%");
		buf.append(specificName);
		buf.append("%'");
		buf.append(" COLLATE UTF8_GENERAL_CI ");

		String whereClause = buf.toString();
		String query = "SELECT * FROM COUNTRY " + whereClause;
		List<CountryCode> countries = this.getJdbcTemplate().query(query, countryCodeRowMapper);		
		return countries;
	}
	
	
}