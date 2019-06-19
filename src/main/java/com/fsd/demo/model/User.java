package com.fsd.demo.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity // This tells Hibernate to make a table out of this class
@Table(name = "user")
public class User implements Serializable
{
    private static final long serialVersionUID = 1L;
 
    @Id
    @Column(name="userId")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer userId;
    
   
    @Column(name="firstName")
    private String firstname;

    @Column(name="lastName")
    private String lastname;
    
    @Column(name="empId")
    private Integer empId;
    
        
    public User(Integer userId, String firstName, String lastName, Integer empId) {
        super();
        this.userId = userId;
        this.firstname = firstName;
        this.lastname = lastName;
        this.empId = empId;
 
    }
     
    public User(){
         
    }
 
    
    @Override
    public String toString() {
        return "User [userid=" + userId + ", firstName=" + firstname
                + ", lastName=" + lastname +", empId=" + empId+"]";
    }

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}
}