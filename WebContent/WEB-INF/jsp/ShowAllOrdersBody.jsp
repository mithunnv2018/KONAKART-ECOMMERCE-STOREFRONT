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
<bean:define id="orderMgr" name="kkEng" property="orderMgr" type="com.konakart.al.OrderMgr"/>
<bean:define id="orderArray" name="orderMgr" property="currentOrders"/>
<bean:define id="maxRows" name="orderMgr" property="pageSize"/>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_history.gif" border="0" alt="<bean:message key="show.all.orders.myorderhistory"/>" title=" <bean:message key="show.all.orders.myorderhistory"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="show.all.orders.myorderhistory"/>
	 </div>
	<div class="body-content-div">
		<logic:empty name="orderMgr" property="currentOrders">
			<div class="msg-box">
				<bean:message key="show.all.orders.nopurchases"/>.
			</div>					
		</logic:empty>
		<logic:notEmpty name="orderMgr" property="currentOrders">
			<logic:iterate id="order" name="orderArray" length="maxRows" type="com.konakart.appif.OrderIf">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td ><b><bean:message key="show.all.orders.ordernumber"/>:</b> <%=order.getId()%></td>
					 	<%String enableInvoice=kkEng.getConfig("ENABLE_PDF_INVOICE_DOWNLOAD"); %>	
						<%if (enableInvoice != null && enableInvoice.equalsIgnoreCase("TRUE") ) {%>													
							<td>
								<b><bean:message key="common.download.invoice"/>:</b>
								<% if (kkEng.isPortlet()) {%>
									<a href="<%=request.getContextPath()%>/../konakartadmin/getPdf?ord=<%=order.getId()%>&rt=2&sed=<%=kkEng.getSessionId()%>&sid=<%=kkEng.getStoreId()%>&em=<%=kkEng.getEngConf().getMode()%>&cs=<%=kkEng.getEngConf().isCustomersShared()%>&ps=<%=kkEng.getEngConf().isProductsShared()%>&ts=<%=kkEng.getEngConf().isCategoriesShared()%>" target="_blank"> <img src="<%=kkEng.getImageBase()%>/icons/pdf.gif" border="0" alt="<bean:message key="common.download.invoice"/>" title="<bean:message key="common.download.invoice"/>"> </a>
								<% } else { %>
									<html:link page="/DownloadInvoice.do" paramId="orderId" paramName="order" paramProperty="id">
										<img  src="<%=kkEng.getImageBase()%>/icons/pdf.gif" border="0" alt="<bean:message key="common.download.invoice"/>" title=" <bean:message key="common.download.invoice"/> ">
									</html:link>
								<% } %>
							</td>
						<% } %>
						<td  align="right"><b><bean:message key="show.all.orders.orderstatus"/>:</b> <%=order.getStatusText()%></td>
					</tr>
				</table>
				<div class="msg-box-no-pad">
					<table border="0" width="100%" cellspacing="2" cellpadding="4" class="body-content-tab">
						<tr>
							<td  width="50%" valign="top"><b><bean:message key="show.all.orders.orderdate"/>:</b> <%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy").format(order.getDatePurchased().getTime())%><br><b><bean:message key="show.all.orders.shippedto"/>:</b> <%=order.getDeliveryName()%></td>
							<td  width="30%" valign="top"><b><bean:message key="show.all.orders.products"/>:</b> <%=order.getNumProducts()%><br><b><bean:message key="show.all.orders.ordercost"/>:</b> <%=kkEng.formatPrice(order.getTotalIncTax(),order.getCurrencyCode())%></td>
							<td  width="20%">
								<html:link page="/ShowOrderDetails.do" paramId="orderId" paramName="order" paramProperty="id">
									<span class="small-button"><span><bean:message key="common.view"/></span></span>
								</html:link>
								<html:link page="/RepeatOrder.do" paramId="orderId" paramName="order" paramProperty="id">
									<span class="small-button"><span><bean:message key="common.repeat"/></span></span>
								</html:link>
							</td>
						</tr>
					</table>
				</div>	
				<br/>
			</logic:iterate>											 
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
					<td class="smallText">
						<bean:message key="show.all.orders.displaying"/>&nbsp;<b><%=orderMgr.getCurrentOffset() + 1%></b> <bean:message key="show.all.orders.to"/> <b><%=orderMgr.getNumberOfOrders() + orderMgr.getCurrentOffset()%></b> (<bean:message key="show.all.orders.of"/> <b><%=orderMgr.getTotalNumberOfOrders()%></b> <bean:message key="show.all.orders.orders"/>)
					</td>
					<td class="smallText" align="right">
					    <%=orderMgr.getNumPages()%> <bean:message key="products.body.result.pages"/>:&nbsp;
						<logic:equal name="orderMgr" property="showBack" value="1">
							<html:link page="/NavigateAllOrders.do" paramId="navDir" paramName="orderMgr" paramProperty="navBack" styleClass="pageResults"><u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u></html:link>&nbsp;&nbsp;
						</logic:equal>
						<logic:notEqual name="orderMgr" property="showBack" value="1">
							<u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u>&nbsp;&nbsp;
						</logic:notEqual>
								<%
								   int j = 0;
						           for (java.util.Iterator<Integer> iterator = orderMgr.getPageList().iterator(); iterator.hasNext();)
						            {
						                Integer pageNum =  iterator.next();
								        java.util.HashMap pageMap = new java.util.HashMap(); 
									    pageMap.put("navDir", pageNum.toString());  
									    request.setAttribute("pageParams"+j, pageMap);  
								        if (orderMgr.getCurrentPage()==pageNum.intValue())
								        {
								 %>
							                <html:link page="/NavigateAllOrders.do" name="<%=\"pageParams\"+j%>"  styleClass="pageResults"><b><u><%=pageNum.intValue()%></u></b>&nbsp;</html:link>
								 <%		} else
								        {
								 %>
							                <html:link page="/NavigateAllOrders.do" name="<%=\"pageParams\"+j%>" styleClass="pageResults"><u><%=pageNum.intValue()%></u>&nbsp;</html:link>											
								 <%		}
						                j++;
						            }									
								 %>
						<logic:equal name="orderMgr" property="showNext" value="1">
							<html:link page="/NavigateAllOrders.do" paramId="navDir" paramName="orderMgr" paramProperty="navNext" styleClass="pageResults"><u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></html:link>
						</logic:equal>
						<logic:notEqual name="orderMgr" property="showNext" value="1">
							<u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u>
						</logic:notEqual>
					</td>
				</tr>
			</table>
		</logic:notEmpty>
	</div>
</div>						
<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<html:link page="/MyAccount.do">
					<span class="button"><span><bean:message key="common.back"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
</div> 	

