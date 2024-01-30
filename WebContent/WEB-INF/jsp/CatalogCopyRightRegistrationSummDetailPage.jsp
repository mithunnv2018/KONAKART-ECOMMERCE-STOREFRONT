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
<%@page import="com.konakart.oleg.actions.OlegSendEmailFromAdminAction"%>
<%@page import="com.konakart.oleg.forms.CertificationForm"%>
<%@page import="com.konakart.oleg.forms.SpecialhandlingForm"%>
<%@page import="com.konakart.oleg.forms.MailCertificateForm"%>
<%@page import="com.konakart.oleg.forms.CorrespondentForm"%>
<%@page import="com.konakart.oleg.forms.RightsPermissionForm"%>
<%@page import="com.konakart.oleg.forms.LimitationClaimForm"%>
<%@page import="com.konakart.oleg.forms.NewClaimantsForm"%>
<%@page import="com.konakart.oleg.db.FormSubmitCopyrightBean"%>
<%@page import="com.konakart.oleg.db.AuthorDetailsBean"%>
<%@page import="com.konakart.oleg.OlegTasks"%>
<%@page import="com.konakart.oleg.actions.OlegLoginAction"%>
<%@page import="java.util.*"%>
<%@page isELIgnored="false"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<head>

<style media="all" type="text/css">
      @import url("styles/maven-base.css"); @import url("styles/maven-theme.css"); @import url("styles/site.css"); @import
      url("styles/screen.css");
    </style><link media="print" type="text/css" href="./styles/print.css" rel="stylesheet"/>
</head>

<div class="body">
<%  if(session.getAttribute(OlegLoginAction.OLEG_USERID)==null)
{	
	//session.setAttribute(OlegLoginAction.OLEG_USERID,null);
	//response.sendRedirect("OlegLoginPage.do");
	%>
	
	<jsp:forward page="/OlegLoginPage.do">
		<jsp:param value="Do Login to continue" name="isLoginError"/>
	</jsp:forward>
<%
}
%>
	<div class="body-content-div">
