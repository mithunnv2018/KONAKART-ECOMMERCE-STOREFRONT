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
		<bean:message key="information.tile.sitemap" />
	</div>
	<div class="body-content-div">
		<table width="98%" border="2">
			<tr >
				<td > <b><a href="Welcome.do">Home</a> </b> </td>
				<td class="smallTextGreen">Welcome Home page</td>
			</tr>
			<tr>
				<td> <b><a href="ShippingAndReturns.do">Shipping And Returns</a> </b> </td>
				<td class="smallTextGreen">Shipping & Returns page</td>
			</tr>
			<tr>
				<td> <b><a href="PrivacyNotice.do">Privacy Notice</a> </b> </td>
				<td class="smallTextGreen">Privacy Notice page</td>
			</tr>
			<tr>
				<td> <b><a href="ConditionsOfUse.do">Conditions of use</a> </b> </td>
				<td class="smallTextGreen">Conditions of use page</td>
			</tr>
			<tr>
				<td> <b><a href="AboutUs.do">About Us</a> </b> </td>
				<td class="smallTextGreen">About Us page</td>
			</tr>
			<tr>
				<td> <b><a href="ContactUs.do">Contact Us</a> </b> </td>
				<td class="smallTextGreen">Contact Us page</td>
			</tr>
			<tr>
				<td> <b><a href="ShowAllSpecials.do">Show All Specials</a> </b> </td>
				<td class="smallTextGreen">Show All Specials page</td>
			</tr>
			<tr>
				<td> <b><a href="LogIn.do">Log In</a> </b> </td>
				<td class="smallTextGreen">Log In page</td>
			</tr>
			<tr>
				<td> <b><a href="ShowCartItems.do">Show Cart Items</a> </b> </td>
				<td class="smallTextGreen">Show Cart Items page</td>
			</tr>
			<tr>
				<td> <b><a href="CheckoutDelivery.do">Checkout Delivery</a> </b> </td>
				<td class="smallTextGreen">Checkout Delivery page</td>
			</tr>
			
		</table>
	</div>
</div>
<div class="tile">
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

