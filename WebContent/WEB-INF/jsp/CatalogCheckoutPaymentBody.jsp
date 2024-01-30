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
<bean:define id="order" name="orderMgr" property="checkoutOrder" type="com.konakart.appif.OrderIf"/>
<bean:define id="rewardPointMgr" name="kkEng" property="rewardPointMgr" type="com.konakart.al.RewardPointMgr"/>

<script language="javascript"><!--
function rowOverEffect(object) {
  if (object.className == 'moduleRow') object.className = 'moduleRowOver';
}

function rowOutEffect(object) {
  if (object.className == 'moduleRowOver') object.className = 'moduleRow';
}
//--></script>
<html:form action="/CheckoutPaymentSubmit.do" styleId="form1">
	<html:hidden name="CheckoutForm" property="shipping" value="dummy"/>
	<%
		com.konakart.forms.CheckoutForm myForm = (com.konakart.forms.CheckoutForm) request.getAttribute("CheckoutForm"); 
		if (myForm != null){
			myForm.setCouponCode(order.getCouponCode());
			myForm.setGiftCertCode(order.getGiftCertCode());
			if (order.getPointsRedeemed()>0) myForm.setRewardPoints(Integer.toString(order.getPointsRedeemed()));
			if (orderMgr.getPaymentDetailsArray() != null && orderMgr.getPaymentDetailsArray().length > 0) myForm.setPayment(orderMgr.getPaymentDetailsArray()[0].getCode());
			if (order.getPaymentDetails() != null) myForm.setPayment(order.getPaymentDetails().getCode());
			if (order.getStatusTrail() != null && order.getStatusTrail()[0] != null) myForm.setComment(order.getStatusTrail()[0].getComments());
		}
	%>
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_payment.gif" border="0" alt="<bean:message key="checkout.payment.paymentinformation"/>" title=" <bean:message key="checkout.payment.paymentinformation"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="checkout.payment.paymentinformation"/>
		 </div>
		<div class="body-content-div">
			<b><bean:message key="checkout.payment.billingaddress"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td> 
						<td  width="50%" valign="top"><bean:message key="checkout.payment.billinginstructions"/>.<br><br>
							<html:link page="/ChangePaymentAddr.do">
								<span class="button"><span><bean:message key="checkout.payment.changeaddress"/></span></span>
							</html:link>
						</td>
						<td align="right" width="50%" valign="top">
							<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td  align="center" valign="top"><b><bean:message key="checkout.payment.billingaddress"/>:</b><br><img src="<%=kkEng.getImageBase()%>/arrow_south_east.gif" border="0" alt="" width="50" height="31"></td>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td> 
									<td  valign="top"><%=kkEng.removeCData(order.getBillingFormattedAddress())%></td>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td> 
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<logic:messagesPresent> 
					<tr>
						<td/>
						<td width="100%">
							<ul>
								<html:messages id="error">
									<li class="messageStackError">
										<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
									</li>
								</html:messages> 
							</ul>
						</td>
					</tr>
				</logic:messagesPresent>
			</table>
			<br/><b><bean:message key="checkout.payment.paymentmethod"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="checkout.payment.selectpayment"/>.</td>
						<td  width="50%" valign="top" align="right"><b><bean:message key="checkout.payment.pleaseselect"/></b><br><img src="<%=kkEng.getImageBase()%>/arrow_east_south.gif" border="0" alt="" width="40" height="32"></td>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
					<logic:notEmpty name="orderMgr"  property="paymentDetailsArray">
						<logic:iterate id="pd" name="orderMgr"  property="paymentDetailsArray" type="com.konakart.appif.PaymentDetailsIf">
							<tr>
								<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								<td colspan="2">
									<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
										<tr class="moduleRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
											<td  colspan="3"><b><%=pd.getTitle()%></b></td>
											<td  align="right">
												<html:radio name="CheckoutForm" property="payment" value="<%=pd.getCode()%>"/>            
											</td>
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
										</tr>
									</table>
								</td>
								<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td> 
							</tr>
						</logic:iterate>											
					</logic:notEmpty>												
				</table>			
			</div>
			<%String dispCouponEntry = kkEng.getConfig("DISPLAY_COUPON_ENTRY");if (dispCouponEntry!=null && dispCouponEntry.equalsIgnoreCase("TRUE")) { %>
				<br/><b><bean:message key="checkout.common.couponcode"/></b>
				<div class="msg-box-no-pad">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td></textarea><html:text size="40" name="CheckoutForm" property="couponCode"/></td>
						</tr>
					</table>
				</div>
			<% } %>
			<%String dispGiftCertEntry = kkEng.getConfig("DISPLAY_GIFT_CERT_ENTRY");if (dispGiftCertEntry!=null && dispGiftCertEntry.equalsIgnoreCase("TRUE")) { %>				
				<br/><b><bean:message key="checkout.common.giftcertcode"/></b>
				<div class="msg-box-no-pad">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td></textarea><html:text size="40" name="CheckoutForm" property="giftCertCode"/></td>
						</tr>
					</table>
				</div>	
			<% } %>
			<%String dispPointsEntry = kkEng.getConfig("ENABLE_REWARD_POINTS");if (dispPointsEntry!=null && dispPointsEntry.equalsIgnoreCase("TRUE")) { %>
				<%int points = rewardPointMgr.pointsAvailable(); %>
				<%if  (points > 0) { %>
					<br/><b><bean:message key="checkout.common.reward_points" arg0="<%=String.valueOf(points)%>"/></b>
					<div class="msg-box-no-pad">
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<tr>
								<td></textarea><html:text size="40" name="CheckoutForm" property="rewardPoints"/></td>
							</tr>
						</table>
					</div>
				<% } %>
			<% } %>
			<br/><b><bean:message key="checkout.payment.addcomments"/></b>
			<div class="msg-box-no-pad">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><html:textarea name="CheckoutForm" property="comment"/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">
					<a style="float:right" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>
					<bean:message key="checkout.payment.continuecheckout"/>.
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
			<td width="25%">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
						<td><img src="<%=kkEng.getImageBase()%>/checkout_bullet.gif" border="0" alt="" width="11" height="11"></td>
						<td width="50%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
					</tr>
				</table>
			</td>
			<td width="25%"><img src="<%=kkEng.getImageBase()%>/pixel_silver.gif" border="0" alt="" width="100%" height="1"></td>
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
			<td align="center" width="25%" class="checkoutBarCurrent"><bean:message key="checkout.common.paymentinformation"/></td>
			<td align="center" width="25%" class="checkoutBarTo"><bean:message key="checkout.common.confirmation"/></td>
			<td align="center" width="25%" class="checkoutBarTo"><bean:message key="checkout.common.finished"/>!</td>
		</tr>
	</table>
</html:form>



