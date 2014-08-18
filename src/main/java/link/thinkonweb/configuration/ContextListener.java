package link.thinkonweb.configuration;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.*;

import org.springframework.core.io.FileSystemResource;
import org.springframework.web.context.support.WebApplicationContextUtils;

public final class ContextListener implements ServletContextListener {
    private ServletContext context = null;
	
    public void contextInitialized(ServletContextEvent event) {
    	context = event.getServletContext();
    	WebApplicationContextUtils
	        .getRequiredWebApplicationContext(context)
	        .getAutowireCapableBeanFactory()
	        .autowireBean(this);
    }

    public void contextDestroyed(ServletContextEvent event) {
    }
    
    public FileSystemResource fileSystemResource() {
		String resourcePath = new String(SystemConstants.ORIGIN_PATH);
		File dir = new File(resourcePath);
		if(!dir.isDirectory()) {
			if(!dir.mkdirs()) {
				dir.setWritable(true);
				dir.setExecutable(true);
				System.out.println("directory creation is failed");
		
			}
		}
		FileSystemResource fsr = new FileSystemResource(dir);
		return fsr;
	}
}