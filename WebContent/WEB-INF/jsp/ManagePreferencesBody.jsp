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
<bean:define id="orderMgr" name="kkEng" property="orderMgr" type="com.konakart.al.OrderMgr"/>
<bean:define id="reviewMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>

<html:form action="/ManagePreferencesSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="preferences.body.mypreferences"/>" title=" <bean:message key="preferences.body.mypreferences"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="preferences.body.mypreferences"/>
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
			<div class="msg-box">
				<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
					<tr>
						<td ><bean:message key="preferences.body.productsperpage"/>:</td>
						<td ><html:text name="PreferencesForm" property="productPageSize" value="<%=String.valueOf(prodMgr.getMaxDisplaySearchResults())%>"/></td>
					</tr>
					<tr>
						<td ><bean:message key="preferences.body.ordersperpage"/>:</td>
						<td ><html:text name="PreferencesForm" property="orderPageSize" value="<%=String.valueOf(orderMgr.getPageSize())%>"/></td>
					</tr>
					<tr>
						<td ><bean:message key="preferences.body.reviewsperpage"/>:</td>
						<td ><html:text name="PreferencesForm" property="reviewPageSize" value="<%=String.valueOf(reviewMgr.getPageSize())%>"/></td>
					</tr>
				</table>
			 </div>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">
					<a style="float:right" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>
					<html:link page="/MyAccount.do">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 
</html:form>	
