<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content ="width = device-width", initial-scale = "1">
<link rel = "stylesheet" href ="css/bootstrap.css">

<title>JSP Notice Board Webpage</title>

<!-- hyperlink text change to black (normal style) -->
<style type = "text/css">
	a, a:hover{
		color : #000000;
		text-decoration: none;
	}
</style>

</head>

<body>
<%
	// make the logged in people available for managing their own session
	String userID = null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
				<thead>
					<tr>
						<th style = "background-color : #eeeeee; text-align : center;"> Number </th>
						<th style = "background-color : #eeeeee; text-align : center;"> Title </th>
						<th style = "background-color : #eeeeee; text-align : center;"> Author </th>
						<th style = "background-color : #eeeeee; text-align : center;"> Date </th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for (int i = 0 ; i < list.size(); i++){
							
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href = "view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11)+" "+list.get(i).getBbsDate().substring(11,13)+" : "+ list.get(i).getBbsDate().substring(14,16)%></td>
					</tr>
					<% 
						}
					%>
				</tbody>
			</table>
			
			<!-- when number of post is over 10, make next button to see the next 10 posts -->
			<%
				if (pageNumber != 1){
			%> 
				<a href = "bbs.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arrow-Left">Previous</a>
			<%
				}if (bbsDAO.nextPage(pageNumber + 1)){
			%> 
				<a href = "bbs.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arrow-Left">Next</a>
			<%
				}
			%>
			<a href = "write.jsp" class = "btn btn-primary pull-right"> Write </a>
		</div>
	</div>
		
<!-- reference for animation functions -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
	
<!-- reference the bootstrap.js on js folder which provided BOOTHSTRAP webpage -->
	<script src = "js/bootstrap.js"></script>	
	
</body>
</html>