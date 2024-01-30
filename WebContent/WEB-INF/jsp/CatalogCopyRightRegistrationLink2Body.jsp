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
<%@page import="com.konakart.oleg.actions.OlegAddNewTitleAction"%>
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
		<% 
			String empty="false";
			if(session.getAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES)!=null)
			{
				ArrayList a=(ArrayList)session.getAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES);
				if(a.size()>0)
				{
					empty="false";
				}
				else
				{
					empty="true";
				}
				
			}
			else
			{
				empty="true";
			}
		%>
		var empty="<%= empty %>";
//		alert("Hi abc="+abc);
		if(empty=="false")
		{
			
			return true;

		}
		else
		{
			alert("Please add a work title by clicking on NEW");
			return false;
		}
	}
</script>
<div class="body">

	<div class="body-content-div">
<%--
		//<logic:equal value="2" parameter="linkno">
 
			
			<p>
				<font color="black" size="2">Give the title(s) exactly as it
					appears on the work. If there is no title, give an identifying
					phrase, or state "untitled".</font>
			</p>
			<p>
				<font color="black" size="2">To enter the title(s), click
					"New". After you enter the title, click "Save". Repeat this process
					for each additional title.</font>
			</p>

			<p>
				
				<a href='AddNewTitles.do' id="olegbutton1"> NEW </a>
			</p>

			<p>
				<font color="black" size="2"> To <u>edit</u> or <u>delete</u>
					a title, click the appropriate link in the list below. When the
					list is complete and correct, click "Continue" to save <br /> the
					information and proceed to the "Publication/Completion" screen. </font>
			</p>

			<p>
--%>
		<p>
			<h3 align="center">Title of Work</h3>
		</p>
		
		<p>
			
			<a href='AddNewTitles.do' id="olegbutton1"> NEW </a>
		</p>
		
			<table border="1" align="left" width="100%">
				<caption align="left">
					<b>All Titles</b>
				</caption>

				<thead>
					<tr>
						<th align="left">Title of Work</th>
						<th align="left">Volume</th>
						<th align="left">Number</th>
						<th align="left">Issue Date</th>
						<th align="left">Type</th>
						<th align="left">Edit</th>
						<th align="left">Delete</th>

					</tr>
				</thead>
				<tbody>
				<% ArrayList<HashMap> alltitles=(ArrayList<HashMap>)session.getAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES); %>
				
				<% if(alltitles!=null && alltitles.size()>0) 
				{	
					
					for(int i=0;i<alltitles.size();i++)
					{
						HashMap row=alltitles.get(i);	
					
				%>							
					<tr>	
						<td>
						<%=row.get("titleofwork") %>
						</td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> 
							<%=row.get("titletype") %>
						</td>
						<td> </td>
						<td> 
						<a href="DoneDeleteNewTitles.do?deleterow=<%= i %>" > <%=(i+1) %>  </a>
						
						</td>

					</tr>
				<%
					}
				}
				else
				{
				%>
					<tr>	
						<td></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>

					</tr>					
				<%
				}
				%>
				</tbody>
			</table>
			 
<%--
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=1" id="olegbutton1">Back</a>
			</p>
--%>			
			<p align="right" >
				<a href="SelectLink2.do" id="olegbutton1"  >Save</a>
				<!-- onclick="return validate2(this);" -->
			</p>
<%--
  		//</logic:equal>
--%>


	</div>
</div>
<div class="tile"></div>

