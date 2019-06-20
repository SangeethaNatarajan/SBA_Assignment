package com.fsd.demo.controller;
 
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.RedirectView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fsd.demo.model.User;
import com.fsd.demo.model.Project;
import com.fsd.demo.model.Task;
import com.fsd.demo.repository.TaskRepository;
import com.fsd.demo.service.ProjectService;
import com.fsd.demo.service.TaskService;
import com.fsd.demo.service.UserService;
 

 
@RestController
@EnableWebMvc
public class TaskRESTController 
{
	
	@Autowired 
	TaskService taskService;
	


	//rendering to index.jsp view
	@RequestMapping(method = RequestMethod.GET)
    public ModelAndView index() {

        return new ModelAndView("index");
    }
	
	@RequestMapping(value="/getTasks",
			method=RequestMethod.GET,produces = { MediaType.APPLICATION_JSON_VALUE})
    public List<Task>  getTasks(Model model) 
    {
		Task task = new Task();
      	List <Task> listOfTasks = this.taskService.getAllTasks();
		  model.addAttribute("task", task);
		  model.addAttribute("tasks", listOfTasks);
		  System.out.println(listOfTasks.size());	
		  return listOfTasks;
    }
	
	@RequestMapping(value="/getActiveTasks",
			method=RequestMethod.GET,produces = { MediaType.APPLICATION_JSON_VALUE})
    public List<Task>  getActiveTasks(Model model) 
    {
		Task task = new Task();
      	List <Task> listOfTasks = this.taskService.getActiveTasks();
		  model.addAttribute("task", task);
		  model.addAttribute("tasks", listOfTasks);
		  System.out.println(listOfTasks.size());	
		  return listOfTasks;
    }
	
	 
    @RequestMapping(value = "/addTask", method = RequestMethod.POST,headers = "Accept=application/json",
    		produces = { MediaType.APPLICATION_JSON_VALUE, //
                    MediaType.APPLICATION_XML_VALUE })
    @ResponseStatus(HttpStatus.OK)
    public Task addTask(@RequestBody Task taskForm)
	{	
    	System.out.println(taskForm.getStartDate());
    	System.out.println(taskForm.getEndDate());
    	Task addTask = taskForm;
    	System.out.println(addTask.toString());	    	
	    
	  	return taskService.addTask(addTask);
	  	
	 }
    
   
    
    @RequestMapping(value = "/updateTask", method = RequestMethod.POST, headers = "Accept=application/json")
    public List <Task> updateTask(@RequestBody Task taskForm) {
    	//System.out.println(" updateTAsk called taskName"+taskForm.getTaskName());
    	//System.out.println("updateTAsk called id"+taskForm.getId());
    	//System.out.println("updateTAsk called parentTAsk"+taskForm.getParentTask());
    	//System.out.println("updateTAsk called startDate"+taskForm.getStartDate());
    	//System.out.println("updateTAsk called endDate"+taskForm.getEndDate());
    	//System.out.println("updateTAsk called priority"+taskForm.getPriority());
      this.taskService.updateTask(taskForm);
      //this.taskService.updateTask(this.taskService.getTask(id));
     // model.addAttribute("tasks", this.taskService.getAllTasks());
      
      return this.taskService.getAllTasks();    
    }
    
    @RequestMapping(value = "/deleteTask/{id}", method = RequestMethod.GET, headers = "Accept=application/json")
    public ModelAndView  deleteTask(@PathVariable("id") int id, Model model) {
    	taskService.deleteTask(id);    	 	
        return new ModelAndView("redirect:/getTasks");
    
    }
    
   /* @RequestMapping(value = "/deleteTask", method = RequestMethod.GET, headers = "Accept=application/json")
    public ModelAndView  deleteTask(@RequestBody Task taskForm) {
    	taskService.deleteTask(taskForm);    	 	
        return new ModelAndView("redirect:/getTasks");
    
    }*/
    
