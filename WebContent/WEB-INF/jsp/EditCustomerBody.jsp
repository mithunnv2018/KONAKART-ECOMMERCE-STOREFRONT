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

<html:form action="/EditCustomerSubmit.do" styleId="form1"> 
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="register.customer.body.account.info"/>" title=" <bean:message key="register.customer.body.account.info"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="register.customer.body.account.info"/>
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
				<td ><b><bean:message key="edit.customer.myaccount"/></b></td>
				<td class="inputRequirement" align="right">* <bean:message key="register.customer.body.required.info"/></td>
			</tr>
		</table>
		 <div class="msg-box">
			<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
				<%if (kkEng.getConfig("ACCOUNT_GENDER").equalsIgnoreCase("TRUE") ) { %>
					<tr>
							<bean:define id="custForm" name="RegisterCustomerForm"  type="com.konakart.forms.RegisterCustomerForm"/>
							<%custForm.setGender(cust.getGender());%>
							<td ><bean:message key="register.customer.body.gender"/>:</td>
							<td >
								<html:radio name="RegisterCustomerForm" property="gender" value="m"/>&nbsp;&nbsp;<bean:message key="register.customer.body.male"/> &nbsp;&nbsp;
								<html:radio name="RegisterCustomerForm" property="gender" value="f"/>&nbsp;&nbsp;<bean:message key="register.customer.body.female"/>&nbsp;<span class="inputRequirement">*</span>
							</td>
					</tr>
				<% } else { %>
					<html:hidden name="RegisterCustomerForm" property="gender" value="-"/>
				<% } %>
				<tr>
					<td ><bean:message key="register.customer.body.first.name"/>:</td>
					<td ><html:text name="RegisterCustomerForm" property="firstName" value="<%=cust.getFirstName()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
				</tr>		              							
				<tr>
					<td ><bean:message key="register.customer.body.last.name"/>:</td>
					<td ><html:text name="RegisterCustomerForm" property="lastName" value="<%=cust.getLastName()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
				</tr>
				<%if (kkEng.getConfig("ACCOUNT_DOB").equalsIgnoreCase("TRUE") ) { %>
					<tr>
						<td ><bean:message key="register.customer.body.dob"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="birthDateString" value="<%=kkEng.getDateAsString(cust.getBirthDate())%>"/>&nbsp;<span class="inputRequirement">* (<bean:message key="date.format"/>)</span></td>
					</tr>
				<% } else { %>
					<html:hidden name="RegisterCustomerForm" property="birthDateString" value="<%=kkEng.getNowAsString()%>"/>
				<% } %>
				<tr>
						<td ><bean:message key="register.customer.body.email"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="emailAddr" value="<%=cust.getEmailAddr()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
				</tr>
				<tr>
						<td ><bean:message key="register.customer.body.tel.number"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="telephoneNumber" value="<%=cust.getTelephoneNumber()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
				</tr>
				<tr>
						<td ><bean:message key="register.customer.body.tel.number1"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="telephoneNumber1" value="<%=cust.getTelephoneNumber1()%>"/>&nbsp;</td>
				</tr>
				<tr>
						<td ><bean:message key="register.customer.body.fax.number"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="faxNumber" value="<%=cust.getFaxNumber()%>"/>&nbsp;</td>
				</tr>
				<tr>
						<td ><bean:message key="register.customer.body.custom1"/>:</td>
						<td ><html:text name="RegisterCustomerForm" property="customerCustom1" value="<%=cust.getCustom1()%>"/>&nbsp;</td>
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
	<html:hidden name="RegisterCustomerForm" property="streetAddress" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="streetAddress1" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="postcode" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="city" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="countryId" value="100"/>
	<html:hidden name="RegisterCustomerForm" property="state" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="password" value="aaaaaaaa"/>
	<html:hidden name="RegisterCustomerForm" property="passwordConfirmation" value="aaaaaaaa"/>
</html:form>
