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
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />

<div class="body">

	<div class="body-content-div">

		<logic:equal value="7" parameter="linkno">

			<p>
				<font color="black" size="2"> You may provide contact
					information for a person and/or organization to be contacted
					regarding copyright management <br /> information or permission to
					use this work.</font>
			</p>
			<p>
				<font color="black" size="2"><b>Important: If you prefer
						not to provide personally identifying information, you may list a
						third party agent or <br> a post office box.</b> </font>
			</p>

			<html:form action="SelectLink7">
 			<table width="100%">
				<tr>
					<td><b>Individual:</b></td>
					<td></td>
					<td><b>Organization:</b></td>

				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;"> First Name: </label> <html:text property="firstname"></html:text>
					</td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Organization Name:</label> 
						<html:text property="organizationname"></html:text>
					</td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Middle Name: </label> 
					<html:text property="middlename"></html:text>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Last Name: </label> 
						<html:text property="lastname"></html:text>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><br /></td>
					<td><br /></td>
					<td><br /></td>
				</tr>
				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Email: </label> 
						<html:text property="email"></html:text>
					</td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Address 1:</label> 
						<html:text property="address1"></html:text>	
					</td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;">Phone: </label> <html:text property="phone"></html:text></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Address 2:</label> <html:text property="address2"></html:text>
					</td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Alternate Phone: </label>  <html:text property="alternatephone"></html:text>
					</td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">City:</label> <html:text property="city"></html:text></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">State:</label> 
							<html:select property="state">
								<html:option value=""></html:option>
								<html:option value="Non-U.S.">Non-U.S.</html:option>
							<html:optionsCollection name="RightsPermissionForm" property="listofstates" label="zoneCode" value="zoneCode"/>
								
							</html:select>
					</td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Postal Code:</label> <html:text property="postalcode"></html:text>
					</td>
				</tr>

				<tr>
					<td> </td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Country:</label> 
					<html:select property="countryid">
						<html:option value=""></html:option>
							<html:optionsCollection name="RightsPermissionForm" property="listofcountries" label="name" value="id" />
						
					</html:select>
					
					</td>
				</tr>


			</table>
			
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=6" id="olegbutton1">Back</a>
			</p>			
			
			<p align="right">
				<html:submit styleId="olegbutton1" value="Continue"></html:submit>
			</p>
			</html:form>
 
		</logic:equal>



	</div>
</div>
<div class="tile"></div>

