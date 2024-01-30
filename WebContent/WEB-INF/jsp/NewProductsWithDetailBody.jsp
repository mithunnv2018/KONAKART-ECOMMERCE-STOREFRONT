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

<%@page import="com.konakart.appif.PromotionIf"%>
<%@page import="com.konakart.appif.PromotionResultIf"%>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>

<logic:notEmpty name="prodMgr" property="newProducts">
	<bean:define id="prodArray" name="prodMgr" property="newProducts"/>
	<bean:define id="promotionMap" name="prodMgr" property="promotionMap"/>
	<div class="tile">
		<div class="new-products-body">
			<!--- box border -->
			<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
			<!-- -->
			<div class="tile-header">
<!--				<bean:message key="new.products.body.title"/>-->
					Follow us @ below Social Media
			</div>
			<div class="tile-content">
				 
 						 <a href="http://www.facebook.com/duly.noted.9" target="_blank">
						 <img alt="Facebook" width="50px" height="50px" src="images/socialmedia/facebook.png">
						 </a>
						
						<a href="https://twitter.com/duly_noted" target="_blank">
						 <img alt="Twitter" width="50px" height="50px" src="images/socialmedia/twitter.png">
						 </a>		
						
						<a href="http://www.myebook.com/dulynoted" target="_blank">
						 <img alt="MyEbook" width="100px" height="50px" src="images/socialmedia/Myebook.png">
						 </a>		
						 
						 <a href="http://www.myspace.com/duly_noted9" target="_blank">
						 <img alt="MySPace" width="100px" height="50px" src="images/socialmedia/Myspace_2010_logo.png">
						 </a>		
						 
						 <a href="http://www.youtube.com/user/dulynotedltd" target="_blank">
						 <img alt="Facebook" width="50px" height="50px" src="images/socialmedia/youtube_logo.png">
						 </a>		
						  				
				<!--<table class="tile-content" width="98%">
					<% int i=0; %>
					<tr>
						<logic:iterate id="prod" name="prodArray" length="maxRows" type="com.konakart.appif.ProductIf">
							<%if ( i% 4 == 0 && i != 0) { %>
								 </tr><tr>
							<% } i++; %>
							<td align="center" width="50%" valign="top">						
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td colspan="2" class="list-detail-header">
											<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><%=prod.getName()%></html:link>
										</td>
									</tr>
									<tr>
										<td colspan="2" style="padding-top:1px;padding-bottom:5px;"><img src="<%=kkEng.getImageBase()%>/DottedLineLong.png" width="223" height="1" border="0"  /></td>
									</tr>
									<tr valign="top">
										<td width="103" align="center">
											<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id">
												<img src="<%=kkEng.getImageBase()%>/<%=prod.getImage()%>" border="0" alt="<%=prod.getName()%>" title=" <%=prod.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>">
											</html:link>
										  	<% if (prod.getPromotionResults()!=null && prod.getPromotionResults().length>0) { %>
								 				<%PromotionResultIf promotionResult = prod.getPromotionResults()[0];%>
								 				<%PromotionIf promotion = prodMgr.getPromotionMap().get(promotionResult.getPromotionId());%>
								 				<%=promotion.getName()%>
											<% }%>
										</td>
										<td width="120" align="justify"  class="productListing-data">
											<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id">
												<% if (prod.getDescription() != null) { %>
													<%=revMgr.truncateDesc(prod.getDescription(),60,100)%>
												<%} else if (prod.getName() != null) { %>
													<%=revMgr.truncateDesc(prod.getName(),60,100)%>
												<%} else {%>
													<%=prod.getId()%>
												<% }%>
											</html:link>
										</td>
									</tr>
									<tr valign="top">
										<td></td>
										<td style="padding-top:5px;padding-bottom:5px;" align="right"><img src="<%=kkEng.getImageBase()%>/DottedLineShort.png" width="120" height="1" border="0"  /></td>
									</tr>
									<tr valign="top">
										<td colspan="2" align="right" class="list-detail-header">
											<%if (kkEng.displayPriceWithTax()){%>
												<%if (prod.getSpecialPriceIncTax() != null){%>
													<br><s><%=kkEng.formatPrice(prod.getPriceIncTax())%></s>
													&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceIncTax())%></span>
												<%}else{%>
													<br><%=kkEng.formatPrice(prod.getPriceIncTax())%>
												<%}%>
											<%}else{%>
													<%if (prod.getSpecialPriceExTax() != null){%>
														<br><s><%=kkEng.formatPrice(prod.getPriceExTax())%></s>
														&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceExTax())%></span>
													<%}else{%>
														<br><%=kkEng.formatPrice(prod.getPriceExTax())%>
													<%}%>
											<%}%>
										</td>
									</tr>
									<tr>
										<td colspan="2" align="center" style="padding-top: 5px;" >
											<html:link page="/AddToCartFromProdId.do" paramId="prodId" paramName="prod" paramProperty="id">
												<span class="button"><span><bean:message key="common.add.to.cart"/></span></span>
											</html:link>&nbsp;
										</td>
									</tr>
								</table>
							</td>
						</logic:iterate>
					</tr>
				</table>
				-->
				</div>
			<!--- end of box border -->
			</div></div></div></div></div></div></div></div>
			<!-- -->
		</div>
	</div>
</logic:notEmpty>


