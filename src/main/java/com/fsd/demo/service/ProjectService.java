package com.fsd.demo.service;
 
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
 
 
import com.fsd.demo.model.Project;
import com.fsd.demo.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



 
@Service("ProjectService")
public class ProjectService
{
    private List<Project> Projects = new ArrayList<Project>();
 
    /*public List<Project> getProjects() {
        return Projects;
    }
 
    public void setProjects(List<Project> Projects) {
        this.Projects = Projects;
    }*/
    
    @Autowired
    ProjectRepository ProjectRepository;
    
    @Transactional
    public List getAllProjects() {
     List<Project> Projects=new ArrayList();
     Iterable ProjectIterable=ProjectRepository.findAll();
     Iterator ProjectIterator=ProjectIterable.iterator();
     while(ProjectIterator.hasNext())
     {
    	 Projects.add((Project) ProjectIterator.next());
     }
     return Projects;
    }
    
/*    @Transactional
    public Project getProject(int projectId) {
     return ProjectRepository.findOne(projectId);
    }*/
    
    @Query
    public Project fetchProjectByProjectName(String projectName){
    	return ProjectRepository.fetchProjectByProjectName(projectName);
    }
    
    @Query
    public Project fetchProjctByTaskId(int taskId){
    	return ProjectRepository.fetchProjctByTaskId(taskId);
    }
    
    @Query
    public Project fetchProjectByProjectId(int projectId){
    	return ProjectRepository.fetchProjectByProjectId(projectId);
    }
    
    @Query
    public Project fetchProjectByEmpID(String EmpID){
    	return ProjectRepository.fetchProjectByEmpID(EmpID);
    }
    
    
    @Transactional
    public Project addProject(Project Project) {
    	return ProjectRepository.save(Project);
    }
    
    @Transactional
    public void updateProject(Project Project) {
    	ProjectRepository.save(Project);
    
    }
    
    @Transactional
    public void deleteProject(int id) {
    	Project pro = ProjectRepository.getOne(id);
    	ProjectRepository.delete(pro);
    }
}