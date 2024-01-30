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
<bean:define id="productMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<bean:define id="downloads" name="productMgr" property="digitalDownloads" type="com.konakart.appif.DigitalDownloadIf[]"/>
<bean:define id="customerMgr" name="kkEng" property="customerMgr" type="com.konakart.al.CustomerMgr"/>
<bean:define id="cust" name="customerMgr" property="currentCustomer" type="com.konakart.appif.CustomerIf"/>
<bean:define id="rewardPointMgr" name="kkEng" property="rewardPointMgr" type="com.konakart.al.RewardPointMgr"/>

<script language="javascript"><!--
function rowOverEffect(object) {
  if (object.className == 'moduleRow') object.className = 'moduleRowOver';
}

function rowOutEffect(object) {
  if (object.className == 'moduleRowOver') object.className = 'moduleRow';
}
//--></script>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="after.login.body.myaccountinfo"/>" title=" <bean:message key="after.login.body.myaccountinfo"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="after.login.body.myaccountinfo"/>
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
		<logic:notEmpty  name="productMgr"  property="digitalDownloads">
			<br/>
			<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
					<td ><b><bean:message key="after.login.body.downloads"/></b></td>
				</tr>
			</table>
			<div class="msg-box-no-pad">
				<table border="0" width="100%" cellspacing="0" cellpadding="2"  class="body-content-tab">
					<tr>
						<td  align="center" valign="top" width="130"><img src="<%=kkEng.getImageBase()%>/arrow_down.gif" border="0" alt=""></td>
						<td>
							<table border="0" width="100%" cellspacing="0" cellpadding="2"  class="body-content-tab">
								<logic:iterate id="download" name="downloads" type="com.konakart.appif.DigitalDownloadIf">
									<%if (download.getProduct() != null) {%>
									<tr class="moduleRow" onMouseOver="rowOverEffect(this)" onMouseOut="rowOutEffect(this)">
										<td ><%=download.getProduct().getName()%></td>
										<td ><%=download.getProduct().getModel()%></td>
										<td ><bean:message key="after.login.body.downloaded"/>&nbsp;<%=download.getTimesDownloaded()%>&nbsp;<bean:message key="after.login.body.times"/></td>
										<logic:notEmpty  name="download"  property="expirationDate">
											<td  width="80"><%=kkEng.getDateAsString(download.getExpirationDate())%></td>
										</logic:notEmpty>
										<td  align="right">
											<html:link page="/DigitalDownload.do" paramId="ddId" paramName="download" paramProperty="id">
												<span class="button"><span><bean:message key="common.download"/></span></span>
											</html:link>
										</td>
									</tr>
									<%}%>
								</logic:iterate>
							</table>
						</td>
						<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			</div>			
		</logic:notEmpty>	
		<logic:notEmpty  name="cust"  property="orders">
			<br/>
			<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
					<td ><b><bean:message key="after.login.body.overview"/></b></td>
					<td >
						<html:link page="/ShowAllOrders.do"><u>(<bean:message key="after.login.body.showallorders"/>)</u></html:link>
					</td>
				</tr>
			</table>
			<div class="msg-box-no-pad">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
							<td  align="center" valign="top" width="130"><b><bean:message key="after.login.body.previousorders"/></b><br><img src="<%=kkEng.getImageBase()%>/arrow_south_east.gif" border="0" alt="" width="50" height="31"></td>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<logic:iterate id="order" name="cust"  property="orders" type="com.konakart.appif.OrderIf">	
										<tr class="moduleRow" onMouseOver="rowOverEffect(this)" onMouseOut="rowOutEffect(this)">
											<td  width="80"><%=kkEng.getDateAsString(order.getDatePurchased())%></td>
											<td >#<%=order.getId()%></td>
											<td ><%=order.getDeliveryName()%>, <%=order.getDeliveryCountry()%></td>
											<td ><%=order.getStatusText()%></td>
											<td  align="right"><b><%=kkEng.formatPrice(order.getTotalIncTax(),order.getCurrencyCode())%></b></td>
											<td  align="right">
												<html:link page="/ShowOrderDetails.do" paramId="orderId" paramName="order" paramProperty="id">
													<span class="small-button"><span><bean:message key="common.view"/></span></span>
												</html:link>
												<html:link page="/RepeatOrder.do" paramId="orderId" paramName="order" paramProperty="id">
													<span class="small-button"><span><bean:message key="common.repeat"/></span></span>
												</html:link>
											 	<%String enableInvoice=kkEng.getConfig("ENABLE_PDF_INVOICE_DOWNLOAD"); %>	
												<%if (enableInvoice != null && enableInvoice.equalsIgnoreCase("TRUE") ) {%>	
													<% if (kkEng.isPortlet()) {%>
														<a href="<%=request.getContextPath()%>/../konakartadmin/getPdf?ord=<%=order.getId()%>&rt=2&sed=<%=kkEng.getSessionId()%>&sid=<%=kkEng.getStoreId()%>&em=<%=kkEng.getEngConf().getMode()%>&cs=<%=kkEng.getEngConf().isCustomersShared()%>&ps=<%=kkEng.getEngConf().isProductsShared()%>&ts=<%=kkEng.getEngConf().isCategoriesShared()%>" target="_blank"> <img src="<%=kkEng.getImageBase()%>/icons/pdf.gif" border="0" alt="<bean:message key="common.download.invoice"/>" title="<bean:message key="common.download.invoice"/>"> </a>
													<% } else { %>
														<html:link page="/DownloadInvoice.do" paramId="orderId" paramName="order" paramProperty="id">
														<img  src="<%=kkEng.getImageBase()%>/icons/pdf.gif" style="vertical-align: middle;" border="0" alt="<bean:message key="common.download.invoice"/>" title=" <bean:message key="common.download.invoice"/> ">
														</html:link>
													<% } %>
												<% } %>
											</td>
										</tr>
									</logic:iterate>
								</table>
							</td>
							<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			 </div>		
		 </logic:notEmpty>	
		 <%if (kkEng.getCustomerMgr().getCurrentCustomer() != null && kkEng.getCustomerMgr().getCurrentCustomer().getType() != 2) { %>
			<br/>
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
						<td ><b><bean:message key="after.login.body.myaccount"/></b></td>
				</tr>
			</table>
			<div class="msg-box-no-pad">						
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td width="60"><img src="<%=kkEng.getImageBase()%>/account_personal.gif" border="0" alt="" width="60" height="60"></td>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/EditCustomer.do"><bean:message key="after.login.body.changeaccountinfo"/>.</html:link>
										</td>
									</tr>
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/AddressBook.do"><bean:message key="after.login.body.changeaddrbook"/>.</html:link>
										</td>
									</tr>
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/ChangePassword.do"><bean:message key="after.login.body.changepassword"/>.</html:link>
										</td>
									</tr>
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/ManagePreferences.do"><bean:message key="after.login.body.managepreferences"/>.</html:link>
										</td>
									</tr>
									<%if (rewardPointMgr.isEnabled()) { %>				
										<%int points = rewardPointMgr.pointsAvailable(); %>
										<tr>
											<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
												<html:link page="/ShowRewardPoints.do"><bean:message key="after.login.body.showrewardpoints"  arg0="<%=String.valueOf(points)%>"/>.</html:link>
											</td>
										</tr>
									<% } %>									
								</table>
							</td>
							<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			</div>
			<br/>
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
						<td ><b><bean:message key="after.login.body.myorders"/></b></td>
				</tr>
			</table>
			<div class="msg-box-no-pad">						
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
						<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td width="60"><img src="<%=kkEng.getImageBase()%>/account_orders.gif" border="0" alt="" width="60" height="60"></td>
						<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td>
							<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
										<html:link page="/ShowAllOrders.do"><bean:message key="after.login.body.vieworders"/>.</html:link>
									</td>
								</tr>
							</table>
						</td>
						<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			</div>
			<br/>
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
						<td ><b><bean:message key="after.login.body.emailnotifications"/></b></td>
				</tr>
			</table>
			<div class="msg-box-no-pad">						
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td width="60"><img src="<%=kkEng.getImageBase()%>/account_notifications.gif" border="0" alt="" width="60" height="60"></td>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/EditNewsletter.do"><bean:message key="after.login.body.subscribenewsletter"/>.</html:link>
										</td>
									</tr>
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/EditNotifiedProducts.do"><bean:message key="after.login.body.changeprodnotlist"/>.</html:link>
										</td>
									</tr>		                  								
								</table>
							</td>
							<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			</div>
			<%String giftRegistryEnabled=kkEng.getConfig("ENABLE_GIFT_REGISTRY"); %>	
			<%if (giftRegistryEnabled != null && giftRegistryEnabled.equalsIgnoreCase("TRUE") ) {%>	
				<br/>
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
							<td ><b><bean:message key="after.login.body.weddinglists"/></b></td>
					</tr>
				</table>
				<div class="msg-box-no-pad">						
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
						<tr>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td width="60"><img src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="" width="60" height="60"></td>
							<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
							<td>
								<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
									<tr>
										<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
											<html:link page="/CreateGiftRegistry.do"><bean:message key="after.login.body.createweddinglist"/>.</html:link>
										</td>
									</tr>
									<logic:notEmpty  name="cust"  property="wishLists">
										<logic:iterate id="wishList" name="cust" property="wishLists" type="com.konakart.appif.WishListIf">
										<%if (wishList != null && wishList.getListType()!= com.konakart.al.WishListMgr.WISH_LIST_TYPE ) {%>
											<tr>
												<td ><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0" alt="" width="12" height="10"> 
													<html:link page="/EditGiftRegistry.do" paramId="wishListId" paramName="wishList" paramProperty="id"><bean:message key="common.edit"/>&nbsp;<%=wishList.getName()%></html:link>
												</td>
											</tr>
										<%}%>
										</logic:iterate>
									</logic:notEmpty> 					
								</table>
							</td>
							<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						</tr>
					</table>
				</div>
			<% } %>
		<% } %>
	</div>
</div>						

