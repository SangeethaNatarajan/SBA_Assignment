package com.fsd_java.demo.model;
 
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity // This tells Hibernate to make a table out of this class
@Table(name = "Task")
public class Task implements Serializable
{
    private static final long serialVersionUID = 1L;
 
    @Id
    @Column(name="ID")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    
   
    @Column(name="taskName")
    private String taskName;

    @Column(name="priority")
    private Integer priority;

    @Column(name="parentTaskName")
    private String parentTask;
    
    @Column(name="startDate")
    private Date startDate;
    
    
    @Column(name="endDate")
    private Date endDate;
     
    public Task(Integer id, String taskName, Integer priority, String parentTask, Date startDate, Date endDate) {
        super();
        this.id = id;
        this.taskName = taskName;
        this.priority = priority;
        this.parentTask = parentTask;
        this.startDate = startDate;
        this.endDate = endDate;
    }
     
    public Task(){
         
    }
 
    public Integer getId() {
        return id;
    }
 
    public void setId(Integer id) {
        this.id = id;
    }
 
    public String getTaskName() {
        return taskName;
    }
 
    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }
 
    public Integer getPriority() {
        return priority;
    }
 
    public void setPriority(Integer priority) {
        this.priority = priority;
    }
 
    public String getParentTask() {
        return parentTask;
    }
 
    public void setParentTask(String parentTask) {
        this.parentTask = parentTask;
    }
    
    public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
 
    @Override
    public String toString() {
        return "TaskVO [id=" + id + ", taskName=" + taskName
                + ", priorty=" + priority + ", parentTask=" + parentTask 
                + ", startDate=" + startDate +", endDate=" + endDate+"]";
    }
}