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
<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
<bean:define id="currentCustomer" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<bean:define id="prod" name="prodMgr" property="selectedProduct" type="com.konakart.appif.ProductIf"/>

<html:form action="/WriteReviewSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<table  width="100%" class="body-header">
				<tr>
					<td class="pageHeading" valign="top"><%=prod.getName()%><br><span class="smallText">[<%=prod.getModel()%>]</span></td>
					<logic:empty name="prod" property="specialPriceExTax">
						<%if (kkEng.displayPriceWithTax()){%>
							<td class="pageHeading" align="right" valign="top"><%=kkEng.formatPrice(prod.getPriceIncTax())%></td>
						<%}else{%>
							<td class="pageHeading" align="right" valign="top"><%=kkEng.formatPrice(prod.getPriceExTax())%></td>
						<%}%>
					</logic:empty>
					<logic:notEmpty name="prod" property="specialPriceExTax">
						<%if (kkEng.displayPriceWithTax()){%>
							<td class="pageHeading" align="right" valign="top"><s><%=kkEng.formatPrice(prod.getPriceIncTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceIncTax())%></span></td>
						<%}else{%>
							<td class="pageHeading" align="right" valign="top"><s><%=kkEng.formatPrice(prod.getPriceExTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceExTax())%></span></td>
						<%}%>
					</logic:notEmpty>
				 </tr>
			</table>
		 </div>
		<div class="body-content-div">		
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td valign="top">
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<tr>
								<td ><b><bean:message key="write.review.body.from"/>:</b>&nbsp;<%=currentCustomer.getFirstName()%>&nbsp;<%=currentCustomer.getLastName()%></td>
							</tr>
							<tr>
								<td ><b><bean:message key="write.review.body.your.review"/>:</b></td>
							</tr>
							<tr>
								<td>
									 <div class="msg-box">
											<table border="0" width="100%" cellspacing="2" cellpadding="2" class="body-content-tab">
												<tr>
													<td ><html:textarea name="WriteReviewForm" property="reviewText" cols="60" rows="15"/></td>
												</tr>
												<tr>
													<td class="smallText" align="right"><small><font color="#ff0000"><b><bean:message key="write.review.body.note"/>:</b></font></small>&nbsp;<bean:message key="write.review.body.not.translated"/>!</td>
												</tr>
												<tr>
													<td ><b><bean:message key="write.review.body.rating"/>:</b> 
														<small><font color="#ff0000"><b><bean:message key="write.review.body.bad"/></b></font></small> 
														<html:radio name="WriteReviewForm" property="rating" value="1"/>
														<html:radio name="WriteReviewForm" property="rating" value="2"/>
														<html:radio name="WriteReviewForm" property="rating" value="3"/>
														<html:radio name="WriteReviewForm" property="rating" value="4"/>
														<html:radio name="WriteReviewForm" property="rating" value="5"/>
														<small><font color="#ff0000"><b><bean:message key="write.review.body.good"/></b></font></small>
													</td>
												</tr>
											</table>
									</div>
								</td>
							</tr>
							<logic:messagesPresent> 
								<tr>
									<td width="100%">
										<ul>
											<html:messages id="error">
												<li class="messageStackError">
													<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
												</li>
											</html:messages> 
										</ul>
									</td>
								</tr>
							</logic:messagesPresent>
						</table>
					</td>
					<td width="110" align="right" valign="top">
						<table border="0" cellspacing="0" cellpadding="2">
							<tr>
								<td align="center" class="smallText">
									<html:link page="/ShowImage.do" paramId="prodId" paramName="prod" paramProperty="id"><img src="<%=kkEng.getImageBase()%>/<%=prod.getImage()%>" border="0" alt="<%=prod.getName()%>" title=" <%=prod.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>" hspace="5" vspace="5"><br><bean:message key="product.details.body.click.to.enlarge"/></html:link>
									<logic:empty name="prod" property="opts">
										<p><html:link page="/AddToCartFromProdId.do" paramId="prodId" paramName="prod" paramProperty="id">
											<span class="button"><span><bean:message key="common.add.to.cart"/></span></span>
										</html:link></p>
									</logic:empty>
									<logic:notEmpty name="prod" property="opts">
										<p><html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id">
											<span class="button"><span><bean:message key="common.add.to.cart"/></span></span>
										</html:link></p>
									</logic:notEmpty>
								</td>
							</tr>
						</table>	
					</td>
				</tr>
			</table>		
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">
					<a style="float:right" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>
					<html:link page="/ShowReviews.do" paramId="prodId" paramName="prod" paramProperty="id">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>							                        				
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 	
</html:form>

