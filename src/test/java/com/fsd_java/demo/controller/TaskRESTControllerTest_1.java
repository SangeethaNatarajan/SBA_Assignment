/*package com.fsd_java.demo.controller;

import static org.hamcrest.collection.IsCollectionWithSize.hasSize;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

import org.junit.Assert;
import org.junit.Before;

import org.junit.Test;
import org.junit.runner.RunWith;
//import org.junit.runners.MethodSorters;
import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.web.context.WebApplicationContext;

//import org.springframework.util.Assert;


import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.fsd_java.demo.model.TaskListVO;
import com.fsd_java.demo.model.User;
import com.fsd_java.demo.model.Project;
import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.repository.TaskRepository;
import com.fsd_java.demo.service.ProjectService;
import com.fsd_java.demo.service.TaskService;
import com.fsd_java.demo.service.UserService;
import com.fsd_java.demo.*;



@RunWith(SpringJUnit4ClassRunner.class)
@Configuration
@EnableAutoConfiguration
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-servlet.xml"})
@SpringBootTest                     

public class TaskRESTControllerTest_1 {
 

	private MockMvc mockMvc;
		 
	@Mock
	TaskRepository taskRepository;
	
	@InjectMocks
	TaskService taskService;
	
	@Before
	public void setup(){
		MockitoAnnotations.initMocks(this);
	}
	
	  @Test
	    public void deleteTask() throws Exception{
	        mockMvc.perform(MockMvcRequestBuilders.delete("/deleteTask/79")
	                .accept(MediaType.APPLICATION_JSON))
	                .andExpect(MockMvcResultMatchers.status().isAccepted());
	    }
	
	@Test
	public void getAllTaskAPI() throws Exception
	{
	  mvc.perform( MockMvcRequestBuilders
	      .get("/getTasks")
	      .accept(MediaType.APPLICATION_JSON))
	      .andDo(print())
	      .andExpect(status().isOk())
	      .andExpect(MockMvcResultMatchers.jsonPath("$.tasks").exists())
	      .andExpect(MockMvcResultMatchers.jsonPath("$.tasks[*].id").isNotEmpty());
	}

	@Test
	
	public void testGetAllTasks(){
		List<Task> taskList = new ArrayList<Task>();
		taskList.add(new Task(1, "TestTask1",2,"TestParent1", new Date(), new Date(), "Active"));
		taskList.add(new Task(2, "TestTask1",4,"TestParent1", new Date(), new Date(), "Active"));
		taskList.add(new Task(3, "TestTask1",5,"TestParent1", new Date(), new Date(), "Active"));
		when(taskRepository.findAll()).thenReturn(taskList);
		
		List<Task> result = this.taskService.getAllTasks();
		
		
		
		Assert.assertEquals(3,result.size());
		//assertEquals(3, result.size());
	}
	    
	    
	 
	    @Mock
	    private SuperHeroRepository superHeroRepository;
	 
	    @InjectMocks
	    private SuperHeroController superHeroController;
	 
	    // This object will be magically initialized by the initFields method below.
	    private JacksonTester<SuperHero> jsonSuperHero;
	 
	    @Before
	    public void setup() {
	        // We would need this line if we would not use MockitoJUnitRunner
	        // MockitoAnnotations.initMocks(this);
	        // Initializes the JacksonTester
	        JacksonTester.initFields(this, new ObjectMapper());
	        // MockMvc standalone approach
	        mvc = MockMvcBuilders.standaloneSetup(superHeroController)
	                .setControllerAdvice(new SuperHeroExceptionHandler())
	                .addFilters(new SuperHeroFilter())
	                .build();
	    }
	 
	    @Test
	    public void canRetrieveByIdWhenExists() throws Exception {
	        // given
	        given(superHeroRepository.getSuperHero(2))
	                .willReturn(new SuperHero("Rob", "Mannon", "RobotMan"));
	 
	        // when
	        MockHttpServletResponse response = mvc.perform(
	                get("/superheroes/2")
	                        .accept(MediaType.APPLICATION_JSON))
	                .andReturn().getResponse();
	 
	        // then
	        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
	        assertThat(response.getContentAsString()).isEqualTo(
	                jsonSuperHero.write(new SuperHero("Rob", "Mannon", "RobotMan")).getJson()
	        );
	    }

}*/