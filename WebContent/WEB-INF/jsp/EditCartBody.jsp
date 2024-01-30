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
<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
<bean:define id="currentCustomer" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr" />
<bean:define id="orderMgr" name="kkEng" property="orderMgr" type="com.konakart.al.OrderMgr"/>
<bean:define id="rewardPointMgr" name="kkEng" property="rewardPointMgr" type="com.konakart.al.RewardPointMgr"/>


<script type="text/javascript"><!--
	function setGoToCheckout() {
		document.EditCartForm.goToCheckout.value="true";
		//alert(document.EditCartForm.goToCheckout.value);
	}

	function resetGoToCheckout() {
		document.EditCartForm.goToCheckout.value="false";
		//alert(document.EditCartForm.goToCheckout.value);
	}

	function isNumber(field) {
		var re = /^[0-9]*$/;
		if (!re.test(field.value)) {
		var msg = "<bean:message key="errors.integer" arg0='"+field.value+"' />";
		alert(msg);
		field.value = field.value.substring(0,field.value.length-1);
		}
		maxQuantity(field);
	}

	function maxQuantity(field) {
		var re = /^[0-9]*$/;
        var maxQ = 10000;
		if (field.value > maxQ) {
		var msg = "<bean:message key="errors.range" arg0='"+field.value+"' arg1="0" arg2='"+maxQ+"'/>";
		alert(msg);
		field.value = 1;
		}
	}

