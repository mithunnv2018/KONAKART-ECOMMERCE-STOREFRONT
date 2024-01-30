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

<script type="text/javascript"><!--
	function rowOverEffect(object) {
	  if (object.className == 'moduleRow') object.className = 'moduleRowOver';
	}
	
	function rowOutEffect(object) {
	  if (object.className == 'moduleRowOver') object.className = 'moduleRow';
	}
//--></script>

	<div class="body">
		<div class="body-header">
		<img  style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="address.book.body.mypersonaladdressbook"/>" title=" <bean:message key="address.book.body.mypersonaladdressbook"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">			
		<bean:message key="address.book.body.mypersonaladdressbook"/>
		 </div>
		<div class="body-content-div">
			<logic:messagesPresent message="true">
				<ul>
					<html:messages id="msg" message="true">
						<li class="messageStackSuccess">
							<img src="<%=kkEng.getImageBase()%>/icons/success.gif" border="0" alt="<bean:message key="common.success"/>" title=" <bean:message key="common.success"/>" width="10" height="10"><bean:write name="msg" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>
			<logic:messagesPresent>			
				<ul>
					<html:messages id="error">
						<li class="messageStackError">
							<img src="<%=kkEng.getImageBase()%>/icons/error.gif" border="0" alt="<bean:message key="errors.error"/>" title=" <bean:message key="errors.error"/>" width="10" height="10"><bean:write name="error" filter="false"/>
						</li>
					</html:messages> 
				</ul>
			</logic:messagesPresent>
			<br/><b><bean:message key="address.book.body.primaryaddress"/></b><br/>
			 <div class="msg-box">						
				 <table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="address.book.body.addrexplanation"/></td>
						<td align="right" width="50%" valign="top">
							<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td  align="center" valign="top"><b><bean:message key="address.book.body.primaryaddress"/></b><br/><img src="<%=kkEng.getImageBase()%>/arrow_south_east.gif" border="0" alt="" width="50" height="31"></td>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
									<logic:notEmpty name="cust"  property="addresses">	
										<bean:define id="addresses" name="cust"  property="addresses" type="com.konakart.appif.AddressIf[]"/>	
										<td  valign="top"><%=kkEng.removeCData(addresses[0].getFormattedAddress())%></td>
									</logic:notEmpty>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<br/><b><bean:message key="address.book.body.addressbookentries"/></b><br/>
			<div class="msg-box-no-pad">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<logic:notEmpty name="cust"  property="addresses">	
						<logic:iterate id="addr" name="cust"  property="addresses" type="com.konakart.appif.AddressIf" indexId="count">	
							<tr>
								<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								<td>
									<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
										<tr class="moduleRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">
											<td >
												<b><%=addr.getFirstName()%>&nbsp;<%=addr.getLastName()%></b>
												<logic:equal name="count" value="0">
													&nbsp;<small><i>(<bean:message key="address.book.body.primaryaddress"/>)</i></small>
												</logic:equal>
											</td>
											<td  align="right">
												<html:link page="/EditAddr.do" paramId="addrId" paramName="addr" paramProperty="id">
													<span class="small-button"><span><bean:message key="common.edit"/></span></span>
												</html:link>&nbsp;
												<html:link page="/DeleteAddr.do" paramId="addrId" paramName="addr" paramProperty="id">
													<span class="small-button"><span><bean:message key="common.delete"/></span></span>
												</html:link>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
												  <tr>
													<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
													<td ><%=kkEng.removeCData(addr.getFormattedAddress())%></td>
													<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
												  </tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<br/>
							</tr>
						</logic:iterate>
					</logic:notEmpty>
				</table>
			 </div>				
			 <p class="smallText"><font color="#ff0000"><b><bean:message key="address.book.body.note"/>:</b></font> <bean:message key="address.book.body.maxentries" arg0='<%=kkEng.getConfig("MAX_ADDRESS_BOOK_ENTRIES")%>'/>.</p>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">								
					<%if ( cust.getAddresses() != null && cust.getAddresses().length < new Integer(kkEng.getConfig("MAX_ADDRESS_BOOK_ENTRIES")).intValue() ) { %>
						<html:link page="/NewAddr.do">
							<span style="float:right" class="button"><span><bean:message key="address.book.body.addaddress"/></span></span>
						</html:link>
					<% } %>
					<html:link page="/MyAccount.do">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 



