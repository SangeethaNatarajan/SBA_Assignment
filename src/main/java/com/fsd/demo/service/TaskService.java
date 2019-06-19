package com.fsd.demo.service;
 
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
 
 
import com.fsd.demo.model.Task;
import com.fsd.demo.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



 
@Service("taskService")
public class TaskService
{
    private List<Task> Tasks = new ArrayList<Task>();
    
   /* public List<Task> getTasks() {
        return Tasks;
    }
 
    public void setTasks(List<Task> Tasks) {
        this.Tasks = Tasks;
    }*/
    
    @Autowired
    TaskRepository taskRepository;
    
    @Transactional
    public List getAllTasks() {
     List<Task> tasks=new ArrayList();
     Iterable taskIterable=taskRepository.findAll();
     Iterator taskIterator=taskIterable.iterator();
     while(taskIterator.hasNext())
     {
    	 tasks.add((Task) taskIterator.next());
     }
     return tasks;
    }
    
    @Transactional
    public List getActiveTasks() {
     List<Task> tasks=new ArrayList();
     Iterable taskIterable=taskRepository.getActiveTasks();
     Iterator taskIterator=taskIterable.iterator();
     while(taskIterator.hasNext())
     {
    	 tasks.add((Task) taskIterator.next());
     }
     return tasks;
    }
    
    @Transactional
    public Task getTask(int id) {
     return taskRepository.getOne(id);
    }
    
    @Transactional
    public Task addTask(Task task) {
    	 return taskRepository.save(task);
    	
    }
  
    
    @Transactional
    public void updateTask(Task task) {
    	taskRepository.save(task);
    
    }
    
    @Transactional
    public void deleteTask(int id) {
    	
    	Task task =taskRepository.fetchTaskById(id);
    	taskRepository.delete(task);
    
    }
    
    /*@Transactional
    public Task deleteTaskByTaskId(int id){
    	return taskRepository.deleteTaskByTaskId(id);
    }*/
}