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
	<%if (!kkEng.getConfig("USE_SOLR_SEARCH").equalsIgnoreCase("TRUE") ) { %>
		<div class="tile">
			<div class="quick-search-tile">
				<!--- box border -->
				<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
				<!-- -->
				<div class="tile-header">
					<img src="<%=kkEng.getImageBase()%>/icons/search.png" border="0"/>
					<bean:message key="quick.search.tile.quick.find"/>	
				</div>
				<div class="tile-content" align="center">
						<html:form action="/QuickSearch.do" >
							<input style="float: right; padding-right: 8px;  padding-top: 5px;" type="image" src="<%=kkEng.getImageBase()%>/infobox/arrow_right.gif" border="0" alt="<bean:message key="quick.search.tile.quick.find"/>" title=" <bean:message key="quick.search.tile.quick.find"/>">
							<html:text name="SearchProductForm" property="searchText" size="10" maxlength="30" style="width: 90px"/>
							<p><bean:message key="quick.search.tile.keywords"/></p>
							<br><html:link page="/AdvancedSearch.do"><b><bean:message key="quick.search.tile.adv.search"/></b></html:link>
						</html:form >		
				</div>
				<!--- end of box border -->
				</div></div></div></div></div></div></div></div>
				<!-- -->
			</div>
		</div>
	<% } %>
</logic:notEmpty>
