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

    	initializeCoverImages();        
    }
    
    
    private void initializeCoverImages() {
    	File source = new File(fileSystemResource().getPath() + File.separator + "coverImages" + File.separator);
		if(!source.isDirectory()) {
			if(!source.mkdirs()) {
				source.setWritable(true);
				source.setExecutable(true);
				System.out.println("directory creation is failed");
		
			}
		}
    	File target = new File(context.getRealPath("") + 
    	File.separator + "WEB-INF" + 
    	File.separator + "classes" + 
    	File.separator + "images" + 
    	File.separator + "coverImages" + File.separator);
    	
    	FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			if (source.isDirectory() && target.isDirectory()) {
	    		String[] files = source.list();
	    	
	            for (int i=0; i < files.length; i++) {
					fis = new FileInputStream(new File(source, files[i]));
					
					fos = new FileOutputStream(new File(target, files[i]));
					byte[] b = new byte[4096];
					int cnt = 0;
					while((cnt=fis.read(b)) != -1) {
						fos.write(b, 0, cnt);
					}
	            }
			}
			System.out.println("Cover Image Copy Success!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {
				if(fis != null)
					fis.close();
				if(fos != null)
					fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
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