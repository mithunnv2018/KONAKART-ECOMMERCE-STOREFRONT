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

<%@page import="com.konakart.appif.ProductIf"%>
<%@page import="com.konakart.appif.DataDescriptorIf"%>
<%@page import="com.konakart.app.CustomerTag"%>
<%@page import="com.konakart.app.DataDescriptor"%>
<%@page import="java.util.HashMap"%>


<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>

<%
	ProductIf[] prodArray = null;
    int[] prodIds = new int[0];
	String prodsViewed =  kkEng.getCustomerTagMgr().getCustomerTagValue("PRODUCTS_VIEWED");
	if (prodsViewed != null && prodsViewed.length() > 0)
	{
	    CustomerTag ct = new CustomerTag();
	    ct.setValue(prodsViewed);
	    ct.setType(CustomerTag.MULTI_INT_TYPE);
	    prodIds = ct.getValueAsIntArray();
	    if (prodIds.length>0)
	    {
	        DataDescriptorIf dataDesc = new DataDescriptor();  
	        dataDesc.setFillDescription(true);
	        prodArray = kkEng.getEng().getProductsFromIdsWithOptions(kkEng.getSessionId(), dataDesc, prodIds, kkEng.getLangId(), kkEng.getFetchProdOptions());
            // Sort the array so last viewed product is displayed first
	        HashMap<Integer, ProductIf> hm = new HashMap<Integer, ProductIf>();
            for (int i = 0; i < prodArray.length; i++)
            {
                ProductIf prod = prodArray[i];
                hm.put(new Integer(prod.getId()), prod);
            }
            int j = 0;
            for (int i = prodIds.length-1; i > -1; i--)
            {
                int prodId = prodIds[i];
                ProductIf prod = hm.get(new Integer(prodId));
                if (prod != null){
                    prodArray[j++]=hm.get(new Integer(prodId));  
                }                                   
            }
	    }               
	 }
%>
<%if (prodArray != null && prodArray.length > 0){ %>
	<div class="tile">
		<div class="new-products-body">
			<!--- box border -->
			<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
			<!-- -->
			<div class="tile-header">
				<bean:message key="recently.viewed.products.body.title"/>		
			</div>
			<div class="tile-content">
				<table class="tile-content" width="98%">
					<% int i=0; %>
					<tr>
						<%for (int j = 0; i < prodArray.length; j++){%>						
                  			<%
	                  			ProductIf product = prodArray[j];
	                  			pageContext.setAttribute("prodInContext",product);                 			
                  			%> 	
                  			<bean:define id="prod" name="prodInContext" type="com.konakart.appif.ProductIf"/>					    
							<%if ( i% 2 == 0 && i != 0) { %>
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
										</td>
										<td width="120" align="justify"  class="productListing-data">
											<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id">
												<%=revMgr.truncateDesc(prod.getDescription(),60,100)%>
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
						<%}%>
					</tr>	
				</table>			</div>
			<!--- end of box border -->
			</div></div></div></div></div></div></div></div>
			<!-- -->
		</div>
	</div>
<%}%>	



