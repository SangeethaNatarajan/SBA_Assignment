package com.fsd.demo.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Stores all web configurations.
 * <p>
 * Created by lukasz on 27.08.2017.
 * With IntelliJ IDEA 15
 */
@EnableWebMvc
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

    @Value("${spring.mvc.view.prefix}")
    private String prefix;

    @Value("${spring.mvc.view.suffix}")
    private String suffix;

    /**
     * Configures resolver for jsp views.
     */
    @Bean
    public InternalResourceViewResolver setupViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix(prefix);
        resolver.setSuffix(suffix);
        resolver.setViewClass(JstlView.class);
        return resolver;
    }
}