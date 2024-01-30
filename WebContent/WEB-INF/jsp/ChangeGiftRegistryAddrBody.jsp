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
<bean:define id="wishListMgr" name="kkEng" property="wishListMgr" type="com.konakart.al.WishListMgr"/>
<bean:define id="wishList" name="wishListMgr" property="currentWishList" type="com.konakart.appif.WishListIf"/>


<script language="javascript"><!--
function rowOverEffect(object) {
  if (object.className == 'moduleRow') object.className = 'moduleRowOver';
}

function rowOutEffect(object) {
  if (object.className == 'moduleRowOver') object.className = 'moduleRow';
}
//--></script>

<html:form action="/ChangeGiftRegistryAddrSubmit.do" styleId="form1">  
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_delivery.gif" border="0" alt="<bean:message key="change.gift.registry.address.body.shippingaddress"/>" title=" <bean:message key="change.gift.registry.address.body.shippingaddress"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="change.gift.registry.address.body.shippingaddress"/>
		 </div>
		<div class="body-content-div">
			</br><b><bean:message key="change.gift.registry.address.body.addrbookentries"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="change.gift.registry.address.body.selectaddr"/>.</td>
						<td  width="50%" valign="top" align="right"><b><bean:message key="change.gift.registry.address.body.pleaseselect"/></b><br><img src="<%=kkEng.getImageBase()%>/arrow_east_south.gif" border="0" alt="" width="40" height="32"></td>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
					<%
									com.konakart.forms.ChangeAddrForm myForm = (com.konakart.forms.ChangeAddrForm) request.getAttribute("ChangeAddrForm"); 					
									myForm.setAddrId(new Integer(wishList.getAddressId()).toString());
					%>
					<logic:notEmpty name="cust"  property="addresses">	
						<logic:iterate id="addr" name="cust"  property="addresses" type="com.konakart.appif.AddressIf" indexId="count">	
							<tr>
								<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								<td colspan="2">        
									<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
										<tr class="moduleRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
											<td  colspan="2"><b><%=addr.getFirstName()%>&nbsp;<%=addr.getLastName()%></b></td>
											<td  align="right"><html:radio name="ChangeAddrForm" property="addrId" value="<%=new Integer(addr.getId()).toString()%>"/></td>
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
										</tr>
										<tr>
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
											<td colspan="3">        
												<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
													<tr>
														<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
														<td ><%=(kkEng.removeCData(addr.getFormattedAddress())).replaceAll("<br>", ", ")%></td>
														<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
													</tr>
												</table>
											</td>
											<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
										</tr>
									</table>
								</td>
								<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							</tr>
						</logic:iterate>
					</logic:notEmpty>
				</table>
			</div>
		</div>
	</div>						
	<div class="tile">
			<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
				<div class="button-tile">
					<a style="float:right" onclick="javascript:document.forms['form1'].submit();" class="button"><span><bean:message key="common.continue"/></span></a>
					<html:link page="/EditGiftRegistry.do">
						<span class="button"><span><bean:message key="common.back"/></span></span>
					</html:link>
				</div>
			</div></div></div></div></div></div></div></div>
	</div> 
</html:form>


		      			
		      			


