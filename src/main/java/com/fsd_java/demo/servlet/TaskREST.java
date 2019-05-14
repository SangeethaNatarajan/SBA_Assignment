/*package com.fsd_java.demo.servlet;
 
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.fsd_java.demo.model.TaskListVO;
import com.fsd_java.demo.model.TaskVO;

@WebServlet(name = "TaskREST", urlPatterns = { "/TaskREST" })
 

public class TaskREST 
{
    
  
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@SuppressWarnings("rawtypes")
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		List<TaskVO> AllPolicyPrefixControlList = new ArrayList<TaskVO>();
		
			
		
		req.setAttribute("PolicyPrefixControlList", AllPolicyPrefixControlList);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher((String) menuFilter.get("url"));
		rd.forward(req, resp);
		
	}
}*/