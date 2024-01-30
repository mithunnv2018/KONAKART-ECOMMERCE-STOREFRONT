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
		var abc2= document.getElementsByName("organizationame");
		var def2=abc2.item(0);
		var organizationame2=def2.value;
 
		if(firstname2.length==0 && organizationame2.length==0)
		{
			alert("Enter Author Name or Organization Name.");
			return false;	
		}

//isauthorscontribution
		var abc6= document.getElementsByName("isauthorscontribution");
		var def6=abc6.item(0);
		var isauthorscontribution2=def6.value;

		if(isauthorscontribution2.length==0)
		{
			alert("Enter if this author's contribution a work made for hire.");
			return false;	
		}

		
		var abc3= document.getElementsByName("citizenship");
		var def3=abc3.item(0);
		var citizenship2=def3.value;

		if(citizenship2.length==0)
		{
			alert("Enter Citizenship.");
			return false;	
		}
		var abc4= document.getElementsByName("domicile");
		var def4=abc4.item(0);
		var domicile2=def4.value;

		if(domicile2.length==0)
		{
			alert("Enter Domicile.");
			return false;	
		}
		var abc5= document.getElementsByName("selectedauthorcontribution");
		var abc6= document.getElementsByName("authorcreatedother");
		var def6=abc6.item(0);
		var authorcreatedother2=def6.value;
		
		var didcheck=false;
		for(i=0;i<abc5.length;i++)
		{
			var def5=abc5.item(i);
			if(def5.checked)
			{
				didcheck=true;
			}
		}
		// alert("selectedauthorcontribution2="+didcheck);

		if(didcheck==false )
		{
			if(authorcreatedother2.length==0){
			alert("Check the appropriate box(es) to indicate the author's contribution.");
			return false;	
			}
		}
		

		
		return true;		
	}
</script>
<div class="body">

	<div class="body-content-div">

		<p>
			<font color="black" size="2">  <b> <u>Author's Name</u> </b>  &nbsp;Give
				either an individual name OR an organization name, but not both. An
				author is a</font> <br /> <font color="black" size="2">person who
				actually created the contribution, unless the contribution was "<u>Made
						for hire</u>" in which case</font> <br /> <font color="black" size="2">the
				<b>employer</b> is the author. Either citizenship/domicile of the
				author is also required.</font>
		</p>

		<html:form action="DoneAddNewAuthor" onsubmit="return validate2(this);">
			<table>
				<tr>
					<td><b>Individual author:</b></td>
					<td><font color="red" size="2"><b>OR</b> </font></td>
					<td><b>Organization:</b></td>
				</tr>
				<tr>
					<td>First Name: <html:text property="firstname"></html:text>
					</td>
					<td></td>
					<td>Organization Name: <html:text property="organizationame"></html:text>
					</td>
				</tr>
				<tr>
					<td>Middle Name: <html:text property="middlename"></html:text>
					</td>
					<td><font color="black" size="1"><u>Help</u>  </font></td>
					<td></td>
				</tr>
				<tr>
					<td>Last Name: <html:text property="lastname"></html:text>
					</td>
					<td></td>
					<td></td>
				</tr>

			</table>
			<p>
				&nbsp;Is this author's contribution a <u>work
						made for hire</u>   ?:
				<html:select property="isauthorscontribution">
					<html:option value=""></html:option>
					<html:option value="Yes">Yes</html:option>
					<html:option value="No">No</html:option>

				</html:select>

			</p>

			<table>
				<tr>
					<td><font size="5" color="red">*</font>Citizenship: <html:select
							property="citizenship">
							<html:option value=""></html:option>

							<html:optionsCollection name="NewAuthorsForm"
								property="listofcountries" label="name" value="id" />

 						</html:select>
					</td>
					<td><font color="black" size="1"> <u>Help</u>  </font></td>
					<td>Anonymous: <html:checkbox property="isanonymous"
							value="Yes"></html:checkbox> <font color="black" size="1"><u>Help</u> </font>
					</td>

				</tr>
				<tr>
					<td><font size="5" color="red">*</font>Domicile: <html:select
							property="domicile">
							<html:option value=""></html:option>
							<html:optionsCollection name="NewAuthorsForm"
								property="listofcountries" label="name" value="id" />
						</html:select></td>
					<td><font color="black" size="1"><u>Help</u>   </font></td>
					<td>Pseudonymous: <html:checkbox property="ispseudonymous"
							value="Yes"></html:checkbox> <font color="black" size="1">
							<u>Help</u>  </font>
					</td>
				</tr>

				<tr>
					<td>Year of Birth: <html:text property="yearofbirth"></html:text>
					</td>
					<td><font color="black" size="1">YYYY  </font></td>
					<td>Pseudonym: <html:text property="pseudonym"></html:text> <font
						color="black" size="1"><u>Help</u> </font>
					</td>
				</tr>
				<tr>
					<td>Year of Death: <html:text property="yearofdeath"></html:text>
					</td>
					<td><font color="black" size="1">YYYY 
					</font></td>
					<td></td>
				</tr>
			</table>

			<p>
				<font color="black" size="2">Check the appropriate box(es) to
					indicate the author's contribution.</font>
					
			</p>
			<br/>
			<p>
				<font size="5" color="red"><b>*</b></font><b>Author Created:</b>
				<logic:iterate  name="NewAuthorsForm" id="authorcon" property="authorcontribution">
					<html:multibox property="selectedauthorcontribution">
						<bean:write name="authorcon"/>
					</html:multibox>
					<bean:write name="authorcon"/>
				</logic:iterate>
				
			</p>
			<p>
			<b>Other:</b><html:text property="authorcreatedother"></html:text>
			</p>
 			<p>
				<html:submit styleId="olegbutton1" value="Add"></html:submit>
				&nbsp; &nbsp;&nbsp; &nbsp;

				<a id="olegbutton1" href="CopyRightRegistration.do?linkno=4"> Cancel</a>

			</p>
		</html:form>
	</div>
</div>
<div class="tile"></div>

