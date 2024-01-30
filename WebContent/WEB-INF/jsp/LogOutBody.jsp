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

<div class="body">
	<div class="body-header">
		<img style="float:left" src="<%=kkEng.getImageBase()%>/table_background_man_on_board.gif" border="0" alt="<bean:message key="account.created.body.account.created"/>" title=" <bean:message key="account.created.body.account.created"/> " width="175" height="198">			
		<bean:message key="header.logout.page"/>
	 </div>
	<div class="body-content-div">
		<p><bean:message key="logout.body.message"/></p>
	</div>
</div>						
<div class="tile" style="clear:both">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile" align="right">
				<html:link page="/Welcome.do">
					<span class="button"><span><bean:message key="common.continue"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
</div> 	
