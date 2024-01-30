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

<logic:notEmpty name="konakartKey">
	<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
	<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
	<logic:greaterThan name="prodMgr" property="numRandomSpecials" value="0">
		<bean:define id="special" name="prodMgr" property="randomSpecial" type="com.konakart.appif.ProductIf"/>
		<div class="tile">
			<div class="random-special-tile">
				<!--- box border -->
				<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
				<!-- -->
				<div class="tile-header">
					<html:link page="/ShowAllSpecials.do"><img src="<%=kkEng.getImageBase()%>/icons/specials.png" border="0" alt="<bean:message key="common.more"/>" title=" <bean:message key="common.more"/>"></html:link>
					<bean:message key="random.special.tile.specials"/>
				</div>
				<div class="tile-content" align="center">
					<html:link page="/SelectProd.do" paramId="prodId" paramName="special" paramProperty="id">
						<img src="<%=kkEng.getImageBase()%>/<%=special.getImage()%>" border="0" alt="<%=special.getName()%>" title=" <%=special.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>">
					</html:link>							                							                        					    								
					<br/>
					<p>
						<html:link page="/SelectProd.do" paramId="prodId" paramName="special" paramProperty="id"><%=special.getName()%></html:link>									
						<%if (kkEng.displayPriceWithTax()){%>
							<br><s><%=kkEng.formatPrice(prodMgr.getPriceIncTax(special))%></s>
							<br><span class="productSpecialPrice"><%=kkEng.formatPrice(prodMgr.getSpecialPriceIncTax(special))%></span>	
						<%}else{%>
							<br><s><%=kkEng.formatPrice(special.getPriceExTax())%></s>
							<br><span class="productSpecialPrice"><%=kkEng.formatPrice(special.getSpecialPriceExTax())%></span>	
						<%}%>
					</p>		    											                        				
				</div>
				<!--- end of box border -->
				</div></div></div></div></div></div></div></div>
				<!-- -->
			</div>
		</div>
	</logic:greaterThan>
</logic:notEmpty>

