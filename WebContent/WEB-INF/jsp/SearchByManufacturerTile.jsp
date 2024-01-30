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
	<logic:notEmpty property="allManuDropList" name="prodMgr">
		<bean:define id="allManu" name="prodMgr" property="allManuDropList"/>
		<bean:define id="allManuArray" name="prodMgr" property="allManuArray" type="com.konakart.appif.ManufacturerIf[]"/>
		<div class="tile">
			<div class="search-by-manufacturer-tile">
				<!--- box border -->
				<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
				<!-- -->
				<div class="tile-header">
					<img src="<%=kkEng.getImageBase()%>/icons/manufacturers.png" border="0"/>
					<bean:message key="search.by.manufacturer.tile.title"/>		
				</div>
				<div class="tile-content">
					<%if (  kkEng.getConfig("MAX_DISPLAY_MANUFACTURERS_IN_A_LIST") != null && (allManuArray.length > new Integer(kkEng.getConfig("MAX_DISPLAY_MANUFACTURERS_IN_A_LIST")).intValue())  ) { %>	
						<%
								com.konakart.forms.FilterByManufacturerForm myForm = (com.konakart.forms.FilterByManufacturerForm) request.getAttribute("FilterByManufacturerForm"); 
								if (myForm == null) 
								{ 
									myForm = new com.konakart.forms.FilterByManufacturerForm();
									request.setAttribute("FilterByManufacturerForm",myForm);
								}
								if (   prodMgr.getSelectedManufacturer() != null  && prodMgr.getSelectedManufacturer().getId() > -1 && myForm != null) { 
									myForm.setManufacturerId(prodMgr.getSelectedManufacturer().getId());
								}
						%>
						<html:form action="/ShowSearchByManufacturerResults.do" >
							<html:select name="FilterByManufacturerForm" property="manufacturerId" onchange="submit()">
								<html:option key="search.by.manufacturer.tile.default.select" value="-1"></html:option>
								<html:options collection="allManu" property="id"  labelProperty="desc"></html:options>
							</html:select>
						</html:form>
					<% } else { %>
						 <logic:empty name="prodMgr" property="selectedManufacturer">
							<logic:iterate id="manu" name="allManuArray"  type="com.konakart.appif.ManufacturerIf">
								<html:link page="/ShowSearchByManufacturerResultsByLink.do" paramId="manuId" paramName="manu" paramProperty="id"><%=manu.getName()%></html:link><br>
							</logic:iterate>
						</logic:empty>
						 <logic:notEmpty name="prodMgr" property="selectedManufacturer">
							<bean:define id="selectedManu" name="prodMgr" property="selectedManufacturer" type="com.konakart.appif.ManufacturerIf"/>
							<logic:iterate id="manu" name="allManuArray"  type="com.konakart.appif.ManufacturerIf">
								<html:link page="/ShowSearchByManufacturerResultsByLink.do" paramId="manuId" paramName="manu" paramProperty="id">
									<%if (   selectedManu.getId() == manu.getId()   ) { %><b><% } %>
									<%=manu.getName()%>
									<%if (   selectedManu.getId() == manu.getId()   ) { %></b><% } %>
								</html:link><br>
							</logic:iterate>
						</logic:notEmpty>
					<% } %> 
				</div>
				<!--- end of box border -->
				</div></div></div></div></div></div></div></div>
				<!-- -->
			</div>
		</div>
	</logic:notEmpty>
</logic:notEmpty>




