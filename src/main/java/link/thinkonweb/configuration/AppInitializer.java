package link.thinkonweb.configuration;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;

public class AppInitializer implements WebApplicationInitializer {	
	private static final Class<?>[] configurationClasses 
		= new Class<?>[]{RootConfiguration.class, RootConfigurationSupport.class};

	@Override
    public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(configurationClasses);
        
        this.addUtf8CharacterEncodingFilter(servletContext);        
        
        System.out.println("***********************************************************");
        System.out.println("AppInitializer Started!");
        System.out.println("servletContext.getServletContextName() - " + servletContext.getServletContextName());
        System.out.println("servletContext.getServerInfo() - " + servletContext.getServerInfo());
        System.out.println("servletContext.getContextPath() - " + servletContext.getContextPath());
        System.out.println("AppInitializer - Database Initialized");
        System.out.println("***********************************************************");        
    }
	
    private void addUtf8CharacterEncodingFilter(ServletContext servletContext) {
        FilterRegistration.Dynamic filter = servletContext.addFilter("CHARACTER_ENCODING_FILTER", CharacterEncodingFilter.class);
        filter.setInitParameter("encoding", "UTF-8");
        filter.setInitParameter("forceEncoding", "true");
        filter.addMappingForUrlPatterns(null, false, "/*");
    }
}