package link.thinkonweb.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLogoutHandler extends SimpleUrlLogoutSuccessHandler implements LogoutSuccessHandler {
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
    	String refererUrl = request.getHeader("Referer");

    	if (refererUrl.indexOf("/journals/") > 0) {
        	int fromIndex = refererUrl.indexOf("/journals/") + 10;
        	String jnid = refererUrl.substring(fromIndex);
    		setDefaultTargetUrl("/journals/" + jnid);
    	} else
    		setDefaultTargetUrl("/");
    	
        super.onLogoutSuccess(request, response, authentication);
    }
}