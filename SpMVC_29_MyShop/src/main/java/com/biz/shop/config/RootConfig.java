package com.biz.shop.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@ComponentScan(basePackages = {"com.biz.shop.auth",
								"com.biz.shop.service"}
)
@Configuration
public class RootConfig {

	
}
