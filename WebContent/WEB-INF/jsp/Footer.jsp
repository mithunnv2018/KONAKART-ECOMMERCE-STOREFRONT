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

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />

<div class="tile">
	<div class="footer-tile">
		<!--- box border -->
		<div class="footer-left">
			<div class="footer-right">
				<div class="footer-bottom">
					<div class="footer-bottom-left">
						<div class="footer-bottom-right">
							<div class="footer-top">
								<div class="footer-top-left">
									<div class="footer-top-right">
										<!-- -->
										<div class="footer1">
											<table width="98%" class="footer2">
												<tr>
													<td align="center">
													<img src="<%=kkEng.getImageBase()%>/icons/info.png"
															border="0" /> <html:link page="/ShippingAndReturns.do"
																 >
																<bean:message key="information.tile.shippingandreturns" />
															</html:link>
													</td> 
													<td>| <html:link page="/PrivacyNotice.do"
																 >
																<bean:message key="information.tile.privacynotice" />
															</html:link>
													</td>
													<td>
															| <html:link page="/ConditionsOfUse.do"
																>
																<bean:message key="information.tile.conditionsofuse" />
															</html:link>|
													</td>
													 
												</tr>
												<tr>
												<td height="10px"></td>
												<td></td>
												<td></td>
												</tr>
												<tr>
													<td width="30%" align="left"><%=new SimpleDateFormat("EEEE d MMMM, yyyy ")
					.format(new Date())%></td>
													<!-- Please leave the "Powered by KonaKart" link - it's a condition of the licence -->
													<td width="40%" align="center"><a
														href="http://www.konakart.com" target="_blank">Powered
															by KonaKart</a>
													</td>
													<!--<td width="30%" align="right">Copyright &copy; 2007 DS
														Data Systems UK Ltd.</td>
												-->
													<td width="30%" align="right"><a href="SiteMap.do">Site
															Map</a></td>
												</tr>
												<tr>
													<td align="center" colspan="3">Duly Noted Ltd. , 560
														High Street , Leytonstone , London E11 3DH
														info@dulynoted.co.uk</td>
												</tr>
											</table>
										</div>
										<!--- end of box border -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- -->
	</div>
</div>

