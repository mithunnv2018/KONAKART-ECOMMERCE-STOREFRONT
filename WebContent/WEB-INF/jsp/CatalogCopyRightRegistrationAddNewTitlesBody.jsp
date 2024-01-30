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
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ page import="java.util.*" %>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />
<script language="JavaScript">
	function validate2(formabc)
	{
		//alert("HI");
		var abc= document.getElementsByName("titleofwork");
		var def=abc.item(0);
		var titleofwork2=def.value;
		if(titleofwork2.length==0)
		{
			alert("Enter text in Title of work!");
			return false;	
		}
		 
		return true;		
	}
</script>
<div class="body">

	<div class="body-content-div">

		<p>
			<font color="black" size="2">Give only one Title and Title
				Type at a time on this screen; then click "Save". </font>
		</p>

		<p>
			<font color="black" size="2">Step 1:&nbsp;Click on "<u>Title
						Type</u>"  to determine the type of title.</font>
		</p>
		<p>
			<font color="black" size="2">Step 2:&nbsp;Select the Title
				Type. You must select  "<u>Title of Work Being Registered</u>"  at least
				once.</font>
		</p>
		<p>
			<font color="black" size="2">Step 3:&nbsp;Enter the title from
				the work that corresponds to the Title Type you selected.</font>
		</p>
		<p>
			<font color="black" size="2">Step 4:&nbsp;When you have
				finished adding all titles, Click "Save" to save the title.</font>
		</p>
		<!--		<form action="CopyRightRegistration.do?linkno=2" method="post">-->
		<html:form action="DoneAddNewTitles" onsubmit="return validate2(this);">

			<% ArrayList listoftitletype=(ArrayList)session.getAttribute("listoftitletype"); %>


			<p>
				<font size="4" color="red"><b>*</b> </font>Title Type: 
				<%
				//if(listoftitletype!=null)
				//{
				%>
				<html:select property="titletypeid" >
					<html:optionsCollection name="NewTitleForm" property="listoftitletype" label="titletype_aliasname" value="titletype_id"/>
				</html:select>
				<%
				 
				%><!--
				<select>
					<option value=""></option>
					<option value="Title of work being registered">Title of
						work being registered</option>
					<option value="Previous or Alternative Title">Previous or
						Alternative Title</option>
					<option value="Title of Larger Work">Title of Larger Work
					</option>
					<option value="Series Title">Series Title</option>
					<option value="Contents Title">Contents Title</option>
				</select>
			-->
			</p>

			<p>
				<font size="4" color="red"><b>*</b> </font> Title of this work:
				<html:textarea property="titleofwork"  cols="40" rows="10"></html:textarea>
			 
			</p>
			<p>
				<html:submit   style="COLOR: #ffffff; BACKGROUND-COLOR: #0000ff;" value="Add"></html:submit>
				&nbsp; &nbsp; &nbsp;
				<a style="COLOR: #ffffff; BACKGROUND-COLOR: #0000ff;"	href="CopyRightRegistration.do?linkno=2"> Cancel</a>

			</p>
		</html:form>
	</div>
</div>
<div class="tile"></div>

