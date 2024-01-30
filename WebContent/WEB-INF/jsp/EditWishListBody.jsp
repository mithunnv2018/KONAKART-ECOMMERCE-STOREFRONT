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

<html:form action="/EditWishListSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_cart.gif" border="0" alt="<bean:message key="edit.wishlist.body.whatsinwishlist"/>" title=" <bean:message key="edit.wishlist.body.whatsinwishlist"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="edit.wishlist.body.whatsinwishlist"/>
		 </div>
		<div class="body-content-div">
			<logic:empty  property="itemList" name="EditWishListForm">
				<div class="msg-box"><bean:message key="edit.wishlist.body.emptywishlist"/></div>
			</logic:empty>
			<logic:notEmpty property="itemList" name="EditWishListForm">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="productListing">
					<tr>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.remove"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.addtocart"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.products"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.priority"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.total"/></td>
					</tr>	
					<% int i=2; %>	
					<nested:iterate id="item" property="itemList" name="EditWishListForm" type="com.konakart.al.WishListUIItem">
					<%if (i%2==0) { %>
						<tr class="productListing-even">
					<%} else { %>
						<tr class="productListing-odd">
					<%}%>
							<td align="center" class="productListing-data" valign="top">
								<nested:checkbox property="remove"/>
							</td>
							<td align="center" class="productListing-data" valign="top">
								<nested:checkbox property="addToBasket"/>
							</td>
								<td class="productListing-data">
									<table border="0" cellspacing="2" cellpadding="2">  
										<tr>    
											<td class="productListing-data" align="center">
												<html:link page="/SelectProd.do" paramId="prodId" paramName="item" paramProperty="prodId"><img src="<%=kkEng.getImageBase()%>/<%=item.getProdImage()%>" border="0" alt="<%=item.getProdName()%>" title=" <%=item.getProdName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>"></html:link>
											</td>    
											<td class="productListing-data" valign="top">
												<html:link page="/SelectProd.do" paramId="prodId" paramName="item" paramProperty="prodId"><b><%=item.getProdName()%></b></html:link>
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
									<nested:select  property="priority" >
										<html:option key="common.highest" value="5"></html:option>
										<html:option key="common.high" value="4"></html:option>
										<html:option key="common.medium" value="3"></html:option>
										<html:option key="common.low" value="2"></html:option>
										<html:option key="common.lowest" value="1"></html:option>
									</nested:select>
								</td>
								<nested:define id="totalPriceIncTax" property="totalPriceIncTax" type="java.math.BigDecimal"/>
								<nested:define id="totalPriceExTax" property="totalPriceExTax" type="java.math.BigDecimal"/>
								<%if (kkEng.displayPriceWithTax()){%>
									<td align="right" class="productListing-data" valign="top"><b><%=kkEng.formatPrice(totalPriceIncTax)%></b></td>
								<%}else{%>
									<td align="right" class="productListing-data" valign="top"><b><%=kkEng.formatPrice(totalPriceExTax)%></b></td>
								<%}%>		    																		
							</tr>											
						<% i++; %>	
					</nested:iterate>	
				</table>	
				<table width="100%">						
					<%if (kkEng.displayPriceWithTax()){%>
						<logic:notEmpty property="finalPriceIncTax" name="EditWishListForm">
							<bean:define id="finalPriceIncTax" name="EditWishListForm" property="finalPriceIncTax" type="java.math.BigDecimal"/>
							<tr><td width="60%"></td> <td   class="productListing-data"><b><bean:message key="common.total"/>:</b></td><td class="productListing-data"><b><%=kkEng.formatPrice(finalPriceIncTax)%></b></td></tr>
						</logic:notEmpty>
					<%}else{%>
						<logic:notEmpty property="finalPriceExTax" name="EditWishListForm">
							<bean:define id="finalPriceExTax" name="EditWishListForm" property="finalPriceExTax" type="java.math.BigDecimal"/>
							<tr><td width="60%"></td> <td   class="productListing-data"><b><bean:message key="common.total"/>:</b></td><td class="productListing-data"><b><%=kkEng.formatPrice(finalPriceExTax)%></b></td></tr>
						</logic:notEmpty>
					<%}%>		    																		
				</table>
		</div>
	</div>		
	<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<html:link page="/Welcome.do">
					<span style="float:right" class="button"><span><bean:message key="edit.cart.body.continue.shopping"/></span></span>
				</html:link>
				<a onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="edit.wishlist.body.updatewishlist"/></span></a>
			</div>
		</div></div></div></div></div></div></div></div>
	</div> 	
	</logic:notEmpty>				
</html:form>
