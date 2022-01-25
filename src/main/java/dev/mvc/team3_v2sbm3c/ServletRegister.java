package dev.mvc.team3_v2sbm3c;

import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dev.mvc.uploadtool.Download;

@Configuration
public class ServletRegister {
    @Bean
    public ServletRegistrationBean getServletRegistrationBean() {

        // urlPatterns: /download?dir=/contents/storage&filename=winter_1.jpg&downname=winter.jpg
        // urlPatterns: /download?dir=/attachfile/storage&filename=winter_1.jpg&downname=winter.jpg
        ServletRegistrationBean registrationBean = new ServletRegistrationBean(new Download());
        registrationBean.addUrlMappings("/download"); // 접근 주소

        return registrationBean;
    }
}