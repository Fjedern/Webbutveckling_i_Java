<%@page import="beans.UserBean"%>
<%@page import="beans.PostBean"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">

		<title>Blankbook</title>
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
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="#">Home</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								Theme
							</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown" id="dropdown">
								<li><a class="dropdown-item" onclick="setThemeDark()" href="#">Dark</a></li>
								<li><a class="dropdown-item" onclick="setThemeLight()" href="#">Light</a></li>
							</ul>
						</li>
					</ul>
				
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
			}
			// if there is a session , then all is well  
			// get the bean to unpack the user data
			out.print("<center><h1>Welcome, " + bean.getName() + "</h1></center>");
		%>
		<div class="container" style="margin-top: 50px;" id="text">
    		<form name="createPostForm" action="<%=request.getContextPath()%>/PostController" method="post">
      			<div class="form-group">
        			<label for="exampleFormControlInput1">Title</label>
        			<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="Title" name="title">
      			</div>
      			<div class="form-group">
        			<label for="exampleFormControlTextarea1">Content</label>
        			<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="content"></textarea>
      			</div>
      			<div class="form-group">
       		 		<label>Tag:</label>
        			<input type="text" name="tagName" />
        			<label>Only one tag can be added</label>
      			</div>
      			<input type="hidden" value="1" name="newpost" />
      			<button type="submit" class="btn btn-primary">Submit</button>
    		</form>
  		</div>
			
		<%
			//getting content from controller to arraylist of ContentBeans
			ArrayList<PostBean> postBeanList = new ArrayList<>();
			postBeanList = (ArrayList<PostBean>) session.getAttribute("posts");
			for (PostBean postBean : postBeanList) {
		%>
		<div class='container' id='test'>
			<div class='row'>
				<h1><%= postBean.getTitle() %></h1>
			</div>
			<div class='row'>
				<p><%= postBean.getContent() %></p>
			</div>
			<div class=" d-flex bd-highlight">
				<%
					for(String tag : postBean.getTags()){
				%>
				<div class='p-2 bd-highlight' id='tag'>
					<%=tag%>
				</div>
				<%
					}
				%>
			</div>
			<div class="row">
				<form class="d-flex" action="<%=request.getContextPath()%>/PostController" method="post">
					<input type="text" name="tagName" style="color: black;"/>
					<input type="hidden" value="<%=postBean.getPostId() %>" name="postid" />
					<input type="hidden" value="1" name="newTag" />
					<button class="btn btn-outline-success" type="submit">Add Tag</button>
				</form>
			</div>
		</div>
		<%		
			}
		%>	
		<input id="hiddenName" type="hidden" name="userName" value="<%=bean.getName() %>" />
		<script src="js/theme.js"></script>
	</body>
</html>