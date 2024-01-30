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
<bean:define id="rewardPointMgr" name="kkEng" property="rewardPointMgr" type="com.konakart.al.RewardPointMgr"/>


	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_confirmation.gif" border="0" alt="<bean:message key="checkout.confirmation.orderconfirmation"/>" title=" <bean:message key="checkout.confirmation.orderconfirmation"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="checkout.confirmation.orderconfirmation"/>
		 </div>
		<div class="body-content-div">
			<table border="0" width="100%" cellspacing="1" cellpadding="2">
				<tr >
					<td class="msg-box-no-pad" width="30%" valign="top">      
						<table border="0" width="100%" cellspacing="0" cellpadding="2"class="body-content-tab">
							<tr>
								<td ><b><bean:message key="show.order.details.body.deliveryaddress"/></b><html:link page="/CheckoutDeliveryNoReset.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link></td>
							</tr>
							<tr>
								<td ><%=kkEng.removeCData(order.getDeliveryFormattedAddress())%></td>
							</tr>
							<tr>
								<td ><b><bean:message key="show.order.details.body.shippingmethod"/></b> <html:link page="/CheckoutDeliveryNoReset.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link></td>
							</tr>
							<tr>
								<td ><%=order.getShippingMethod()%></td>
							</tr>
						</table>
					</td>
					<td class="msg-box-no-pad" width="70%" valign="top">      
						<table border="0" width="100%" cellspacing="0" cellpadding="0"class="body-content-tab">
							<tr>
								<td>      
									<table border="0" width="100%" cellspacing="0" cellpadding="2"class="body-content-tab">
										<tr>
											<td  colspan="2"><b><bean:message key="show.order.details.body.products"/></b> 
												<html:link page="/ShowCartItems.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link>
											</td>
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
																<logic:notEmpty name="option">
																	<%if (option.getType()==1) {%>
																		<br><nobr><small>&nbsp;<i> - <%=option.getName()%>: <%=option.getQuantity()%> <%=option.getValue()%></i></small></nobr>
																	<%} else {%>
																		<br><nobr><small>&nbsp;<i> - <%=option.getName()%>: <%=option.getValue()%></i></small></nobr>
																	<%}%>																		
																</logic:notEmpty>
															</logic:iterate>
														</logic:notEmpty>
													</td>
													<td  valign="top" align="right"><%=op.getTaxRate().setScale(2, BigDecimal.ROUND_HALF_UP)%>%</td>
														<%if (kkEng.displayPriceWithTax()) {%>
															<td  align="right" valign="top"><%=kkEng.formatPrice(op.getFinalPriceIncTax())%></td>
														<%} else {%>
															<td  align="right" valign="top"><%=kkEng.formatPrice(op.getFinalPriceExTax())%></td>
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
			<br/><b><bean:message key="show.order.details.body.billinginformation"/></b>
			<table border="0" width="100%" cellspacing="1" cellpadding="2">
				<tr >
					<td class="msg-box-no-pad" width="30%" valign="top">      
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<tr>
								<td ><b><bean:message key="show.order.details.body.billingaddress"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link></td>
							</tr>
							<tr>
								<td ><%=kkEng.removeCData(order.getBillingFormattedAddress())%></td>
							</tr>
							<tr>
								<td ><b><bean:message key="show.order.details.body.paymentmethod"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link></td>
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
										<%if (ot.getClassName().equals("ot_reward_points")){%>
										    <td  align="right" width="100%"><%=ot.getTitle()%></td>	
											<td  align="right"><%=ot.getValue()%></td>
										<%}else if (ot.getClassName().equals("ot_free_product")) {%>
											<td  align="right" width="100%"><%=ot.getTitle()%></td>
											<td  align="right" style="white-space: nowrap"><%=ot.getText()%></td>
										<%}else{%>
										    <td  align="right" width="100%"><%=ot.getTitle()%></td>	
											<td  align="right"><%=kkEng.formatPrice(ot.getValue())%></td>
										<%}%>		    																		
									</tr>
								</logic:iterate>
							</logic:notEmpty>
						</table>
					</td>
				</tr>
			</table>
			<%String dispCouponEntry = kkEng.getConfig("DISPLAY_COUPON_ENTRY");if (dispCouponEntry!=null && dispCouponEntry.equalsIgnoreCase("TRUE")) { %>
				<br/><b><bean:message key="checkout.common.couponcode"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link>
				<div class="msg-box-no-pad"> 
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<logic:notEmpty name="order" property="couponCode">
							<td  valign="top"><%=order.getCouponCode()%></td>													
						</logic:notEmpty>	
						<logic:empty name="order" property="couponCode">
							<td  valign="top">&nbsp;</td>
						</logic:empty>															
					</table>
				</div>   
			<% } %>
			<%String dispGiftCertEntry = kkEng.getConfig("DISPLAY_GIFT_CERT_ENTRY");if (dispGiftCertEntry!=null && dispGiftCertEntry.equalsIgnoreCase("TRUE")) { %>
				<br/><b><bean:message key="checkout.common.giftcertcode"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link>
				<div class="msg-box-no-pad"> 
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<logic:notEmpty name="order" property="giftCertCode">
							<td  valign="top"><%=order.getGiftCertCode()%></td>													
						</logic:notEmpty>	
						<logic:empty name="order" property="giftCertCode">
							<td  valign="top">&nbsp;</td>
						</logic:empty>															
					</table>
				</div>   
			<% } %>
			<%String dispPointsEntry = kkEng.getConfig("ENABLE_REWARD_POINTS");if (dispPointsEntry!=null && dispPointsEntry.equalsIgnoreCase("TRUE")) { %>
				<%int points = rewardPointMgr.pointsAvailable(); %>
				<%if  (points > 0) { %>
					<br/><b><bean:message key="checkout.common.reward_points" arg0="<%=String.valueOf(points)%>"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link>
					<div class="msg-box-no-pad"> 
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						    <%if  (order.getPointsRedeemed() > 0) { %>
								<td  valign="top"><%=order.getPointsRedeemed()%></td>
							<% } else { %>													
								<td  valign="top">&nbsp;</td>
							<% } %>
						</table>
					</div>   
				<% } %>
			<% } %>
			<br/><b><bean:message key="checkout.confirmation.ordercomments"/></b> <html:link page="/CheckoutPayment.do"><span class="orderEdit">(<bean:message key="common.edit"/>)</span></html:link>
				<div class="msg-box-no-pad">     
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<logic:notEmpty name="order" property="statusTrail">
							<logic:iterate id="ost" name="order" property="statusTrail" type="com.konakart.appif.OrderStatusHistoryIf">
								<tr>
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
				</div>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile" align="right">
					<html:link page="/CheckoutConfirmationSubmit.do">
						<span class="button"><span><bean:message key="common.confirmorder"/></span></span>
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
			<td width="25%">      
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
						<td><img src="<%=kkEng.getImageBase()%>/checkout_bullet.gif" border="0" alt="" width="11" height="11"></td>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
					</tr>
				</table>
			</td>
			<td width="25%">      
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="1" height="5"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" width="25%" class="checkoutBarFrom"><html:link page="/CheckoutDeliveryNoReset.do"><bean:message key="checkout.common.deliveryinformation"/></html:link></td>
			<td align="center" width="25%" class="checkoutBarFrom"><html:link page="/CheckoutPayment.do"><bean:message key="checkout.common.paymentinformation"/></html:link></td>
			<td align="center" width="25%" class="checkoutBarCurrent"><bean:message key="checkout.common.confirmation"/></td>
			<td align="center" width="25%" class="checkoutBarTo"><bean:message key="checkout.common.finished"/>!</td>
		</tr>
	</table>
	


