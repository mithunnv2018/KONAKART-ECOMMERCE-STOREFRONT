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

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
<bean:define id="cust" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_address_book.gif" border="0" alt="<bean:message key="delete.addr.book.title"/>" title=" <bean:message key="delete.addr.book.title"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">		
		<bean:message key="delete.addr.book.title"/>
	 </div>
	<div class="body-content-div">	
		<b><bean:message key="delete.addr.book.deleteaddress"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="delete.addr.book.areyousure"/></td>
						<td align="right" width="50%" valign="top">
							<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td  align="center" valign="top"><b>Selected Address</b><br><img src="<%=kkEng.getImageBase()%>/arrow_south_east.gif" border="0" alt="" width="50" height="31"></td>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
									<logic:notEmpty name="customerMgr"  property="selectedAddr">	
										<td  valign="top"><%=kkEng.removeCData(kkEng.getCustomerMgr().getSelectedAddr().getFormattedAddress())%></td>
									</logic:notEmpty>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
	</div>
</div>						
<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<html:link page="/DeleteAddrSubmit.do">
					<span class="button"><span><bean:message key="common.delete"/></span></span>
				</html:link>
				<html:link page="/AddressBook.do">
					<span class="button"><span><bean:message key="common.back"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
</div> 	

