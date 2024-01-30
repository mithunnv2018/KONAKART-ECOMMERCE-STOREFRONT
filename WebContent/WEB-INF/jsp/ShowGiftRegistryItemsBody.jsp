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
<bean:define id="wishListMgr" name="kkEng" property="wishListMgr" type="com.konakart.al.WishListMgr"/>

<!-- Messages -->
<bean:define id="sortItemsByPriority"><bean:message key="edit.wishlist.body.sort.by.priority"/></bean:define>


<html:form action="/GiftRegistryListSubmit.do" styleId="form1">  
	<%
		// Get the form
		com.konakart.forms.EditWishListForm myForm = (com.konakart.forms.EditWishListForm) session.getAttribute("EditWishListForm"); 	
	%>		

	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_cart.gif" border="0" alt="<bean:message key="show.giftregistry.items.body.whatsinweddinglist"/>" title=" <bean:message key="show.giftregistry.items.body.whatsinweddinglist"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<%=myForm.getListName()%>
		 </div>
		<div class="body-content-div">
			<logic:empty  property="itemList" name="EditWishListForm">
				<div class="msg-box"><bean:message key="show.giftregistry.items.body.empty.weddinglist"/></div>
			</logic:empty>
			<logic:notEmpty property="itemList" name="EditWishListForm">
				<table>
					<tr>
						<td>		
							<bean:message key="show.giftregistry.items.body.instructions"/><br>
						</td>
					</tr>
				</table>	
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="productListing">
					<tr>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.addtocart"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.products"/></td>
						<td align="center" class="productListing-heading">
							<html:link page="/SortGiftRegistryItems.do" paramId="orderBy" paramName="wishListMgr" paramProperty="obPriority" title="<%=sortItemsByPriority%>" styleClass="productListing-heading"><bean:message key="edit.wishlist.body.priority"/></html:link>&nbsp;
						</td>			
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.q.desired"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.q.received"/></td>
						<td align="center" class="productListing-heading"><bean:message key="edit.wishlist.body.price"/></td>
					</tr>	
					<% int i=2; %>	
					<nested:iterate id="item" property="itemList" name="EditWishListForm" type="com.konakart.al.WishListUIItem">
					<%if (i%2==0) { %>
						<tr class="productListing-even">
					<%} else { %>
						<tr class="productListing-odd">
					<%}%>
							<td align="center" class="productListing-data" valign="top">
								<% if (item.getQuantityReceived() < item.getQuantityDesired()){%>
									<nested:checkbox property="addToBasket"/>
								<%  }%>
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
								<% if (item.getPriority() == 1 ){%>
									<bean:message key="common.lowest"/>
								<%  } else if (item.getPriority() == 2 ){ %>
									<bean:message key="common.low"/>
								<%  } else if (item.getPriority() == 3 ){ %>
									<bean:message key="common.medium"/>
								<%  } else if (item.getPriority() == 4 ){ %>
									<bean:message key="common.high"/>
								<%  } else if (item.getPriority() == 5 ){ %>
									<bean:message key="common.highest"/>
								<%  }%>
							</td>
							<td align="center" class="productListing-data" valign="top">
								<nested:define id="quantityDesired" property="quantityDesired"/>
								<%=quantityDesired %>							
							</td>
							<td align="center" class="productListing-data" valign="top">
								<nested:define id="quantityReceived" property="quantityReceived"/>
								<%=quantityReceived %>
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
				<logic:notEmpty name="wishListMgr" property="currentWishListItems">
					<table border="0" width="100%" cellspacing="0" cellpadding="2">
						<tr>
							<td class="smallText"><bean:message key="show.giftregistries.body.displaying"/>&nbsp;<b><%=wishListMgr.getCurrentOffset() + 1%></b> <bean:message key="show.giftregistries.body.to"/> <b><%=wishListMgr.getNumberOfWishListItems() + wishListMgr.getCurrentOffset()%></b> (<bean:message key="show.giftregistries.body.of"/> <b><%=wishListMgr.getTotalNumberOfWishListItems()%></b> <bean:message key="show.giftregistry.items.body.gifts"/>)</td>
							<td class="smallText" align="right">
								<logic:equal name="wishListMgr" property="showBack" value="1">
									<html:link page="/NavigateGiftRegistryItems.do" paramId="navDir" paramName="wishListMgr" paramProperty="navBack" styleClass="pageResults"><u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u></html:link>&nbsp;&nbsp;
								</logic:equal>
								<logic:notEqual name="wishListMgr" property="showBack" value="1">
									<u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u>&nbsp;&nbsp;
								</logic:notEqual>
								<logic:equal name="wishListMgr" property="showNext" value="1">
									<html:link page="/NavigateGiftRegistryItems.do" paramId="navDir" paramName="wishListMgr" paramProperty="navNext" styleClass="pageResults"><u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></html:link>
								</logic:equal>
								<logic:notEqual name="wishListMgr" property="showNext" value="1">
									<u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u>
								</logic:notEqual>
							</td>
						</tr>
					</table>
				  </logic:notEmpty>				
		</div>
	</div>		
	<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile">
				<html:link page="/Welcome.do">
					<span style="float:right" class="button"><span><bean:message key="edit.cart.body.continue.shopping"/></span></span>
				</html:link>
				<a onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.add.to.cart"/></span></a>
			</div>
		</div></div></div></div></div></div></div></div>
	</div> 	
	</logic:notEmpty>				
</html:form>
