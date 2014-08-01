package link.thinkonweb.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter;
import org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

@EnableWebMvc
@Configuration 
public class RootConfigurationSupport extends WebMvcConfigurationSupport {

	public RootConfigurationSupport() {
		// TODO Auto-generated constructor stub
	}
	
	@Bean
	public RequestMappingHandlerAdapter requestMappingHandlerAdapter() {
	    RequestMappingHandlerAdapter handlerAdapter = super.requestMappingHandlerAdapter();
	    return handlerAdapter;
	}
	
	@Bean
	public DefaultAnnotationHandlerMapping defaultAnnotationHandlerMapping() {
	    DefaultAnnotationHandlerMapping m = new DefaultAnnotationHandlerMapping();
	    m.setDetectHandlersInAncestorContexts(true);
	    return m;
	}
	
	@Bean
	public AnnotationMethodHandlerAdapter annotationMethodHandlerAdapter() {
		AnnotationMethodHandlerAdapter a = new AnnotationMethodHandlerAdapter();
		return a;
	}

	@Bean
	public MappingJacksonHttpMessageConverter mappingJacksonHttpMessageConverter() {
		MappingJacksonHttpMessageConverter mjhmc = new MappingJacksonHttpMessageConverter();
		return mjhmc;
	}
}
