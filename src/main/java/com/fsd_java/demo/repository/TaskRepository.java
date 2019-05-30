package com.fsd_java.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.fsd_java.demo.model.Project;
import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.model.User;


public interface TaskRepository extends CrudRepository <Task, Integer> {

	 @Query("SELECT a FROM Task a WHERE a.status != 'DeActive' ")    
	 public List getActiveTasks();
	 
	 @Query("SELECT a FROM Task a WHERE a.ID=:id")    
	 public Task fetchTaskByID(@Param("id") int id);
	 
	 @Query("DELETE a FROM Task a WHERE a.ID=:id")    
	 public Task deleteTaskByID(@Param("id") int id);
	
}