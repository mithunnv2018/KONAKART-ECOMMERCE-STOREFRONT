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
<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<logic:empty name="revMgr" property="selectedReview">
	<div class="body">
		<div class="body-content-div">
			<div class="msg-box"><bean:message key="show.reviews.body.review.not.found"/></div>
		</div>
	</div>
</logic:empty>
<logic:notEmpty name="revMgr" property="selectedReview">
	<bean:define id="rev" name="revMgr" property="selectedReview" type="com.konakart.appif.ReviewIf"/>
	<bean:define id="prod" name="prodMgr" property="selectedProduct" type="com.konakart.appif.ProductIf"/>	
	<div class="body">
		<div class="body-header">
			<table width="100%" class="body-header">
				<tr>
					<td valign="top"><%=prod.getName()%><br><span class="smallText">[<%=prod.getModel()%>]</span></td>
					<logic:empty name="prod" property="specialPriceExTax">
						<%if (kkEng.displayPriceWithTax()){%>
							<td  align="right" valign="top"><%=kkEng.formatPrice(prod.getPriceIncTax())%></td>
						<%}else{%>
							<td  align="right" valign="top"><%=kkEng.formatPrice(prod.getPriceExTax())%></td>
						<%}%>		    							
					</logic:empty>
					<logic:notEmpty name="prod" property="specialPriceExTax">
						<%if (kkEng.displayPriceWithTax()){%>
							<td  align="right" valign="top"><s><%=kkEng.formatPrice(prod.getPriceIncTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceIncTax())%></span></td>
						<%}else{%>
							<td  align="right" valign="top"><s><%=kkEng.formatPrice(prod.getPriceExTax())%></s>&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceExTax())%></span></td>
						<%}%>		    							
					</logic:notEmpty>
				 </tr>
			</table>
		 </div>
		<div class="body-content-div">
			<table width="100%" >
				<tr>
					<td valign="top">
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<tr>
								<td >
									<b><bean:message key="show.reviews.body.by"/>&nbsp;<%=rev.getCustomerName()%></b>
								</td>
								<td class="smallText" align="right"><bean:message key="show.reviews.body.date.added"/>:&nbsp;<%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy").format(rev.getDateAdded().getTime())%></td>
							</tr>
						</table>
						 <div class="msg-box">
							<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
										<td valign="top" ><%=revMgr.truncateDesc(rev.getReviewText(),60,0)%><br><br><i><bean:message key="show.reviews.body.rating"/>: <img src="<%=kkEng.getImageBase()%>/stars_<%=rev.getRating()%>.gif" border="0" alt="<%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/>" title=" <%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/> " width="59" height="11"> [<%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/>]</i></td>
										<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								</tr>
							</table>
						</div>
					</td>
					<td width="110" align="right" valign="top">
						<table border="0" cellspacing="0" cellpadding="2">
							<tr>
								<td align="center" class="smallText">
									<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><img src="<%=kkEng.getImageBase()%>/<%=prod.getImage()%>" border="0" alt="<%=prod.getName()%>" title=" <%=prod.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>" hspace="5" vspace="5"></html:link>
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
					<html:link page="/WriteReview.do" paramId="prodId" paramName="prod" paramProperty="id">
						<span style="float:right" class="button"><span><bean:message key="common.write.review"/></span></span>
					</html:link>							                        				
					<html:link page="/ShowReviews.do" paramId="prodId" paramName="prod" paramProperty="id">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>							                        								
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 	
</logic:notEmpty>	
