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
 
<div class="body">

	<div class="body-content-div">
		<p><img src="images/logo.png"></p>
 
		<html:form action="OlegCustomerCopyrightTable?oleglogin=true"  method="POST">
 			<h1 align="center">Welcome to Admin Login Page</h1>
 			
 			<%session.setAttribute("oleglogin","true"); %>	 
 			<p align="center">
 			User Name:
 			<html:text property="user" ></html:text>
 			</p>
 			<p align="center">
 			Password:
 			<html:password property="password" />
 			
 			</p>
 			<p align="center">
 				<html:submit value="Admin Login"></html:submit>
 			</p>
 			
 		
 		</html:form>


	</div>
</div>
<div class="tile"></div>

