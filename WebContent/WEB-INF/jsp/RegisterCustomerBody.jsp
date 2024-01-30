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
<logic:notEmpty name="customerMgr"  property="zonesForRegistration">
	<bean:define id="zoneArray" name="customerMgr" property="zonesForRegistration" type="com.konakart.appif.ZoneIf[]"/>
</logic:notEmpty>

<html:form action="/CustomerRegistrationSubmit.do" styleId="form1"> 
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
			<span class="smallText"><br/>
				<font color="#FF0000"><small><b><bean:message key="register.customer.body.note"/>:&nbsp;</b></font></small><bean:message key="register.customer.body.already.account"/>&nbsp;
				<html:link page="/LogIn.do"><u><bean:message key="register.customer.body.login.page"/></u></html:link>.<br/><br/>
			</span>		
			<span class="inputRequirement" style="float:right">* <bean:message key="register.customer.body.required.info"/></span>
			<b><bean:message key="register.customer.body.personal.details"/></b> 
				<table  width="100%" class="body-content-tab">
					<tr>
						<td class="msg-box-no-pad">				
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<%if (kkEng.getConfig("ACCOUNT_GENDER").equalsIgnoreCase("TRUE") ) { %>
									<tr>
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
									<td ><html:text name="RegisterCustomerForm" property="firstName"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<tr>
									<td ><bean:message key="register.customer.body.last.name"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="lastName"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<%if (kkEng.getConfig("ACCOUNT_DOB").equalsIgnoreCase("TRUE") ) { %>
									<tr>
										<td ><bean:message key="register.customer.body.dob"/>:</td>
										<td ><html:text name="RegisterCustomerForm" property="birthDateString"/>&nbsp;<span class="inputRequirement">* (<bean:message key="date.format"/>)</span></td>
									</tr>
								<% } else { %>
									<html:hidden name="RegisterCustomerForm" property="birthDateString" value="<%=kkEng.getNowAsString()%>"/>
								<% } %>
								<tr>
									<td ><bean:message key="register.customer.body.email"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="emailAddr"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
							</table>
						</td>
					</tr>
					<%if (kkEng.getConfig("ACCOUNT_COMPANY").equalsIgnoreCase("TRUE") ) { %>
						<tr>
							<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
						</tr>
						<tr>
							<td ><b><bean:message key="register.customer.body.company.details"/></b></td>
						</tr>
						<tr>
							<td class="msg-box-no-pad">
								<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
									<tr>
										<td ><bean:message key="register.customer.body.company.name"/>:</td>
										<td ><html:text name="RegisterCustomerForm" property="company"/>&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
					<% } else { %>
						<html:hidden name="RegisterCustomerForm" property="company" value=""/>
					<% } %>
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td ><b><bean:message key="register.customer.body.your.addr"/></b></td>
					</tr>
					<tr>
						<td class="msg-box-no-pad">
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<tr>
									<td ><bean:message key="register.customer.body.street.addr"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="streetAddress"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<%if (kkEng.getConfig("ACCOUNT_STREET_ADDRESS_1").equalsIgnoreCase("TRUE") ) { %>
									<tr>
											<td ><bean:message key="register.customer.body.street.addr1"/>:</td>
											<td ><html:text name="RegisterCustomerForm" property="streetAddress1"/>&nbsp;</td>
									</tr>
								<% } else { %>
									<html:hidden name="RegisterCustomerForm" property="streetAddress1" value=""/>
								<% } %>
								<%if (kkEng.getConfig("ACCOUNT_SUBURB").equalsIgnoreCase("TRUE") ) { %>
									<tr>
										<td ><bean:message key="register.customer.body.suburb"/>:</td>
										<td ><html:text name="RegisterCustomerForm" property="suburb"/>&nbsp;</td>
									</tr>
								<% } else { %>
									<html:hidden name="RegisterCustomerForm" property="suburb" value=""/>
								<% } %>
								<tr>
									<td ><bean:message key="register.customer.body.postcode"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="postcode"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<tr>
									<td ><bean:message key="register.customer.body.city"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="city"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<%if (kkEng.getConfig("ACCOUNT_STATE").equalsIgnoreCase("TRUE") ) { %>
									<logic:notEmpty name="customerMgr"  property="zonesForRegistration">	
										<tr>
											<td ><bean:message key="register.customer.body.state"/>:</td>
											<td >
												<html:select name="RegisterCustomerForm" property="state">
													<html:options collection="zoneArray" property="zoneName"  labelProperty="zoneName"></html:options>
												</html:select>
											</td>
										</tr>																							
									</logic:notEmpty>
									<logic:empty name="customerMgr"  property="zonesForRegistration">	
										<tr>
											<td ><bean:message key="register.customer.body.state"/>:</td>
											<td ><html:text name="RegisterCustomerForm" property="state"/>&nbsp;<span class="inputRequirement">*</td>
										</tr>											
									</logic:empty>
								<% } else { %>
									<html:hidden name="RegisterCustomerForm" property="state" value="-----"/>
								<% } %>
								<tr>
									<td ><bean:message key="register.customer.body.country"/>:</td>
									<td >
										<html:select name="RegisterCustomerForm" property="countryId">
											<html:option value="-1"><bean:message key="register.customer.body.select"/></html:option>
												<%	com.konakart.appif.CountryIf[] countries = kkEng.getAllCountries();
														if (countries != null)
														{
															for ( int i = 0; i < countries.length; i++)
															{
																com.konakart.appif.CountryIf country = countries[i];%>
																<html:option value="<%=Integer.toString(country.getId())%>"><%=country.getName()%></html:option>                 
												<%		}           
														}		%>																
										</html:select>&nbsp;<span class="inputRequirement">*</span>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td ><b><bean:message key="register.customer.body.contact.info"/></b></td>
					</tr>
					<tr>
						<td class="msg-box-no-pad">
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<tr>
									<td ><bean:message key="register.customer.body.tel.number"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="telephoneNumber"/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<tr>
									<td ><bean:message key="register.customer.body.tel.number1"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="telephoneNumber1"/>&nbsp;</td>
								</tr>
								<tr>
									<td ><bean:message key="register.customer.body.fax.number"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="faxNumber"/>&nbsp;</td>
								</tr>
							</table> 
						</td>
					</tr>
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td ><b><bean:message key="register.customer.body.options"/></b></td>
					</tr>
					<tr>
						<td class="msg-box-no-pad">
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<tr>
									<td ><bean:message key="register.customer.body.newsletter"/>:</td>
									<td ><html:checkbox name="RegisterCustomerForm" property="newsletterBool"/>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td ><b><bean:message key="register.customer.body.your.password"/></b></td>
					</tr>
					<tr>
						<td class="msg-box-no-pad">
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<tr>
									<td ><bean:message key="register.customer.body.password"/>:</td>
									<td ><input type="password" name="password" maxlength="40" autocomplete="off" value=""/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
								<tr>
									<td ><bean:message key="register.customer.body.confirm.password"/>:</td>
									<td ><input type="password" name="passwordConfirmation" maxlength="40" autocomplete="off" value=""/>&nbsp;<span class="inputRequirement">*</span></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
					</tr>
					<tr>
						<td ><b><bean:message key="register.customer.body.custom"/></b></td>
					</tr>
					<tr>
						<td class="msg-box-no-pad">
							<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
								<tr>
									<td  title="An example for adding custom attributes. It is not required, but if present, it must have a value greater than 4 characters"><bean:message key="register.customer.body.custom1"/>:</td>
									<td ><html:text name="RegisterCustomerForm" property="customerCustom1"/>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</div>
	</div>
	<br/>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile" align="right">
					<a onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 	
</html:form>


