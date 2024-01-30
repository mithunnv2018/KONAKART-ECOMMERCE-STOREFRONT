<%@page import="com.workingdogs.village.Record"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.torque.util.BasePeer"%>
<%@page import="com.konakart.al.KKAppEng"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />
<bean:define id="customerMgr" name="kkEng" property="customerMgr"
	type="com.konakart.al.CustomerMgr" />
<bean:define id="cust" name="customerMgr" property="currentCustomer"
	type="com.konakart.appif.CustomerIf" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
	function xmlhttprequest2(url, gohere) {
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var resp = xmlhttp.responseText;
				
 				if (gohere != null)
					document.location = gohere;
			}
		}
		xmlhttp.open("GET", url, true);
		xmlhttp.send();
	}

	function adminchatparams(id) {
		xmlhttprequest2('OlegDoPaidChatting.do?othermethod2=adminparams&adminname='+ id ,'LoginOlegPaidChat.do');
		
	}
</script>
</head>
<body>

	<%
		List<Record> executeQuery = BasePeer
				.executeQuery("SELECT * FROM customers c  where customers_type=1");
		if (executeQuery.isEmpty() == false) {
	%>

	<table border="0" width="100%" height="100%">
		<%
			for (int i = 0; i < executeQuery.size(); i++) {
					Record row = executeQuery.get(i);
					if (row.getValue("customers_id").asInt() == 2) {
						continue;
					}
		%>
		<tr>
			<td><img alt="" width="200" height="200"
				src="<%=row.getValue("custom1").asString()%>"><br />
				<div align="center">
					<input type="button" value="Chat with me"
						onclick="adminchatparams('<%=row.getValue("customers_email_address")
							.asString()%>');">
				</div></td>
			<td align="left"><%=row.getValue("customers_firstname").asString()%>
				<%=row.getValue("customers_lastname").asString()%> <br />
				
				<%=row.getValue("custom2").asString()%>
				
			</td>

		</tr>
		
		<%
			}
		%>
	</table>
	<%
		} else {

			//out.println("Sorry No admins available!");
		}
	%>

</body>
</html>