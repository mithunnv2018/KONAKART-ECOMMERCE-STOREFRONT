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

<html:form  action="/EditNewsletterSubmit.do" styleId="form1">
	<div class="body">
		<div class="body-header">
			<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_account.gif" border="0" alt="<bean:message key="edit.newsletter.title"/>" title=" <bean:message key="edit.newsletter.title"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
			<bean:message key="edit.newsletter.title"/>
		 </div>
		<div class="body-content-div">
			<b><bean:message key="edit.newsletter.mysubscriptions"/></b>
			<div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr class="moduleRow">
						<%
						com.konakart.forms.NewsletterForm myForm = (com.konakart.forms.NewsletterForm) request.getAttribute("NewsletterForm");
						%>															
						<% myForm.setNewsletterBool(cust.getNewsletter().equals("1")?true:false);%>
						<td ><html:checkbox name="NewsletterForm" property="newsletterBool"/></td>
						<td ><b><bean:message key="edit.newsletter.generalnewsletter"/></b></td>
					</tr>
					<tr>
						<td >&nbsp;</td>
						<td>
							<table border="0" cellspacing="0" cellpadding="2" class="body-content-tab">
								<tr>
									<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
									<td ><bean:message key="edit.newsletter.newslettercontents"/>.</td>
									<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
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
</html:form>


	


