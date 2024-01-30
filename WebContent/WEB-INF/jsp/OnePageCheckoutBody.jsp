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
<script language="javascript" src="<%=kkEng.getStoreBase()%>/com.konakart.Konakart.nocache.6.3.0.0.8279.js"></script>

<table  border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100%" valign="top">         
		    <div id="nowloading" style="position:absolute;left:50%;top:50%"><img src="<%=kkEng.getImageBase()%>/loader.gif"/></div>      
			<div id="kk-OnePageCheckout"></div> 
		</td>
	</tr>
</table>
	<form id="kkLabelForm0" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="headingImageWidth" value="<%=kkEng.getHeadingImageWidth()%>">
		<input type="hidden" name="headingImageHeight" value="<%=kkEng.getHeadingImageHeight()%>">
		<input type="hidden" name="dispPriceWithTax" value="<%=kkEng.displayPriceWithTax()%>">
		<input type="hidden" name="locale" value="<%=kkEng.getLocale()%>">
		<input type="hidden" name="dispCoupon" value="<%=kkEng.getConfig("DISPLAY_COUPON_ENTRY")%>">
		<input type="hidden" name="dispGiftCert" value="<%=kkEng.getConfig("DISPLAY_GIFT_CERT_ENTRY")%>">
		<input type="hidden" name="language.dir" value="<bean:message key="language.dir"/>">
		<input type="hidden" name="exception.short.message" value="<bean:message key="exception.short.message"/>">
		<input type="hidden" name="exception.show.details" value="<bean:message key="exception.show.details"/>">
		<input type="hidden" name="exception.hide.details" value="<bean:message key="exception.hide.details"/>">
		<input type="hidden" name="common.close" value="<bean:message key="common.close"/>">
		<input type="hidden" name="common.back" value="<bean:message key="common.back"/>">
		<input type="hidden" name="common.continue" value="<bean:message key="common.continue"/>">
		<input type="hidden" name="images.folder" value="images">
		<input type="hidden" name="common.confirmorder" value="<bean:message key="common.confirmorder"/>">
		<input type="hidden" name="allowNoRegister" value="<%=kkEng.getConfig("ALLOW_CHECKOUT_WITHOUT_REGISTRATION")%>">
		<input type="hidden" name="one.page.checkout.register.error1" value="<bean:message key="one.page.checkout.register.error1"/>">
		<input type="hidden" name="one.page.checkout.register.error2" value="<bean:message key="one.page.checkout.register.error2"/>">
	</form>
	<form id="kkLabelForm1" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="checkout.confirmation.orderconfirmation" value="<bean:message key="checkout.confirmation.orderconfirmation"/>">
		<input type="hidden" name="show.order.details.body.deliveryaddress" value="<bean:message key="show.order.details.body.deliveryaddress"/>">
		<input type="hidden" name="common.edit" value="<bean:message key="common.edit"/>">
		<input type="hidden" name="show.order.details.body.shippingmethod" value="<bean:message key="show.order.details.body.shippingmethod"/>">
		<input type="hidden" name="show.order.details.body.products" value="<bean:message key="show.order.details.body.products"/>">
		<input type="hidden" name="show.order.details.body.tax" value="<bean:message key="show.order.details.body.tax"/>">
		<input type="hidden" name="show.order.details.body.total" value="<bean:message key="show.order.details.body.total"/>">
		<input type="hidden" name="show.order.details.body.billinginformation" value="<bean:message key="show.order.details.body.billinginformation"/>">
		<input type="hidden" name="show.order.details.body.billingaddress" value="<bean:message key="show.order.details.body.billingaddress"/>">
		<input type="hidden" name="show.order.details.body.paymentmethod" value="<bean:message key="show.order.details.body.paymentmethod"/>">
		<input type="hidden" name="checkout.common.couponcode" value="<bean:message key="checkout.common.couponcode"/>">
		<input type="hidden" name="checkout.common.giftcertcode" value="<bean:message key="checkout.common.giftcertcode"/>">
		<input type="hidden" name="checkout.confirmation.ordercomments" value="<bean:message key="checkout.delivery.addcomments"/>">
		<input type="hidden" name="common.confirmorder" value="<bean:message key="common.confirmorder"/>">
		<input type="hidden" name="one.page.checkout.update.coupon" value="<bean:message key="one.page.checkout.update.coupon"/>">
		<input type="hidden" name="one.page.checkout.update.giftcert" value="<bean:message key="one.page.checkout.update.giftcert"/>">
		<input type="hidden" name="one.page.checkout.update.points" value="<bean:message key="one.page.checkout.update.points"/>">
		<input type="hidden" name="one.page.checkout.no.payment.methods" value="<bean:message key="one.page.checkout.no.payment.methods"/>">
		<input type="hidden" name="one.page.checkout.no.shipping.methods" value="<bean:message key="one.page.checkout.no.shipping.methods"/>">
		<input type="hidden" name="one.page.checkout.no.shipping.methods.selected" value="<bean:message key="one.page.checkout.no.shipping.methods.selected"/>">
		<input type="hidden" name="one.page.checkout.no.payment.methods.selected" value="<bean:message key="one.page.checkout.no.payment.methods.selected"/>">
		<input type="hidden" name="use.checkout.order" value="<%=kkEng.getOrderMgr().isUseCheckoutOrder()%>">
		<%String dispPointsEntry = kkEng.getConfig("ENABLE_REWARD_POINTS");if (dispPointsEntry!=null && dispPointsEntry.equalsIgnoreCase("TRUE")) { %>
			<input type="hidden" name="checkout.common.reward_points" value="<bean:message key="checkout.common.reward_points" arg0="<%=String.valueOf(kkEng.getRewardPointMgr().pointsAvailable())%>"/>">
			<input type="hidden" name="reward.points.available" value="<%=kkEng.getRewardPointMgr().pointsAvailable()%>">
		<% } else { %>													
			<input type="hidden" name="checkout.common.reward_points" value="<bean:message key="checkout.common.reward_points" arg0="0"/>">
			<input type="hidden" name="reward.points.available" value="0">
		<% } %>
	</form>
	<form id="kkLabelForm2" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="login.body.email" value="<bean:message key="login.body.email"/>">
		<input type="hidden" name="login.body.password" value="<bean:message key="login.body.password"/>">
		<input type="hidden" name="login.body.forgotten.password" value="<bean:message key="login.body.forgotten.password"/>">
		<input type="hidden" name="login.body.login.error" value="<bean:message key="login.body.login.error"/>">
		<input type="hidden" name="login.body.invalid.email" value="<bean:message key="login.body.invalid.email"/>">
		<input type="hidden" name="forgotten.password.body.explanation1" value="<bean:message key="forgotten.password.body.explanation1"/>">
		<input type="hidden" name="forgotten.password.body.sentpw" value="<bean:message key="forgotten.password.body.sentpw"/>">
		<input type="hidden" name="login.body.welcome.email" value="<bean:message key="login.body.welcome.email"/>">
		<input type="hidden" name="login.body.welcome" value="<bean:message key="login.body.welcome"/>">
		<input type="hidden" name="forgotten.password.body.forgotten" value="<bean:message key="forgotten.password.body.forgotten"/>">
		<input type="hidden" name="ENTRY_EMAIL_ADDRESS_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_EMAIL_ADDRESS_MIN_LENGTH")%>">
		<input type="hidden" name="one.page.checkout.enter.email" value="<bean:message key="one.page.checkout.enter.email"/>">
		<input type="hidden" name="one.page.checkout.enter.password.login" value="<bean:message key="one.page.checkout.enter.password.login"/>">
		<input type="hidden" name="email.welcome.subject" value="<bean:message key="email.welcome.subject"/>">	
	</form>
	<form id="kkLabelForm3" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="register.customer.body.delivery.details" value="<bean:message key="register.customer.body.delivery.details"/>">
		<input type="hidden" name="ACCOUNT_GENDER" value="<%=kkEng.getConfig("ACCOUNT_GENDER")%>">
		<input type="hidden" name="ACCOUNT_DOB" value="<%=kkEng.getConfig("ACCOUNT_DOB")%>">
		<input type="hidden" name="ACCOUNT_COMPANY" value="<%=kkEng.getConfig("ACCOUNT_COMPANY")%>">
		<input type="hidden" name="ACCOUNT_SUBURB" value="<%=kkEng.getConfig("ACCOUNT_SUBURB")%>">
		<input type="hidden" name="ACCOUNT_STREET_ADDRESS_1" value="<%=kkEng.getConfig("ACCOUNT_STREET_ADDRESS_1")%>">
		<input type="hidden" name="ACCOUNT_STATE" value="<%=kkEng.getConfig("ACCOUNT_STATE")%>">
		<input type="hidden" name="ENTRY_FIRST_NAME_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_FIRST_NAME_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_LAST_NAME_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_LAST_NAME_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_DOB_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_DOB_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_STREET_ADDRESS_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_STREET_ADDRESS_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_STREET_ADDRESS1_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_STREET_ADDRESS1_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_COMPANY_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_COMPANY_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_POSTCODE_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_POSTCODE_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_CITY_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_CITY_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_STATE_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_STATE_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_TELEPHONE_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_TELEPHONE_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_PASSWORD_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_PASSWORD_MIN_LENGTH")%>">
		<input type="hidden" name="ENTRY_EMAIL_ADDRESS_MIN_LENGTH" value="<%=kkEng.getConfig("ENTRY_EMAIL_ADDRESS_MIN_LENGTH")%>">
		<input type="hidden" name="STORE_COUNTRY" value="<%=kkEng.getConfig("STORE_COUNTRY")%>">
		<input type="hidden" name="one.page.checkout.shipping.address" value="<bean:message key="one.page.checkout.shipping.address"/>">
		<input type="hidden" name="one.page.checkout.billing.address" value="<bean:message key="one.page.checkout.billing.address"/>">
		<input type="hidden" name="register.customer.body.gender" value="<bean:message key="register.customer.body.gender"/>">
		<input type="hidden" name="register.customer.body.male" value="<bean:message key="register.customer.body.male"/>">
		<input type="hidden" name="register.customer.body.female" value="<bean:message key="register.customer.body.female"/>">
		<input type="hidden" name="register.customer.body.first.name" value="<bean:message key="register.customer.body.first.name"/>">
		<input type="hidden" name="register.customer.body.last.name" value="<bean:message key="register.customer.body.last.name"/>">
		<input type="hidden" name="register.customer.body.dob" value="<bean:message key="register.customer.body.dob"/>">
		<input type="hidden" name="register.customer.body.company.name" value="<bean:message key="register.customer.body.company.name"/>">
		<input type="hidden" name="register.customer.body.street.addr" value="<bean:message key="register.customer.body.street.addr"/>">
		<input type="hidden" name="register.customer.body.street.addr1" value="<bean:message key="register.customer.body.street.addr1"/>">
		<input type="hidden" name="register.customer.body.suburb" value="<bean:message key="register.customer.body.suburb"/>">
		<input type="hidden" name="register.customer.body.postcode" value="<bean:message key="register.customer.body.postcode"/>">
		<input type="hidden" name="register.customer.body.city" value="<bean:message key="register.customer.body.city"/>">
		<input type="hidden" name="register.customer.body.state" value="<bean:message key="register.customer.body.state"/>">
		<input type="hidden" name="register.customer.body.country" value="<bean:message key="register.customer.body.country"/>">
		<input type="hidden" name="register.customer.body.tel.number" value="<bean:message key="register.customer.body.tel.number"/>">
		<input type="hidden" name="register.customer.body.tel.number1" value="<bean:message key="register.customer.body.tel.number1"/>">
		<input type="hidden" name="register.customer.body.fax.number" value="<bean:message key="register.customer.body.fax.number"/>">
		<input type="hidden" name="register.customer.body.password" value="<bean:message key="register.customer.body.password"/>">
		<input type="hidden" name="register.customer.body.confirm.password" value="<bean:message key="register.customer.body.confirm.password"/>">
		<input type="hidden" name="register.customer.body.required.info" value="<bean:message key="register.customer.body.required.info"/>">
		<input type="hidden" name="register.customer.body.delivery.details" value="<bean:message key="register.customer.body.delivery.details"/>">
		<input type="hidden" name="register.customer.body.select" value="<bean:message key="register.customer.body.select"/>">
		<input type="hidden" name="login.body.email" value="<bean:message key="login.body.email"/>">
	 </form>
	 <form id="kkLabelForm4" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="one.page.checkout.choose.shipping.address" value="<bean:message key="one.page.checkout.choose.shipping.address"/>">
		<input type="hidden" name="one.page.checkout.choose.billing.address" value="<bean:message key="one.page.checkout.choose.billing.address"/>">
		<input type="hidden" name="change.payment.address.body.selectaddr" value="<bean:message key="change.payment.address.body.selectaddr"/>">
		<input type="hidden" name="change.delivery.address.body.selectaddr" value="<bean:message key="change.delivery.address.body.selectaddr"/>">
		<input type="hidden" name="change.payment.address.body.pleaseselect" value="<bean:message key="change.payment.address.body.pleaseselect"/>">
		<input type="hidden" name="one.page.checkout.insert.address" value="<bean:message key="one.page.checkout.insert.address"/>">
	 </form>
	 <form id="kkLabelForm5" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="one.page.checkout.enter.your.address.details" value="<bean:message key="one.page.checkout.enter.your.address.details"/>">
	 </form>
	 <form id="kkLabelForm6" action="http://somesite.com/prog/adduser" method="post">
		<input type="hidden" name="register.customer.body.passwords.no.match" value="<bean:message key="register.customer.body.passwords.no.match"/>">
		<input type="hidden" name="one.page.checkout.enter.password" value="<bean:message key="one.page.checkout.enter.password"/>">
		<input type="hidden" name="one.page.checkout.enter.shipping.address" value="<bean:message key="one.page.checkout.enter.shipping.address"/>">
	 </form>
