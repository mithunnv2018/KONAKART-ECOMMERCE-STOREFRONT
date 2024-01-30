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
<bean:define id="pd" name="order" property="paymentDetails" type="com.konakart.appif.PaymentDetailsIf"/>

<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery-1.7.2.min.js"></script>

<script type="text/javascript">

$(function() {
	$('#waitImg').hide();
});

function submit(){
		$('#continueBtn').hide();
		$('#waitImg').fadeIn();
		document.forms['form1'].submit();
}
</script>

<html:form action="/CheckoutServerPaymentSubmit.do" styleId="form1">  
			<%
				com.konakart.forms.CreditCardForm myForm = (com.konakart.forms.CreditCardForm) request.getAttribute("CreditCardForm"); 
				if (myForm != null){
					myForm.setOwner(order.getCustomerName());
					myForm.setPostcode(order.getBillingPostcode());
					myForm.setStreetAddress(order.getBillingStreetAddress());
				}				
			%>
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_payment.gif" border="0" alt="<bean:message key="checkout.cc.payment"/>" title=" <bean:message key="checkout.cc.payment"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="checkout.cc.payment"/>
		 </div>
		<div class="body-content-div">
			<logic:messagesPresent> 
				<ul>
					<html:messages id="error">
						<li class="messageStackError">
							<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>
			<b><bean:message key="checkout.cc.ccdetails"/></b>
			 <div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<logic:notEmpty name="order" property="orderTotals">
							<logic:iterate id="ot" name="order" property="orderTotals" type="com.konakart.appif.OrderTotalIf">
									<%if (ot.getClassName() != null && ot.getClassName().equals("ot_total")) {%>
										<%if (kkEng.getDefaultCurrency().getCode().equals(kkEng.getUserCurrency().getCode())){%>
											<td  align="left" valign="top"><bean:message key="checkout.cc.explanation" arg0="<%=kkEng.formatPrice(ot.getValue())%>"/>.</td>
										<%} else {%>
											<td  align="left" valign="top"><bean:message key="checkout.cc.explanation.other.currency" arg0="<%=kkEng.formatPrice(ot.getValue())%>" arg1="<%=kkEng.formatPrice(ot.getValue(), order.getCurrency().getCode())%>" />.</td>
										<%}%>
									<%}%>
							</logic:iterate>
						</logic:notEmpty>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>										
			 </div>
			 </br>
			 <div class="msg-box">
				<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
				<%if (pd.isShowType()) {%>
					<tr>
						<td ><bean:message key="checkout.cc.type"/>:</td>
						<td >
							<html:select name="CreditCardForm" property="type">
								<html:option value="visa">Visa</html:option><html:option value="mastercard">Mastercard</html:option><html:option value="amex">American Express</html:option><html:option value="diners">Diners</html:option>
							</html:select>
						</td>
						<td/>
					</tr>
				<%}%>
				<%if (pd.isShowOwner()) {%>
					<tr>
						<td ><bean:message key="checkout.cc.ccowner"/>:</td>
						<td ><html:text name="CreditCardForm" property="owner"/></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.ccowner.exp"/>." title="<bean:message key="checkout.cc.ccowner.exp"/>."></td>
					</tr>
				<%}else{%>
						<html:hidden name="CreditCardForm" property="owner" value="aaaaaa"/>
				<%}%>
					<tr>
						<td ><bean:message key="checkout.cc.number"/>:</td>
						<td ><html:text name="CreditCardForm" property="number"/></td>
						<td/>
					</tr>
					<tr>
						<td ><bean:message key="checkout.cc.expiry"/>:</td>	
						<td >
							<html:select name="CreditCardForm" property="expiryMonth">
								<html:option value="01"><bean:message key="common.jan"/></html:option><html:option value="02"><bean:message key="common.feb"/></html:option><html:option value="03"><bean:message key="common.mar"/></html:option><html:option value="04"><bean:message key="common.apr"/></html:option><html:option value="05"><bean:message key="common.may"/></html:option><html:option value="06"><bean:message key="common.jun"/></html:option><html:option value="07"><bean:message key="common.jul"/></html:option><html:option value="08"><bean:message key="common.aug"/></html:option><html:option value="09"><bean:message key="common.sep"/></html:option><html:option value="10"><bean:message key="common.oct"/></html:option><html:option value="11"><bean:message key="common.nov"/></html:option><html:option value="12"><bean:message key="common.dec"/></html:option>
							</html:select>&nbsp;														
							<html:select name="CreditCardForm" property="expiryYear">													
								<html:option value="12">2012</html:option><html:option value="13">2013</html:option><html:option value="14">2014</html:option><html:option value="15">2015</html:option><html:option value="16">2016</html:option><html:option value="17">2017</html:option><html:option value="18">2018</html:option><html:option value="19">2019</html:option>									
							</html:select>
						</td>
						<td/>
					</tr>
					<%if (pd.isShowCVV()) {%>
					<tr>
						<td ><bean:message key="checkout.cc.cvv"/>:</td>
						<td ><html:text name="CreditCardForm" property="cvv"/></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.cvv.exp"/>." title="<bean:message key="checkout.cc.cvv.exp"/>."></td>
					</tr>
					<%}else{%>
						<html:hidden name="CreditCardForm" property="cvv" value="1"/>
					<%}%>
					<%if (pd.isShowPostcode()) {%>
					<tr>
						<td ><bean:message key="checkout.cc.postcode"/>:</td>
						<td ><html:text name="CreditCardForm" property="postcode"/></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.postcode.exp"/>." title="<bean:message key="checkout.cc.postcode.exp"/>."></td>
					</tr>
					<%}else{%>
						<html:hidden name="CreditCardForm" property="postcode" value="111111"/>
					<%}%>
					<%if (pd.isShowAddr()) {%>
					<tr>
						<td ><bean:message key="checkout.cc.streetAddress"/>:</td>
						<td ><html:text name="CreditCardForm" property="streetAddress"/></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.streetAddress.exp"/>." title="<bean:message key="checkout.cc.streetAddress.exp"/>."></td>
					</tr>
					<%}else{%>
						<html:hidden name="CreditCardForm" property="streetAddress" value="aaaaaa"/>
					<%}%>
				</table> 
			 </div>
			 </br>
			 <div class="msg-box">
				 <bean:message key="checkout.cc.continueinstructions"/>.
			 </div>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">
				    <img src="<%=kkEng.getImageBase()%>/confirm_wait.gif" border="0" alt="" style="float:right" id="waitImg">
					<a style="float:right" onclick="javascript:submit();" class="button" id="continueBtn"><span><bean:message key="common.continue"/></span></a>
					<html:link page="/CheckoutDelivery.do">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 	
</html:form>

