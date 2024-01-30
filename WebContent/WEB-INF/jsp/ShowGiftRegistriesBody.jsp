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
<bean:define id="wishListMgr" name="kkEng" property="wishListMgr" type="com.konakart.al.WishListMgr"/>
<bean:define id="wishListArray" name="wishListMgr" property="currentWishLists"/>
<bean:define id="maxRows" name="wishListMgr" property="maxRows"/>

<table width="100%" >
	<tr>
		<td valign="top">
			<div class="body">
				<div class="body-header">
					<table width="100%" class="body-header">
						<tr>
							<td class="pageHeading" valign="top"><bean:message key="show.giftregistries.body.weddinglists.found"/></td>						
						 </tr>
					</table>
				 </div>
				<div class="body-content-div">
					<logic:empty name="wishListMgr" property="currentWishLists">
						<div class="msg-box">
							<bean:message key="show.giftregistries.body.no.weddinglists"/>.	
						</div>					
					</logic:empty>
					<logic:iterate id="wl" name="wishListArray" length="maxRows" type="com.konakart.appif.WishListIf">
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<tr>
								<td>
									<html:link page="/ShowGiftRegistryItems.do" paramId="wishListId" paramName="wl" paramProperty="id">
										<u><b><%=wl.getName()%></b></u>
									</html:link>
								</td>							
							</tr>
						</table>
						 <div class="msg-box">
							<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td width="50%"><bean:message key="show.giftregistries.body.groomname"/>:</td>
									<td width="50%"><%=wl.getCustomerFirstName() %>&nbsp;<%=wl.getCustomerLastName() %></td>
								</tr>
								<tr>
									<td width="50%"><bean:message key="show.giftregistries.body.bridename"/>:</td>
									<td width="50%"><%=wl.getCustomer1FirstName() %>&nbsp;<%=wl.getCustomer1LastName() %></td>
								</tr>
								<tr>
									<td width="50%"><bean:message key="show.giftregistries.body.eventdate"/>:</td>
									<td width="50%"><%=kkEng.getDateAsString(wl.getEventDate())%></td>
								</tr>
								<%if (wl.getLinkUrl() != null && wl.getLinkUrl().length() > 0) {%>
									<tr>
										<td width="50%"><bean:message key="create.gift.registry.body.event.link.url"/>:</td>
										<td width="50%"><a href="<%=wl.getLinkUrl()%>"><%=wl.getLinkUrl()%></a></td>
									</tr>
								<%}%>
							</table>
						</div><br/>
				</logic:iterate>	  
				<logic:notEmpty name="wishListMgr" property="currentWishLists">
					<table border="0" width="100%" cellspacing="0" cellpadding="2">
						<tr>
							<td class="smallText"><bean:message key="show.giftregistries.body.displaying"/>&nbsp;<b><%=wishListMgr.getCurrentOffset() + 1%></b> <bean:message key="show.giftregistries.body.to"/> <b><%=wishListMgr.getNumberOfWishLists() + wishListMgr.getCurrentOffset()%></b> (<bean:message key="show.giftregistries.body.of"/> <b><%=wishListMgr.getTotalNumberOfWishLists()%></b> <bean:message key="show.giftregistries.body.wishlists"/>)</td>
							<td class="smallText" align="right">
								<logic:equal name="wishListMgr" property="showBack" value="1">
									<html:link page="/NavigateWishList.do" paramId="navDir" paramName="wishListMgr" paramProperty="navBack" styleClass="pageResults"><u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u></html:link>&nbsp;&nbsp;
								</logic:equal>
								<logic:notEqual name="wishListMgr" property="showBack" value="1">
									<u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u>&nbsp;&nbsp;
								</logic:notEqual>
								<logic:equal name="wishListMgr" property="showNext" value="1">
									<html:link page="/NavigateWishList.do" paramId="navDir" paramName="wishListMgr" paramProperty="navNext" styleClass="pageResults"><u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></html:link>
								</logic:equal>
								<logic:notEqual name="wishListMgr" property="showNext" value="1">
									<u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u>
								</logic:notEqual>
							</td>
						</tr>
					</table>
				  </logic:notEmpty>
				</div>
			</div>						
			<div class="tile">
				<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
					<div class="button-tile">
						<html:link page="/CatalogGiftRegistrySearchPage.do">
							<span class="button"><span><bean:message key="common.back"/></span></span>
						</html:link>							                        				
					</div>
				</div></div></div></div></div></div></div></div>
			</div> 	
		</td>
	</tr>
</table>
