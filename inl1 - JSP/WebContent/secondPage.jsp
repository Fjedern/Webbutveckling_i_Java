<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Middlepage</title>
</head>
<body>
	<jsp:include page="headerAndFooter.jsp" />  
    <%
    	String pages = request.getParameter("page");
		if(pages.equals("page1")) {
	%>
	<jsp:forward page="page1.jsp" />
	<%
		}
		else if(pages.equals("page2")) {
	%>
	<jsp:forward page="page2.jsp" />
	<%
		}
		else {
			
	%>
	<jsp:forward page="index.jsp" />
	<%
		}
	%>
</body>
</html>