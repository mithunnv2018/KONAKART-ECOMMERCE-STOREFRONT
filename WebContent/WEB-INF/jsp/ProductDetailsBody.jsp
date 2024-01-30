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
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<logic:empty name="prodMgr" property="selectedProduct">
	<div class="body">
		<div class="body-content-div">
			<div class="msg-box"><bean:message key="product.details.body.product.not.found"/></div>
		</div>
	</div>
</logic:empty>
<logic:notEmpty name="prodMgr" property="selectedProduct">
	<bean:define id="wishListMgr" name="kkEng" property="wishListMgr" type="com.konakart.al.WishListMgr"/>
	<bean:define id="prod" name="prodMgr" property="selectedProduct" type="com.konakart.appif.ProductIf"/>
	<bean:define id="selectedOpts" name="prodMgr" property="selectedProductOptions"/>
	<bean:define id="prodUrl" name="prod" property="url"/>
	<bean:define id="prodOpts" name="prod" property="opts"/>
	<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
	<bean:define id="cust" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
	
	<script type="text/javascript"><!--
		function setAddToWishList() {
			document.AddToCartForm.addToWishList.value="true";
			document.AddToCartForm.wishListId.value="-1";
			//alert(document.AddToCartForm.addToWishList.value);
		}
	
		function resetAddToWishList() {
			document.AddToCartForm.addToWishList.value="false";
			//alert(document.AddToCartForm.addToWishList.value);
		}
		
		function setWishListId(id) {
			document.AddToCartForm.wishListId.value=id;
			document.AddToCartForm.addToWishList.value="true";
			//alert(document.AddToCartForm.wishListId);
		}

	//--></script>


	<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery-1.7.2.min.js"></script>
	<script language="javascript">
	
		$(document).ready(function() {
			$("#gallery_output img").not(":first").hide();

			$("#gallery a").click(function() {
				if ( $("#" + this.rel).is(":hidden") ) {
					$("#gallery_output img").slideUp();
					$("#" + this.rel).slideDown();
				}
			});
		});

	</script>

		<html:form action="/AddToCartSubmit.do" styleId="form1">
		<html:hidden name="AddToCartForm" property="addToWishList" value=""/>
		<div class="body">
			<html:hidden name = "AddToCartForm" property="productId" value="<%=new Integer(prod.getId()).toString() %>"></html:hidden>
			<html:hidden name = "AddToCartForm" property="wishListId" value="-1"/>
			<div class="body-header">
				<table width="100%">
					<tr class="body-header">
						<td>
							<%=prod.getName()%>
							<br>
							<span class="smallText">[<%=prod.getModel()%>]</span>
							<logic:empty name="prodOpts">
								<%if (prod.getQuantity()>0){%>
									<span class="smallTextGreen"> - <%=prod.getQuantity()%> <bean:message key="product.details.body.items.in.stock"/></span>
								<%}else{%>
									<span class="smallTextRed"> - <bean:message key="product.details.body.out.of.stock"/></span>
								<%}%>	
							</logic:empty>	
						</td>
						<td align="right" valign="top">
							<logic:empty name="prod" property="specialPriceExTax">
								<%if (kkEng.displayPriceWithTax()){%>
									<%=kkEng.formatPrice(prod.getPriceIncTax())%>
								<%}else{%>
									<%=kkEng.formatPrice(prod.getPriceExTax())%>
								<%}%>		    							
							</logic:empty>
							<logic:notEmpty name="prod" property="specialPriceExTax">
								<%if (kkEng.displayPriceWithTax()){%>
									<s><%=kkEng.formatPrice(prod.getPriceIncTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceIncTax())%></span>
								<%}else{%>
									<s><%=kkEng.formatPrice(prod.getPriceExTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceExTax())%></span>
								<%}%>		    							
							</logic:notEmpty>
						</td>
					</tr>
				</table>	
			 </div>
			<div class="body-content-div">
				<table width="100%" class="body-content-tab">
					<tr>
						<td>
							<div id="imgcontent">
								<div id="gallery">
									<div id="gallery_nav">								
										<%for (int i = 1; i < 5; i++){%>
											<%String name = prod.getImage();%>
											<%if (name != null){%>
												<%String[] names = name.split("\\.");%>
												<%name = names[0];%>
												<%String ext = names[1];%>
												<%String imgSrc = kkEng.getImageBase()+"/"+name+"_"+i+"."+ext;%>
												<a rel="img<%=i%>" href="javascript:;"><img src="<%=imgSrc%>" /></a>											
											<%}%>
										<%}%>									
									</div>
									
									<div id="gallery_output">
										<%for (int i = 1; i < 5; i++){%>
											<%String name = prod.getImage();%>
											<%if (name != null){%>
												<%String[] names = name.split("\\.");%>
												<%name = names[0];%>
												<%String ext = names[1];%>
												<%String imgSrc = kkEng.getImageBase()+"/"+name+"_"+i+"_big."+ext;%>
												<img id="img<%=i%>" src="<%=imgSrc%>" />											
											<%}%>
										<%}%>									
									</div>
									
									<div class="clear"></div>
								</div>
							</div>
						</td>					
					</tr>
					<tr>
						<td >
							<logic:notEmpty name="prod" property="tierPrices">
								<bean:define id="tierPrices" name="prod" property="tierPrices"/>
								<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab msg-box">
									<logic:iterate id="tp" name="tierPrices"  type="com.konakart.appif.TierPriceIf">
										<tr>
											<td>
											<%if (tp.isUsePercentageDiscount()){ %>
												<bean:message key="product.details.body.buy"/>&nbsp;
												<%=tp.getQuantity()%>&nbsp;
												&nbsp;<bean:message key="product.details.body.and"/>
												&nbsp;<b><bean:message key="product.details.body.save"/></b>
												&nbsp;<b><%=tp.getPriceExTax().setScale(0, BigDecimal.ROUND_HALF_UP)%></b>%											
											<%} else { %>
												<bean:message key="product.details.body.buy"/>&nbsp;
												<%=tp.getQuantity()%>&nbsp;
												<bean:message key="product.details.body.for"/>&nbsp;
												<%if (kkEng.displayPriceWithTax()){%>
													<%=kkEng.formatPrice(tp.getPriceIncTax())%>
												<%}else{%>
													<%=kkEng.formatPrice(tp.getPriceExTax())%>
												<%}%>		    							
												&nbsp;<bean:message key="product.details.body.each"/>
												&nbsp;<bean:message key="product.details.body.and"/>
												&nbsp;<b><bean:message key="product.details.body.save"/></b>
												&nbsp;<b><%=new BigDecimal(100).subtract(tp.getPriceExTax().multiply(new BigDecimal(100)).divide(prod.getPriceExTax(),0,BigDecimal.ROUND_HALF_UP))%></b>%											
											<%}%>
											</td>
										</tr>   
									</logic:iterate>
								</table>
							 </logic:notEmpty>						
							<p><%=prod.getDescription()%></p>
							<logic:notEmpty name="prodMgr" property="bundledProducts">
								<bean:define id="bundledProducts" name="prodMgr" property="bundledProducts"/>
								<logic:iterate id="bProd" name="bundledProducts"  type="com.konakart.appif.ProductIf">
									<p><%=bProd.getDescription()%></p>
								</logic:iterate>
							</logic:notEmpty>
							<logic:notEmpty name="prod" property="customAttrArray">
								<bean:define id="customAttrs" name="prod" property="customAttrArray"/>
								<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab msg-box">
									<logic:iterate id="attr" name="customAttrs"  type="com.konakart.appif.ProdCustAttrIf">
										<tr><td><bean:message key="<%=(attr.getMsgCatKey()==null)? attr.getName():attr.getMsgCatKey()%>"/>:</td><td><%=attr.getValue()%></td></tr>
									</logic:iterate>
								</table>
							</logic:notEmpty>						
							<logic:notEmpty name="prodOpts">
								<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
									<tr>
										<td  colspan="2"><bean:message key="product.details.body.available.options"/>:</td>
									</tr>	      
									<% int i=0; %>			            				            			            			
									<logic:iterate id="optContainer" name="selectedOpts"  type="com.konakart.al.ProdOptionContainer">
										<bean:define id="values" name="optContainer" property="optValues" />
										<html:hidden name = "AddToCartForm" property='<%= "optionId["+i+"]"%>' value="<%= optContainer.getId() %>"></html:hidden>
										<html:hidden name = "AddToCartForm" property='<%= "type["+i+"]"%>' value="<%= optContainer.getType() %>"></html:hidden>								
										<tr>
										<%if (optContainer.getType().equals("0")){%>										
											<td><bean:write  name="optContainer" property="name"/>:</td>
											<td>
												<html:select name="AddToCartForm" property='<%= "valueId["+i+"]"%>' >									
													<%if (kkEng.displayPriceWithTax()){%>
														<html:options collection="values" property="id"  labelProperty="formattedValueIncTax"></html:options>
													<%}else{%>
														<html:options collection="values" property="id"  labelProperty="formattedValueExTax"></html:options>
													<%}%>		    																		
												</html:select>	              			
											</td>    
										<%}else{%>
											<td><%=optContainer.getName()+" "%> 
												<%if (kkEng.displayPriceWithTax()){%>
													<%=optContainer.getOptValues().get(0).getFormattedValueIncTax()%>
												<%}else{%>
													<%=optContainer.getOptValues().get(0).getFormattedValueExTax()%>
												<%}%>
											</td>
											<td>
												<html:text name="AddToCartForm" property='<%= "quantity["+i+"]"%>' />
												<html:hidden name = "AddToCartForm" property='<%= "valueId["+i+"]"%>' value="<%= Integer.toString(optContainer.getOptValues().get(0).getId()) %>"></html:hidden>			
											</td>    
										<%}%> 
										</tr>   
										<% i++; %>			            				            			            			   			
									</logic:iterate>
									<html:hidden name = "AddToCartForm" property="numOptions" value='<%= new Integer(i).toString()%>'></html:hidden>
								</table>
							 </logic:notEmpty>
						</td>
					</tr>	
				<tr>
			</table>												

								
							

					
			
				<%if (prodUrl != null && ((String)(prodUrl)).length() > 0){%>
					<p><bean:message key="product.details.body.more.information"/>&nbsp;<a href="http://<%=prodUrl%>" target="_blank"><u><bean:message key="product.details.body.webpage"/></u></a>.</p>
				<%}%>		
				<p class="smallText" align="center"><bean:message key="product.details.body.added.to.cat"/>&nbsp;<%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy").format(prod.getDateAdded().getTime())%>.</p>
					<%String giftRegistryEnabled=kkEng.getConfig("ENABLE_GIFT_REGISTRY"); %>	
					<%if (giftRegistryEnabled != null && giftRegistryEnabled.equalsIgnoreCase("TRUE") ) {%>	
					<br/>
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<logic:notEmpty  name="cust"  property="wishLists">
										<logic:iterate id="wishList" name="cust" property="wishLists" type="com.konakart.appif.WishListIf">
										<%if (wishList != null && wishList.getListType()!= com.konakart.al.WishListMgr.WISH_LIST_TYPE ) {%>
											<tr>
												<td>
													<bean:message key="product.details.body.add.product"/>&nbsp;<%=wishList.getName()%>
													<input onmouseover="setWishListId(<%=new Integer(wishList.getId()).toString()%>)" type="image" src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="<bean:message key="product.details.body.add.to.wedding.list"/>" title=" <bean:message key="product.details.body.add.to.wedding.list"/> ">																						</td>
												</td>
											</tr>
										<%}%>
										</logic:iterate>
									</logic:notEmpty> 					
								</table>
							</td>
						</tr>
					</table>
				<% } %>
			</div>
		</div>						
		<div class="tile">
				<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
					<div class="button-tile">
						<a style="float:right" onmouseover="resetAddToWishList()" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.add.to.cart"/></span></a>
						<!--<html:link  page="/ShowReviews.do" paramId="prodId" paramName="prod" paramProperty="id">
							<span class="button"><span><bean:message key="product.details.body.reviews"/></span></span>
						</html:link>
						-->
						<%String wishListEnabled=kkEng.getConfig("ENABLE_WISHLIST"); %>	
						<%if (wishListEnabled != null && wishListEnabled.equalsIgnoreCase("TRUE") ) {%>	
							<a style="margin-left: 20px;" onmouseover="setAddToWishList()" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.add.to.wishlist"/></span></a>	
						<% } %>						
					</div>
				</div></div></div></div></div></div></div></div>
		</div> 		
	</html:form>
</logic:notEmpty>
