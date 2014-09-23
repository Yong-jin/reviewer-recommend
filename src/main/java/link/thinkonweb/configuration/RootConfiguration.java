package link.thinkonweb.configuration;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.cache.CacheManager;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheFactoryBean;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.acls.domain.AclAuthorizationStrategyImpl;
import org.springframework.security.acls.domain.ConsoleAuditLogger;
import org.springframework.security.acls.domain.EhCacheBasedAclCache;
import org.springframework.security.acls.jdbc.BasicLookupStrategy;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.cache.EhCacheBasedUserCache;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.mvc.support.ControllerClassNameHandlerMapping;
import org.springframework.web.servlet.view.ResourceBundleViewResolver;

//this is the same as <mvc:annotation-driven/>
@EnableWebMvc
//this is the same as <context:component-scan base-package=”link.thinkonweb.config”/>
@ComponentScan(basePackages = {"link.thinkonweb.controller", 
							   "link.thinkonweb.service", 
							   "link.thinkonweb.domain", 
							   "link.thinkonweb.dao",
							   "link.thinkonweb.configuration",
							   "link.thinkonweb.util"
							   })
@Configuration
public class RootConfiguration extends WebMvcConfigurerAdapter{
    @Inject
    private ResourceLoader resourceLoader;

	private String driverClassName = "com.mysql.jdbc.Driver";;

    
   	@Bean
    public static PropertyPlaceholderConfigurer propertyPlaceholderConfigurer() {
        PropertyPlaceholderConfigurer ppc = new PropertyPlaceholderConfigurer();
        return ppc;
    }
	
	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		StringHttpMessageConverter stringConverter = new StringHttpMessageConverter(Charset.forName("UTF-8"));
	    stringConverter.setSupportedMediaTypes(Arrays.asList( //
	            MediaType.TEXT_PLAIN, //
	            MediaType.TEXT_HTML, //
	            MediaType.APPLICATION_JSON));
	    converters.add(stringConverter);
	}
	
    
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
    	registry.addViewController("/error/404").setViewName("exception.404");
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
        		.addResourceLocations("/WEB-INF/classes/resources/")
        		.setCachePeriod(3600);
    }
    
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(localeChangeInterceptor());
	}
		
	@Bean(name="localeChangeInterceptor")
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }
	
	@Bean(name="localeResolver")
	public SessionLocaleResolver sessionLocaleResolver() {
		SessionLocaleResolver slr = new SessionLocaleResolver();
		slr.setDefaultLocale(new Locale("en", "US"));
		return slr;
	}
	
	@Bean 
	public ShaPasswordEncoder shaPasswordEncoder() {
		ShaPasswordEncoder spe = new ShaPasswordEncoder(256);
		return spe;
	}
	
	@Bean
	public ControllerClassNameHandlerMapping controllerClassNameHandlerMapping() {
		ControllerClassNameHandlerMapping ccnhm = new ControllerClassNameHandlerMapping();
		ccnhm.setInterceptors(new Object[]{this.localeChangeInterceptor()});
		return ccnhm;
	}



	@Bean(name="dataSource")
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        if(SystemConstants.TEST_MODE) {
            dataSource.setUrl("jdbc:mysql://127.0.0.1:3306/jms?zeroDateTimeBehavior=convertToNull&amp;characterEncoding=UTF-8&amp;autoReconnect=true");
            dataSource.setUsername("root");
            dataSource.setPassword("jipskorg");
        } else {
            dataSource.setUrl("jdbc:mysql://db.manuscriptlink.com:3306/jms?zeroDateTimeBehavior=convertToNull&amp;characterEncoding=UTF-8&amp;autoReconnect=true");
            dataSource.setUsername("manuscriptlink");
            dataSource.setPassword("link#1234");
        }
        
        dataSource.setDriverClassName(this.driverClassName);
        dataSource.setInitialSize(5);
        dataSource.setMaxActive(15);
        dataSource.setValidationQuery("SELECT 1");
        dataSource.setTestOnBorrow(true);
        dataSource.setDefaultTransactionIsolation(java.sql.Connection.TRANSACTION_REPEATABLE_READ);
        return dataSource;
    }
	

	@Bean
	public NamedParameterJdbcTemplate namedParameterJdbcTemplate() {
		NamedParameterJdbcTemplate npjt = new NamedParameterJdbcTemplate(this.dataSource());
		return npjt;
	}


	@Bean(name="multipartResolver")
	public CommonsMultipartResolver commonsMultipartResolver() {
		
		CommonsMultipartResolver cmr = new CommonsMultipartResolver();
		cmr.setDefaultEncoding("UTF-8");
		cmr.setMaxUploadSize(31457280); //30MB
		try {
			cmr.setUploadTempDir(this.fileSystemResource());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return cmr;
	}
	
	@Bean
	public FileSystemResource fileSystemResource() {
		//FileSystemResource fsr = new FileSystemResource("/Users/yhhan/Documents/uploads/");

		String resourcePath = new String(File.separator + "var" + File.separator + "jms" + File.separator);
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

	@Bean
	public UserDetailsManager userDetailsManager() {
		JdbcUserDetailsManager userDetailsManager = new JdbcUserDetailsManager();
		userDetailsManager.setDataSource(this.dataSource());
		userDetailsManager.setUserCache(this.ehCacheBasedUserCache());
		userDetailsManager.setUsersByUsernameQuery("SELECT USERNAME, PASSWORD, ENABLED FROM USERS WHERE USERNAME=?");
		userDetailsManager.setAuthoritiesByUsernameQuery("SELECT U.USERNAME, A.ROLE FROM USERS U, AUTHORITIES A WHERE U.ID = A.USER_ID AND U.USERNAME=?");
		
		//userDetailsManager.setUsersByUsernameQuery("SELECT EMAIL, USERNAME, PASSWORD, ENABLED FROM USERS WHERE (USERNAME=? OR EMAIL=?)");
		//userDetailsManager.setAuthoritiesByUsernameQuery("SELECT U.EMAIL, A.ROLE FROM USERS U, AUTHORITIES A WHERE U.ID = A.USER_ID AND (U.USERNAME=? OR U.EMAIL=?)");
		return userDetailsManager;
	}
	
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource bundle = new ReloadableResourceBundleMessageSource();
		bundle.setBasenames(new String[] {"WEB-INF/classes/i18n/message", "WEB-INF/classes/i18n/email"});
		bundle.setCacheSeconds(1);
		bundle.setFallbackToSystemLocale(false);
		return bundle;
	}
	
	@Bean
    public CacheManager cacheManager() {
        EhCacheCacheManager ehCacheCacheManager = new EhCacheCacheManager();
        try {
            ehCacheCacheManager.setCacheManager(ehcacheCacheManager().getObject());
        } catch (Exception e) {
            throw new IllegalStateException("Failed to create an EhCacheManagerFactoryBean", e);
        }
        return ehCacheCacheManager;
    }

    @Bean
    public FactoryBean<net.sf.ehcache.CacheManager> ehcacheCacheManager() {
        EhCacheManagerFactoryBean bean = new EhCacheManagerFactoryBean();
        bean.setShared(true);
        bean.setConfigLocation(resourceLoader.getResource("classpath:resources/ehcache.xml"));
        return bean;
    }

	@Bean 
	public EhCacheFactoryBean ehCacheFactoryBean() {
		EhCacheFactoryBean ecfb = new EhCacheFactoryBean();
		try {
			ecfb.setCacheManager(this.ehcacheCacheManager().getObject());
		} catch (Exception e) {
			e.printStackTrace();
		}
		ecfb.setCacheName("userCache");
		return ecfb;
	}
	@Bean(name="ehCacheBasedUserCache")
	public EhCacheBasedUserCache ehCacheBasedUserCache() {
		EhCacheBasedUserCache ecbuc = new EhCacheBasedUserCache();
		ecbuc.setCache(this.ehCacheFactoryBean().getObject());
		return ecbuc;
	}
	
	@Bean
	public EhCacheBasedAclCache ehCacheBasedAclCache() {
		EhCacheBasedAclCache ecbac = new EhCacheBasedAclCache(this.ehCacheFactoryBean().getObject());
		return ecbac;
	}	
    
    @Bean
    public AclAuthorizationStrategyImpl aclAuthorizationStrategyImpl() {
    	AclAuthorizationStrategyImpl aasi = new AclAuthorizationStrategyImpl(new GrantedAuthority[]{this.simpleGrantedAuthority(), this.simpleGrantedAuthority(), this.simpleGrantedAuthority()});
    	return aasi;
    }
    
    public SimpleGrantedAuthority simpleGrantedAuthority() {
    	return new SimpleGrantedAuthority("ROLE_SUPER_MANAGER");
    }
    
    @Bean
    public ConsoleAuditLogger consoleAuditLogger() {
    	ConsoleAuditLogger cal = new ConsoleAuditLogger();
    	return cal;
    }
    
    @Bean
    public BasicLookupStrategy basicLookupStrategy() {
    	BasicLookupStrategy bls = new BasicLookupStrategy(this.dataSource(), this.ehCacheBasedAclCache(), this.aclAuthorizationStrategyImpl(), this.consoleAuditLogger());
    	return bls;
    }

    @Bean
    public JdbcMutableAclService jdbcMutableAclService() {
    	JdbcMutableAclService jmas = new JdbcMutableAclService(this.dataSource(), this.basicLookupStrategy(), this.ehCacheBasedAclCache());
    	jmas.setSidIdentityQuery("SELECT @@IDENTITY");
    	jmas.setClassIdentityQuery("SELECT @@IDENTITY");
    	return jmas;
    }
    
  	/**  
	<bean id="aclMessageDeleteVoter" class="org.springframework.security.acls.AclEntryVoter">
        <constructor-arg ref="aclService"/>
        <constructor-arg value="ACL_MESSAGE_DELETE"/>
        <constructor-arg>
            <list>
                <util:constant static-field="org.springframework.security.acls.domain.BasePermission.ADMINISTRATION"/>
                <util:constant static-field="org.springframework.security.acls.domain.BasePermission.DELETE"/>
            </list>
        </constructor-arg>
        <property name="processDomainObjectClass" value="link.thinkonweb.board.domain.Message"/>
  	</bean>
  	**/
 	
	@Bean
	public ResourceBundleViewResolver resourceBundleViewResolver() {
		ResourceBundleViewResolver rbvr = new ResourceBundleViewResolver();
		rbvr.setBasename("/resources/views");
		rbvr.setOrder(1);
		return rbvr;
	}

}