<p><img src="images/logo.png"/></p>
		<p align="right" >
			<a href="OlegCustomerCopyrightTable.do?oleglogout=true"> Log Out</a>
		</p>		
		<%
			HashMap summdata = null;
			Integer formcopyid=null;
			if (request.getParameter("formcopyid") != null) {
				formcopyid = Integer.parseInt(request
						.getParameter("formcopyid"));
				summdata = OlegTasks.doRetrieveSummaryDetail(request,
						formcopyid);

			}
			
		%>

		<%
			HashMap link1 = (HashMap) summdata.get("link1");
			ArrayList<HashMap> link2 = (ArrayList<HashMap>) summdata
					.get("link2");
			request.setAttribute("link2", link2);

			FormSubmitCopyrightBean link3 = (FormSubmitCopyrightBean) summdata
					.get("link3");

			ArrayList<AuthorDetailsBean> link4 = (ArrayList<AuthorDetailsBean>) summdata
					.get("link4");
			request.setAttribute("link4", link4);

			ArrayList<NewClaimantsForm> link5 = (ArrayList<NewClaimantsForm>) summdata
					.get("link5");
			request.setAttribute("link5", link5);

			LimitationClaimForm link6 = (LimitationClaimForm) summdata
					.get("link6");
			request.setAttribute("link6", link6);

			RightsPermissionForm link7 = (RightsPermissionForm) summdata
					.get("link7");
			CorrespondentForm link8 = (CorrespondentForm) summdata.get("link8");

			MailCertificateForm link9 = (MailCertificateForm) summdata
					.get("link9");

			SpecialhandlingForm link10 = (SpecialhandlingForm) summdata
					.get("link10");
					
			CertificationForm link11=(CertificationForm) summdata.get("link11");
		%>
		<p>
		
		<% if(link1!=null)
			{
		%>
		<br/>
		<br/>
		
		<h1 align="center">SUMMARY OF COPY RIGHTS</h1>		
		<hr width="100%"/>
		<h1>	Type of Work Name:&nbsp; <%=link1.get("typeworkname")%></h1>
		</p>
		<%
			OlegSendEmailFromAdminAction abc=new OlegSendEmailFromAdminAction();
	    	abc.execute(null, null, request, response);
			}
		%>
		<br />
		<hr />
		 
		<%
			if(session.getAttribute(OlegTasks.FILEDOWNLOADURL)!=null)
			{
		%>
			<a target="_blank" href="<%=session.getAttribute(OlegTasks.FILEDOWNLOADURL) %>">Download Certificate</a>
		
		<%
				session.removeAttribute(OlegTasks.FILEDOWNLOADURL);
			}
		%>
		<h1>Title of Work</h1>
		<% 
			
		%>
		<display:table name="link2" style="border: aqua;">
			<display:caption>Title List</display:caption>
			<display:column title="Title of Work" property="titledetails_name"></display:column>
			<display:column title="Type" property="titletype_name"></display:column>

		</display:table>
 
		<br />
		<hr />
		<h1>Publication / Completion</h1>
		<% if(link3!=null)
		   {	
		%>
		<table border="1" class="report">
			<caption align="left">
				<b>List of Publication / Completion</b>
			</caption>
			<tr>
				<td>Published Work : <%=link3.getFormcopy_workpublished()%></td>
				<td>Nation of First Publication: <%= OlegTasks.doGetCountry(link3.getCountries_id()) %></td>
			</tr>
			<tr>
				<td>Year of Completion (Year of Creation): <%=link3.getFormcopy_yearofcomp()%>
				</td>
				<td>International Standard Number Type: <%=link3.getFormcopy_internotype()%>
				</td>
			</tr>
			<tr>
				<td>Date of First Publication: <%=link3.getFormcopy_dateoffirstpub()%>
				</td>
				<td>International Standard Number: <%=link3.getFormcopy_internumber()%>
				</td>

			</tr>
			<tr align="center">
				<td colspan="2">Preregistration Number: <%=link3.getFormcopy_preregnos()%>
				</td>
				<td></td>
			</tr>
		</table>
		<%} %>

		<br />
		<hr />

		<h1>Authors</h1>
		<%if(link4!=null)
		{
		%>
		<display:table name="link4">
			<display:caption>List of Authors</display:caption>
			<display:column title="Name" property="author_name"></display:column>
			<display:column title="Organization Name"
				property="author_organizationname"></display:column>
			<display:column title="Work For Hire"
				property="author_workmadeforhire"></display:column>
			<display:column title="Anonymous" property="author_anonym"></display:column>
			<display:column title="Pseudonym" property="author_psedonymname"></display:column>

		</display:table>
		<%} %>
		<br />
		<hr />

		<h1>Claimants</h1>
		<%if(link5!=null)
		{
		%>
		<display:table name="link5" id="row">
			<display:caption>List of Claimants</display:caption>
			<display:column title="Name">${row.firstname} ${row.middlename} ${row.lastname}</display:column>
			<display:column title="Organization Name" property="organizationname"></display:column>
			<display:column title="Transfer Statement"
				property="transferstatement"></display:column>
			<display:column title="Address" property="address1"></display:column>

		</display:table>

		<%} %>
		<br />
		<hr />

		<h1>Limitation of Claim</h1>
		<%if(link6!=null) 
		{
		%>
		<table>
			<tr>
				<td>
					<table border="1">
						<caption>Material Excluded:</caption>
						<tr>
							<td>Text</td>
							<td><%=link6.getExcluded_text()%></td>
						</tr>
						<tr>
							<td>2-D Artwork</td>
							<td><%=link6.getExcluded_2dartwork()%></td>
						</tr>
						<tr>
							<td>Photograph(s)</td>
							<td><%=link6.getExcluded_photo()%></td>
						</tr>
						<tr>
							<td>Jewelry design</td>
							<td><%=link6.getExcluded_jewelrydesign()%></td>
						</tr>
						<tr>
							<td>Architectural work</td>
							<td><%=link6.getExcluded_architectural()%></td>
						</tr>
						<tr>
							<td>Sculpture</td>
							<td><%=link6.getExcluded_sculpture()%></td>
						</tr>
						<tr>
							<td>Technical Drawing t</td>
							<td><%=link6.getExcluded_drawing()%></td>
						</tr>
						<tr>
							<td>Map</td>
							<td><%=link6.getExcluded_map()%></td>
						</tr>
						<tr>
							<td>Other</td>
							<td><%=link6.getExcluded_other()%></td>
						</tr>



					</table></td>
				<td>
					<table border="1">
						<caption>Previous Registration:</caption>

						<tr>
							<td>1st Prev. Reg. #: <%=link6.getFirstprevreg()%></td>
						</tr>

						<tr>
							<td>Year: <%=link6.getFirstyear()%></td>
						</tr>

						<tr>
							<td>2nd Prev. Reg. #: <%=link6.getSecondprevreg()%></td>
						</tr>

						<tr>
							<td>Year: <%=link6.getSecondyear()%></td>
						</tr>

					</table>
				</td>
				<td>
					<table border="1">
						<caption>New Material Included:</caption>
						<tr>
							<td>Text</td>
							<td><%=link6.getIncluded_text()%></td>
						</tr>
						<tr>
							<td>2-D Artwork</td>
							<td><%=link6.getIncluded_2dartwork()%></td>
						</tr>
						<tr>
							<td>Photograph(s)</td>
							<td><%=link6.getIncluded_photo()%></td>
						</tr>
						<tr>
							<td>Jewelry design</td>
							<td><%=link6.getIncluded_jewelrydesign()%></td>
						</tr>
						<tr>
							<td>Architectural work</td>
							<td><%=link6.getIncluded_architectural()%></td>
						</tr>
						<tr>
							<td>Sculpture</td>
							<td><%=link6.getIncluded_sculpture()%></td>
						</tr>
						<tr>
							<td>Technical Drawing t</td>
							<td><%=link6.getIncluded_drawing()%></td>
						</tr>
						<tr>
							<td>Map</td>
							<td><%=link6.getIncluded_map()%></td>
						</tr>
						<tr>
							<td>Other</td>
							<td><%=link6.getIncluded_other()%></td>
						</tr>



					</table></td>
			</tr>
		</table>
		<%} %>
		<br />
		<hr />
		<br> <br>
		<h1>Rights & Permissions Information</h1>
		<%if(link7!=null)
		{
		%>
		<table style="width: 121px; height: 53px">
			<tr>
				<td>
					<table border="1">
						<caption>Individual:</caption>
						<tr>
							<td>First Name:</td>
							<td><%=link7.getFirstname()%></td>
						</tr>
						<tr>
							<td>Middle Name:</td>
							<td><%=link7.getMiddlename()%></td>
						</tr>
						<tr>
							<td>Last Name:</td>
							<td><%=link7.getLastname()%></td>
						</tr>
						<tr>
							<td>Email</td>
							<td><%=link7.getEmail()%></td>
						</tr>
						<tr>
							<td>Phone</td>
							<td><%=link7.getPhone()%></td>
						</tr>
						<tr>
							<td>Alt Phone:</td>
							<td><%=link7.getAlternatephone()%></td>
						</tr>
					</table>
				</td>
				<td>
					<table border="1">
						<caption>Organization:</caption>
						<tr>
							<td>Organization Name:</td>
							<td><%=link7.getOrganizationname()%></td>
						</tr>

						<tr>
							<td>Address1:</td>
							<td><%=link7.getAddress1()%></td>
						</tr>

						<tr>
							<td>Address2:</td>
							<td><%=link7.getAddress2()%></td>
						</tr>
						<tr>
							<td>City:</td>
							<td><%=link7.getCity()%></td>
						</tr>
						<tr>
							<td>State:</td>
							<td><%=link7.getState()%></td>
						</tr>
						<tr>
							<td>Postal Code:</td>
							<td><%=link7.getPostalcode()%></td>
						</tr>
						<tr>
							<td>Country</td>
							<td><%=OlegTasks.doGetCountry(link7.getCountryid())%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%} %>
		<br />
		<hr />

		<h1>Correspondent</h1>
		<% if(link8!=null)
		   {	
			%>
		<table>
			<tr>
				<td>
					<table border="1">
						<caption>Individual:</caption>
						<tr>
							<td>First Name:</td>
							<td><%=link8.getFirstname()%></td>
						</tr>
						<tr>
							<td>Middle Name:</td>
							<td><%=link8.getMiddlename()%></td>
						</tr>
						<tr>
							<td>Last Name:</td>
							<td><%=link8.getLastname()%></td>
						</tr>
						<tr>
							<td>Email</td>
							<td><%=link8.getEmail()%></td>
						</tr>
						<tr>
							<td>Phone</td>
							<td><%=link8.getPhone()%></td>
						</tr>
						<tr>
							<td>Alt Phone:</td>
							<td><%=link8.getAlternatephone()%></td>
						</tr>
						<tr>
							<td>Fax:</td>
							<td><%=link8.getFax()%></td>
						</tr>
					</table>
				</td>

				<td>
					<table border="1">
						<caption>Organization:</caption>
						<tr>
							<td>Organization Name:</td>
							<td><%=link8.getOrganizationname()%></td>
						</tr>

						<tr>
							<td>Address1:</td>
							<td><%=link8.getAddress1()%></td>
						</tr>

						<tr>
							<td>Address2:</td>
							<td><%=link8.getAddress2()%></td>
						</tr>
						<tr>
							<td>City:</td>
							<td><%=link8.getCity()%></td>
						</tr>
						<tr>
							<td>State:</td>
							<td><%=link8.getState()%></td>
						</tr>
						<tr>
							<td>Postal Code:</td>
							<td><%=link8.getPostalcode()%></td>
						</tr>
						<tr>
							<td>Country</td>
							<td><%=OlegTasks.doGetCountry(link8.getCountryid())%></td>
						</tr>
					</table></td>
			</tr>
		</table>
		<%} %>

		<br />
		<hr />

		<h1>Mail Certificate</h1>
		<%if(link9!=null)
		{
			%>
		<table>
			<tr>
				<td>
					<table border="1">
						<caption>Individual:</caption>
						<tr>
							<td>First Name:</td>
							<td><jsp:expression>link9.getFirstname()</jsp:expression></td>
						</tr>
						<tr>
							<td>Middle Name:</td>
							<td><jsp:expression>link9.getMiddlename()</jsp:expression></td>
						</tr>
						<tr>
							<td>Last Name:</td>
							<td><jsp:expression>link9.getLastname()</jsp:expression></td>
						</tr>
						<tr>
							<td>Address1:</td>
							<td><jsp:expression>link9.getAddress1()</jsp:expression></td>
						</tr>
						<tr>
							<td>Address2:</td>
							<td><jsp:expression>link9.getAddress2()</jsp:expression></td>
						</tr>
						<tr>
							<td>City:</td>
							<td><jsp:expression>link9.getCity()</jsp:expression></td>
						</tr>

					</table></td>
				<td><table border="1">
						<caption>Organization:</caption>
						<tr>
							<td>Organization Name:</td>
							<td><jsp:expression>link9.getOrganizationname()</jsp:expression></td>
						</tr>
						<tr>
							<td>State:</td>
							<td><jsp:expression>link9.getState()</jsp:expression></td>
						</tr>
						<tr>
							<td>Postal Code:</td>
							<td><jsp:expression>link9.getPostalcode()</jsp:expression></td>
						</tr>
						<tr>
							<td>Country:</td>
							<td><jsp:expression>OlegTasks.doGetCountry(link9.getCountryid())</jsp:expression></td>
						</tr>



					</table></td>

			</tr>
		</table>
		<%} %>
		<br />
		<hr />

		<h1>Special Handling</h1>
		<%if(link10!=null)
		{
			%>
		<p>
			Is Special Handling required :<%=(link10.getSpecialhandling().equalsIgnoreCase("null")) ? "No"
					: link10.getSpecialhandling()%></p>

		<b>Compelling Reason(s)</b> <br />
		<table border="1">
			<tr>
				<td><h4>Pending or prospective litigation :</h4></td>
				<td><%=link10.getReason_pending().equalsIgnoreCase("null") ? "No"
					: link10.getReason_pending()%></td>
			</tr>
			<tr>
				<td><h4>Customs matters:</h4></td>
				<td><%=link10.getReason_custom().equalsIgnoreCase("null") ? "No"
					: link10.getReason_custom()%></td>
			</tr>
			<tr>
				<td><h4>Contract or publishing deadlines that necessitate
						the expedited issuance of a certificate:</h4></td>
				<td><%=link10.getReason_contract().equalsIgnoreCase("null") ? "No"
					: link10.getReason_contract()%></td>
			</tr>

		</table>
		<p>
			You certify that I am the author, copyright claimant of exclusive
			rights, or the authorized agent of the author, copyright claimant of
			exclusive rights of this work. :
			<%=link10.getIcertify().equalsIgnoreCase("null") ? "No"
					: link10.getIcertify()%>
		</p>
		<p>Explanation for Special Handling :<%= link10.getExplanation() %></p>
		<%} %>		
		<br/>
		<hr/>
		<h1>Certification</h1>
		<%if(link11!=null)
			{
			%>
		<p>Name of certifying individual: <%=link11.getNameofindividual() %></p>
		<p>Applicant's Internal Tracking Number: <%=link11.getTrackingnumber() %></p>
		<p>Note to Copyright Office : <%=link11.getNote() %></p>
		<%} %>
		<br/>
		<hr>
		
	</div>
</div>

