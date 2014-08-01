package link.thinkonweb.util;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcOperations;

public class JdbcTokenRepositoryImplCleaner implements Runnable {
	private Logger logger = LoggerFactory.getLogger(getClass());
    private final JdbcOperations jdbcOperations;
    private final long tokenValidityInMs;

    public JdbcTokenRepositoryImplCleaner(JdbcOperations jdbcOperations, long tokenValidityInMs) {
        if (jdbcOperations == null) {
            throw new IllegalArgumentException("jdbcOperations cannot be null");
        }
        if (tokenValidityInMs < 1) {
            throw new IllegalArgumentException("tokenValidityInMs must be greater than 0. Got " + tokenValidityInMs);
        }
        this.jdbcOperations = jdbcOperations;
        this.tokenValidityInMs = tokenValidityInMs;
    }

    public void run() {
        long expiredInMs = System.currentTimeMillis() - tokenValidityInMs;
        try {
            jdbcOperations.update("delete from persistent_logins where last_used <= ?", new Date(expiredInMs));
        }catch(Throwable t) {
            logger.error("Could not clean up expired persistent remember me tokens.",t);
        }
    }
}
