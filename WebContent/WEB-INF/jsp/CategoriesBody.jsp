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
<bean:define id="catMgr" name="kkEng" property="categoryMgr" type="com.konakart.al.CategoryMgr"/>
<bean:define id="catArray" name="catMgr" property="cats"/>
<bean:define id="subCatArray" name="catMgr" property="currentSubCats"/>
<bean:define id="currentTopCat" name="catMgr" property="currentTopCat" type="com.konakart.appif.CategoryIf"/>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/<%=currentTopCat.getImage()%>" border="0" alt="<%=currentTopCat.getName()%>" title=" <%=currentTopCat.getName()%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="categories.body.categories"/>
	 </div>
	<div class="body-content-div">
		<table border="0" width="100%" cellspacing="0" cellpadding="2" valign="top">
			<tr>				
				<% 
				int i=0; int catWrap=3;
				if (   kkEng.getConfig("MAX_DISPLAY_CATEGORIES_PER_ROW") != null  ) { 
					catWrap = new Integer(kkEng.getConfig("MAX_DISPLAY_CATEGORIES_PER_ROW")).intValue();
				} %>							
				<logic:iterate id="cat" name="subCatArray" type="com.konakart.appif.CategoryIf">
					<td align="center" class="smallText" width="33%" valign="top">					
						<html:link page="/SelectCat.do" paramId="catId" paramName="cat" paramProperty="id">
							<img src="<%=kkEng.getImageBase()%>/<%=cat.getImage()%>" border="0" alt="<%=cat.getName()%>" title=" <%=cat.getName()%> " width="<%=kkEng.getSubcatImageWidth()%>" height="<%=kkEng.getSubcatImageHeight()%>"><br><%=cat.getName()%>
						</html:link>
					</td>
					<%i++; if ( i % catWrap == 0) { %>
					</tr><tr>
					<% } %>
				</logic:iterate>
			</tr>
		</table>		
	</div>
</div>						