//--></script>
<html:form action="/EditCartSubmit.do" styleId="form1">  
	<html:hidden name="EditCartForm" property="goToCheckout" value=""/>
	<% boolean outOfStock=false; %>	
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_cart.gif" border="0" alt="<bean:message key="edit.cart.body.whatsincart"/>" title=" <bean:message key="edit.cart.body.whatsincart"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="edit.cart.body.whatsincart"/>
		 </div>
		<div class="body-content-div">
			<logic:empty  property="itemList" name="EditCartForm">
				<div class="msg-box"><bean:message key="edit.cart.body.emptycart"/></div>
			</logic:empty>
			<logic:notEmpty property="itemList" name="EditCartForm">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="productListing">
					<tr>
						<td align="center" class="productListing-heading"><bean:message key="edit.cart.body.remove"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.cart.body.products"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.cart.body.quantity"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.cart.body.total"/></td>
					</tr>	
					<% int i=2; %>	
					<nested:iterate id="item" property="itemList" name="EditCartForm" type="com.konakart.al.CartItem">
					<%if (i%2==0) { %>
						<tr class="productListing-even">
					<%} else { %>
						<tr class="productListing-odd">
					<%}%>
							<td align="center" class="productListing-data" valign="top">
								<nested:checkbox property="remove"/>
							</td>
								<td class="productListing-data">
									<table border="0" cellspacing="2" cellpadding="2">  
										<tr>    
											<td class="productListing-data" align="center">
												<html:link page="/SelectProd.do" paramId="prodId" paramName="item" paramProperty="prodId"><img src="<%=kkEng.getImageBase()%>/<%=item.getProdImage()%>" border="0" alt="<%=item.getProdName()%>" title=" <%=item.getProdName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>"></html:link>
											</td>    
											<td class="productListing-data" valign="top">
												<html:link page="/SelectProd.do" paramId="prodId" paramName="item" paramProperty="prodId"><b><%=item.getProdName()%></b></html:link>
												<logic:equal property="inStock" name="item" value="false">
													<logic:notEmpty name="prodMgr" property="STOCK_CHECK">
														<span class="markProductOutOfStock">***</span>
														<% outOfStock=true; %>
													</logic:notEmpty>
												</logic:equal> 
												<logic:notEmpty property="optNameArray" name="item" >
													<logic:iterate id="optName" property="optNameArray" name="item" >
														<br><small><i> - <%=optName%></i></small>
													</logic:iterate>
												</logic:notEmpty> 
											</td>  
										</tr>
									</table>
								</td>
								<td align="center" class="productListing-data" valign="top">
									<nested:text property="quantity" size="4" onkeyup="isNumber(this)"/>	
								</td>
								<logic:notEmpty name="item" property="totalPriceIncTax">
									<nested:define id="totalPriceIncTax" property="totalPriceIncTax" type="java.math.BigDecimal"/>
									<%if (kkEng.displayPriceWithTax()){%>
										<td align="right" class="productListing-data" valign="top"><b><%=kkEng.formatPrice(totalPriceIncTax)%></b></td>
									<%}%>		    																		
								</logic:notEmpty>
								<logic:notEmpty name="item" property="totalPriceExTax">
									<nested:define id="totalPriceExTax" property="totalPriceExTax" type="java.math.BigDecimal"/>
									<%if (!kkEng.displayPriceWithTax()){%>
										<td align="right" class="productListing-data" valign="top"><b><%=kkEng.formatPrice(totalPriceExTax)%></b></td>
									<%}%>		    																		
								</logic:notEmpty>
							</tr>											
						<% i++; %>	
					</nested:iterate>	
				</table>

			<logic:notEmpty  property="checkoutOrder" name="orderMgr">
				<bean:define id="order" name="orderMgr" property="checkoutOrder" type="com.konakart.appif.OrderIf"/>
				<logic:notEmpty  property="orderTotals" name="order">
					<table width="100%">
						<logic:iterate id="ot" name="order" property="orderTotals" type="com.konakart.appif.OrderTotalIf">
							<%if (ot.getClassName().equals("ot_reward_points")){%>
								<tr><td width="60%"></td> <td   class="productListing-data"><b><%=ot.getTitle()%></b></td><td align="right" class="productListing-data"><b><%=ot.getValue()%></b></td></tr>
							<%}else if (ot.getClassName().equals("ot_free_product")){%>
								<tr><td width="60%"></td> <td   class="productListing-data"><b><%=ot.getTitle()%></b></td><td align="right" class="productListing-data"><b><%=ot.getText()%></b></td></tr>
							<%}else{%>
								<tr><td width="60%"></td> <td   class="productListing-data"><b><%=ot.getTitle()%></b></td><td align="right" class="productListing-data"><b><%=kkEng.formatPrice(ot.getValue())%></b></td></tr>
							<%}%>		    																		
						</logic:iterate>
					</table>
				</logic:notEmpty>
			</logic:notEmpty>
			<logic:empty  property="checkoutOrder" name="orderMgr">
				<p align="right"><b><bean:message key="edit.cart.body.subtotal"/>:&nbsp;<%=kkEng.getBasketMgr().getBasketTotal()%></b></p>
			</logic:empty>
			
			<%String dispCouponEntry = kkEng.getConfig("DISPLAY_COUPON_ENTRY");if (dispCouponEntry!=null && dispCouponEntry.equalsIgnoreCase("TRUE")) { %>				
				<br/><b><bean:message key="checkout.common.couponcode"/></b>
				<div class="msg-box-no-pad">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td><html:text size="40" name="EditCartForm" property="couponCode"/></td><td><bean:message key="edit.cart.body.coupon"/></td>
						</tr>
					</table>
				</div>	
			<% } %>
			<%String dispGiftCertEntry = kkEng.getConfig("DISPLAY_GIFT_CERT_ENTRY");if (dispGiftCertEntry!=null && dispGiftCertEntry.equalsIgnoreCase("TRUE")) { %>				
				<br/><b><bean:message key="checkout.common.giftcertcode"/></b>
				<div class="msg-box-no-pad">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td><html:text size="40" name="EditCartForm" property="giftCertCode"/></td><td><bean:message key="edit.cart.body.giftcert"/></td>
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
								<td><html:text size="40" name="EditCartForm" property="rewardPoints"/></td><td><bean:message key="edit.cart.body.points"/></td>
							</tr>
						</table>
					</div>	
				<% } %>
			<% } %>
	
			<logic:notEmpty name="prodMgr" property="STOCK_CHECK">
				<%if (outOfStock) { %>
					<logic:notEmpty name="prodMgr" property="STOCK_ALLOW_CHECKOUT">
						<p align="center"><span class="stockWarning"><br><bean:message key="edit.cart.body.outofstock"/></span></p>
					</logic:notEmpty>
					<logic:empty name="prodMgr" property="STOCK_ALLOW_CHECKOUT">
						<p align="center"><span class="stockWarning"><br><bean:message key="edit.cart.body.outofstock.error"/></span></p>
					</logic:empty>
				<%}%>
			</logic:notEmpty>
		</div>
	</div>		
	<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<a style="float:right" onmouseover="setGoToCheckout()" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.checkout"/></span></a>
				<a onmouseover="resetGoToCheckout()" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="edit.cart.body.updatecart"/></span></a>
				<html:link page="/Welcome.do">
					<span style="margin-left: 20px;" class="button"><span><bean:message key="edit.cart.body.continue.shopping"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
	</div> 	
	</logic:notEmpty>				
</html:form>
