package com.fsd_java.demo.controller;

import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import com.fsd_java.demo.model.Task;
import com.fsd_java.demo.service.TaskService;

@RunWith(SpringJUnit4ClassRunner.class)
@Configuration
@EnableAutoConfiguration
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-servlet.xml"})
@WebMvcTest
public class TaskRESTControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private TaskService TaskService;

    @Test
    public void findAll() throws Exception {
        // given
        Task Task = new Task();
      /*  Task.setId(1L);
        Task.setName("Task 1");
        Task.setPrice(new BigDecimal(1));*/

        List<Task> Tasks = Arrays.asList(Task);
        given(TaskService.getAllTasks()).willReturn(Tasks);

        // when + then
        this.mockMvc.perform(get("/getTasks"))
       
                .andExpect(status().isOk());
               // .andExpect(content()..json("[{'id': 1,'name': 'Task 1';'price': 1}]"));
        			
    }
}
