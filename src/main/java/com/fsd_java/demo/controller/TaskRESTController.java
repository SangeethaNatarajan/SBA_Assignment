package com.fsd_java.demo.controller;
 
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

import com.fsd_java.demo.model.TaskListVO;
import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.repository.TaskRepository;
import com.fsd_java.demo.service.TaskService;
 

 
@RestController
@EnableWebMvc
public class TaskRESTController 
{
	
	@Autowired 
	TaskService taskService;
	@RequestMapping(value="/getTasks",
			method=RequestMethod.GET,produces = { MediaType.APPLICATION_JSON_VALUE})
    //@ResponseStatus(HttpStatus.OK)
	//@ResponseBody
    public List<Task>  getTasks(Model model) 
    {
		Task task = new Task();
      	List <Task> listOfTasks = this.taskService.getAllTasks();
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
	    taskService.addTask(addTask);
	  	return addTask;
	}
    
    @RequestMapping(value = "/updateTask", method = RequestMethod.POST, headers = "Accept=application/json")
    public List <Task> updateTask(@RequestBody Task taskForm) {
    	System.out.println(" updateTAsk called taskName"+taskForm.getTaskName());
    	System.out.println("updateTAsk called id"+taskForm.getId());
    	System.out.println("updateTAsk called parentTAsk"+taskForm.getParentTask());
    	System.out.println("updateTAsk called startDate"+taskForm.getStartDate());
    	System.out.println("updateTAsk called endDate"+taskForm.getEndDate());
    	System.out.println("updateTAsk called priority"+taskForm.getPriority());
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
    
   
}