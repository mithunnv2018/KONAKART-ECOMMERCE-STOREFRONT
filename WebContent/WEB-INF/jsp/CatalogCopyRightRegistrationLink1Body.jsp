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
	function validate2()
	{
	
	}
</script>
<div class="body">

	<div class="body-content-div">

	<!-- 	logic:equal value="1" parameter="linkno" --><!--
					 	These are the types of work available in claim registration. Click on a Type of Work listed below for more
			 	<br />
			 	information about each type.
			 	<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Literary Work</font> </a>
			</p>

			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Work of the Visual Arts</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Sound Recording</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Work of the Performing Arts (includes music, lyrics, screenplays,
						etc.)</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Motion Picture / Audio Visual Work</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Mask Work</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Single Serial Issue</font> </a>
			</p>
			<p>
				<a href="/abc" style="color: #6666cc;"><font size="2">
						Works that include more than one type of authorship.</font> </a>
			</p>

			<p>
				<a href="/def" style="color: #6666cc;">Click here</a> for
				information on what may be included on a single application.
			</p>

			<font color="red" size="2">Type of Work cannot be changed
				after you click "Continue."  <u>Click here</u>   for more information.</font>

			-->
			
			<html:form action="SelectLink1">
				<% ArrayList listoftypeofwork=(ArrayList)session.getAttribute("listoftypeofwork"); %>
				
				<p align="center">
					<font color="Red" size="5">* </font> Type of Work:
					<html:select disabled="false" property="typeworkid" name="TblTypeofwork">
						<% 	if(listoftypeofwork!=null)
					
						{
							for(int i1=0;i1<listoftypeofwork.size();i1++)
							{
								HashMap map2=(HashMap)listoftypeofwork.get(i1);
							 
						%>
						  
						<html:option  value='<%=map2.get("typeworkid").toString() %>'><%= map2.get("typeworkaliasname") %></html:option>
						
						<%
							}
						}
						else
						{
							%>
							<html:option value="-1">Empty</html:option>	
							<%
						}
						%>
						<!--
						<html:option value="Work of the Visual Arts">Work of the Visual Arts</html:option>
						<html:option value="Sound Recording">Sound Recording</html:option>
						<html:option value="Work of the Performing Arts">Work of the Performing Arts</html:option>
						<html:option value="Motion Picture/AV Work">Motion Picture/AV Work</html:option>
						<html:option value="Single Serial Issue">Single Serial Issue</html:option>

					--></html:select>

					<p>
					Previous Reg. No.:	<html:text property="previousregno" name="TblTypeofwork"></html:text>
					</p>
					<p>
					Previous Reg. Date:	<html:text property="previousregdate" name="TblTypeofwork"></html:text>
					</p>
					
					
 				</p>
 				<p align="right" style="width: 100%">
 					<html:submit value="Save"  styleId="olegbutton1"></html:submit>
 				</p>
			</html:form>

 <!-- 	logic:equal -->



	</div>
</div>
 
