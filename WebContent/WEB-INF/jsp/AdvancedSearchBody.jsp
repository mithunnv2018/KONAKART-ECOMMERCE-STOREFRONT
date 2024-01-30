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
<bean:define id="searchAll" name="kkEng" property="SEARCH_ALL" type="java.lang.String"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<bean:define id="catMgr" name="kkEng" property="categoryMgr" type="com.konakart.al.CategoryMgr"/>
<bean:define id="allCats" name="catMgr" property="allCatsDropList"/>
<bean:define id="allManu" name="prodMgr" property="allManuDropList"/>

<html:form action="/ShowSearchResults.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img  style="float:right" src="<%=kkEng.getImageBase()%>/table_background_browse.gif" border="0" alt="<bean:message key="advanced.search.body.advanced.search"/>" title=" <bean:message key="advanced.search.body.advanced.search"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="advanced.search.body.advanced.search"/>
		 </div>
		<div class="body-content-div">
			<logic:messagesPresent> 
				<ul>
					<html:messages id="error">
						<li class="messageStackError">
							<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>	
			<br/>		
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2">
					<tr>
						<td class="fieldKey"><bean:message key="advanced.search.body.search.criteria"/>:</td>
					</tr>				
					<tr>
							<td class="boxText" colspan="2"><html:text name="SearchProductForm" property="searchText" style="width: 100%"/></td>
					</tr>
					<tr>
							<td align="right" class="boxText"  colspan="2"><html:checkbox name="SearchProductForm" property="searchInDescription" /><bean:message key="advanced.search.body.search.in.descriptions"/></td> 
					</tr>
					<tr>
							<td colspan="2"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.categories"/>:</td>
							<td class="fieldValue">
						<html:select name="SearchProductForm" property="categoryId">
							<html:option key="advanced.search.body.all.categories" value="<%=searchAll%>"></html:option>
							<html:options collection="allCats" property="id"  labelProperty="desc" filter="false"></html:options>
						</html:select>
							</td>
					</tr>
					<tr>
							<td colspan="2"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.manufacturers"/>:</td>
						<td class="fieldValue">
						<html:select name="SearchProductForm" property="manufacturerId">
							<html:option key="advanced.search.body.all.manufacturers" value="<%=searchAll%>"></html:option>
							<html:options collection="allManu" property="id"  labelProperty="desc" filter="false"></html:options>
						</html:select>
						</td>
					</tr>
					<tr>
							<td colspan="2"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td class="fieldKey"><bean:message key="advanced.search.body.price.from"/>:</td>
						<td class="fieldValue"><html:text name="SearchProductForm" property="priceFrom"/></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.price.to"/>:</td>
							<td class="fieldValue"><html:text name="SearchProductForm" property="priceTo"/></td>
					</tr> 
					<tr>
							<td colspan="2"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.date.from"/>&nbsp;(<bean:message key="date.format"/>):</td>
							<td class="fieldValue"><html:text name="SearchProductForm" property="dateAddedFrom" /></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.date.to"/>&nbsp;(<bean:message key="date.format"/>):</td>
							<td class="fieldValue"><html:text name="SearchProductForm" property="dateAddedTo" /></td>
					</tr>
					<!-- Remove the following section if you don't require searches on custom fields -->
					<tr>
							<td colspan="2"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
							<td class="fieldKey"><bean:message key="advanced.search.body.custom1"/>:</td>
							<td class="fieldValue"><html:text name="SearchProductForm" property="custom1" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>	
		<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile" align="right">
					<a onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="advanced.search.body.search"/></span></a>	
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 						
</html:form>	




