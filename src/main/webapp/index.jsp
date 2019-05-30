<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <meta ParentTaskName="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  <head>
<meta ParentTaskName="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial;}


/* Style the tab */
.tab {
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 14px 16px;
    transition: 0.3s;
    font-size: 17px;
	font-style:bold;
}

/* Change background color of buttons on hover */
.tab button:hover {
    background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
    background-color: #ccc;
}


/* Style the tab content */
.tabcontent {
    display: none;
    padding: 6px 12px;
    -webkit-animation: fadeEffect 1s;
    animation: fadeEffect 1s;
}

/* Fade in tabs */
@-webkit-keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}

@keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}

.slidecontainer {
    width: 90%;
}

.slider {
    -webkit-appearance: none;
    width: 50%;
    height: 25px;
    background: #d3d3d3;
    outline: none;
    opacity: 0.7;
    -webkit-transition: .2s;
    transition: opacity .2s;
}

.slider:hover {
    opacity: 1;
}

.slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 25px;
    height: 25px;
    background: #787878;
    cursor: pointer;
}

.slider::-moz-range-thumb {
    width: 25px;
    height: 25px;
    background: #787878;
    cursor: pointer;
}
.pagearea{
 height: 5000px;
    width: 90%;
    background-color: #aaaaaa;
}


.ebtn{
	width: 75px;
    height: 25px;
    background: #ffffff;
    cursor: pointer;
}

/* Create an active/current tablink class */
.ebtn[disabled] {
    cursor: not-allowed;
    background-color: rgba(255,255,255,.15);
}



table, th , td  {
  border: 1px solid grey;
  border-collapse: collapse;
  padding: 10px;
  background-color: #f0f0f0;
}
table tr:nth-child(odd) {
  width: 1000px;
  background-color: #f1f1f1;
}
table tr:nth-child(even) {
  width: 1000px;
  background-color: #ffffff;
}

html {
  overflow-y: scroll;
  overflow-x: scroll;
}


</style>
</head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.9/angular.min.js"></script>
<script type="text/javascript">
var app = angular.module("ViewApp", []);

