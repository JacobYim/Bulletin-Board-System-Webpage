<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
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
	
	// setup for the variables
	int bbsID = 0;
	if (request.getParameter("bbsID") != null){						// if there is the parameter which named as "bbsID",
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('invalid post')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
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
				<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan = "3" style = "background-color : #eeeeee; text-align : center;"> View Board Contents </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style = "width : 20%;"> Title</td>							
							<td colspan = "2"> <%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td> Writer </td>							
							<td colspan = "2"> <%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td> Date </td>							
							<td colspan = "2"> <%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+":"+bbs.getBbsDate().substring(14,16) %></td>
						</tr>
						<tr>
							<td> Content </td>							
							<td colspan = "2" style="min-height :200px; text-align: left"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href = "bbs.jsp" class="btn btn-primary"> List </a>
				<% 
					if (userID != null && userID.equals(bbs.getUserID())){
				%>
					<a href = "update.jsp?bbsID=<%= bbsID%>" class = "btn btn-primary"> Modify</a>
					<a href = "deleteAction.jsp?bbsID=<%= bbsID%>" class = "btn btn-primary"> Delete</a>
				<%		
					}
				%>
		</div>
	</div>
		
<!-- reference for animation functions -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
	
<!-- reference the bootstrap.js on js folder which provided BOOTHSTRAP webpage -->
	<script src = "js/bootstrap.js"></script>	
	
</body>
</html>