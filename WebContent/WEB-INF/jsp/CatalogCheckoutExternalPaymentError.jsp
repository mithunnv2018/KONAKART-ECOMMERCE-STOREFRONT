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
<%@ taglib uri="/tags/struts-nested" prefix="nested" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>

<div class="body">
	<div class="body-header" align="center">
		<bean:message key="checkout.external.payment.error.title"/>		 
	</div>
	<div class="body-content-div" align="center">
		<bean:message key="checkout.external.payment.error.explanation"/>.
	</div>
</div>						
<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile" align="right">
				<html:link page="/MyAccount.do">
					<span class="button"><span><bean:message key="common.continue"/></span></span>
				</html:link>	
			</div>
		</div></div></div></div></div></div></div></div>
</div> 
<table></table>
</br>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="25%">      
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="50%" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="1" height="5"></td>
					<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
				</tr>
			</table>
		</td>
		<td width="25%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
		<td width="25%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
		<td width="25%">      
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
					<td width="50%"><img src="<%=kkEng.getImageBase()%>/checkout_bullet.gif" border="0" alt="" width="11" height="11"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" width="25%" class="checkoutBarFrom"><bean:message key="checkout.common.deliveryinformation"/></td>
		<td align="center" width="25%" class="checkoutBarFrom"><bean:message key="checkout.common.paymentinformation"/></td>
		<td align="center" width="25%" class="checkoutBarFrom"><bean:message key="checkout.common.confirmation"/></td>
		<td align="center" width="25%" class="checkoutBarCurrent"><bean:message key="checkout.common.finished"/>!</td>
	</tr>
</table>
	



