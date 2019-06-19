package com.fsd.demo.model;
 
import java.util.ArrayList;
import java.util.List;
 
import javax.xml.bind.annotation.XmlRootElement;
 
@XmlRootElement (name="Tasks")
public class TaskListVO
{
    private List<Task> Tasks = new ArrayList<Task>();
 
    public List<Task> getTasks() {
        return Tasks;
    }
 
    public void setTasks(List<Task> Tasks) {
        this.Tasks = Tasks;
    }
}