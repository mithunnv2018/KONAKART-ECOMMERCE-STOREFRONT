<%--
//
// (c) 2006 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//

--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.konakart.oleg.OlegTasks"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />
<style>
<!--
	#olegbutton1
	{
		border:1px;  
		COLOR: #ffffff; 
		BACKGROUND-COLOR: #0099F2;
		font-size: 15pt;
		padding: 3px;
	}
-->
</style>
 
<script type="text/javascript">
<!--
		if(<%=kkEng.getActiveCustId() %> <=0)
		{
			alert("Please Login before using any service from Copyright");
			window.location.href="LoginSubmit.do";
			
		}
	
//-->
</script>

<div class="body">
	<div class="body-header">
		<img style="float: right"
			src="<%=kkEng.getImageBase()%>/table_background_specials.gif"
			border="0"
			alt="<bean:message key="information.tile.copyregistration"/>"
			title=" <bean:message key="information.tile.copyregistration"/> "
			width="<%=kkEng.getHeadingImageWidth()%>"
			height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="information.tile.copyregistration" />
	</div>
	<div class="body-content-div">

	<!--<%if(request.getParameter("linkno")==null) 
	{
		response.sendRedirect("CopyRightRegistration.do?linkno=1");
	%>
				<div style="background-color: black;">
				<font color="white"><big><b>Type of Work</b> </big> </font>
			</div>
		 	Hi U clicked link no <%=request.getParameter("linkno")%>
	
		<%--	<tiles:insert name="catalog.mithcopyright.link1"></tiles:insert>
		--%>
		 hi 	
	<%} %>

-->

<!--  ////////////////NEW START////////////////// -->
<p style="color: red;font-size: 12px">Note: Press Save after entering any information</p>
<%
	HashMap listofobjects=(HashMap)session.getAttribute(OlegTasks.LISTOFOBJECTS);
	if(listofobjects!=null)
	{
	if(listofobjects.get("link1")!=null && listofobjects.get("link2")!=null && listofobjects.get("link3")!=null && listofobjects.get("link4")!=null && 
			listofobjects.get("link5")!=null  )
	{
%>
		
 
				<p >
				<a id="olegbutton1" href="OlegCopyrightPayNow.do">PAY NOW!</a>
				</p>
<%
	}
	else
	{
		if(listofobjects.get("link1")==null)
		{
%>
			<p style="color: red;">Enter Type of work</p>
<%				
		}
		if(listofobjects.get("link2")==null)
		{
%>
			<p style="color: red;">Enter Title of work</p>

<%			
		}
		if(listofobjects.get("link3")==null)
		{
%>
			<p style="color: red;">Enter Year of completion</p>
<%			
		}
		if(listofobjects.get("link4")==null)
		{
%>
			<p style="color: red;">Enter Author Details</p>
<%			
		}
		if(listofobjects.get("link5")==null)
		{
%>
			<p style="color: red;">Enter Claimant Details</p>
<%			
		}
	}
	}		 
%>
 


<!--<h1>Link1</h1>-->
<tiles:insert name="catalog.mithcopyright.link1"></tiles:insert>
<!--<h1>Link2</h1>-->
<tiles:insert name="catalog.mithcopyright.link2"></tiles:insert>
<!--<h1>Link3</h1>-->
<tiles:insert name="catalog.mithcopyright.link3"></tiles:insert>
<!--<h1>Link4</h1>-->
<tiles:insert name="catalog.mithcopyright.link4"></tiles:insert>

<!--<h1>Link5</h1>-->
<tiles:insert name="catalog.mithcopyright.link5"></tiles:insert>
<!--<h1>Link6</h1>-->
<tiles:insert name="catalog.mithcopyright.link6"></tiles:insert>

 

