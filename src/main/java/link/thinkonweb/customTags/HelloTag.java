package link.thinkonweb.customTags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class HelloTag extends RequestContextAwareTag {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public int doStartTagInternal() throws JspException, IOException {
		RequestContext requestContext = getRequestContext();
		WebApplicationContext webApplicationContext = getRequestContext().getWebApplicationContext();
		JspWriter out = pageContext.getOut();
	    out.print("Hello SimpleTag!<br/>");
	    out.print(webApplicationContext.getBean("dataSource") + "<br/>");
	    out.print(webApplicationContext.getBean("manuscriptService") + "<br/>");
	    out.print(requestContext.getLocale().getLanguage() + "<br/>");
	    return 0;
	}
}