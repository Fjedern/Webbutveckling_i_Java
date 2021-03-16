<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page2</title>
</head>
<body>
	<jsp:include page="headerAndFooter.jsp" /> 
	<h2>Du är på page2</h2>
	
	<%
    	String pages = request.getParameter("page");
    	out.print("You are on " + pages + "<br>");
		String name = request.getParameter("fname");  
		out.print("welcome " + name + "<br>"); 
	%>
</body>
</html>