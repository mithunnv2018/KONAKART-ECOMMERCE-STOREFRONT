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
		var abc= document.getElementsByName("yearofcompletion");
		var def=abc.item(0);
		var yearofcompletion2=def.value;
		if(yearofcompletion2.length!=4)
		{
			alert("Enter Year of Completion.(YYYY)");
			return false;	
		}
		 
		return true;		
	}
</script>
<div class="body">

	<div class="body-content-div">
		<html:form action="SelectLink3?doprocess=true" onsubmit="return validate2(this);" >

		<table>
			<tr>
				<td><font color="black" size="2">Has this work been
						published?</font>:</td>
				<td><html:text readonly="true" property="hasbeenpublished"></html:text>
				</td>

			</tr>
			<tr>
				<td><font size="5" color="red">*</font> <font color="black"
					size="2">Year of Completion (year of Creation)</font>:</td>
				<td><html:text property="yearofcompletion"></html:text> <font color="black"
					size="1"> YYYY  </font>
				</td>
			</tr>
		</table>

		<p>
			<font color="black" size="2">If you have <b>Preregistered</b>
				your work under 17 U.S.C 408 (f) (and received a Preregistration
				number beginning with</font> <br /> <font color="black" size="2">the
				PRE prefix), give the Preregistration number here. Click  <u>here</u>
			  for further information about Preregistration.</font>

		</p>

		<p>
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
			<a  id="olegbutton1" href="CopyRightRegistration.do?linkno=3">Cancel</a>
		</p>
		</html:form>

	</div>
</div>
<div class="tile"></div>

