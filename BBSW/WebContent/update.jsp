<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
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
	if (userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Do login')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	
	// id and session valiation check
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
	if (!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('No Athorization')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
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

		</div>
	</nav>
	
	<!-- board table starts -->
	
	<div class = "container">
		<div class = "row">
			<form method = "post" action = "updateAction.jsp?bbsID=<%=bbsID %>">
				<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan = "2" style = "background-color : #eeeeee; text-align : center;"> Board Edit Format </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td> <input type = "text" class = "form-control" placeholder = "Title" name = "bbsTitle" maxlength = "50" value = "<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>
							<td> <textarea class = "form-control" placeholder = "Content" name = "bbsContent" maxlength = "2048" style = "height: 350px;"> <%= bbs.getBbsContent() %> </textarea></td>
						</tr>
					</tbody>
				</table>
				<input type = "submit" class = "btn btn-primary pull-right" value ="Edit">
			</form>
		</div>
	</div>
		
<!-- reference for animation functions -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
	
<!-- reference the bootstrap.js on js folder which provided BOOTHSTRAP webpage -->
	<script src = "js/bootstrap.js"></script>	
	
</body>
</html>