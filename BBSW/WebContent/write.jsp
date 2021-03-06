<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content ="width = device-width", initial-scale = "1">
<link rel = "stylesheet" href ="css/bootstrap.css">

<title>JSP Notice Board Webpage</title>
</head>

<body>
<%
	// make the logged in people available for managing their own session
	String userID = null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
%>

<!-- add navigation, which makes see the structure of webpage  -->
	
	<nav class="navbar navbar-default">	
		<div class = "navbar-header">
			<button type="button" class="navbar-toggle collapsed" 
					data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
					aria-expended = "false">
				<span class = "icon-bar"> </span>
				<span class = "icon-bar"> </span>			
				<span class = "icon-bar"> </span>
			</button>

<!-- Add Title of the webpage on the page  -->

			<a class = "navbar-brand" href="main.jsp"> JSP Notice Board Webpage</a>
		</div>
		
		<div class = "collapse navbar-collapse" id ="bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li class = "active"><a href = "main.jsp">Main</a></li>
				<li><a href = "bbs.jsp">Notice Board</a></li>
			</ul>
			
<!-- make the connect option is available for only people does not have session -->
			<% 
				if (userID == null){
			%>
			
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
				
<!-- login and register parts -->
				
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdown" role = "botton" aria-haspopup="true"
						aria-expanded="false"> Connect <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = login.jsp>Login</a></li>
						<li><a href = "join.jsp">Join</a></li>
					</ul>
				</li>
			</ul>
				
			<%		
				}else{
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
				
<!-- login and register parts -->
				
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdown" role = "botton" aria-haspopup="true"
						aria-expanded="false"> Account Management <span class = "caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href = logoutAction.jsp>Logout</a></li>
					</ul>
				</li>
			</ul>	
			<%
				}
			%>

		</div>
	</nav>
	
	<!-- board table starts -->
	
	<div class = "container">
		<div class = "row">
			<form method = "post" action = "writeAction.jsp">
				<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan = "2" style = "background-color : #eeeeee; text-align : center;"> Board Write Format </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td> <input type = "text" class = "form-control" placeholder = "Title" name = "bbsTitle" maxlength = "50"></td>
						</tr>
						<tr>
							<td> <textarea class = "form-control" placeholder = "Content" name = "bbsContent" maxlength = "2048" style = "height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type = "submit" class = "btn btn-primary pull-right" value ="Write">
			</form>
		</div>
	</div>
		
<!-- reference for animation functions -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
	
<!-- reference the bootstrap.js on js folder which provided BOOTHSTRAP webpage -->
	<script src = "js/bootstrap.js"></script>	
	
</body>
</html>