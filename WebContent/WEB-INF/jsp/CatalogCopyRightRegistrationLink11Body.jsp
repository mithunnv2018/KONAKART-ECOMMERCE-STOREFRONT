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
		var abc= document.getElementsByName("icertify");
		var def=abc.item(0);
		//var icertify2=def.value;
		if(def.checked==false)
		{
			alert("Click on certify");
			return false;	
		}
		
		var abc2= document.getElementsByName("nameofindividual");
		var def2=abc2.item(0);
		var nameofindividual2=def2.value;
		if(nameofindividual2.length==0)
		{
			alert("Enter Name of Certifying Individual");
			return false;	
		}
		 
		return true;		
	}
</script>

<div class="body">

	<div class="body-content-div">

		<logic:equal value="11" parameter="linkno">

			<p>
				<font color="black" size="2">The Application must be
					certified by the author, copyright claimant, or owner of exclusive
					right(s), or by the authorized <br /> agent of any of the
					preceding.</font>
			</p>
			 
			<html:form action="SelectLink11" onsubmit="return validate2(this);">
			<p>
				<html:checkbox property="icertify" value="Yes"></html:checkbox>
				  <font color="black" size="2"><font
					size="5" color="red">*</font><b>I certify</b> that I am the author,
					copyright claimant, or owner of exclusive rights, or the authorized
					agent of the <br />author, copyright claimant, or owner of
					exclusive rights of this work and that the information given in
					this <br />application is correct to the best of my knowledge. </font>
			</p>

			<p>
				<font color="black" size="2"><font size="5" color="red">*</font><b>Name of certifying individual:</b> 
					<html:text property="nameofindividual"></html:text>
					
				 </font>
			</p>

			<p>
				<font color="black" size="2"> <b>Applicant's Internal Tracking Number (Optional):</b> 
					<html:text property="trackingnumber"></html:text>
				 </font>
			</p>
			<p>
				<font color="black" size="2"> <b>Note to Copyright Office (Optional):</b> 
					 
				 </font>
			</p>
			<p>
				<font color="black" size="2">This is the place to give any comments specific to this claim, the application, or the deposit copy, if necessary.
				</font>
				<br/>
				<html:textarea property="note" style="height: 48; width: 704"></html:textarea>
				
			</p>
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=10" id="olegbutton1">Back</a>
			</p>			

			<p align="right">
				<html:submit  styleId="olegbutton1" value="Continue"></html:submit>
			</p>
			</html:form>
 
		</logic:equal>



	</div>
</div>
<div class="tile"></div>

