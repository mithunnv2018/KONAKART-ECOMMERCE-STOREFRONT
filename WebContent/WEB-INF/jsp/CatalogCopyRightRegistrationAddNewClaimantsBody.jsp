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
// version 2.1 of the License, or (at your html:option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//

--%>
<%@page import="com.konakart.oleg.OlegTasks"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ page import="java.util.*"%>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />
<style>
<!--
	#olegbutton1
	{
		border:1px;  
		COLOR: #ffffff; 
		BACKGROUND-COLOR: #0099F2;
		font-size: 15pt;
		padding: 3px;
	}
-->
</style>
 
<script language="JavaScript">
	function validate2(formabc)
	{
		//alert("HI");
		var abc= document.getElementsByName("firstname");
		var def=abc.item(0);
		var firstname2=def.value;
		var abc3= document.getElementsByName("lastname");
		var def3=abc3.item(0);
		var lastname2=def3.value;
		
		var abc2= document.getElementsByName("organizationname");
		var def2=abc2.item(0);
		var organizationame2=def2.value;
 
		if((firstname2.length==0 || lastname2.length==0) && organizationame2.length==0)
		{
			alert("Enter Author's full Name or Organization Name.");
			return false;	
		}
		if(firstname2.length>0 && organizationame2.length>0)
		{
			alert("Enter either an individual name OR an organization name, but not both.")
			return false;
		} 
		var abc4= document.getElementsByName("address1");
		var def4=abc4.item(0);
		var address12=def4.value;
 
		if(address12.length==0)
		{
			alert("Enter Address.");
			return false;	
		}

		var abc5= document.getElementsByName("city");
		var def5=abc5.item(0);
		var city2=def5.value;
 
		if(city2.length==0)
		{
			alert("Enter City Name.");
			return false;	
		}

		var abc6= document.getElementsByName("countryid");
		var def6=abc6.item(0);
		var countryid2=def6.value;
 
		if(countryid2.length==0)
		{
			alert("Select Country.");
			return false;	
		}
		var abc7= document.getElementsByName("state");
		var def7=abc7.item(0);
		var state2=def7.value;
 
		if(state2.length==0)
		{
			alert("Select State of Country.");
			return false;	
		}
		 
	}
</script>
<div class="body">

	<div class="body-content-div">

		<p>
			<font color="black" size="2"><b><u> Claimant's Name</u> </b>  &nbsp; Give
				either an individual name OR an organization name, but not both.</font>
		</p>

		<html:form action="DoneAddNewClaimants" onsubmit="return validate2(this);">
			<table>
				<tr>
					<td><b>Individual author:</b>
					</td>
					<td></td>
					<td><font color="red" size="2"><b>OR</b> </font>
					</td>
					<td><b>Organization:</b>
					</td>
					<td></td>
				</tr>
				<tr>
					<td><p align="right"><font size="4" color="red"><b>*</b> </font>First Name:</p></td>
					<td><html:text property="firstname"></html:text>
					</td>
					<td></td>
					<td><p align="right"><font size="4" color="red"><b>*</b> </font>Organization
						Name: </p></td>
					<td><html:text property="organizationname"></html:text></td>
				</tr>
				<tr>
					<td><p align="right">Middle Name:</p></td>
					<td><html:text property="middlename"></html:text>
					</td>
					<td><font color="black" size="1"> <u>Help</u>   </font>
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><p align="right"><font size="4" color="red"><b>*</b> </font>Last Name:</p></td>
					<td><html:text property="lastname"></html:text>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><p align="right"><font size="4" color="red"><b>*</b> </font>Address 1:</p></td>
					<td><html:text property="address1"></html:text>
					</td>
					<td></td>
					<td><p align="right">State: 
					</p></td>
					<td>
						<html:select property="state">
							<html:option value=""></html:option>
							<html:option value="Non-U.S.">Non-U.S.</html:option>
							
							<html:optionsCollection name="NewClaimantsForm" property="listofstatezones" label="zoneCode" value="zoneCode"/>
						</html:select></td>
				</tr>
				<tr>
					<td><p align="right">Address 2:</p></td>
					<td><html:text property="address2"></html:text>
					</td>
					<td></td>
					<td><p align="right">Postal Code: 
					</p></td>
					<td><html:text property="postalcode"></html:text></td>
				</tr>
				<tr>
					<td><p align="right"><font size="4" color="red"><b>*</b> </font>City:</p></td>
					<td><html:text property="city"></html:text>
					</td>
					<td></td>
					<td><p align="right">Country: 
					</p></td>
					<td><html:select property="countryid">
							<html:option value=""></html:option>

							<html:optionsCollection name="NewClaimantsForm" property="listofcountries" label="name" value="id" />

						</html:select></td>
				</tr>

			</table>
			<p>
				<font color="black" size="2">If any claimant is not an
					author, you must include a  <u>transfer statement</u>   showing how the
					claimant obtained the</font> <br /> <font color="black" size="2">copyright.</font>
			</p>

			 <table>
			 	<tr>
			 		<td> Transfer Statement:</td>
			 		<td>
			 			<html:select property="transferstatement">
			 				<html:option value=""></html:option>
			 				<html:option value="By written agreement">By written agreement</html:option>
			 				<html:option value="By inheritance">By inheritance</html:option>
			 				<html:option value="Other">Other</html:option>
			 			</html:select>
			 		</td>
			 		
			 	</tr>
			 	<tr>
			 		<td> Transfer Statement Other:</td>
			 		<td>
			 		<html:textarea property="othertransferstatement"></html:textarea>
			 		</td>
			 	</tr>
			 </table>
 			<p>
				<html:submit styleId="olegbutton1" value="Add"></html:submit>
					&nbsp; &nbsp; &nbsp;
				<a id="olegbutton1" href="CopyRightRegistration.do?linkno=5"> Cancel</a>

			</p>
		</html:form>
	</div>
</div>
<div class="tile"></div>

