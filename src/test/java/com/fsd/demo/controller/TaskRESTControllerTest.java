package com.fsd.demo.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.fsd.demo.model.Project;
import com.fsd.demo.model.Task;
import com.fsd.demo.model.User;
import com.fsd.demo.service.ProjectService;
import com.fsd.demo.service.TaskService;
import com.fsd.demo.service.UserService;
import com.fsd.demo.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = DemoApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class TaskRESTControllerTest {
     @Autowired
     private TestRestTemplate restTemplate;

     @Autowired
     private TaskService taskService;
     
     @Autowired
     private UserService userService;
     
     @Autowired
     private ProjectService projectService;

     @LocalServerPort
     private int port;

     private String getRootUrl() {
         return "http://localhost:" + port;
     }

     @Test
     public void contextLoads() {

     }

     @Test
     public void testGetAllTasks() {
     HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<String>(null, headers);
        ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/getTasks",
        HttpMethod.GET, entity, String.class);  
        assertNotNull(response.getBody());
    }
     
     @Test
     public void testGetActiveTasks() {
     HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<String>(null, headers);
        ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/getActiveTasks",
        HttpMethod.GET, entity, String.class);  
        assertNotNull(response.getBody());
    }
     
     @Test
     public void testGetUsers() {
     HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<String>(null, headers);
        ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/getUsers",
        HttpMethod.GET, entity, String.class);  
        assertNotNull(response.getBody());
        
        
    }
     
     @Test
     public void testGetProjects() {
     HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<String>(null, headers);
        ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/getProjects",
        HttpMethod.GET, entity, String.class);  
        assertNotNull(response.getBody());
    }
     
   
     
     @Test
     public void testTask() {
    	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date date1 = new Date();
         Date date2 = new Date();
		try {
			date1 = sdf.parse("2019-01-01");
			date2 = sdf.parse("2019-12-31");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       Task task = new Task(-1, "sampleTaskTest", 100, "SampleParentTest", date1, date2, "Active");
     
       Task savedTask = taskService.addTask(task);
       assertThat(taskService.getTask(savedTask.getId())).isNotNull();
       savedTask.setStatus("DeActive");
       savedTask.setEndDate(date2);
       savedTask.setStartDate(date1);
       savedTask.setPriority(100);
       savedTask.setTaskName("sampleTaskTest");
       savedTask.setParentTask("SampleParentTest");
       savedTask.setId(savedTask.getId());
       taskService.updateTask(savedTask);
       assertEquals(savedTask.getStatus(),"DeActive");
       assertNotNull(savedTask.toString());
       
      
       
       Task task1 = new Task(-1, "sampleTaskTest1", 101, "SampleParentTest1", date1, date2, "Active");
    
       RestTemplate restTemplate = new RestTemplate();
       Task result = restTemplate.postForObject( getRootUrl() +"/addTask", task1, Task.class);
       assertNotNull(result);
     
       taskService.deleteTask(savedTask.getId());
      
     }
     
     
     @Test
     public void testProject() {    	
    	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         Date date1 = new Date();
         Date date2 = new Date();
		try {
			date1 = sdf.parse("2019-01-01");
			date2 = sdf.parse("2019-12-31");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
       Project project = new Project(-1, "SampleProject", date1, date2, 123, 
   		    "SampleManager", 100000);
       Project savedProject = projectService.addProject(project);
       savedProject.setProjectName("SampleProjectUpdate");
       savedProject.setManager("SampleManagerTest");
       savedProject.setPriority(22222);
       savedProject.setTaskId(12331);
       savedProject.setProjectId(savedProject.getProjectId());
       savedProject.setStartDate(date1);
       savedProject.setEndDate(date2);
       projectService.updateProject(savedProject);
       assertEquals(savedProject.getProjectName(),"SampleProjectUpdate");   
       assertEquals(projectService.fetchProjctByTaskId(12331).getManager(),"SampleManagerTest");
       assertEquals(projectService.fetchProjectByEmpID("SampleManagerTest").getManager(),"SampleManagerTest");
       assertEquals(projectService.fetchProjectByProjectId(savedProject.getProjectId()).getManager(),"SampleManagerTest");
       assertEquals(projectService.fetchProjectByProjectName("SampleProjectUpdate").getManager(),"SampleManagerTest");
       assertNotNull(savedProject.toString());
       projectService.deleteProject(savedProject.getProjectId());
       
       
       Project project1 = new Project(-1, "SampleProject", date1, date2, 123, 
      		    "SampleManager", 100000);
       
       RestTemplate restTemplate = new RestTemplate();
       Project result1 = restTemplate.postForObject( getRootUrl() +"/addProject", project1, Project.class);
       assertNotNull(result1);
       
      // assertThat(taskService.getTask(taskId)).isNull();
     }
     
     
     @Test
     public void testUser() {    	
    	 
       User user = new User(-1, "TestFirstName", "TestLastName", 777777);
       User savedUser = userService.addUser(user);
       savedUser.setFirstname("TestFirstNameUpdate");
       savedUser.setLastname("TestLastName");
       savedUser.setUserId(savedUser.getUserId());
       savedUser.setEmpId(777777);
       userService.updateUser(savedUser);
       assertEquals(savedUser.getFirstname(),"TestFirstNameUpdate");      
       User getUser = userService.findByEmpID(777777);
       assertEquals(getUser.getEmpId(),savedUser.getEmpId());
       assertEquals(userService.findByFirstName("TestFirstNameUpdate").getFirstname(),"TestFirstNameUpdate");
       assertEquals(userService.findByLastName("TestLastName").getLastname(),"TestLastName");
       assertNotNull(savedUser.toString());
       userService.deleteUser(savedUser.getUserId());
       
       User user1 = new User(-1, "TestFirstName", "TestLastName", 777777);
      
      RestTemplate restTemplate = new RestTemplate();
     
      User result2 = restTemplate.postForObject( getRootUrl() +"/addUser", user1, User.class);
      assertNotNull(result2);
     // userService.deleteUser(result2.getUserId());
     
       
     }
     
   /*  @Autowired 
 	UserService userService1;
 	@RequestMapping(value="/getUsers",
 			method=RequestMethod.GET,produces = { MediaType.APPLICATION_JSON_VALUE})
     //@ResponseStatus(HttpStatus.OK)
 	//@ResponseBody
     public List<User>  getUsers(Model model) 
     {
 		User user = new User();
       	List <User> listOfUsers = this.userService1.getAllUsers();
 		  model.addAttribute("user", user);
 		  model.addAttribute("users", listOfUsers);
 		  System.out.println(listOfUsers.size());	
 		  return listOfUsers;
     }*/
}



/*package com.fsd.demo.controller;

import static org.junit.Assert.assertEquals;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import com.fsd.demo.model.Task;
import com.fsd.demo.model.User;
import com.fsd.demo.service.TaskService;
import com.fsd.demo.service.UserService;

@RunWith(SpringRunner.class)
@Configuration
@EnableAutoConfiguration
//@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-servlet.xml"})
//@WebMvcTest

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class TaskRESTControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private TaskService TaskService;
    
    @MockBean
    private UserService userService;

    @Test
    public void findAll() throws Exception {
        // given
        Task Task = new Task();
        Task.setId(1L);
        Task.setName("Task 1");
        Task.setPrice(new BigDecimal(1));

        List<Task> Tasks = Arrays.asList(Task);
        given(TaskService.getAllTasks()).willReturn(Tasks);

        // when + then
        this.mockMvc.perform(get("/getTasks"))
       
                .andExpect(status().isOk());
               // .andExpect(content()..json("[{'id': 1,'name': 'Task 1';'price': 1}]"));
        			
    }
    
   
        @Autowired
        private TestRestTemplate restTemplate;
        
        
        
        @Test
        public void createUser() {
            ResponseEntity<User> responseEntity =
                restTemplate.postForEntity("/addUser", new User(1, "FirstName", "LastName", 123123),User.class);
            User user = responseEntity.getBody();
            assertEquals(HttpStatus.CREATED, responseEntity.getStatusCode());
            assertEquals("FirstName", user.getFirstname());
        }
    
}

*/