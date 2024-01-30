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
<%@ taglib uri="/tags/struts-nested" prefix="nested" %>

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

<html:form  action="/EditNotifiedProductsSubmit.do" styleId="form1">
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="edit.notifiedproducts.body.prodnots"/>" title=" <bean:message key="edit.notifiedproducts.body.prodnots"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="edit.notifiedproducts.body.prodnots"/>
		 </div>
		<div class="body-content-div">
			<b><bean:message key="edit.notifiedproducts.body.myprodnots"/></b>
			<div class="msg-box"><bean:message key="edit.notifiedproducts.body.info"/>.</div>

			<br/><b><bean:message key="edit.notifiedproducts.body.gprodnots"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr class="moduleRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">
						<td  width="30">
							<%
													com.konakart.forms.EditNotifiedProductForm myForm = (com.konakart.forms.EditNotifiedProductForm) session.getAttribute("EditNotifiedProductForm"); 					
													myForm.setGlobalNotificationBool(cust.getGlobalProdNotifier()==1?true:false);
							%>
							<html:checkbox name="EditNotifiedProductForm" property="globalNotificationBool"/>
						</td>
						<td ><b><bean:message key="edit.notifiedproducts.body.gprodnots"/></b></td>
					</tr>
					<tr>
						<td width="30">&nbsp;</td>
						<td ><bean:message key="edit.notifiedproducts.body.recprodnots"/>.</td>
					</tr>
				</table>
			</div>		
			<logic:lessThan name="cust" property="globalProdNotifier" value="1">					
				<br/><b><bean:message key="edit.notifiedproducts.body.prodnots"/></b>
				<div class="msg-box">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
							<%
																// Populate the form
																if (cust != null && cust.getProductNotifications() != null)
																{
														 
															java.util.ArrayList prodList = new java.util.ArrayList();
															for (int i = 0; i < cust.getProductNotifications().length; i++)
															{
																com.konakart.appif.ProductIf p = cust.getProductNotifications()[i];
																com.konakart.al.NotifiedProductItem npf = new com.konakart.al.NotifiedProductItem(p.getId(), p.getName());
																prodList.add(npf);
															}
															myForm.setItemList(prodList);
																}
							%>		
						<logic:notEmpty name="EditNotifiedProductForm"  property="itemList">		
							<tr>
								<td  colspan="2"><bean:message key="edit.notifiedproducts.body.remprodnots"/>.</td>
							</tr>									
							<nested:iterate id="item" property="itemList" name="EditNotifiedProductForm" type="com.konakart.al.NotifiedProductItem">
								<tr class="moduleRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">
									<td  width="30"><nested:checkbox property="remove"/></td>
									<td ><b><nested:write property="prodName"/></b></td>
								</tr>
							</nested:iterate>
						</logic:notEmpty>	
						<logic:empty name="EditNotifiedProductForm"  property="itemList">												
							<tr>
								<td ><bean:message key="edit.notifiedproducts.body.noprodnots"/>.</td>
							</tr>
						</logic:empty>	
							</table>
				</div>
			</logic:lessThan>											
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

