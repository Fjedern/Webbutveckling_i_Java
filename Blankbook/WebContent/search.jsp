
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<jsp:useBean id="con" class="database.PostConnectionSQL" />
<!DOCTYPE html>
<html class="theme-light">
<head>
<meta charset="ISO-8859-1">
<title>Search</title>

<!-- Bootstrap core CSS -->
	<script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<!-- <link href="css/signin.css" rel="stylesheet"> -->
	<link href="css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-none">
		<div class="container-fluid" id="text">
			<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="Login">Back</a>
					</li>
				</ul>
				<form class="d-flex" action="<%=request.getContextPath()%>/Logout" method="post">
					<button class="btn btn-outline-success" type="submit">Logout</button>
				</form>
			</div>
		</div>
	</nav>
<%
try {  
    	con.searchPosts(request.getParameter("search"));  
    	ResultSet temp = con.getResult();  
    	int countPosts = 0; 

    	while (temp.next()){
    		countPosts++;
    		System.out.println(countPosts);
    		con.seeTags(countPosts);
    		ResultSet TagsOnPost = con.getResult();
    	  
    %>
	<div class="container" id="text">
		<div class="row">
			<!-- welcome text was here -->
			<h1><%out.print(temp.getString("title"));%></h1>
		</div>
		<div class="row">
			<p><%out.print(temp.getString("content"));%></p>
		</div>
		<div class="row">
			<p>Author: <%out.print(temp.getString("author"));%></p>
		</div>
		<div class=" d-flex bd-highlight">
			<%
				while(TagsOnPost.next()){
					out.print("<div class='p-2 bd-highlight' id='tag'> #" + TagsOnPost.getString("TagName") + "</div>");
				}
				//System.out.print(TagsOnPost.getString("TagName"));
				TagsOnPost.close();
			%>
		</div>
		<div class="row">
			<form class="d-flex" action="<%=request.getContextPath()%>/addTag" method="post">
				<input type="text" name="tagName" />
				<input type="hidden" value="<%=temp.getString("postid") %>" name="postid" />
				<button class="btn btn-outline-success" type="submit">Add Tag</button>
			</form>

			<!--<button style="max-width: 20%;">add tag</button>-->
		</div>
	</div>
	<input id="hiddenName" type="hidden" name="hiddenName" value="<%=request.getParameter("userName") %>" />
	
	<% 
		}  
    } catch (Exception e) {  
      e.printStackTrace();  
   	}  
	%>
	<script>
	var user = document.getElementById("hiddenName").value;
	
	(function () {
		if (getCookie(user) === "theme-dark") {
			document.documentElement.className = "theme-dark";
		} else {
			document.documentElement.className = "theme-light";
		}
	})();
	
	function getCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(";");
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == " ") c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
		}
		return null;
	}
	</script>
</body>
</html>