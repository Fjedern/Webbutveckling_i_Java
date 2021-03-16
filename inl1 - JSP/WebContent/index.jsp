<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form</title>
</head>
<body>
	<jsp:include page="headerAndFooter.jsp" />  
	<form action="secondPage.jsp">
		<label for="fname">Username:</label><br>
  		<input type="text" id="fname" name="fname" value="Ananas"><br>
  		
  		<label for="pages">Choose a page:</label>
  		<select id="pages" name="page">
    		<option value="page1">page1</option>
    		<option value="page2">page2</option>
  		</select>
  		<input type="submit" value="Submit">
	</form>
</body>
</html>
