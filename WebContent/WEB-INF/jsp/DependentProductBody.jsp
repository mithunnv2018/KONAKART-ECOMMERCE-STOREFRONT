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
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>

<logic:notEmpty name="prodMgr" property="dependentProducts">
	<bean:define id="prodArray" name="prodMgr" property="dependentProducts"/>
	<div class="tile">
		<div class="dependent-product-body">
			<!--- box border -->
			<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
			<!-- -->
			<div class="tile-header">
				<bean:message key="dependent.product.body.title"/>	
			</div>
			<div class="tile-content">
				<table class="tile-content" width="98%">	
					<% int i=0; %>
					<tr>
						<logic:iterate id="prod" name="prodArray" length="maxRows" type="com.konakart.appif.ProductIf">
							<%if ( i% 3 == 0 && i != 0) { %>
								 </tr><tr>
							<% } i++; %>
							<td align="center" width="33%" valign="top">
								<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id">
									<img src="<%=kkEng.getImageBase()%>/<%=prod.getImage()%>" border="0" alt="<%=prod.getName()%>" title=" <%=prod.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>">
								</html:link><br>
								<%if (kkEng.displayPriceWithTax()){%>
									<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><%=prod.getName()%></html:link><br><%=kkEng.formatPrice(prod.getPriceIncTax())%>
								<%}else{%>
									<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><%=prod.getName()%></html:link><br><%=kkEng.formatPrice(prod.getPriceExTax())%>
								<%}%>		    							
							</td>										
						</logic:iterate>
					</tr>	
				</table>
			</div>
			<!--- end of box border -->
			</div></div></div></div></div></div></div></div>
			<!-- -->
		</div>
	</div>	
</logic:notEmpty>
