<%@page import="beans.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="con" class="database.PostConnectionSQL" />
<!DOCTYPE html>

<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
</head>
<body>
    <%
        con.setTitle(request.getParameter("title"));
        con.setContent(request.getParameter("content"));			
        System.out.println(con.getTitle() + con.getContent());
        con.setAuthor("test");

        con.createSimplePost();

        con.setTag(request.getParameter("tagName"), con.getPostId(con.getTitle()));

        response.sendRedirect("Login");
    %>
</body>

</html>