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
<bean:define id="manu" name="prodMgr" property="selectedManufacturer" type="com.konakart.appif.ManufacturerIf"/>

<logic:notEmpty name="manu" property="name">
	<div class="tile">
		<div class="manufacturer-tile">
			<!--- box border -->
			<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
			<!-- -->
			<div class="tile-header">
				<img src="<%=kkEng.getImageBase()%>/icons/manufacturers.png" border="0"/>
				<bean:message key="manufacturer.tile.manufacturerinfo"/>	
			</div>
			<div class="tile-content" align="center">
				<img src="<%=kkEng.getImageBase()%>/<%=manu.getImage()%>" border="0" alt="<%=manu.getName()%>" title=" <%=manu.getName()%> " width="100" height="57">
				<p align="left">
					<br/>-&nbsp; <html:link page="/ShowHomepage.do" paramId="url" paramName="manu" paramProperty="url" target="_blank"><%=manu.getName()%>&nbsp;<bean:message key="manufacturer.tile.home.page"/></html:link>
					<br/>-&nbsp; <html:link page="/ShowProductsForManufacturer.do" paramId="manuId" paramName="manu" paramProperty="id"><bean:message key="manufacturer.tile.other.products"/></html:link>
				</p>
			</div>
			<!--- end of box border -->
			</div></div></div></div></div></div></div></div>
			<!-- -->
		</div>
	</div>
</logic:notEmpty>


 
