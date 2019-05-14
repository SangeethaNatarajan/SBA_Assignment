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
    width: 80%;
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
 height: 500px;
    width: 75%;
    background-color: #aaaaaa;
}


.ebtn{
	width: 75px;
    height: 25px;
    background: #ffffff;
    cursor: pointer;
}
table, th , td  {
  border: 0px solid grey;
  border-collapse: collapse;
  padding: 10px;
}
table tr:nth-child(odd) {
  width: 1000px;
  background-color: #f1f1f1;
}
table tr:nth-child(even) {
  width: 1000px;
  background-color: #ffffff;
}


</style>
</head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.9/angular.min.js"></script>
<script type="text/javascript">
var app = angular.module("ViewApp", []);

//Controller Part
app.controller("TaskController", function($scope, $http) {
		console.log("Initializing");
    //Initialize page with default data which is blank in this example
    $scope.tasks = [];
    $scope.taskForm = {
        id : -1,
        taskName : "",
        priority : "",
        parentTask : ""
    };
    

//Now load the data from server
 $scope.viewTask = function (event, taskName){
	 $scope.loadTaskData(event, taskName);
}

//Now add the data to server
 $scope.addTask = function (event, taskName){
	 $scope.addTaskData(event, taskName);
}

//Now load the data from server
 $scope.editTask = function (event, taskID){ 	
	 console.log("  "+taskID);	
	 $scope.editTaskData(event, taskID);
}

//Now add the data to server
 $scope.endTask = function (event, taskId){
 	 $scope.endTaskData(event, taskId);
}

 $scope.addTaskData = function (evt, taskName) {
	// HTTP POST/PUT methods for add/edit employee  
	    // Call: http://localhost:8080/employee
	   	    var method = "";
	        var url = "";
	        
	        //alert(" task Name"+$scope.ntask);
	        $scope.taskForm.id = -1;
	        $scope.taskForm.taskName = $scope.ntask;
	        $scope.taskForm.priority = $scope.prRange;
	        $scope.taskForm.parentTask = $scope.ptask;	
	        $scope.taskForm.startDate =  $scope.stdate;
	        $scope.taskForm.endDate =  $scope.enddate; 
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
	    };
	 
	    $scope.createTask = function() {
	        clearFormData();
	    }
	    
	 // Clear the form
	    function clearFormData() {
	        alert("Clearing data");
	      //  alert("  *****  "+$scope.taskForm.taskName);
	        $scope.taskForm.id = -1;
	        $scope.taskForm.taskName = "";
	        $scope.taskForm.priority = "";
	        $scope.taskForm.parentTask = "";	
	        $scope.taskForm.stdate =  "";
	        $scope.taskForm.enddate =  "";
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
   			//alert("Entered into Edit");
   			alert("task startDate"+task.startDate);
   			alert("task endDate "+task.endDate);
   			
   			
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
	        $scope.taskForm.stdate =  task.startDate;
	        $scope.taskForm.enddate =  task.endDate; 
    		
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
       //alert(monDate);
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
            alert(" Task id for updating "+$scope.taskForm.id);
            
            alert(" Task stdate for updating "+$('#stdate').val());
             alert(" Task enddate for updating "+$('#enddate').val());
            
	        //$scope.taskForm.id = $scope.task.id;
	        $scope.taskForm.taskName = $('#ntask').val();
	        $scope.taskForm.priority = $('#prRange').val();
	        $scope.taskForm.parentTask = $('#ptask').val();	
	        $scope.taskForm.stdate =  $('#stdate').val();
	        $scope.taskForm.enddate =  $('#enddate').val();
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

   
   $scope.endTaskData = function (evt, taskId) {
       alert("Entered into End   "+taskId);
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
            document.getElementById(taskName).style.display = "block";
           // evt.currentTarget.className += " active";
           }, function errorCallback(response) {
               console.log(response.statusText);
           });
       }

      
   });
   
   
   

      

   


   
function openTask(evt, taskName) {
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
}

var p = document.getElementById("prRange"),
res = document.getElementById("result");

p.addEventListener("input", function() {
res.innerHTML =  p.value;
}, false); 





</script>
<body ng-app="ViewApp" ng-controller="TaskController" ng-init="init()">

<div class="pagearea">
<h3>Task Manager</h3>
<form ng-submit="submitTask()">
<div class="tab">
  <button class="tablinks" onclick="openTask(event, 'add')">Add Task</button>
  <button class="tablinks" ng-click="viewTask(event, 'view')">View Task</button>
 
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
				    <td><button type="button" class="ebtn" id="editbtn" name="editbtn" ng_click="editTask(event,task)">Edit Task</button></td>
					 <!--<td><button type="button" class="ebtn" id="endbtn" name="endbtn" ng_click="endTask(event, 'end',{task})">End Task</button></td>-->  
                	<!--<td><a href="http://localhost:8010/Fsdspringrestexample/editTask/{{task.id}}" ng-click="editTask(event, {{task}})"/>Edit</a></td>-->
   					<!--<td><a href="http://localhost:8010/Fsdspringrestexample/deleteTask/{{task.id}}"  ng-click="endTask()"/>Delete</a></td>-->
   					<td> <button type="button" class="ebtn" id="endbtn" name="endbtn" ng-click="endTask(event,task.id)">Delete</button></td>
                </tr>				
            </tbody>
			</span>			
        </table>
		</div>
   
</div>

<div id="add" class="tabcontent">
 
  <br>
  <div ng-app="fse">
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
				<div class="slidecontainer">				
					<input type="range" min="1" max="30" step="1" value="15" class="slider" ng-model="prRange" id="prRange" name="prRange"/>
				</div>	
				<p id="result"></p>
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
	
</div>
 </form>  
</body>
</html> 


