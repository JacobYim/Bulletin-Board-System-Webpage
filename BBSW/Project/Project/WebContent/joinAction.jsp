 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- import more file to use in this js file. --> 

<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- add the jsp execution codes -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name = "user" property = "userID"/>
<jsp:setProperty name = "user" property = "userPassword"/>
<jsp:setProperty name = "user" property = "userName"/>
<jsp:setProperty name = "user" property = "userGender"/>
<jsp:setProperty name = "user" property = "userEmail"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Notice Board Webpage</title>
</head>
<body>
	<% 
		// when any block remains as blank, shows the alert.
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You have missed blanks')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('the ID is already used.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>>
</body>
</html>