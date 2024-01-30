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
		<logic:notEmpty name="currentCustomer" property="wishLists">
			<bean:define id="wishLists" name="currentCustomer" property="wishLists"/>				
			<%boolean weHaveData = false;%>
			<logic:iterate id="wishList" name="wishLists" type="com.konakart.appif.WishListIf">
				<%if (wishList.getListType()== com.konakart.al.WishListMgr.WISH_LIST_TYPE && wishList.getWishListItems()!= null && wishList.getWishListItems().length > 0){%>
					<%weHaveData = true;%>
				<%}%>
 			</logic:iterate>		
			<%if (weHaveData){%>
				<div class="tile">
					<div class="wishlist-tile">
						<!--- box border -->
						<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
						<!-- -->
						<div class="tile-header">
							<html:link page="/ShowWishListItems.do"><img src="<%=kkEng.getImageBase()%>/icons/wishlist.png" border="0" alt="<bean:message key="common.more"/>" title=" <bean:message key="common.more"/>"></html:link>
							<bean:message key="wishlist.tile.wishlist"/>
						</div>
						<div class="tile-content" align="left">
							<p>						
							<logic:iterate id="wishList" name="wishLists" type="com.konakart.appif.WishListIf">
								<%if (wishList.getListType()== com.konakart.al.WishListMgr.WISH_LIST_TYPE){%>
									<logic:notEmpty name="wishList" property="wishListItems">
										<bean:define id="items" name="wishList" property="wishListItems"/>		
										<table class="tile-content">
										<logic:iterate id="item" name="items" type="com.konakart.appif.WishListItemIf">
											<logic:notEmpty name="item" property="product">		
												<bean:define id="product" name="item" property="product" type="com.konakart.appif.ProductIf"/>
												<tr>
												<td><img src="<%=kkEng.getImageBase()%>/<%=item.getProduct().getImage()%>" border="0" width="30" height="24"></td>
												<td><html:link page="/SelectProd.do" paramId="prodId" paramName="product" paramProperty="id"><%=item.getProduct().getName()%></html:link></td>
												</tr>
											</logic:notEmpty>
										</logic:iterate>
										</table>
										<img src="<%=kkEng.getImageBase()%>/pixel_black.gif" border="0" alt="" width="100%" height="1">
										<%if (kkEng.displayPriceWithTax()){%>
											<p align="right"><%=kkEng.formatPrice(wishList.getFinalPriceIncTax())%></p>
										<%}else{%>
											<p align="right"><%=kkEng.formatPrice(wishList.getFinalPriceExTax())%></p>
										<%}%>		    																											
									</logic:notEmpty>
								<%}%>
							</logic:iterate>
							</p>
						</div>
						<!--- end of box border -->
						</div></div></div></div></div></div></div></div>
						<!-- -->
					</div>
				</div>
			<%}%>
		</logic:notEmpty>	
	</logic:notEmpty>
</logic:notEmpty>

