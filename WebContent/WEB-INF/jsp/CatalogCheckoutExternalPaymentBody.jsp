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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<%@page import="java.math.BigDecimal"%>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="orderMgr" name="kkEng" property="orderMgr" type="com.konakart.al.OrderMgr"/>
<bean:define id="order" name="orderMgr" property="checkoutOrder" type="com.konakart.appif.OrderIf"/>
<bean:define id="pDetails" name="order" property="paymentDetails" type="com.konakart.appif.PaymentDetailsIf"/>

<html>
	<head/>
		<body onload="document.forms[0].submit();">
		<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
			<tr>
				<td><b><bean:message key="external.payments.body.message"/></b></td>
			</tr>
		</table>
		<logic:notEmpty name="pDetails" property="parameters">
			<form  action="<%=pDetails.getRequestUrl()%>" method="<%=pDetails.getPostOrGet()%>">
				<logic:iterate id="parm" name="pDetails" property="parameters" type="com.konakart.appif.NameValueIf">
					<input type="hidden" name="<%=parm.getName()%>" value="<%=parm.getValue()%>">
				</logic:iterate>
				<noscript>
					<br/>
					<br/>
					<div style="text-align: center">
						<h1><bean:message key="external.payments.body.message.heading"/></h1>
						<p><bean:message key="external.payments.body.message.clickmsg"/></p>
						<input type="submit" class="button" value="<bean:message key="common.continue"/>"/>
					</div>
				</noscript>
			</form>
		</logic:notEmpty>
	</body>
</html>














