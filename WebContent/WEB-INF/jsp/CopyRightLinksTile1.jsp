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
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page  isELIgnored="false" %>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />

<div class="body">
	<div class="body-header">
		<img style="float: right"
			src="<%=kkEng.getImageBase()%>/table_background_specials.gif"
			border="0" alt="<bean:message key="information.tile.aboutus"/>"
			title=" <bean:message key="information.tile.aboutus"/> "
			width="<%=kkEng.getHeadingImageWidth()%>"
			height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="information.tile.aboutus" />
	</div>
	<%
		String[] links2 = { "Type of Work", "Titles",
				"Publication/Completion", "Authors", "Claimants",
				"Limitation of Claim","Rights & Permissions","Correspondent",
				"Mail Certificate","Special Handling","Certification","Review Submission"};
		
	%>
	<div class="body-content-div">
		<table border="0">
			<thead>
				<tr>
					 
					<td><b>Links</b></td>
 
				</tr>
			</thead>
				<%for(int i=0;i<links2.length;i++)
				 {
				%>
			<tr>
				 
				 
				<td>
				<%
			 //	<a href="CopyRightRegistration.do?linkno=<%= (i+1) "> links2[i]</a>
				%>
				<%= links2[i] %>
				 
				</td>
 			</tr>
				
				<%} %>

		</table>

	</div>
</div>
<!--<div class="tile">
	<div class="button-left">
		<div class="button-right">
			<div class="button-bottom">
				<div class="button-bottom-left">
					<div class="button-bottom-right">
						<div class="button-top">
							<div class="button-top-left">
								<div class="button-top-right">
									<div class="button-tile" align="right">
										<html:link page="/Welcome.do">
											<span class="button"><span><bean:message
														key="common.continue" />
											</span>
											</span>
										</html:link>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

-->