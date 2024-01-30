<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="loginnow();">
	<script type="text/javascript">
		var xmlhttp = null;
		var reply;
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
		//loginnow();

		////////////////////////////////
		function loginnow() {
			var username = document.getElementById('idusername').value;

			var password = document.getElementById('idpassword').value;

			xmlhttprequest2('OlegDoChatting.do?othermethod2=login&username2='
					+ username + '&password2=' + password);

		}

		function xmlhttprequest2(url, gohere) {
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var resp = xmlhttp.responseText;
					document.getElementById('idchatreceived').innerHTML = "<font color='red'>Hello Admin here how can I help you?</font>";

					alert("Called login status=" + resp);
					
					document.getElementById("divlogin").style.display = "none";
					document.getElementById("divchatnow").style.display = "block";
					
					setInterval(function() {
						callreceiver()
					}, 3000);

					if (gohere != null)
						document.location = gohere;
				}
			}
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		}
		//////////////////////////////////

		/*		setInterval(function() {
		 callreceiver()
		 }, 3000);
		 */
		function callreceiver() {
			var resp = xmlhttprequest('OlegDoChatting.do?othermethod2=receivechat');
			//document.getElementById('idchatreceived').innerHTML = resp;
			if(reply!=null)
			document.getElementById('idchatreceived').innerHTML = reply;

				/*document
					.getElementById('idchatreceived').innerHTML
					
					+ reply;
				*/
			var objDiv = document.getElementById('idchatreceived');
			objDiv.scrollTop = objDiv.scrollHeight;
		}
		function sendmessage() {
			var messagebody = document.getElementById("txtsendmessage").value;
			var to = "infodulynoted.co.uk@198.38.92.127";
			var resp = xmlhttprequest3('OlegDoChatting.do?othermethod2=sendchat&messagebody='
					+ messagebody + '&to=' + to);
			document.getElementById("txtsendmessage").value="";
			

		}

		function logout() {
			var resp = xmlhttprequest('OlegDoChatting.do?othermethod2=logout2');
			document.location = "Welcome.do";

		}

		function xmlhttprequest(url) {
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var resp = xmlhttp.responseText;
					//alert("Called dochat=" + resp);
					reply = resp;
					
					
					return resp;

				}
			}
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		}

		function xmlhttprequest3(url) {
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var resp = xmlhttp.responseText;
					//alert("Called dochat=" + resp);
					//reply = resp;
					
					
					return resp;

				}
			}
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		}
		
		function onkeyEnter2(e)
		{
			//alert("Key code="+e.keyCode);
			if (e.keyCode==13){
				sendmessage();
				return true;
			}
			return true;	
		}
	</script>

	<table border="2" width="100%" height="100%">

		<tr>

			<td width="30%">

				<div id="divlogin" style="display: none;">
					<table>
						<tr>
							<td>Login User name</td>
							<td><input type="hidden" value="mithun" id="idusername" /></td>
						</tr>
						<tr>
							<td>Login Password</td>
							<td><input type="hidden" value="mithun" id="idpassword" /></td>
						</tr>
						<tr>
							<td>Click to Login!</td>
							<td><input type="button" id="btnlogin" value="Login"
								onclick="loginnow();" /></td>
						</tr>

					</table>

				</div>
				<div id="divchatnow" style="display: block;">
					
					<div id="idchatreceived"  style="height: 150px; width: 100%; overflow:auto;">
					</div>
					
					<br />
					<table width="100%">
						<tr>
							<td width="80%">
								<textarea rows="2" cols="100" id="txtsendmessage" onkeyup="onkeyEnter2(event)"></textarea>
							</td>
							<td width="20%">
								<input type="button" id="btnsend" value="SEND" width="100px" height="100px"
									onclick="sendmessage();" />
							</td>
						</tr>
					</table>
					
					<br/>
					 								
					<input type="button" id="btnsend" value="Close Chat"
									onclick="logout();" />

							 
				</div>
			</td>

		</tr>

	</table>


</body>
</html>