<%
	//HashMap listofobjects=(HashMap)session.getAttribute(OlegTasks.LISTOFOBJECTS);
	if(listofobjects!=null)
	if(listofobjects.get("link1")!=null && listofobjects.get("link2")!=null && 
			listofobjects.get("link3")!=null && listofobjects.get("link4")!=null && 
			listofobjects.get("link5")!=null  )
	{
%>
		
 
				<p >
				<a id="olegbutton1" href="OlegCopyrightPayNow.do">PAY NOW!</a>
				</p>
<%
	}
	 
%>
	
<%--
<h1>Link7</h1>
<tiles:insert name="catalog.mithcopyright.link7"></tiles:insert>
<h1>Link8</h1>
<tiles:insert name="catalog.mithcopyright.link8"></tiles:insert>
<h1>Link9</h1>
<tiles:insert name="catalog.mithcopyright.link9"></tiles:insert>
<h1>Link10</h1>
<tiles:insert name="catalog.mithcopyright.link10"></tiles:insert>
<h1>Link11</h1>
<tiles:insert name="catalog.mithcopyright.link11"></tiles:insert>
--%> 

<!--  //////////////////NEW END////////////////////// -->
<%--
		<logic:equal value="1" parameter="linkno">
			<div style="background-color: black;">
				<font color="white"><big><b>Type of Work</b> </big> </font>
			</div>
			Hi U clicked link no <%=request.getParameter("linkno")%>

			<tiles:insert name="catalog.mithcopyright.link1"></tiles:insert>
		</logic:equal>

		<logic:equal value="2" parameter="linkno">
			<div style="background-color: black;">
				<font color="white"><big><b>Titles</b> </big> </font>
			</div>
				Hi: U clicked link no <%=request.getParameter("linkno")%>
			<tiles:insert name="catalog.mithcopyright.link2"></tiles:insert>
		</logic:equal>
		<logic:equal value="3" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Publication /
							Completion</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link3"></tiles:insert>
		</logic:equal>
		<logic:equal value="4" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Authors</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link4"></tiles:insert>
		</logic:equal>
		<logic:equal value="5" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Claimants</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link5"></tiles:insert>
		</logic:equal>
		<logic:equal value="6" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Limitation of Claim</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link6"></tiles:insert>
		</logic:equal>
		<logic:equal value="7" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Rights & Permissions
							Information (Optional) </b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link7"></tiles:insert>
		</logic:equal>
		<logic:equal value="8" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Correspondent</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link8"></tiles:insert>
		</logic:equal>
		<logic:equal value="9" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Mail Certificate</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link9"></tiles:insert>	
		</logic:equal>
		<logic:equal value="10" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
			<div style="background-color: black;">
				<font color="white"><big><b>Special Handling (Optional)</b> </big> </font>
			</div>
			<tiles:insert name="catalog.mithcopyright.link10"> </tiles:insert>
		</logic:equal>
		<logic:equal value="11" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
				<div style="background-color: black;">
				<font color="white"><big><b>Certification</b> </big> </font>
			</div><tiles:insert name="catalog.mithcopyright.link11"></tiles:insert>
		</logic:equal>
		<logic:equal value="12" parameter="linkno">
			 	
				Hi U clicked link no <%=request.getParameter("linkno")%>
				<br/>
				Send mail after u have logged in:
				<a href="OlegSendEmail.do" >Click me to send mail</a>
				
				
				<h3 style="color: red;">Warning : Please note that by clicking on pay now will result in empting the shopping cart</h3>
				<h2>Congratulations you have entered all necessary information.</h2>
				<h2>To receive certificate on your email pay now!</h2>
				<p >
				<a id="olegbutton1" href="OlegCopyrightPayNow.do">PAY NOW!</a>
				</p>
				
				<%if(request.getParameter("emailinfo2")!=null) 
				{
					%>
					<h1>Email info is </h1>
					<p>
					<%=request.getParameter("emailinfo2") %>
					</p>
				<%
				}
				%>
		</logic:equal>


	--%></div>
</div>
 
