package com.fsd_java.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.fsd_java.demo.model.User;

public interface UserRepository extends CrudRepository <User, Integer> {
	
	 @Query("SELECT a FROM User a WHERE a.firstname=:firstname")    
	 public User fetchUserByFirstName(@Param("firstname") String firstname);
	 
	 @Query("SELECT a FROM User a WHERE a.lastname=:lastname")    
	 public User fetchUserByLastName(@Param("lastname") String lastname); 
	 
	 @Query("SELECT a FROM User a WHERE a.empId=:empId")    
	 public User fetchUserByEmpID(@Param("empId") int empId);
	    
	 @Query("DELETE a FROM User a WHERE a.empId=:empId")    
	 public User deleteUserByEmpID(@Param("empId") int empId);

}