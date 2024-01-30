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
@import url("styles/maven-base.css");

@import url("styles/maven-theme.css");

@import url("styles/site.css");

@import url("styles/screen.css");
</style>
<link media="print" type="text/css" href="./styles/print.css"
	rel="stylesheet" />
</head>
<div class="body">
 	<i><%= request.getParameter("isLoginError") %></i>
	<%

		if (session.getAttribute(OlegLoginAction.OLEG_USERID) == null) {
			
	%>

	<jsp:forward page="/OlegLoginPage.do" >
	
		<jsp:param value="Do Login to continue" name="isLoginError" />
	</jsp:forward>
	<%
		}
	%>
	<div class="body-content-div">
		<p>
			<img src="images/logo.png" />
		</p>
		<p align="right" >
			<a href="OlegCustomerCopyrightTable.do?oleglogout=true"> Log Out</a>
		</p>
		<%
			ArrayList<HashMap> abc = OlegTasks.doRetrieveTableForSummary();
			request.setAttribute("test", abc);
		%>
  <br />

		<display:table name="test" id="row" class="mars" pagesize="5"
			excludedParams="*" requestURI="OlegCustomerCopyrightTable.do">
			<display:caption>List of Authors</display:caption>
			<display:column title="Author Name" property="authorname" />
			<display:column title="Organization Name" property="organizationname" />
			<display:column title="Year of Completion" property="yearofcomp" />
			<display:column title="Registration Date" property="regdate" />
			<display:column>
				<a href="OlegSummaryInDetail.do?formcopyid=${row.formcopyid}">SELECT</a>
			</display:column>
		</display:table>

	</div>
</div>
<div class="tile"></div>

