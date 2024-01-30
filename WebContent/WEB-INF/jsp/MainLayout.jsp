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
<%@ taglib uri="/tags/struts-tiles" prefix="tiles" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<logic:notEmpty name="konakartKey">
	<html>
	<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
		<head>
			<title id="target.title"><%=kkEng.getPageTitle()%></title>
			<meta name="keywords" content="<%=kkEng.getMetaKeywords()%>" />
			<meta name="description" content="<%=kkEng.getMetaDescription()%>" />
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/skin_style.css" />
			<script language="JavaScript" type="text/javascript">
 					if (top.location != location) {
    					top.location.href = document.location.href ;
  					}
			</script>
			<!--- KonaKart v6.3.0.0.8279 -->
		</head>
		<body>
		    <table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td>
						<tiles:insert attribute="header" />
					</td>
				</tr>
				<tr>
					<td>
						<table cellpadding="3" cellspacing="3" border="0" width="100%">
							<tr>
								<td width="160" valign="top">
									<table border="0" width="100%" cellspacing="0" cellpadding="2">
										<tr>
											<td>
												<tiles:insert attribute="leftTile1" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile2" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile3" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile4" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile5" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile6" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="leftTile7" />
											</td>
										</tr>
									</table>
								</td>
								<td  valign="top">
									<table border="0" width="100%" cellspacing="0" cellpadding="2">
										<tr>
											<td>
												<tiles:insert attribute="body" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="body1" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="body2" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="body3" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="body4" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="body5" />
											</td>
										</tr>
									</table>
								</td>
								<td width="160" valign="top">
									<table border="0" width="100%" cellspacing="0" cellpadding="2">
										<tr>
											<td>
												<tiles:insert attribute="rightTile1" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile2" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile3" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile4" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile5" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile6" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile7" />
											</td>
										</tr>
										<tr>
											<td>
												<tiles:insert attribute="rightTile8" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<tiles:insert attribute="footer" />
					</td>
				</tr>
			</table>
	
			<%=kkEng.getAnalyticsCode()%>
		</body>
	</html>
</logic:notEmpty>
