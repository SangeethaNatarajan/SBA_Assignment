package com.fsd_java.demo.repository;

import org.springframework.data.repository.CrudRepository;
import com.fsd_java.demo.model.Task;

public interface TaskRepository extends CrudRepository<Task, Integer> {

}