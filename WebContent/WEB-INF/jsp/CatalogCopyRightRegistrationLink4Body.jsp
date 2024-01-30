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
<%@page import="com.konakart.oleg.actions.OlegAddNewAuthorAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ page import="java.util.*" %>
<%@ page import="com.konakart.oleg.actions.*" %>
<%@ page import="com.konakart.oleg.db.*" %>

<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />
<script language="JavaScript">
	function validate2(formabc)
	{
		<% 
		String empty="false";
		if(session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS)!=null )
		{
			ArrayList a=(ArrayList)session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS);
			if(a.size()>0)
			{
				empty="false";
			}
			else
			{
				empty="true";
			}
			
		}else
		{
			empty="true";
		}
	%>
	var empty=<%= empty %>+"" ;
	
	//	var abc=< session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS)!=null %>+"" ;
//		alert("Hi abc="+abc);
		if(empty=="false")
		{
			
			return true;

		}
		else
		{
			alert("Please add Author Details by clicking on NEW");
			return false;
		}
	}
</script>

<div class="body">

	<div class="body-content-div">
	<%--

//		<logic:equal value="4" parameter="linkno">

			
			<p>
				<font color="black" size="2">Name the author(s) of the work
					being registered, and give the requested information. Generally,
					the application should name <u>all</u> </font> <br /> <font color="black"
					size="2">the authors of the authorship being registered.</font>
			</p>
			<p>
				<font color="black" size="2">Click "New" to add an author,
					or, if you are an author and your name appears in the User Profile
					for this account, click "Add Me".</font>
			</p>

			<p>
				<font color="black" size="2">After you enter the author
					information, click "Save". Repeat this process for each additional
					author.</font>
			</p>

			<p>
--%>
			<p>
				<h3 align="center">Author Details</h3>
			</p>
			<table width="100%">
				<tr>
					<td align="left">
					<a href='AddNewAuthors.do' id="olegbutton1" > NEW</a>
					</td>
					<td align="right">
					
					</td>
			</table>
			</p>

<%--
			<p>
				<font color="black" size="2">To <u>edit</u> or <u>delete</u>
					an author, click the appropriate link in the list below. When the
					list is complete and correct, click "Continue" to <br> save
					the information and proceed to the "Claimants" screen.</font>
			</p>

			<p>
--%>			
			<%
				ArrayList<AuthorDetailsBean> listofauthors=(ArrayList<AuthorDetailsBean>) session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS);
			%>
			<table border="1" align="left" width="100%">
				<caption align="left">
					<b>Authors</b>
				</caption>

				<thead>
					<tr>
						<th align="left">Name</th>
						<th align="left">Organization Name</th>
						<th align="left">Work For Hire</th>
						<th align="left">Anonymous</th>
						<th align="left">Pseudonym</th>
						<th align="left">Edit</th>
						<th align="left">Delete</th>

					</tr>
				</thead>
				<tbody>
				<%if(listofauthors!=null && listofauthors.size()>0)
				{
						
					for(int i=0;i<listofauthors.size();i++)
					{
						
						AuthorDetailsBean row= listofauthors.get(i);
				%>
					<tr>
						<td>
							<%=row.getAuthor_name()  %>
						</td>
						<td><%=row.getAuthor_organizationname()  %></td>
						<td>
						<%= row.getAuthor_workmadeforhire() %>
						</td>
						<td>
						<%= row.getAuthor_anonym() %>
						</td>
						<td>
						<%=row.getAuthor_psedonymname() %>
						</td>
						<td></td>
						<td>
						<a href="DoneDeleteNewAuthors.do?deleterow=<%=i %>"> <%= (i+1) %></a>
						</td>

					</tr>
					<%
					}
				}
					%>
				</tbody>
			</table>
			</p>
<%--			
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=3" id="olegbutton1">Back</a>
				</p>
				
--%>							
			<p align="right" >
				<a href="SelectLink4.do" id="olegbutton1" >Save</a>
			</p><!-- onclick="return validate2(this);" -->

<%--	//	</logic:equal>--%>



	</div>
</div>
<div class="tile"></div>

