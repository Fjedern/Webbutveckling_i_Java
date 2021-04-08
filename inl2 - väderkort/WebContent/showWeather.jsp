<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.weatherBean"%>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<%@ page import ="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
	<link
         href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
         rel="stylesheet"
         integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
         crossorigin="anonymous"
      />
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>the weather</title>
</head>
<body>
	<div style="margin: 50px;">
	<% weatherBean wBean = (weatherBean) request.getAttribute("wBean"); %>
	<div class="card text-white bg-dark mb-3" style="max-width: 14rem;">
  		<div class="card-header">Search</div>
  		<div class="card-body">
    		<h5 class="card-title"><%= wBean.getCityStr() %></h5>
    		<p class="card-text"><%= wBean.getCloudsStr() %></p>
  			<p class="card-text"><%= wBean.getTemperatureStr() %> C</p>
  			<p class="card-text"><%= wBean.getLastUpdateStr() %></p>
  		</div>
	</div>
	<h1>Recent searches: </h1>
	<div class="card-group">
		<%
		Cookie[] cookies = request.getCookies();
		String allValues;
	
		for(Cookie cookie : cookies){
			if(!cookie.getName().equals("JSESSIONID")){
				out.print("<div class='card text-white bg-dark mb-3' style='max-width: 22rem; margin: 10px;'>");
				out.print("<div class='card-body'>");
				out.print("<h5 class='card-title'>" + cookie.getName() + "</h5>");
				out.print("<p class='card-text'>" + URLDecoder.decode(cookie.getValue()).replace("#", " ")  + "</p>");
				out.print("</div></div>");
			}
		}
		%>
	</div>
	</div>
	<script
         src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
         integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
         crossorigin="anonymous"
     ></script>
	
</body>
</html>