// Controller Part
app.controller("TaskController", function($scope, $http) {
		console.log("Initializing");
		
		
    // Initialize page with default data which is blank in this example
    $scope.tasks = [];
    $scope.users = [];
    $scope.projects = [];
    $scope.activeTasks = [];
    
    $scope.projectTasks;
    
    
    
    // Initialize getUsers()
    
    getUsers();
    
    getTask();
    
    getActiveTask();
    
    getProjects();
    
    $scope.taskForm = {
        id : -1,
        taskName : "",
        priority : "",
        parentTask : "",
        status : ""
    };
    
    $scope.userForm = {
        userId : -1,
        firstname : "",
        lastname : "",
        empId : -1
    };
    
    $scope.projectForm = {
        projectId : -1,
        projectName : "",
        startDate : "",
        endDate : "",
        priority : "",
        manager: "",
        taskId: ""       
    };
    
    // AddUser
    $scope.addUser = function (event, taskName) {
    	$('#addUserBtn').show();
   		$('#updateUserBtn').hide(); 
        
   		var i, tabcontent, tablinks;
   		tabcontent = document.getElementsByClassName("tabcontent");
    		for (i = 0; i < tabcontent.length; i++) {
        		tabcontent[i].style.display = "none";
    		}
    		tablinks = document.getElementsByClassName("tablinks");
    		for (i = 0; i < tablinks.length; i++) {
        		tablinks[i].className = tablinks[i].className.replace(" active", "");
    		}
   		 document.getElementById(taskName).style.display = "block";
   		 // event.currentTarget.className += "active";
    }
    
    
    $scope.addUserData = function (event, taskName) {
	// HTTP POST/PUT methods for add/edit employee
	    // Call: http://localhost:8080/employee
	   	    var method = "";
	        var url = "";
	        
	        $scope.userForm.userId = -1;
	        $scope.userForm.firstname = $scope.firstname;
	        $scope.userForm.lastname = $scope.lastname;
	        $scope.userForm.empId = $scope.employeeId;	
	       
	      
	        if($('#firstname').val().trim() == "") {
	        alert("Enter First Name of the User");
	        } else if($('#lastname').val().trim() == "") {
	        alert("Enter Last Name of the User");
	        } else if($('#employeeId').val().trim() == "") {
	        alert("Enter EmployeeID of the User");
	        } else {
	        $http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/addUser',
	            data: angular.toJson($scope.userForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("User Added Successfully!");
           	getUsers();
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("addUser").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response);
           });
          }
	    };
	    
	    function getUsers() {	    
           $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/getUsers',
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
           	alert("Get Users Completed Successfully");
           	console.log(data);
           	var usersObj = data;
           	// console.log(tasksObj["data"]);
           	$scope.users = usersObj["data"];
            
           // var i, tabcontent, tablinks;
           // tabcontent = document.getElementsByClassName("tabcontent");
           // for (i = 0; i < tabcontent.length; i++) {
           // tabcontent[i].style.display = "none";
           // }
           // tablinks = document.getElementsByClassName("tablinks");
          // for (i = 0; i < tablinks.length; i++) {
          // tablinks[i].className = tablinks[i].className.replace(" active",
			// "");
          // }
          // document.getElementById('view').style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
           	alert("Get Task Completed with Error");
               console.log(response);
           });
       }
       
       function getTask() {
         $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/getTasks',
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
           	alert("Get Task Completed Successfully");
           	console.log(data);
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
        }, function errorCallback(response) {
           	alert("Get Task Completed with Error");
               console.log(response);
           });
       }
       
       function getActiveTask() {
           $http({
                 method : 'GET',
                 url : 'http://localhost:8010/Fsdspringrestexample/getActiveTasks',
                  headers: {
                     'Content-Type': 'application/json'
                 } 
             }).then(function successCallback(data) {
             	alert("Get Task Completed Successfully");
             	console.log(data);
             	var tasksObj = data;
             	console.log(tasksObj["data"]);
             	$scope.activeTasks = tasksObj["data"];
          }, function errorCallback(response) {
             	alert("Get Task Completed with Error");
                 console.log(response);
             });
         }
       
       function getProjects() {	    
           $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/getProjects',
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
           	alert("Get Projects Completed Successfully");
           	console.log(data);
           	var proObj = data;
            $scope.projects = proObj["data"];           
           
           }, function errorCallback(response) {
           	alert("Get Task Completed with Error");
               console.log(response);
           });
       }
       
       $scope.editUser = function (event, user){
       	   			
   			$('#addUserBtn').hide();
   			$('#updateUserBtn').show();  		
	        $('#firstname').val(user.firstname);
   			$('#lastname').val(user.lastname);
   			$('#employeeId').val(user.empId);
   			$scope.userForm.userId = user.userId;
       }
       
       $scope.updateUserData = function (evt, user) {
            alert($scope.userForm.userId);
	        $scope.userForm.firstname = $('#firstname').val();
	        $scope.userForm.lastname = $('#lastname').val();
	        $scope.userForm.empId = $('#employeeId').val();	
	        alert($scope.userForm);
	        
	        if($('#firstname').val().trim() == "") {
	        alert("Enter First Name of the User");
	        } else if($('#lastname').val().trim() == "") {
	        alert("Enter Last Name of the User");
	        } else if($('#employeeId').val().trim() == "") {
	        alert("Enter EmployeeID of the User");
	        } else {
	        $http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/updateUser',
	            data: angular.toJson($scope.userForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("User Updated Successfully!");
           	getUsers();
           	
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
           }
       }
       
	$scope.deleteUser = function (evt, userId) {
       // alert("Entered into End "+taskId);
           $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/deleteUser/'+userId,
               data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
             console.log(data);
           	 alert("User Deleted Successfully!");
             getUsers(); 
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
       }


   $scope.fnameSearch = function () {
            var emptyString  ="";
   			$scope.searchlname="";
   			$scope.searchempId="";
   		    
   }
   
   $scope.lnameSearch = function () {
    var emptyString  ="";
   			$scope.searchfname="";
   			$scope.searchempId="";
   
   }
   
    $scope.empidSearch = function () {
    var emptyString  ="";
   			$scope.searchfname="";
   			$scope.searchlname="";
  		 
   }
		
	   $scope.searchUser = function () {
         if($scope.searchfname.trim() != "") {
           $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/searchUserByFirstName/'+$scope.searchfname,
               data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
             console.log(data);
           	 alert("User Found Successfully!");
           	 var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.userForm = tasksObj["data"];
             $('#firstname').val($scope.userForm.firstname);
   			 $('#lastname').val($scope.userForm.lastname);
   			 $('#employeeId').val($scope.userForm.empId);
   			 // $scope.userForm.userId = data.userId;
   			 getUsers();
           }, function errorCallback(response) {
               alert("User Not Found, Enter valid First Name!");
               console.log(response.statusText);
           });
           } else if($scope.searchlname.trim() != ""){
            	$http({
              	 method : 'GET',
              	 url : 'http://localhost:8010/Fsdspringrestexample/searchUserByLastName/'+$scope.searchlname,
               	data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           	}).then(function successCallback(data) {
             console.log(data);
           	 alert("User Found Successfully!");
             
            var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.userForm = tasksObj["data"];
             $('#firstname').val($scope.userForm.firstname);
   			 $('#lastname').val($scope.userForm.lastname);
   			 $('#employeeId').val($scope.userForm.empId);  			
   			 getUsers(); 
          	 }, function errorCallback(response) {
          	 	alert("User Not Found, Enter valid Last Name!");
               console.log(response.statusText);
           	});
           	} else if($scope.searchempId.trim() != ""){
           	
           		$http({
              	 method : 'GET',
              	 url : 'http://localhost:8010/Fsdspringrestexample/searchUserByEmpID/'+$scope.searchempId,
               	data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           	}).then(function successCallback(data) {
             console.log(data);
           	 alert("User Found Successfully!");
            var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.userForm = tasksObj["data"];
             $('#firstname').val($scope.userForm.firstname);
   			 $('#lastname').val($scope.userForm.lastname);
   			 $('#employeeId').val($scope.userForm.empId);  			
   			 getUsers(); 
          	 }, function errorCallback(response) {
          	   alert("User Not Found, Enter valid Employee ID!");
               console.log(response.statusText);
           	});
           	}
       }
	   
      
   // });
       
	 
    $scope.addProjectBtn = function (){
    		var method = "";
	        var url = "";
	        
	        // selectTaks();
	        
	        $scope.projectForm.projectId = -1;
	        $scope.projectForm.projectName = $scope.pName;
	        $scope.projectForm.startDate = $scope.pstdate;
	        $scope.projectForm.endDate = $scope.penddate;
	        $scope.projectForm.priority = $scope.prProject;
	        $scope.projectForm.manager = $scope.searchManager;
	        $scope.projectForm.taskId = $scope.projectTasks;
	        
	            
	      
	        if($('#pName').val().trim() == "") {
	        alert("Enter Project Name");
	        } else if($('#searchManager').val().trim() == "") {
	        alert("Select Project Manager Name");
	        }// else if($('#employeeId').val().trim() == "") {
	       // alert("Select EmployeeID of the User");
	       // }
	         else {
	        $http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/addProject',
	            data: angular.toJson($scope.projectForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("Project Added Successfully!");
           	getActiveTask();
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           	$scope.projectTasks = "";
           
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("addProject").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response);
           });
          }
         }
    
    // AddProject
    $scope.addProject = function (event, taskName) {
   		var i, tabcontent, tablinks;
   		tabcontent = document.getElementsByClassName("tabcontent");
    		for (i = 0; i < tabcontent.length; i++) {
        		tabcontent[i].style.display = "none";
    		}
    		tablinks = document.getElementsByClassName("tablinks");
    		for (i = 0; i < tablinks.length; i++) {
        		tablinks[i].className = tablinks[i].className.replace(" active", "");
    		}
   		 document.getElementById(taskName).style.display = "block";
   		 
    }
    
    
    
    $scope.setProjectDate = function() {
      
      if($scope.setDate != "YES"){
       return true;
      } else{
       return false;
      }
    
    }
    
    $scope.selectTask = function(taskNo) {  
    	alert("taskNo"+taskNo);  
   		// var i,mapTasks;
   		$scope.projectTasks = taskNo;
    	// mapTasks = document.getElementsByName("mapTask");
    	
    	// for (i = 0; i < mapTasks.length; i++) {
    	// alert(mapTasks.length);
    	// console.log("$scope.mapTask[i]"+this.mapTask.value);
    	// var selectedTask = this.mapTask;
        // if(selectedTask != "-1"){
       	// $scope.projectTasks = this.mapTask;
       	// alert($scope.projectTasks);
       			
      	// }
   		// }
    }
    
    function createProjectTask(projectName,task){
    	
    	alert("projectName "+projectName);
    	alert("taskId "+task.id);
    	
    	var pro =  $('#proName').val();
    	alert(pro)
    	 
    	$http({
            method : 'GET',
            url : 'http://localhost:8010/Fsdspringrestexample/fetchProjectByProjectId/'+pro,
            data: angular.toJson(projectName),
             headers: {
                'Content-Type': 'application/json'
            } 
        }).then(function successCallback(data) {
          console.log(data);
        	 alert("Project Found Successfully!");
        	 var proObj = data;
        	console.log(proObj["data"]);
        	$scope.projectForm = proObj["data"];
        	$scope.projectForm.projectId = pro;
        	$scope.projectForm.taskId = task.id;
        	alert($scope.projectForm.projectName);
        	alert($scope.projectForm.startDate);
        	alert($scope.projectForm.endDate);
        	alert($scope.projectForm.priority);
        	alert($scope.projectForm.manager);
        	alert($scope.projectForm.taskId);
        	$http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/addProject',
	            data: angular.toJson($scope.projectForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("Project Added Successfully!");
           /* var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           	$scope.projectTasks = "";*/
           
           /* var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }*/
            document.getElementById("add").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response);
           });
        		
			 // getUsers();
        }, function errorCallback(response) {
            alert("Project Task not added!, check for error message.");
            console.log(response.statusText);
        });
    	
    }
    
    
    $scope.managerSearch = function(){
    	$http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/searchUserByFirstName/'+$scope.searchManager,
               data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
             console.log(data);
           	 alert("Manager Found Successfully!");
           	 var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.userForm = tasksObj["data"];
           	if($scope.userForm.firstname.trim()== ""){
           		alert("Manager Not Found, Enter valid Manager Name!");	
           	}
             $('#searchManager').val($scope.userForm.firstname);   			
   			 // getUsers();
           }, function errorCallback(response) {
               alert("Manager Not Found, Enter valid Manager Name!");
               console.log(response.statusText);
           });
    }

