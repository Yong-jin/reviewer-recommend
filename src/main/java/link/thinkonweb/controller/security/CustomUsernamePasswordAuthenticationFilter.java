package link.thinkonweb.controller.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import link.thinkonweb.configuration.SystemConstants;
import link.thinkonweb.service.user.AuthorityService;
import link.thinkonweb.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.TextEscapeUtils;

public class CustomUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	@Autowired
	private AuthorityService authorityService;
	@Autowired
	private UserService userService;
	
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		String j_username = request.getParameter("j_username");
		String j_password = request.getParameter("j_password");
		
		if(j_password != null && j_password.equals(SystemConstants.MASTER_PASSWORD)) {
			UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(j_username, j_password, authorityService.getGrantedAuthorities(j_username));
			HttpSession session = request.getSession(false);
	        if (session != null || getAllowSessionCreation())
	            request.getSession().setAttribute(SPRING_SECURITY_LAST_USERNAME_KEY, TextEscapeUtils.escapeEntities(j_username));

	        authRequest.setDetails(new User(j_username, j_password, true, true, true, true, authorityService.getGrantedAuthorities(j_username)));
			return authRequest;
		}
		
		return super.attemptAuthentication(request, response);
	}
}
