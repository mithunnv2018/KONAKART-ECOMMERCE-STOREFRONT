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
		var abc= document.getElementsByName("nationoffirstpub");
		var def=abc.item(0);
		var nationoffirstpub2=def.value;
		if(nationoffirstpub2.length==0)
		{
			alert("Select Nation of First Publication.");
			return false;	
		}

		var abc2= document.getElementsByName("yearofcompletion");
		var def2=abc2.item(0);
		var yearofcompletion2=def2.value;
		if(yearofcompletion2.length==0)
		{
			alert("Enter Year of Completion.");
			return false;	
		} 

		var abc3= document.getElementsByName("dateoffirstpublication");
		var def3=abc3.item(0);
		var dateoffirstpublication2=def3.value;
		if(dateoffirstpublication2.length==0)
		{
			alert("Enter Date of First Publication(MM/DD/YYYY).");
			
			return false;	
		} 
		return true;		
	}
</script>

<div class="body">

	<div class="body-content-div">

		<html:form action="SelectLink3?doprocess=true" onsubmit="return validate2(this);">
		<table>
			<tr>
				<td align="right"><font color="black" size="2">Published
						work?</font>:</td>
				<td><html:text readonly="true" property="hasbeenpublished"></html:text>
				</td>
				<td align="right"><font size="5" color="red">*</font> <font
					color="black" size="2">Nation of First Publication</font>:</td>
				<td><html:select property="nationoffirstpub">
						<html:option value=""></html:option>
						<html:optionsCollection name="PublicationForm"
							property="listofcountries" label="name" value="id" />

					</html:select></td>

			</tr>
			<tr>
				<td align="right"><font size="5" color="red">*</font><font
					color="black" size="2">Year of Completion (Year of Creation)</font>:</td>

				<td><html:text property="yearofcompletion"></html:text> <font
					color="black" size="1"> YYYY  </font>
				</td>
				<td align="right"><font color="black" size="2">International
						Standard Number Type</font>:</td>
				<td><html:select property="intstandardnumtype">
						<html:option value=""></html:option>
						<html:option value="ISBN">ISBN</html:option>
						<html:option value="ISRC">ISRC</html:option>
						<html:option value="ISSN">ISSN</html:option>

					</html:select></td>

			</tr>
			<tr>
				<td align="right"><font size="5" color="red">*</font> <font
					color="black" size="2">Date of First Publication <br> <font
						color="black" size="1">[MM/DD/YYYY]</font>:</font>
				</td>
				<td><html:text property="dateoffirstpublication"></html:text> <font
					color="black" size="1"> <u>Help</u>  </font></td>

				<td align="right"><font color="black" size="2">International
						Standard Number</font>:</td>

				<td><html:text property="intstandardnumber"></html:text>
				</td>

			</tr>
		</table>

		<p>
			<font color="black" size="2">If you have <b>Preregistered</b>
				your work under 17 U.S.C 408 (f) (and received a Preregistration
				number beginning with the PRE prefix),</font> <br /> <font color="black"
				size="2">give the Preregistration Number here. Click  <u>here</u>
			    for further information about Preregistration.</font>
		</p>

		<p align="center">
			<font color="black" size="2">Preregistration Number</font>:
			<html:text property="preregistrationnumber"></html:text>
		</p>

		<p>
			<font color="black" size="2">Click "Continue" to save the
				information and proceed to the "Authors" screen.</font>
		</p>
		<p align="right">
			<html:submit styleId="olegbutton1" value="Continue"></html:submit>
			&nbsp; &nbsp; &nbsp;
			<a id="olegbutton1" href="CopyRightRegistration.do?linkno=3">Cancel</a>
		</p>
		</html:form>
	</div>
</div>
<div class="tile"></div>

