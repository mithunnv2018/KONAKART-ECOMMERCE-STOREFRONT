<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var xmlhttp = null;
		function loaddoc() {
			//alert("in load data");
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//alert("loading..");
			//popGridXMLHTTPJson();
		}
		loaddoc();
		function loginnow() {
			var username = document.getElementById("idusername").value;

			var password = document.getElementById("idpassword").value;

			xmlhttprequest('OlegDoChatting.do?othermethod2=login&username2=' + username
					+ '&password2=' + password, 'CatalogDoChat.jsp');

		}

		function xmlhttprequest(url, gohere) {
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var resp = xmlhttp.responseText;
					alert("Called login status=" + resp);
					if (gohere != null)
						document.location = gohere;
				}
			}
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		}
	</script>
	<table>
		<tr>
			<td>Login User name</td>
			<td><input type="text" id="idusername" />
			</td>
		</tr>
		<tr>
			<td>Login Password</td>
			<td><input type="password" id="idpassword" />
			</td>
		</tr>
		<tr>
			<td>Click to Login!</td>
			<td><input type="button" id="btnlogin" value="Login"
				onclick="loginnow();" />
			</td>
		</tr>

	</table>

</body>
</html>