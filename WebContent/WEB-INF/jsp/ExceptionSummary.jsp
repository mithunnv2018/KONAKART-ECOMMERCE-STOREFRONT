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
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<script type="text/javascript">
<!--
	function show(object) {
		document.getElementById("message").style.visibility='visible';
		document.getElementById("message").style.display='block';
	}
	
	function hide(object) {
		document.getElementById("message").style.visibility='hidden';
		document.getElementById("message").style.display='none';
	}
-->
</script>


<div class="body-content">
	<table border="0" width="100%" cellspacing="0" cellpadding="0" class="msg-box">
		<tr class="body-content-tab">
			<td colspan="2" valign="top" align="center">
				<bean:message key="exception.short.message"/>
			</td>
		</tr>
		<tr class="body-content-tab">
			<td class="pageHeading" valign="top" >
				<p align="center" class="konakart-HandCursor" onclick="show()"><bean:message key="exception.show.details"/></p>
			</td>
			<td class="pageHeading" valign="top" >
				<p align="center" class="konakart-HandCursor" onclick="hide()"><bean:message key="exception.hide.details"/></p>
			</td>
		</tr>
	</table>
 </div>
<div id="message" class="msg-box">
	<logic:messagesPresent> 
		<html:messages id="error">
			 <span class="body-content-tab"><bean:write name="error" filter="false"/></span>
		 </html:messages> 
	</logic:messagesPresent>
</div>
 
	<script type="text/javascript">
	<!--
		document.getElementById("message").style.visibility='hidden';
		document.getElementById("message").style.display='none';
	-->
	</script>	





