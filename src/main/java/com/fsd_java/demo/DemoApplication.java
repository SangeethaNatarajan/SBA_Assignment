package com.fsd_java.demo;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.fsd_java.demo.model.TaskListVO;
import com.fsd_java.demo.model.User;
import com.fsd_java.demo.model.Project;
import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.repository.TaskRepository;
import com.fsd_java.demo.service.ProjectService;
import com.fsd_java.demo.service.TaskService;
import com.fsd_java.demo.service.UserService;

@Configuration
@EnableAutoConfiguration
@ComponentScan({"com.fsd_java.demo"})

//@SpringBootApplication
public class DemoApplication {
	
	private static final Logger logger = LoggerFactory.getLogger(DemoApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
	
	@Bean 
	public CommandLineRunner setup(TaskRepository toDoRepository) {
		return (args) -> {
			toDoRepository.save(new Task(1, "TestTask1",2,"TestParent1", new Date(), new Date(), "Active"));
			toDoRepository.save(new Task(2, "TestTask1",4,"TestParent1", new Date(), new Date(), "Active"));
			toDoRepository.save(new Task(3, "TestTask1",5,"TestParent1", new Date(), new Date(), "Active"));		
			logger.info("The sample data has been generated");
		};
	}
}