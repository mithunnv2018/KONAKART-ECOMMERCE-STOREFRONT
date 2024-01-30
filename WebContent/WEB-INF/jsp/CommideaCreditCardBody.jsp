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
<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.validate.min.js"></script>

<script type="text/javascript">

$(function() {
	$('#waitImg').hide();
});

jQuery.validator.messages = {
	required: '<bean:message key="jquery.validator.required"/>',
	creditcard: '<bean:message key="jquery.validator.creditcard"/>',
	digits: '<bean:message key="jquery.validator.digits"/>',
	maxlength: jQuery.validator.format('<bean:message key="jquery.validator.maxlength"/> {0} <bean:message key="jquery.validator.maxlength1"/>'),
	minlength: jQuery.validator.format('<bean:message key="jquery.validator.minlength"/> {0} <bean:message key="jquery.validator.minlength1"/>'),
	expirydate: '<bean:message key="jquery.validator.expiryMMYY"/>'
};

jQuery.validator.addMethod("expiry", function(exp_date, element) {
	return this.optional(element) || 
	exp_date.match(/^((0[1-9])|(1[0-2]))(\d{2})$/);	
}, '<bean:message key="jquery.validator.expiryMMYY"/>');	

function validate(){
	var val = $("#form1").validate({
		errorPlacement: function(error, element) {
			error.appendTo( element.parent("td").next("td").next("td"));
  		}	
	}).form();
	if (val) {
		$('#continueBtn').hide();
		$('#waitImg').fadeIn();
		document.forms['form1'].submit();
	}
}
</script>



<form id="form1" action="<%=pd.getCustom4()%>" method="post" autocomplete="off">
 	<input type="hidden" name="sessionguid" value="<%=(pd.getCustom1().split(";"))[0]%>">
 	<input type="hidden" name="sessionpasscode" value="<%=pd.getCustom2()%>">
 	<input type="hidden" name="processingdb" value="<%=(pd.getCustom1().split(";"))[1]%>">
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
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="pan"><bean:message key="checkout.cc.number"/>:</label></td>
						<td ><input size="30" type="text" name="pan" id="pan" class="required creditcard" ></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="expirydate"><bean:message key="checkout.cc.expiry"/> (MMYY):</label></td>	
						<td ><input size="30" type="text" name="expirydate" id="expirydate" class="required expiry" ></td>						
						<td></td>
						<td></td>
					</tr>
					<%if (pd.isShowCVV()) {%>
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="csc"><bean:message key="checkout.cc.cvv"/>:</label></td>
						<td ><input size="30" type="text" name="csc" id="csc" class="required digits" minlength="3" maxlength="4" ></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.cvv.exp"/>." title="<bean:message key="checkout.cc.cvv.exp"/>."></td>
						<td></td>
					</tr>
					<%}%>
					
					<%if (pd.isShowOwner()) {%>
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="cardholdername"><bean:message key="checkout.cc.ccowner"/>:</label></td>
						<td ><input size="30" type="text" name="cardholdername" id="cardholdername" class="required" value="<%=order.getCustomerName()%>"></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.ccowner.exp"/>." title="<bean:message key="checkout.cc.ccowner.exp"/>."></td>
						<td></td>
					</tr>
					<%}else{%>
						<input type="hidden" name="cardholdername" value="<%=order.getCustomerName()%>">
					<%}%>
					<%if (pd.isShowPostcode()) {%>
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="postcode"><bean:message key="checkout.cc.postcode"/>:</label></td>
						<td ><input size="30" type="text" name="postcode" id="postcode" class="required" value="<%=order.getBillingPostcode()%>"></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.postcode.exp"/>." title="<bean:message key="checkout.cc.postcode.exp"/>."></td>
						<td></td>
					</tr>
					<%}else{%>
						<input type="hidden" name="postcode" value="<%=order.getBillingPostcode()%>">
					<%}%>
					<%if (pd.isShowAddr()) {%>
					<tr>
						<td style="white-space: nowrap; width: 160px"><label for="address1"><bean:message key="checkout.cc.streetAddress"/>:</label></td>
						<td ><input size="30" type="text" name="address1" id="address1" class="required" value="<%=order.getBillingStreetAddress()%>"></td>
						<td  valign="middle" align="left"><img src="<%=kkEng.getImageBase()%>/icons/qmark.jpg" border="0" alt="<bean:message key="checkout.cc.streetAddress.exp"/>." title="<bean:message key="checkout.cc.streetAddress.exp"/>."></td>
						<td></td>
					</tr>
					<%}else{%>
						<input type="hidden" name="address1" value="<%=order.getBillingStreetAddress()%>">
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
					<a style="float:right" onclick="javascript:validate();" class="button" id="continueBtn"><span><bean:message key="common.continue"/></span></a>
					<html:link page="/CheckoutDelivery.do">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 	
</form>

