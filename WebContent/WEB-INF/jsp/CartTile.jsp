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
<%@ taglib uri="/tags/app" prefix="app" %>
<%@ taglib uri="/tags/struts-layout" prefix="layout" %>

<logic:notEmpty name="konakartKey">
	<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
	<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
	<logic:notEmpty name="customerMgr" property="currentCustomer">	
		<bean:define id="currentCustomer" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
	</logic:notEmpty>
	<div class="tile">
		<div class="cart-tile">
			<!--- box border -->
			<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
			<!-- -->
			<div class="tile-header">
				<html:link page="/ShowCartItems.do"><img src="<%=kkEng.getImageBase()%>/icons/cart_16x16.png" border="0" alt="<bean:message key="common.more"/>" title=" <bean:message key="common.more"/>"></html:link>
				<bean:message key="cart.tile.shoppingcart"/>
			</div>
			<div class="tile-content" align="left">
				<p>
					<logic:empty name="customerMgr" property="currentCustomer">				 	
						<bean:message key="cart.tile.zeroitems"/>
					</logic:empty>
					<logic:notEmpty name="customerMgr" property="currentCustomer">				 	
						<logic:empty name="currentCustomer" property="basketItems">
							<bean:message key="cart.tile.zeroitems"/>
						</logic:empty>
						<logic:notEmpty name="currentCustomer" property="basketItems">
							<bean:define id="basketItems" name="currentCustomer" property="basketItems"/>	
							<table class="tile-content">
								<logic:iterate id="item" name="basketItems" type="com.konakart.appif.BasketIf">
									<logic:notEmpty name="item" property="product">		
										<bean:define id="product" name="item" property="product" type="com.konakart.appif.ProductIf"/>
										<tr>
											<td><%=item.getQuantity()%>&nbsp;x&nbsp;</td>
											<td><html:link page="/SelectProd.do" paramId="prodId" paramName="product" paramProperty="id"><%=item.getProduct().getName()%></html:link></td>
										</tr>
									</logic:notEmpty>
								</logic:iterate>
							</table>
							<img src="<%=kkEng.getImageBase()%>/pixel_black.gif" border="0" alt="" width="100%" height="1">
							<p align="right"><%=kkEng.getBasketMgr().getBasketTotal()%></p> 
						</logic:notEmpty>
					</logic:notEmpty>
				</p>
			</div>
			<!--- end of box border -->
			</div></div></div></div></div></div></div></div>
			<!-- -->
		</div>
	</div>	
</logic:notEmpty>

