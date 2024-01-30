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

<logic:notEmpty name="customerMgr" property="currentCustomer">
	<bean:define id="currentCustomer" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
</logic:notEmpty>

<html:form action="/LoginSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_login.gif" border="0" alt="<bean:message key="login.body.welcome"/>" title=" <bean:message key="login.body.welcome"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">			
			<bean:message key="login.body.welcome"/>
		 </div>
		<div class="body-content-div">
			<logic:notEmpty name="customerMgr" property="currentCustomer">				 	
				<logic:notEmpty name="currentCustomer" property="basketItems">
						<span class="smallText"><font color="#ff0000"><b><bean:message key="login.body.note"/>:</b></font> <bean:message key="login.body.merge.warning"/> <html:link page="/CatalogShowMergeInfoPage.do"  target="_blank">[<bean:message key="login.body.more.info"/>]</html:link></span>
				</logic:notEmpty>
			</logic:notEmpty>
		        			
			<logic:messagesPresent> 
				<ul>
					<html:messages id="error">
						<li class="messageStackError">
							<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>
			<logic:messagesPresent message="true">
				<ul>
					<html:messages id="msg" message="true">
						<li class="messageStackSuccess">
							<img src="<%=kkEng.getImageBase()%>/icons/success.gif" border="0" alt="<bean:message key="common.success"/>" title=" <bean:message key="common.success"/>" width="10" height="10"><bean:write name="msg" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>									
			<table class="body-content-tab" border="0"  width="100%">		
				<tr>
						<td  width="50%" valign="top"><b><bean:message key="login.body.new.customer"/></b></td>
						<td  width="50%" valign="top"><b><bean:message key="login.body.returning.customer"/></b></td>
				</tr>
				<tr>
					<td width="50%" height="100%" valign="top" class="msg-box">
						<p><bean:message key="login.body.I.am.a.new.customer"/></p>
						<p align="right">
							<html:link page="/CustomerRegistration.do">
								<span class="button"><span><bean:message key="common.continue"/></span></span>
							</html:link>					
						</p>
					</td>		           					
					 <td width="50%" height="100%" valign="top" class="msg-box">
						<p><bean:message key="login.body.I.am.a.returning.customer"/></p>									
						<table border="0" width="100%"  class="body-content-tab">
							<tr>
								<td><b><bean:message key="login.body.email"/>:</b></td>
								<td><html:text name="LoginForm" property="user"/></td>										                  		
							</tr>								
							<tr>
								<td><b><bean:message key="login.body.password"/>:</b></td>
								<td><html:password name="LoginForm" property="password"/></td>
							</tr>
						</table>
						<p><span class="smallText">
							<html:link page="/ForgotPassword.do"><bean:message key="login.body.forgotten.password"/></html:link>
						</span></p>								
						<p align="right">														
							<a style="float:right" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="login.body.sign.in"/></span></a>
						</p>							
					</td>
				</tr>
			</table>
		</div>
	</div>						
</html:form>



