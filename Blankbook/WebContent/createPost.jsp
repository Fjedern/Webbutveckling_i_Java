<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="con" class="database.PostConnectionSQL" />

<!DOCTYPE html>
<html class="theme-light">

<head>
  <meta charset="ISO-8859-1">
  <title>Insert title here</title>

  <!-- Bootstrap core CSS -->
  <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">
</head>

<body>

  <div class="container" style="margin-top: 50px;" id="text">
    <form name="createPostForm" action="createPostHandler.jsp" method="post">
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
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>


  </div>
</body>

</html>