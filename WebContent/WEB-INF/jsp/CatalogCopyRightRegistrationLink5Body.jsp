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
<%@page import="com.konakart.oleg.forms.NewClaimantsForm"%>
<%@page import="com.konakart.oleg.actions.OlegAddNewClaimantsAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ page import="java.util.*"%>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />

<div class="body">

	<div class="body-content-div">

<%--		//<logic:equal value="5" parameter="linkno">

			<p>
				<font color="black" size="2">Please identify the  <u>copyright claimant(s)</u> 
				 in this work. The
					author is the original copyright claimant. The claimant may</font> <br />

				<font color="black" size="2">also be a person or organization
					to whom copyright has been transferred.</font>
			</p>
			<p>
				<font color="black" size="2">To be named as a claimant by
					means of a transfer, a person or organization must own   <u>all rights</u>  
					under the </font> <font
					color="black" size="2">  <u> copyright law</u>  . </font>
			</p>

			<p>
				<font color="black" size="2">In addition, a claimant must own
					the copyright in  <u>all the authorship</u>   covered by this
					registration.</font>
			</p>

			<p>
				<font color="black" size="2">Click "New" to add a claimant,
					or, if you are a claimant and your name appears in the User Profile
					for this account,</font> <font color="black" size="2">click "Add
					Me" to add your name and address into the claimants list.</font>
			</p>

			<p>
				<font color="black" size="2">After you enter the claimant
					information, click"Save". Repeat this process for each additional
					claimant.</font>
			</p>
--%>

 			<h3 align="center">Copyright Claimants</h3>
			<p>
			<table width="100%">
				<tr>
					<td align="left"><a href='AddNewClaimants.do' id="olegbutton1" >NEW </a>
					</td>
					<td align="right"> 
					</td>
			</table>
			</p>
<%--
			<p>
				<font color="black" size="2">To <u>edit</u> or <u>delete</u>
					a claimant, click the appropriate link in the list below. When the
					list is complete and correct, click</font> <font color="black" size="2">"Continue"
					to save the information and proceed to the "Limitation of Claim"
					screen.</font>

			</p>

--%>
			<p>
				<%
					ArrayList<NewClaimantsForm> listofclaimants = (ArrayList<NewClaimantsForm>) session
								.getAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS);
				%>
			
			<table border="1" align="left" width="100%">
				<caption align="left">
					<h3>Claimants</h3>
				</caption>

				<thead>
					<tr>
						<th align="left">Name</th>
						<th align="left">Organization Name</th>
						<th align="left">Transfer Statement</th>
						<th align="left">Address</th>
						<th align="left">Edit</th>
						<th align="left">Delete</th>

					</tr>
				</thead>
				<tbody>
					<%
						if (listofclaimants != null) {

								for (int i = 0; i < listofclaimants.size(); i++) {
									NewClaimantsForm abc = listofclaimants.get(i);
					%>

					<tr>
						<td><%=abc.getFirstname() + " "
								+ abc.getMiddlename() + " " + abc.getLastname()%>
						</td>
						<td><%=abc.getOrganizationname()%></td>
						<td>c</td>
						<td><%=abc.getAddress1()%></td>
						<td></td>
						<td>
							<a href="DoneDeleteNewClaimants.do?deleterow=<%= i %>"> <%=(i+1) %> </a>
						</td>

					</tr>
					<%
						}
							} else {
					%>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

			</p>
<%--			
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=4" id="olegbutton1">Back</a>
			</p>			
--%>			
			<p align="right">
				<a href="SelectLink5.do"  id="olegbutton1">Save</a>
			</p>

<%-- 		//</logic:equal>
--%>


	</div>
</div>
<div class="tile"></div>

