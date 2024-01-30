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

		if(firstname2.length==0 || lastname2.length==0 )
		{
			alert("Enter First Name and Last Name.");
			return false;	
		}

		var abc4= document.getElementsByName("email");
		var def4=abc4.item(0);
		var email2=def4.value;

		if(email2.length==0  )
		{
			alert("Enter your Email ID.");
			return false;	
		}

		var abc5= document.getElementsByName("address1");
		var def5=abc5.item(0);
		var address12=def5.value;

		if(address12.length==0  )
		{
			alert("Enter your Postal Address.");
			return false;	
		}

		var abc6= document.getElementsByName("city");
		var def6=abc6.item(0);
		var city2=def6.value;

		if(city2.length==0  )
		{
			alert("Enter your City Name.");
			return false;	
		}


		var abc7= document.getElementsByName("countryid");
		var def7=abc7.item(0);
		var countryid2=def7.value;

		if(countryid2.length==0  )
		{
			alert("Enter your Country Name.");
			return false;	
		}
				
		return true;		
	}
</script>

<div class="body">

	<div class="body-content-div">

		<logic:equal value="8" parameter="linkno">

			<p>
				<font color="black" size="2"> This is the person the
					Copyright Office will contact if it has questions about this
					application. <br /> <br /> </font>
			</p>
			<p>
				<font color="black" size="2">Completion of the name, email
					address and correspondence address is mandatory. </font>
			</p>

			 
			<html:form action="SelectLink8" onsubmit="return validate2(this);">
			
			<table width="100%">
				<tr>
					<td align="center"><b>Individual:</b></td>
					<td></td>
					<td align="center"><b>Organization:</b></td>

				</tr>

				<tr>
					<td><font size="5" color="red">*</font><label
						style="FONT-WEIGHT: bold;"> First Name: </label> <html:text
							property="firstname"></html:text></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Organization
							Name:</label> <html:text property="organizationname"></html:text></td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Middle Name: </label> <html:text
							property="middlename"></html:text></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><font size="5" color="red">*</font><label
						style="FONT-WEIGHT: bold;"> Last Name: </label> <html:text
							property="lastname"></html:text></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><br /></td>
					<td><br /></td>
					<td><br /></td>
				</tr>
				<tr>
					<td><font size="5" color="red">*</font><label
						style="FONT-WEIGHT: bold;"> Email: </label> <html:text
							property="email"></html:text></td>
					<td></td>
					<td><font size="5" color="red">*</font><label
						style="FONT-WEIGHT: bold;">Address 1:</label> <html:text
							property="address1"></html:text></td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;">Phone: </label> <html:text
							property="phone"></html:text></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Address 2:</label> <html:text
							property="address2"></html:text></td>
				</tr>

				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Alternate
							Phone: </label> <html:text property="alternatephone"></html:text></td>
					<td></td>
					<td><font size="5" color="red">*</font><label
						style="FONT-WEIGHT: bold;">City:</label> <html:text
							property="city"></html:text></td>
				</tr>
				<tr>
					<td><label style="FONT-WEIGHT: bold;"> Fax: </label> <html:text
							property="fax"></html:text></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">State:</label> <html:select
							property="state">
							<html:option value=""></html:option>
							<html:option value="Non-U.S.">Non-U.S.</html:option>

							<html:optionsCollection name="CorrespondentForm"
								property="listofstates" label="zoneCode" value="zoneCode" />
						</html:select></td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Postal Code:</label> <html:text
							property="postalcode"></html:text></td>
				</tr>

				<tr>
					<td></td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Country:</label> <html:select
							property="countryid">
							<html:option value=""></html:option>

							<html:optionsCollection name="CorrespondentForm"
								property="listofcountries" label="name" value="id" />

						</html:select></td>
				</tr>
				

			</table>
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=7" id="olegbutton1">Back</a>
			</p>			

				<p  align="right">
					<html:submit styleId="olegbutton1" value="Continue"></html:submit>
				</p>

			
			</html:form>
 			
			


		</logic:equal>



	</div>
</div>
<div class="tile"></div>

