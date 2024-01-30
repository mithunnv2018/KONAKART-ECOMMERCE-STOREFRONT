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
<%@ taglib uri="/tags/app" prefix="app" %>
<%@ taglib uri="/tags/struts-layout" prefix="layout" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>

<div class="tile">
	<div class="information-tile">
		<!--- box border -->
		<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
		<!-- -->
		<div class="tile-header">
			<img src="<%=kkEng.getImageBase()%>/icons/info.png" border="0"/>
			<bean:message key="information.tile.information"/>		
		</div>
		<div class="tile-content">
			<html:link page="/ShippingAndReturns.do"><bean:message key="information.tile.shippingandreturns"/></html:link><br>
			<html:link page="/PrivacyNotice.do"><bean:message key="information.tile.privacynotice"/></html:link><br>
			<html:link page="/ConditionsOfUse.do"><bean:message key="information.tile.conditionsofuse"/></html:link><br>
			<html:link page="/AboutUs.do"><bean:message key="information.tile.aboutus"/></html:link><br>	
			<html:link page="/ContactUs.do"><bean:message key="information.tile.contactus"/></html:link>	
		</div>
		<!--- end of box border -->
		</div></div></div></div></div></div></div></div>
		<!-- -->
	</div>
</div>

