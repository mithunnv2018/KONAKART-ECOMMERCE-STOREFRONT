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
<%@ taglib uri="/tags/app" prefix="app" %>
<%@ taglib uri="/tags/struts-layout" prefix="layout" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>

<div class="tile">
	<div class="categories-tile-1">
		<!--- box border -->
		<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
		<!-- -->
		<div class="tile-header">
			<img src="<%=kkEng.getImageBase()%>/icons/categories.png" border="0"/>
			<bean:message key="categories.tile.categories"/>	
		</div>
		<div class="tile-content">
			<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
			<bean:define id="catMgr" name="kkEng" property="categoryMgr" type="com.konakart.al.CategoryMgr"/>
			<bean:define id="catList" name="catMgr" property="catMenuList" type="java.util.List"/>
			<bean:define id="currentCat" name="catMgr" property="currentCat" type="com.konakart.appif.CategoryIf"/>											 
			<p>	
			     <% if (catList.size() == 0) kkEng.getCategoryMgr().reset();%> 	
				<logic:iterate id="cat" name="catList" type="com.konakart.appif.CategoryIf">	
					<% if (cat.isSelected()){%>
						<html:link page="/SelectCat.do" paramId="catId" paramName="cat" paramProperty="id">
							<%for (int i = 0; i < cat.getLevel(); i++){%>
								<%="&nbsp;"%>
							<% }%>
							<b><%=cat.getName()%></b>
						</html:link>
					<% } else {%>
						<html:link page="/SelectCat.do" paramId="catId" paramName="cat" paramProperty="id">
							<%for (int i = 0; i < cat.getLevel(); i++){%>
								<%="&nbsp;"%>
							<% }%>
							<%=cat.getName()%>
						</html:link>
					<% }%>
					<logic:notEmpty name="catMgr" property="SHOW_COUNTS">
						<% if (cat.getChildren()!=null && cat.getChildren().length > 0){%>
							<%="->"%>
						<% }%>
						&nbsp;(<%=cat.getNumberOfProducts()%>)
					</logic:notEmpty>
					<br>
				</logic:iterate>	
			</p>										
		</div>
		<!--- end of box border -->
		</div></div></div></div></div></div></div></div>
		<!-- -->
	</div>
</div>