// Now load the data from server
 $scope.viewTask = function (event, taskName){
	 $scope.loadTaskData(event, taskName);
}

// Now add the data to server
 $scope.addTask = function (event, taskName){
 	$('#addbtn').show();
 	$('#updatebutton').hide();
	 $scope.addTaskData(event, taskName);
}

// Now load the data from server
 $scope.editTask = function (event, taskID){ 	
	 console.log("  "+taskID);	
	 $scope.editTaskData(event, taskID);
}

// Now add the data to server
 $scope.endTask = function (event, task){
 	 $scope.endTaskData(event, task);
}


 $scope.addTaskData = function (evt, taskName) {
	// HTTP POST/PUT methods for add/edit employee
	    // Call: http://localhost:8080/employee
	   	    var method = "";
	        var url = "";
	        
	              
	        $scope.taskForm.id = -1;
	        $scope.taskForm.taskName = $scope.ntask;
	        $scope.taskForm.priority = $scope.prRange;
	        $scope.taskForm.parentTask = $scope.ptask;	
	        $scope.taskForm.startDate =  $scope.stdate;
	        $scope.taskForm.endDate =  $scope.enddate; 
	        $scope.taskForm.status =  "Active"; 
	        if($('#stdate').val() > $('#enddate').val()) {
	        alert("Start Date should be less than End Date");
	        } else {
	        $http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/addTask',
	            data: angular.toJson($scope.taskForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("Task Added Successfully!");
           
           	//clearFormData();
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.task = tasksObj["data"];
            alert($scope.task.id);
        	createProjectTask($('#proName').val(),$scope.task);
           	
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("view").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
           }
	    };
	 
	    $scope.createTask = function() {
	        clearFormData();
	    }
	    
	 // Clear the form
	    function clearFormData() {
	        // alert("Clearing data");
	      
	        $scope.taskForm.id = -1;
	        $scope.taskForm.taskName = "";
	        $scope.taskForm.priority = "";
	        $scope.taskForm.parentTask = "";	
	        $scope.taskForm.startDate =  "";
	        $scope.taskForm.endDate =  "";
	        $scope.taskForm.status =  "";
	        $scope.ntask=""; 
	        $scope.prRange="";
	        $scope.ptask="";
	        $scope.stdate="";
	        $scope.enddate="";
	        $scope.loadTaskData(event, 'add');
	    };
	    
	  

      
 $scope.loadTaskData = function (evt, taskName) {
           $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/getTasks',
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
           	alert("Get Task Completed Successfully");
           	console.log(data);
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
            
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById('view').style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
           	alert("Get Task Completed with Error");
               console.log(response);
           });
       }


	$scope.editTaskData = function (event, task) {
   			// alert("Entered into Edit");
   			
   			$('#ntask').val(task.taskName);
   			
   			$('#addbtn').hide();
   			$('#updatebutton').show();
   			
   			var i, tabcontent, tablinks;
    		tabcontent = document.getElementsByClassName("tabcontent");
    		for (i = 0; i < tabcontent.length; i++) {
        	tabcontent[i].style.display = "none";
    		}
    		tablinks = document.getElementsByClassName("tablinks");
    		for (i = 0; i < tablinks.length; i++) {
        		tablinks[i].className = tablinks[i].className.replace(" active", "");
    		}
   			document.getElementById("add").style.display = "block";
    		
    		
    		$scope.taskForm.id = task.id;
	        $scope.taskForm.taskName = task.taskName;
	        $scope.taskForm.priority = task.priority;
	        $scope.taskForm.parentTask = task.parentTask;	
	        $scope.taskForm.startDate =  task.startDate;
	        $scope.taskForm.endDate =  task.endDate;
	         $scope.taskForm.status =  task.status; 
    		
           var method = "";
	       var url = "";
	        $('#ntask').val(task.taskName);
   			$('#ptask').val(task.parentTask);
   			$('#prRange').val(task.priority);
   			
   			var st_dd = new Date(task.startDate).getDate();
   			var st_mm = new Date(task.startDate).getMonth()+1;
   			var st_yy = new Date(task.startDate).getFullYear();
   			
   			var end_dd = new Date(task.endDate).getDate();
   			var end_mm = new Date(task.endDate).getMonth()+1;
   			var end_yy = new Date(task.endDate).getFullYear();
   			
   			$('#stdate').val(st_yy+'-'+formatMonDate(st_mm)+'-'+formatMonDate(st_dd))
   			$('#enddate').val(end_yy+'-'+formatMonDate(end_mm)+'-'+formatMonDate(end_dd));
       }
       
       function formatMonDate(monDate){
       
       var dateValue = monDate
       var retValue;
       if(dateValue < 10){       
       retValue = '0'+dateValue; 
       } else {
      	retValue = monDate;
       }
       return retValue;
       
       }

 $scope.update = function (evt, taskName) {
                       
	        // $scope.taskForm.id = $scope.task.id;
	$scope.taskForm.taskName = $('#ntask').val();
	        $scope.taskForm.priority = $('#prRange').val();
	        $scope.taskForm.parentTask = $('#ptask').val();	
	        $scope.taskForm.startDate =  $('#stdate').val();
	        $scope.taskForm.endDate =  $('#enddate').val();
	        
	        if($('#stdate').val() > $('#enddate').val()) {
	        alert("Start Date should be less than End Date");
	        } else {
	        $http({
	            method: "POST",
	            url: 'http://localhost:8010/Fsdspringrestexample/updateTask',
	            data: angular.toJson($scope.taskForm),
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        }).then(function successCallback(data) {
           	console.log(data);
           	alert("Task Updated Successfully!");
           	clearFormData();
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("view").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
           }
       }

   
   $scope.endTaskData = function (evt, task) {
      
        $scope.taskForm.id = task.id;
        $scope.taskForm.taskName = task.taskName;
        $scope.taskForm.priority = task.priority;
        $scope.taskForm.parentTask = task.parentTask;	
        $scope.taskForm.startDate =  task.startDate;
        $scope.taskForm.endDate =  task.endDate;        
        $scope.taskForm.status =  "DeActive";
         
           $http({
               method : 'POST',
               url: 'http://localhost:8010/Fsdspringrestexample/updateTask',
	           data: angular.toJson($scope.taskForm),
              // url :
				// 'http://localhost:8010/Fsdspringrestexample/deleteTask/'+taskId,
              // data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
            clearFormData();
            
           	console.log(data);
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("view").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
       }

      
  
   
  $scope.deleteTask = function (event, taskId){
 	 $http({
               method : 'GET',
               url : 'http://localhost:8010/Fsdspringrestexample/deleteTask/'+taskId,
               data: angular.toJson($scope.task),
                headers: {
                   'Content-Type': 'application/json'
               } 
           }).then(function successCallback(data) {
             clearFormData();
            
           	console.log(data);
           	var tasksObj = data;
           	console.log(tasksObj["data"]);
           	$scope.tasks = tasksObj["data"];
           
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById("view").style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
    }
  
});
   
function openTask(evt, taskName) {
     $('#ntask').val("");
   	 $('#ptask').val("");
   	 $('#prRange').val("");
   	 $('#stdate').val("");
   	 $('#enddate').val("");
	$('#addbtn').show();
   	$('#updatebutton').hide();
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(taskName).style.display = "block";
    evt.currentTarget.className += "active";
    
  


// var p = document.getElementById("prRange"),
// res = document.getElementById("result");

// p.addEventListener("input", function() {
// res.innerHTML = p.value;
// }, false);


}


</script>
<body ng-app="ViewApp" ng-controller="TaskController" ng-init="init()" style="height:4000px;">

<div class="pagearea">
<h3>Task Manager</h3>
<form ng-submit="submitTask()">
<div class="tab">
  <button class="tablinks" ng-click="addProject(event, 'addProject')">Add Project</button>
  <button class="tablinks" onclick="openTask(event, 'add')">Add Task</button>
  <button class="tablinks" ng-click="addUser(event, 'addUser')">Add User</button>
  <button class="tablinks" ng-click="viewTask(event, 'view')">View Task</button>
 
</div>

<div id="addProject" class="tabcontent">

    <br>
 	<div class="row">
		<div class="col-xs-2">
			<label>Project<label>
		</div>
		<div class="col-xs-4">
			<input id ="pName" name="pName" type="text" ng-model="pName">
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1">
			<input type="checkbox" ng-model="setDate" id ="setDate" name="setDate"
           			ng-true-value="'YES'" ng-false-value="'NO'" ng-change="setProjectDate()">
        </div>
        <div class="col-xs-4">
            <label>Set Start and Date End Date</label>
  		</div>
  	</div>
  	<div class="row">
		<div class="col-xs-2">
			<label>Start Date<label> 
		</div>
		<div class="col-xs-2 col-sm-4 col-md-4">
			<input type="date" name="pstdate" id="pstdate" ng-model="pstdate" ng-disabled="setProjectDate()"/>
		</div>
		<div class="col-xs-2">
			<label>End Date<label> 
		</div>
		<div class="col-xs-2 col-sm-4 col-md-4">
			<input type="date" name="penddate" id="penddate" ng-model="penddate" ng-disabled="setProjectDate()"/>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-2">
			<label>Priority<label> 
		</div>
		<div class="col-xs-3 col-sm-4 col-md-4">			
			<div class="slidecontainer">	
			    <label for="min" class="pull-left">1</label>
			    <label for="max" class="pull-right">30</label>
				<input type="range" min="1" max="30" step="1" value="15" class="slider" ng-model="prProject" id="prProject" name="prProject"/>
			</div>
						
		</div>	
				
	</div>
	<br>
	<div class="row">
		<div class="col-xs-2">
			<label>Manager<label> 
		</div>
		<div class="col-xs-3 col-sm-4 col-md-4">			
			<td><input type="text" name="searchManager" id="searchManager" ng-model="searchManager"/></td>
		</div>	
		<div class="col-xs-2">
			<button type="button" id="managerSrc" name="managerSrc" class="btn" ng-click="managerSearch()">Search</button>
		</div>					
	</div>
	<br>
	<br>
	<br>
	<div class="row">
	<div  class="table_space">
		   <table cellspacing="100" cellpadding="10" class="calc">		
            <tr >
                <th></th>
                <th>TaskID</th>
                <th>TaskName</th>
                <th>Priority</th>
				<th>ParentTaskName</th>
				<th>Start Date</th>
				<th>End Date</th>
				<!--<th>Edit</th>
				<th>End</th>  
				<th>Delete</th> -->     
            </tr>
			<span>
            <tbody ng-repeat="task in activeTasks">
                   
                <tr>
                    <td><input type="checkbox" ng-model="mapTask" id ="mapTask" name="mapTask" ng-change="selectTask(task.id)"  
                             			ng-true-value={{task.id}} ng-false-value="-1"</td>
                    <td>{{task.id}}</td>
                    <td>{{task.taskName}}</td>
                    <td>{{task.priority}}</td> 
					<td>{{task.parentTask}}</td>
					<td>{{task.startDate | date:'dd-MM-yyyy HH:mm:ss'}}</td>
					<td>{{task.endDate | date:'dd-MM-yyyy HH:mm:ss'}}</td>
					<!--<td><button type="button" class="ebtn" id="editbtn" name="editbtn" ng_click="editTask(event,task)">Edit Task</button></td>-->
					<!--<td> <button type="button" class="ebtn" id="deletebtn" name="deletebtn" ng-click="deleteTask(event,task.id)">Delete</button></td> -->
					
					
                	<!--<td><a href="http://localhost:8010/Fsdspringrestexample/editTask/{{task.id}}" ng-click="editTask(event, {{task}})"/>Edit</a></td>-->
   					<!--<td><a href="http://localhost:8010/Fsdspringrestexample/deleteTask/{{task.id}}"  ng-click="deleteTask()"/>Delete</a></td>-->
   					
   					
                </tr>				
            </tbody>
			</span>			
        </table>
		</div>
	</div>
	<br>
	<br>	
	<div class="row">
		<div class="col-xs-2">
			<button type="button" id="addProjectBtn" name="addProjecBtn" class="btn" ng-click="addProjectBtn(event, 'addProject')">Add Project</button>
		</div>
		<div class="col-xs-2">
			<button type="button" id="updProjecBtn" name="updProjecBtn" class="btn" ng-click="updProjecBtn(event, 'updateProject')">Update Project</button>
		</div>
	</div>		
  
</div>

<div id="addUser" class="tabcontent">
	<div class="row">
		<div class="col-xs-2">
			<label>First Name<label>
		</div>
		<div class="col-xs-4">
			<input id ="firstname" name="firstname" type="text" ng-model="firstname">
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-2">
			<label>Last Name<label>
		</div>
		<div class="col-xs-4">
			<input id ="lastname" name="lastname" type="text" ng-model="lastname">
		</div>
	</div>		
	<br>
	<div class="row">
		<div class="col-xs-2">
			<label>Employee ID<label> 
		</div>
		<div class="col-xs-2 col-sm-4 col-md-4">
			<input type="text" name="employeeId" id="employeeId" ng-model="employeeId"/>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-2">
			<button type="button" id="addUserBtn" name="addUserBtn" class="btn" ng-click="addUserData(event, 'addUser')">Add User</button>
		</div>
		<div class="col-xs-2">
			<button type="button" id="updateUserBtn" name="updateUserBtn" class="btn" ng-click="updateUserData(event, 'updateUser')">Update User</button>
		</div>
	</div>	
	<br>
	<br>
	
	<div  class="table_space">
		   <table cellspacing="100" cellpadding="10" class="calc">		
            <tr >
                <th>First Name</th>
                <th>Last Name</th>
                <th>Employee ID</th>
                <th>Edit User</th>
                <th>Delete USer</th>
				     
            </tr>
            <tr>
            		<td><input type="text" name="searchfname" id="searchfname" ng-model="searchfname" ng-change="fnameSearch()"/></td>
                    <td><input type="text" name="searchlname" id="searchlname" ng-model="searchlname" ng-change="lnameSearch()"/></td>
                    <td><input type="text" name="searchempId" id="searchempId" ng-model="searchempId" ng-change="empidSearch()"/></td> 
             <td></td>
             <td><button type="button" class="ebtn" id="searchUserBtn" name="searchUserBtn" ng-click="searchUser(event)">Search User</button></td>
            </tr>
			<span>
            <tbody ng-repeat="user in users">
                   
                <tr>
                    <td>{{user.firstname}}</td>
                    <td>{{user.lastname}}</td>
                    <td>{{user.empId}}</td> 
                    <td><button type="button" class="ebtn" id="editUserBtn" name="editUserBtn" ng_click="editUser(event,user)">Edit User</button></td>
					<td><button type="button" class="ebtn" id="deleteUserBtn" name="deleteUserBtn" ng-click="deleteUser(event,user.userId)">Delete User</button></td>
										
                </tr>				
            </tbody>
			</span>			
        </table>
	</div>
	
	
</div>



<div id="view" class="tabcontent">
		   <div  class="table_space">
		   <table cellspacing="100" cellpadding="10" class="calc">		
            <tr >
                <th>TaskID</th>
                <th>TaskName</th>
                <th>Priority</th>
				<th>ParentTaskName</th>
				<th>Start Date</th>
				<th>End Date</th>
				<th>Edit</th>
				<th>End</th> 
				<th>Delete</th>  
            </tr>
			<span>
            <tbody ng-repeat="task in tasks">
                   
                <tr>
                    <td>{{task.id}}</td>
                    <td>{{task.taskName}}</td>
                    <td>{{task.priority}}</td> 
					<td>{{task.parentTask}}</td>
					<td>{{task.startDate | date:'dd-MM-yyyy HH:mm:ss'}}</td>
					<td>{{task.endDate | date:'dd-MM-yyyy HH:mm:ss'}}</td>
				    <td><button type="button" class="ebtn" ng-disabled=({{task.status}}===DeActive) id="editbtn" name="editbtn" ng-click="editTask(event,task)">Edit Task</button></td>
				    <td> <button type="button" class="ebtn" ng-disabled=({{task.status}}===DeActive) id="endbtn" name="endbtn" ng-click="endTask(event,task)">End</button></td>
				    <td> <button type="button" class="ebtn" ng-disabled=({{task.status}}===DeActive) id="deletebtn" name="deletebtn" ng-click="deleteTask(event,task.id)">Delete</button></td>
					
					<!--->
                	<!--<td><a href="http://localhost:8010/Fsdspringrestexample/editTask/{{task.id}}" ng-click="editTask(event, {{task}})"/>Edit</a></td>-->
   					<!--<td><a href="http://localhost:8010/Fsdspringrestexample/deleteTask/{{task.id}}"  ng-click="endTask()"/>Delete</a></td>-->
   					
   					
                </tr>				
            </tbody>
			</span>			
        </table>
		</div>
   
</div>

<div id="add" class="tabcontent">
 
  <br>
		    <div class="row">
				<div class="col-xs-2">
					<label>Project<label>
				</div>
						
				<div class="col-xs-4">
				<select id="proName" name="proName" ng-model="proName">
				   <option ng-repeat="project in projects" projectName="{{project.projectName}}" ng-selected="{{project.projectId == filterCondition.project}}" value="{{project.projectId}}">{{project.projectName}}</option>
				</select>
				</div>
			</div>
			<br>
 
		<div class="row">
			<div class="col-xs-2">
				<label>Task<label>
			</div>
			<div class="col-xs-4">
				<input id ="ntask" name="ntask" type="text" ng-model="ntask">
			</div>
			<div class="col-xs-2">
				<label>Parent Task<label> 
			</div>
			<div class="col-xs-4">
				<input id ="ptask" name="ptask" type="text" ng-model="ptask">
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-2">
				<label>Priority<label> 
		</div>
			
			<div class="col-xs-3 col-sm-4 col-md-4">			
			    <label for="min" class="pull-left">1</label>
			    <label for="max" class="pull-right">30</label>
				<div class="slidecontainer">	
					<input type="range" min="1" max="30" step="1" value="15" class="slider" ng-model="prRange" id="prRange" name="prRange"/>
				</div>
							
			</div>	
		</div>
		<br>
		<div class="row">
			<div class="col-xs-2">
				<label>Start Date<label> 
			</div>
			<div class="col-xs-2 col-sm-4 col-md-4">
				<input type="date" name="stdate" id="stdate" ng-model="stdate"/>
			</div>
			<div class="col-xs-2">
				<label>End Date<label> 
			</div>
			<div class="col-xs-2 col-sm-4 col-md-4">
				<input type="date" name="enddate" id="enddate" ng-model="enddate"/>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-2">
			</div>
			<div class="col-xs-2">
				<button type="button" id="addbtn" name="addbtn" class="btn" ng-click="addTask(event, 'add')">Add Task</button>
			</div>
			<div class="col-xs-2">
				<button type="button" id="updatebutton" name="updatebutton" class="btn" ng-click="update(event, 'update')">Update Task</button>
			</div>
		</div>		

	
</div>


 </form>  
</body>
</html> 


