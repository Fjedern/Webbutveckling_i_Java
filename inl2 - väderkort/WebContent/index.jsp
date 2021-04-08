<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 
	
	<script src="jquery-3.5.1.min.js"></script>
	<link rel="stylesheet" href="CookiePopup.css">
<meta charset="UTF-8">
<title>OpenWeather</title>
</head>
<body>
	<form action="OWservlet" method="post" style="margin: 100px;">
  		<div class="form-group">
    		<label for="exampleInputEmail1">Enter a city</label>
    		<input type="text" name="city" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter city">
    		<small id="emailHelp" class="form-text text-muted">Please avoid å, ä, ö.</small>
  		</div>
  		<button type="submit" class="btn btn-primary">Go</button>
	</form>
	<script>
	(function() {
		if (!localStorage.getItem('cookieconsent')) {
			document.body.innerHTML += '\
			<div class="cookieconsent" style="position:fixed;padding:20px;left:0;bottom:0;background-color:#000;color:#FFF;text-align:center;width:100%;z-index:99999;">\
				This site uses cookies. By continuing to use this website, you agree to their use. \
				<a href="#" style="color:#555555;">I Understand</a>\
			</div>\
			';
			document.querySelector('.cookieconsent a').onclick = function(e) {
				e.preventDefault();
				document.querySelector('.cookieconsent').style.display = 'none';
				localStorage.setItem('cookieconsent', true);
			};
		}
	})();
	</script>
</body>
</html>