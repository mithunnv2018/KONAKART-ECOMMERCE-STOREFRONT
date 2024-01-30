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
<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
<bean:define id="cust" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>

<html:form action="/ChangePasswordSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="change.password.body.mypassword"/>" title=" <bean:message key="change.password.body.mypassword"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="change.password.body.mypassword"/>
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
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
					<td ><b><bean:message key="change.password.body.mypassword"/></b></td>
					<td class="inputRequirement" align="right">* <bean:message key="register.customer.body.required.info"/></td>
				</tr>
			</table>
			<div class="msg-box">
				<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
					<tr>
						<td ><bean:message key="change.password.body.currentpassword"/>:</td>
						<td ><html:password name="ChangePasswordForm" property="currentPassword"/>&nbsp;<span class="inputRequirement">*</span></td>
					</tr>
					<tr>
						<td ><bean:message key="change.password.body.newpassword"/>:</td>
						<td ><html:password name="ChangePasswordForm" property="newPassword"/>&nbsp;<span class="inputRequirement">*</span></td>
					</tr>
					<tr>
						<td ><bean:message key="change.password.body.passwordconfirmation"/>:</td>
						<td ><html:password name="ChangePasswordForm" property="confirmPassword"/>&nbsp;<span class="inputRequirement">*</span></td>
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
