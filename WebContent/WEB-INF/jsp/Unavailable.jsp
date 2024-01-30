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

<div class="body-content">
	<table border="0" width="100%" cellspacing="0" cellpadding="0" class="msg-box">
		<tr class="body-content-tab">
			<td  valign="top" align="center">
				<logic:messagesPresent> 
					<html:messages id="error">
						 <span class="body-content-tab"><bean:write name="error" filter="false"/></span>
					 </html:messages> 
				</logic:messagesPresent>
			</td>
		</tr>		
	</table>
 </div>
 