    @Autowired 
	UserService userService;
    @RequestMapping(value = "/addUser", method = RequestMethod.POST,headers = "Accept=application/json",
    		produces = { MediaType.APPLICATION_JSON_VALUE, //
                    MediaType.APPLICATION_XML_VALUE })
    @ResponseStatus(HttpStatus.OK)
    public User addUser(@RequestBody User userForm)
	{	    
    	User addUser = userForm;    		
    	userService.addUser(addUser);
	  	return addUser;
	}
    
    @Autowired 
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
    }
	
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST, headers = "Accept=application/json")
    public List <User> updateUser(@RequestBody User userForm) {
		System.out.println(" updateUser called firstname"+userForm.getFirstname());
    	System.out.println("updateUser called lastname"+userForm.getLastname());
    	System.out.println("updateUser called empId"+userForm.getEmpId());
    	System.out.println("updateUser called userID"+userForm.getUserId());
    	
    	
      this.userService.updateUser(userForm);
      //this.taskService.updateTask(this.taskService.getTask(id));
     // model.addAttribute("tasks", this.taskService.getAllTasks());
      
      return this.userService.getAllUsers();    
    }
    
	 @RequestMapping(value = "/deleteUser/{id}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  List <User>   deleteUser(@PathVariable("id") int id, Model model) {
		 	this.userService.deleteUser(id);    	 	
		 	return this.userService.getAllUsers();	    
	    }
   
	 @RequestMapping(value = "/searchUserByFirstName/{firstName}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  User searchUserByFirstName(@PathVariable("firstName") String firstName, Model model) {
		 	User user = this.userService.findByFirstName(firstName) ;  	 	
		 	return user;	    
	    }
	 
	 @RequestMapping(value = "/searchUserByLastName/{lastName}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  User searchUserByLastName(@PathVariable("lastName") String lastName, Model model) {
		 	User user = this.userService.findByLastName(lastName) ;  	 	
		 	return user;	    
	    }
	 
	 @RequestMapping(value = "/searchUserByEmpID/{EmpID}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  User searchUserByEmpID(@PathVariable("EmpID") int EmpID, Model model) {
		 	User user = this.userService.findByEmpID(EmpID);  	 	
		 	return user;	    
	    }
	 
	 
	 @Autowired 
		ProjectService projectService;
	    @RequestMapping(value = "/addProject", method = RequestMethod.POST,headers = "Accept=application/json",
	    		produces = { MediaType.APPLICATION_JSON_VALUE, //
	                    MediaType.APPLICATION_XML_VALUE })
	    @ResponseStatus(HttpStatus.OK)
	    public Project addProject(@RequestBody Project projectForm)
		{	
	    	System.out.println(" Project passed "+ projectForm.toString());
	    	Project addProject = projectForm;
	    	System.out.println(projectForm.toString());	    	
	    	projectService.addProject(addProject);
		  	return addProject;
		}
	    
	    
	    @RequestMapping(value="/getProjects",
				method=RequestMethod.GET,produces = { MediaType.APPLICATION_JSON_VALUE})
	    //@ResponseStatus(HttpStatus.OK)
		//@ResponseBody
	    public List<Project>  getProjects(Model model) 
	    {
	    	Project project = new Project();
	      	List <Project> listOfProject = this.projectService.getAllProjects();
			  model.addAttribute("project", project);
			  model.addAttribute("projects", listOfProject);
			  System.out.println(listOfProject.size());	
			  return listOfProject;
	    }
	    
	    @RequestMapping(value = "/fetchProjectByProjectName/{projectName}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  Project fetchProjectByProjectName(@PathVariable("projectName") String projectName, Model model) {
	    	Project project = this.projectService.fetchProjectByProjectName(projectName); 
	    	System.out.println("     "+project.toString());
		 	return project;	    
	    }
	    
	    @RequestMapping(value = "/fetchProjectByProjectId/{projectId}", method = RequestMethod.GET, headers = "Accept=application/json")
	    public  Project fetchProjectByProjectId(@PathVariable("projectId") int projectId, Model model) {
	    	Project project = this.projectService.fetchProjectByProjectId(projectId); 
	    	System.out.println("     "+project.toString());
		 	return project;	    
	    }
	 
		
}