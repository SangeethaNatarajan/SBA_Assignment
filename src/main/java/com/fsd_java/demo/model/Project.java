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
@Table(name = "Project")
public class Project implements Serializable
{
    private static final long serialVersionUID = 1L;
    
    /*`projectId` int(11) NOT NULL AUTO_INCREMENT,
    `projectName` varchar(45) NOT NULL,
    `startDate` date DEFAULT NULL,
    `endDate` date DEFAULT NULL,
    `priority` int(11) NOT NULL,
    `manager` varchar(45) NOT NULL,
    `taskId` int(11) NOT NULL,*/
 
    @Id
    @Column(name="projectId")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer projectId;
    
   
    public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
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

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}


	@Column(name="projectName")
    private String projectName;

    @Column(name="startDate")
    private Date startDate;
    
    @Column(name="endDate")
    private Date endDate;
    
    @Column(name="priority")
    private int priority;
    
    @Column(name="manager")
    private String manager;
    
    @Column(name="taskId")
    private Integer taskId;
    
        
    public Project(Integer projectId, String projectName, Date startDate, Date endDate, Integer priority, 
    		    String manager, int taskId ) {
        super();
        this.projectId = projectId;
        this.projectName = projectName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.manager = manager;
        this.taskId = taskId;
 
    }
     
    public Project(){         
    }
 
    
    @Override
    public String toString() {
        return "User [projectId=" + projectId + ", projectName=" + projectName
                + ", startDate=" + startDate +", endDate=" + endDate
                + ", priority=" + priority +", manager=" + manager + ", taskId=" + taskId               
                +"]";
    }

	
}