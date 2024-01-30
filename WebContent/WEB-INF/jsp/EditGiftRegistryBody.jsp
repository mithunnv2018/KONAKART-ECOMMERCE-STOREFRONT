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

<html:form action="/EditGiftRegistrySubmit.do" styleId="form1"> 
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="edit.gift.registry.body.wedding.list"/>" title=" <bean:message key="edit.gift.registry.body.wedding.list"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="edit.gift.registry.body.wedding.list"/>
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
					<td ><b><bean:message key="edit.gift.registry.body.edit.wedding.list"/></b></td>
					<td class="inputRequirement" align="right">* <bean:message key="register.customer.body.required.info"/></td>
				</tr>
			</table>
			 <div class="msg-box">
				<table border="0" cellspacing="2" cellpadding="2" class="body-content-tab">
					<tr>
						<td ><bean:message key="create.gift.registry.body.event.name"/>:</td>
						<td ><html:text size="60" name="CreateGiftRegistryForm" property="name" value="<%=wishList.getName()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
					</tr>		              							
					<tr>
						<td ><bean:message key="create.gift.registry.body.event.link.url"/>:</td>
						<td ><html:text size="60" name="CreateGiftRegistryForm" property="linkUrl" value="<%=wishList.getLinkUrl()%>"/></td>
					</tr>		              							
					<tr>
						<td ><bean:message key="create.gift.registry.body.groom.names"/>:</td>
						<td ><html:text name="CreateGiftRegistryForm" property="customerFirstName" value="<%=wishList.getCustomerFirstName()%>"/>&nbsp;<html:text name="CreateGiftRegistryForm" property="customerLastName" value="<%=wishList.getCustomerLastName()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
					</tr>		              							
					<tr>
						<td ><bean:message key="create.gift.registry.body.bride.names"/>:</td>
						<td ><html:text name="CreateGiftRegistryForm" property="customer1FirstName" value="<%=wishList.getCustomer1FirstName()%>"/>&nbsp;<html:text name="CreateGiftRegistryForm" property="customer1LastName" value="<%=wishList.getCustomer1LastName()%>"/>&nbsp;<span class="inputRequirement">*</span></td>
					</tr>		              							
					<tr>
						<td ><bean:message key="create.gift.registry.body.event.date"/>:</td>
						<td ><html:text name="CreateGiftRegistryForm" property="eventDateString" value="<%=kkEng.getDateAsString(wishList.getEventDate())%>"/>&nbsp;<span class="inputRequirement">* (<bean:message key="date.format"/>)</span></td>
					</tr>
					<tr>					
						<td ><bean:message key="create.gift.registry.body.is.public"/>:</td>
						<td >
							<%
								com.konakart.forms.CreateGiftRegistryForm myForm = (com.konakart.forms.CreateGiftRegistryForm) request.getAttribute("CreateGiftRegistryForm"); 
								if (myForm != null){
									myForm.setPublicWishList(wishList.isPublicWishList()?"true":"false");
								}				
							%>
							<html:radio name="CreateGiftRegistryForm" property="publicWishList" value="true"/>&nbsp;&nbsp;<bean:message key="create.gift.registry.body.public"/> &nbsp;&nbsp;
							<html:radio name="CreateGiftRegistryForm" property="publicWishList" value="false"/>&nbsp;&nbsp;<bean:message key="create.gift.registry.body.private"/>
						</td>
					</tr>		              							
					<tr>
						<td/>
						<td >
							<html:link page="/ShowWishListItems.do" paramId="wishListId" paramName="wishList" paramProperty="id">
								<bean:message key="edit.gift.registry.body.editgifts"/>
							</html:link>
							&nbsp;<bean:message key="edit.gift.registry.body.addgifts"/>
						</td>
					</tr>
				</table>
			</div>
			<br/><b><bean:message key="edit.gift.registry.body.delete.wedding.list"/></b><br/>
			 <div class="msg-box">						
				 <table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="edit.gift.registry.body.deleteexplanation"/></td>
						<td align="right" width="50%" valign="top">
							<html:link page="/DeleteGiftRegistry.do" paramId="wishListId" paramName="wishList" paramProperty="id">
								<span class="button"><span><bean:message key="common.delete"/></span></span>
							</html:link>
						</td>
					</tr>
				</table>
			</div>
			
			<br/><b><bean:message key="create.gift.registry.body.shippingaddress"/></b><br/>
			 <div class="msg-box">						
				 <table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td  width="50%" valign="top"><bean:message key="edit.gift.registry.body.addrexplanation"/><br><br>
							<html:link page="/ChangeGiftRegistryAddr.do" paramId="wishListId" paramName="wishList" paramProperty="id">
								<span class="button"><span><bean:message key="checkout.delivery.changeaddress"/></span></span>
							</html:link>
						</td>
						<td align="right" width="50%" valign="top">
							<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td  align="center" valign="top"><b><bean:message key="create.gift.registry.body.shippingaddress"/></b><br/><img src="<%=kkEng.getImageBase()%>/arrow_south_east.gif" border="0" alt="" width="50" height="31"></td>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
									<logic:notEmpty name="wishList"  property="address">	
										<bean:define id="address" name="wishList"  property="address" type="com.konakart.appif.AddressIf"/>	
										<td  valign="top"><%=kkEng.removeCData(address.getFormattedAddress())%></td>
										<html:hidden name="CreateGiftRegistryForm" property="addressId" value="<%=new Integer(address.getId()).toString()%>"/>
									</logic:notEmpty>
									<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
								</tr>
							</table>
						</td>
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
	<html:hidden name="CreateGiftRegistryForm" property="listType" value="<%=new Integer(com.konakart.al.WishListMgr.WEDDING_LIST_TYPE).toString()%>"/>
</html:form>
