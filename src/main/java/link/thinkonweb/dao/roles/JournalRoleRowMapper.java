package link.thinkonweb.dao.roles;

import java.sql.ResultSet;
import java.sql.SQLException;

import link.thinkonweb.domain.roles.JournalRole;

import org.springframework.jdbc.core.RowMapper;


public abstract class JournalRoleRowMapper<T extends JournalRole> implements RowMapper<T> {
    public T mapRow(final ResultSet rs, final int rowNum) throws SQLException {
        final T entity = instantiateEntityClass(rs, rowNum);        
        entity.setId(rs.getInt("ID"));
        entity.setJournalId(rs.getInt("JOURNAL_ID"));
		entity.setUserId(rs.getInt("USER_ID"));
		entity.setAuthorityId(rs.getInt("AUTHORITY_ID"));

        return entity;
    }

    protected abstract T instantiateEntityClass(final ResultSet rs, final int rowNum) throws SQLException;

}