<%@page import="beans.UserBean"%>
<%@page import="beans.postBean"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<jsp:useBean id="con" class="database.PostConnectionSQL" />
<!DOCTYPE html>

<html class="theme-light">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">

	<title>BlankBook</title>

	<!-- Bootstrap core CSS -->
	<script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


	<!-- <link href="css/signin.css" rel="stylesheet"> -->
	<link href="css/style.css" rel="stylesheet">

</head>

<body>

	<%
	UserBean bean = (UserBean) request.getAttribute("user");
	%>
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
						<a class="nav-link active" aria-current="page" href="#">Home</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="createPost.jsp">Add post</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">
							Theme
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown" id="dropdown">
							<li><a class="dropdown-item" onclick="setThemeDark()" href="#">Dark</a></li>
							<li><a class="dropdown-item" onclick="setThemeLight()" href="#">Light</a></li>
						</ul>
					</li>
				</ul>
				<form style="display:flex;" action="search.jsp" action="get">
					<input class="form-control" type="search" placeholder="Search" aria-label="Search" style="color: black;" name="search">
					<input id="hiddenName" type="hidden" name="userName" value="<%=bean.getName() %>" />
      				<button class="btn btn-outline-success" type="submit">Search</button>
      			</form>
				<form class="d-flex" action="<%=request.getContextPath()%>/Logout" method="post">
					<button class="btn btn-outline-success" type="submit">Logout</button>
				</form>
			</div>
		</div>
	</nav>

	<%
	  // Check to see if the session has a user bean.
	  if (session.getAttribute("user") == null) {
		  // if there is not one, goto the logout servlet
		  RequestDispatcher rd = request.getRequestDispatcher("Logout");
		  rd.forward(request, response);
	  } else {
		  // if there is a session , then all is well  
		  // get the bean to unpack the user data
		  
		  out.print("<center><h1>Welcome, " + bean.getName() + "</h1></center>");
	  }
	  %>
	<%      
	
   	try {  
    	con.getPosts();  
    	ResultSet temp = con.getResult();  
    	int countPosts = 0; 

    	while (temp.next()){
    		countPosts++;
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
				<input type="text" name="tagName" style="color: black;"/>
				<input type="hidden" value="<%=temp.getString("postid") %>" name="postid" />
				<button class="btn btn-outline-success" type="submit">Add Tag</button>
			</form>

			<!--<button style="max-width: 20%;">add tag</button>-->
		</div>
	</div>
	
	<% 
		}  
    } catch (Exception e) {  
      e.printStackTrace();  
   	}  
	%>
	<script src="js/theme.js"></script>
</body>

</html>