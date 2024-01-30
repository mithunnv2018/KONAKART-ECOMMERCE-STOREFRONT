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
<%--
		<logic:equal value="6" parameter="linkno">

			<p>
				<font color="black" size="2">Complete this screen to  <u>limit your claim</u> 
					 if this work contains
					or is based on previously registered material, previously <br />
					published material, material in the public domain or material not
					owned by this claimant. The purpose of this section is to<br />
					exclude such material from the claim and identify the new material
					upon which the present claim is based.<br /> </font>
			</p>
			<p>
				<font color="black" size="2"><b>If your work does not
						contain any preexisting material, click "Continue" to proceed to
						the Rights and Permissions <br> screen.</b> </font>
			</p>
--%>
<%--			<html:form action="SelectLink6"  enctype="multipart/form-data">
 			
 			<table width="100%">
				<tr>
					<td><font color="black" size="2"> <u>Material Excluded</u>:  </font></td>

					<td><font color="black" size="2"> <u>Previous Registration</u>:  </font>
					</td>

					<td><font color="black" size="2"> <u>New Material Included</u>:  </font>
					</td>

				</tr>
				<tr>
					<td>
						<html:checkbox property="excluded_text" value="Yes"></html:checkbox> 
					 <label>Text</label>
					</td>
					<td style="FONT-WEIGHT: bold;">1st Prev. Reg. #:  
						<html:text property="firstprevreg"></html:text>
					</td>
					<td><html:checkbox property="included_text" value="Yes" title="Text"></html:checkbox> <label>Text</label>
					</td>
				</tr>
				<tr>
					<td>
						<html:checkbox property="excluded_2dartwork" value="Yes"></html:checkbox>
					 	<label>2-D
							Artwork </label>
					</td>
					<td style="FONT-WEIGHT: bold;">Year:
						<html:text property="firstyear"></html:text>	
					</td>
					<td>
					<html:checkbox property="included_2dartwork" value="Yes"></html:checkbox> 
					 <label>2-D
							Artwork </label></td>

				</tr>
				<tr>
					<td>
						<html:checkbox property="excluded_photo" value="Yes"></html:checkbox>
					 <label>Photograph(s)
					</label></td>
					<td></td>
					<td> <html:checkbox property="included_photo" value="Yes"></html:checkbox>
					 <label>Photograph(s)
					</label></td>
				</tr>
				<tr style="FONT-WEIGHT: bold;">
					<td> 
					<html:checkbox property="excluded_jewelrydesign" value="Yes"></html:checkbox>
					 <label>Jewelry
							design </label></td>
					<td>2nd Prev. Reg. #: <html:text property="secondprevreg"></html:text>
					</td>
					<td> 
					<html:checkbox property="included_jewelrydesign" value="Yes"></html:checkbox>	
					 <label>Jewelry
							design </label></td>
				</tr>
				<tr>
					<td> 
					<html:checkbox property="excluded_architectural" value="Yes"></html:checkbox>
					 <label>Architectural
							work </label></td>
					<td style="FONT-WEIGHT: bold;">Year: 
						<html:text property="secondyear"></html:text>
					</td>
					<td> 
					<html:checkbox property="included_architectural" value="Yes"></html:checkbox>
					 <label>Architectural
							work </label></td>
				</tr>
				<tr>
					<td> 
					<html:checkbox property="excluded_sculpture" value="Yes"></html:checkbox>
					 <label>Sculpture</label>
					</td>
					<td></td>
					<td><html:checkbox property="included_sculpture" value="Yes"> </html:checkbox> <label>Sculpture</label>
					</td>

				</tr>
				<tr>
					<td>
					<html:checkbox property="excluded_drawing" value="Yes"></html:checkbox>
					 <label>Technical
							Drawing </label></td>
					<td></td>
					<td>
					<html:checkbox property="included_drawing" value="Yes"></html:checkbox>
					 <label>Technical
							Drawing </label></td>
				</tr>
				<tr>
					<td>
					<html:checkbox property="excluded_map" value="Yes"></html:checkbox>
					 <label>Map</label></td>
					<td></td>
					<td>
					<html:checkbox property="included_map" value="Yes"></html:checkbox>
					 <label>Map</label></td>

				</tr>

				<tr>
					<td align="left"><label style="FONT-WEIGHT: bold;">Other:</label> 
						<html:text property="excluded_other"></html:text>
					</td>
					<td></td>
					<td><label style="FONT-WEIGHT: bold;">Other:</label> 
						<html:text property="included_other"></html:text>
					</td>
				</tr>

			</table>
--%>			
			<html:form action="SelectLink6"  enctype="multipart/form-data">

			<h3>Upload File</h3>
			<p>
			
			<html:file  property="uploadfile"  ></html:file>
 			<br/>
 			<font color="#ff0000" >*</font>please call help line for extended space
 			</p>
 			<p>
 				<%
 					if(session.getAttribute("FILE_UPLOADED2")!=null)
 					{
 				%>
 					<p>File name is :<%=session.getAttribute("FILE_UPLOADED2") %></p>	
 				<%	} %>
 			</p>
<%-- 			
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=5" id="olegbutton1">Back</a>
			</p>			
--%>			
			<p align="right">
				<html:submit styleId="olegbutton1" value="Upload"> </html:submit>
			</p>
			</html:form>


<%--		</logic:equal>
--%>


	</div>
</div>
<div class="tile"></div>

