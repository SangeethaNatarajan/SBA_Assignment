package com.fsd_java.demo.service;
 
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
 
 
import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



 
@Service("taskService")
public class TaskService
{
    private List<Task> Tasks = new ArrayList<Task>();
 
    public List<Task> getTasks() {
        return Tasks;
    }
 
    public void setTasks(List<Task> Tasks) {
        this.Tasks = Tasks;
    }
    
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
    public Task getTask(int id) {
     return taskRepository.findOne(id);
    }
    
    @Transactional
    public void addTask(Task task) {
    	taskRepository.save(task);
    }
    
    @Transactional
    public void updateTask(Task task) {
    	taskRepository.save(task);
    
    }
    
    @Transactional
    public void deleteTask(int id) {
    	taskRepository.delete(id);
    }
}