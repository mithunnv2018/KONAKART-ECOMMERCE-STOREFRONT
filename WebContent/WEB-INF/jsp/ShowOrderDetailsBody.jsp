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
<bean:define id="order" name="orderMgr" property="selectedOrder" type="com.konakart.appif.OrderIf"/>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_history.gif" border="0" alt="<bean:message key="show.order.details.body.orderinformation"/>" title=" <bean:message key="show.order.details.body.orderinformation"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="show.order.details.body.orderinformation"/>
	 </div>
	<div class="body-content-div">
		<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
			<tr>
				<td  colspan="2"><b><bean:message key="show.order.details.body.order"/> #<%=order.getId()%> <small>(<%=order.getStatusText()%>)</small></b></td>
			</tr>
			<tr>
				<td class="smallText"><bean:message key="show.order.details.body.orderdate"/>: <%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy").format(order.getDatePurchased().getTime())%></td>
				<td class="smallText" align="right"><bean:message key="show.order.details.body.ordertotal"/>: <%=kkEng.formatPrice(order.getTotalIncTax(),order.getCurrencyCode())%></td>
			</tr>
		</table>
		<table border="0" width="100%" cellspacing="1" cellpadding="2" >
			<tr >
				<td class="msg-box-no-pad" width="30%" valign="top">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td ><b><bean:message key="show.order.details.body.deliveryaddress"/></b></td>
						</tr>
						<tr>
							<td ><%=kkEng.removeCData(order.getDeliveryFormattedAddress())%></td>											
						</tr>
						<tr>
							<td ><b><bean:message key="show.order.details.body.shippingmethod"/></b></td>
						</tr>
						<tr>
							<td ><%=order.getShippingMethod()%></td>
						</tr>
					</table>
				</td>
				<td class="msg-box-no-pad" width="70%" valign="top">
					<table border="0" width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<tr>
										<td  colspan="2"><b><bean:message key="show.order.details.body.products"/></b></td>
										<td class="smallText" align="right"><b><bean:message key="show.order.details.body.tax"/></b></td>
										<td class="smallText" align="right"><b><bean:message key="show.order.details.body.total"/></b></td>
									</tr>
									<logic:notEmpty name="order" property="orderProducts">
										<logic:iterate id="op" name="order" property="orderProducts" type="com.konakart.appif.OrderProductIf">
											<tr>
												<td  align="right" valign="top" width="0%"><%=op.getQuantity()%>&nbsp;x</td>																
												<td  align="left" valign="top"><%=op.getName()%>
													<logic:notEmpty name="op" property="opts">
														<logic:iterate id="option" name="op" property="opts" type="com.konakart.appif.OptionIf">
															<br><nobr><small>&nbsp;<i> - <%=option.getName()%>: <%=option.getValue()%></i></small></nobr>
														</logic:iterate>
													</logic:notEmpty>
												</td>
												<td  valign="top" align="right"><%=op.getTaxRate().setScale(2, BigDecimal.ROUND_HALF_UP)%>%</td>
													<%if (kkEng.displayPriceWithTax()) {%>
														<td  align="right" valign="top"><%=kkEng.formatPrice(op.getFinalPriceIncTax(),order.getCurrencyCode())%></td>
													<%} else {%>
														<td  align="right" valign="top"><%=kkEng.formatPrice(op.getFinalPriceExTax(),order.getCurrencyCode())%></td>
													<%}%>	
											</tr>
										</logic:iterate>
									</logic:notEmpty>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br/><b><bean:message key="show.order.details.body.billinginformation"/></b><br/>
		<table border="0" width="100%" cellspacing="1" cellpadding="2">
			<tr >
				<td class="msg-box-no-pad" width="30%" valign="top">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td ><b><bean:message key="show.order.details.body.billingaddress"/></b></td>
						</tr>
						<tr>
							<td ><%=kkEng.removeCData(order.getBillingFormattedAddress())%></td>
						</tr>
						<tr>
							<td ><b><bean:message key="show.order.details.body.paymentmethod"/></b></td>
						</tr>
						<tr>
							<td ><%=order.getPaymentMethod()%></td>
						</tr>
					</table>
				</td>
				<td class="msg-box-no-pad" width="70%" valign="top">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<logic:notEmpty name="order" property="orderTotals">
							<logic:iterate id="ot" name="order" property="orderTotals" type="com.konakart.appif.OrderTotalIf">
								<tr>
									<td  align="right" width="100%"><%=ot.getTitle()%></td>
									<td  align="right" nowrap="true"><%=ot.getText()%></td>
								</tr>
							</logic:iterate>
						</logic:notEmpty>
					</table>
				</td>
			</tr>
		</table>
		<br/><b><bean:message key="show.order.details.body.orderhistory"/></b><br/>
		<table border="0" width="100%" cellspacing="1" cellpadding="2" class="msg-box-no-pad">
			<tr >
				<td valign="top">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<logic:notEmpty name="order" property="statusTrail">
							<logic:iterate id="ost" name="order" property="statusTrail" type="com.konakart.appif.OrderStatusHistoryIf">
								<tr>
									<td  valign="top" width="70"><%=kkEng.getDateAsString(ost.getDateAdded())%></td>
									<td  valign="top" width="70"><%=ost.getOrderStatus()%></td>
									<logic:empty name="ost" property="comments">
										<td  valign="top">&nbsp;</td>
									</logic:empty>
									<logic:notEmpty name="ost" property="comments">
										<td  valign="top"><%=ost.getComments()%></td>
									</logic:notEmpty>
								</tr>
							</logic:iterate>
						</logic:notEmpty>									
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>						
<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<html:link page="/RepeatOrder.do" paramId="orderId" paramName="order" paramProperty="id">
					<span style="float:right" class="button"><span><bean:message key="common.repeat"/></span></span>
				</html:link>
				<html:link page="/MyAccount.do">
					<span class="button"><span><bean:message key="common.back"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
</div> 	




