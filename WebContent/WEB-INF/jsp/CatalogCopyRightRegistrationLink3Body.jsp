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
		var abc= document.getElementsByName("yearofcompletion");///hasbeenpublished");
		var def=abc.item(0);
		var hasbeenpublished=def.value;
		if(hasbeenpublished.length==0)
		{
			alert("Select year of completion!");// if the work has been published!");
			return false;	
		}
		 
		return true;		
	}
</script>

<div class="body">
   
	<div class="body-content-div">
<%--
		<logic:equal value="3" parameter="linkno">

			<p>
				<font color="black" size="2"> <b>Publication</b> results from
					the distribution of copies of a work to the public by sale or other
					transfer of ownership, <br /> or by rental, lease, or lending. A
					work is also "published" if there has been an offering to
					distribute copies to a <br /> group of persons for purposes of
					further distribution, public performance, or public display. A
					public performance <br /> or display does not, by itself,
					constitute "publication". <br /> </font>
			</p>
			<p>
				<font color="black" size="2">For information on the
					publication of works online, click   <u>here</u>  . Indicate whether this work has
					been published by</font> <br /> <font color="black" size="2">
					selecting either "yes" or "no" from the drop down list below.</font>
			</p>
--%>			
			<html:form action="SelectLink3?doprocess=true"> 
			<!-- onsubmit="return validate2(this);">-->
			
				<html:hidden property="hasbeenpublished" value="No" />
				<html:hidden property="preregistrationnumber" value=" " />
				
				 
					<h3 align="center">Year of completion: </h3>
					<p align="center">
					<html:select property="yearofcompletion">
							<html:option value=""></html:option>
					 	<% for(int i=1900;i<=2020;i++)
						{	
						%>		
					
							<html:option value="<%=String.valueOf(i)%>"> <%=String.valueOf(i) %> </html:option>
						<%
						}
						%>
					</html:select>
				</p>

<%--
				<p align="center">
					<font size="5" color="red"><b>*</b> </font> Has this work been
					published?:

						
						
					<html:select property="hasbeenpublished">
						<html:option value=""></html:option>
						<html:option value="Yes">Yes</html:option>
						<html:option value="No">No</html:option>

					</html:select>
 				</p>
 				<p align="left" >
					<a  href="CopyRightRegistration.do?linkno=2" id="olegbutton1" >Back</a>
				</p>
--%>				
				<p align="right" style="width: 100%">
					<html:submit styleId="olegbutton1" value="Save"></html:submit>
				</p>

			</html:form>

			<p></p>


<%--
		</logic:equal>
--%>


	</div>
</div>
<div class="tile"></div>

