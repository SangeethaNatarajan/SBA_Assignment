package com.fsd.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.fsd.demo.model.Project;


public interface ProjectRepository extends JpaRepository <Project, Integer> {
	
	 @Query("SELECT a FROM Project a WHERE a.projectName=:projectName")    
	 public Project fetchProjectByProjectName(@Param("projectName") String projectName);
	 
	 @Query("SELECT a FROM Project a WHERE a.taskId=:taskId")    
	 public Project fetchProjctByTaskId(@Param("taskId") int taskId); 
	 
	 @Query("SELECT a FROM Project a WHERE a.manager=:manager")    
	 public Project fetchProjectByEmpID(@Param("manager") String manager);
	 
	 @Query("SELECT a FROM Project a WHERE a.projectId=:projectId")    
	 public Project fetchProjectByProjectId(@Param("projectId") int projectId);

	
	/* @Query("DELETE a FROM Project a WHERE a.projectId=:projectId")    
	 public Project deleteProjectByProjectId(@Param("projectId") int projectId);   */
	

}