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
<bean:define id="orderMgr" name="kkEng" property="orderMgr" type="com.konakart.al.OrderMgr"/>
<bean:define id="order" name="orderMgr" property="checkoutOrder" type="com.konakart.appif.OrderIf"/>

<html:form  action="/CheckoutFinishedSubmit.do" styleId="form1">
	<div class="body">
		<div class="body-header">
			<img style="float:left" src="<%=kkEng.getImageBase()%>/table_background_man_on_board.gif" border="0" alt="<bean:message key="checkout.finished.orderprocessed"/>!" title=" <bean:message key="checkout.finished.orderprocessed"/>! " width="175" height="198">
			<bean:message key="checkout.finished.orderprocessed"/>!
		 </div>
		<div class="body-content-div">
			<p><bean:message key="checkout.finished.orderprocessedlong"/>.</p>
			<%if (kkEng.getCustomerMgr().getCurrentCustomer() != null && kkEng.getCustomerMgr().getCurrentCustomer().getType() != 2) { %>
				<%if (kkEng.getCustomerMgr().getCurrentCustomer() != null && kkEng.getCustomerMgr().getCurrentCustomer().getGlobalProdNotifier() == 0) { %>
				<bean:message key="checkout.finished.notifyme"/>:<br>									
				<p class="productsNotifications">				
				<%
																// Populate the form
																com.konakart.forms.EditNotifiedProductForm myForm = (com.konakart.forms.EditNotifiedProductForm) session.getAttribute("EditNotifiedProductForm"); 	
																if (order != null && order.getOrderProducts() != null)
																{
																	java.util.ArrayList prodList = new java.util.ArrayList();
																	for (int i = 0; i < order.getOrderProducts().length; i++)
																	{
																com.konakart.appif.OrderProductIf op = order.getOrderProducts()[i];
																com.konakart.al.NotifiedProductItem npf = new com.konakart.al.NotifiedProductItem(op.getProductId(), op.getName());
																npf.setRemove(false);
																prodList.add(npf);
																	}
																	myForm.setItemList(prodList);
																}
					%>		
				<logic:notEmpty name="EditNotifiedProductForm"  property="itemList" scope="session">	
					<nested:iterate id="item" property="itemList" name="EditNotifiedProductForm" type="com.konakart.al.NotifiedProductItem">
						<nested:checkbox property="remove"/>&nbsp;<nested:write property="prodName"/><br>													
					</nested:iterate>
				</logic:notEmpty>	
				</p>            
				<h3><bean:message key="checkout.finished.thanks"/>!</h3>
			<% } else { %>
				<bean:message key="checkout.finished.vieworderhistory" /> : <html:link page='/ShowAllOrders.do'> <bean:message key="checkout.finished.orderhistory" /></html:link><br><br>
				<bean:message key="checkout.finished.questions"/>.
			<% } %>
		<% } %>

		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile" align="right">
					<a onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>				
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 
</html:form>
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
	



