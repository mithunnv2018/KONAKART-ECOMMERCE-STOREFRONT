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

		<logic:equal value="10" parameter="linkno">

			<p>
				<font color="black" size="2">Complete this section only if
					you are applying for  <u>special handling</u>   of the case. The
					Application must be certified for</font> <br /> Special Handling by the
				author/claimant of exclusive right(s), or by the authorized agent of
				any of the preceding.
			</p>
			<p>
				<!-- <font color="red" size="2"><b>Warning: The special
						handling fee for a single claim is $760</b> </font> -->
			</p>

			<html:form action="SelectLink10">
			<%-- <p>
				<html:checkbox property="specialhandling" value="Yes"></html:checkbox>
				<font color="black" size="2"><b>Special
						Handling</b> (The information requested below is required for Special
					Handling claims)</font>
			</p> --%>

			<p>
				<font color="black" size="2"><b>Compelling Reason(s)</b> (At
					least one must be selected)</font>
			</p>

			<table width="100%"   cellspacing="20">
				<tr>
					<td width="5%"><html:checkbox property="reason_pending" value="Yes"></html:checkbox></td>
					<td width="95%">Pending or prospective litigation</td>
				</tr>
				<tr>
					<td><html:checkbox property="reason_custom" value="Yes"></html:checkbox></td>
					<td>Customs matters</td>
				</tr>
				<tr>
					<td><html:checkbox property="reason_contract" value="Yes"></html:checkbox></td>
					<td>Contract or publishing deadlines that necessitate the
						expedited issuance of a certificate</td>
				</tr>
 
			</table>
			<html:checkbox property="icertify" value="Yes"></html:checkbox>
			<font color="black" size="2"><strong>I certify</strong> that I
				am the author, copyright claimant of exclusive rights, or the
				authorized agent of the author, <br /> copyright claimant of
				exclusive rights of this work.</font>

			<p>
				<font color="black" size="2"><strong>Explanation for
						Special Handling</strong> </font> <strong>:</strong> 
						<br/>
						<font color="black" size="2">This
					is the place to give any comments/instructions regarding special
					handling specific to this claim.</font>
					<html:textarea property="explanation" style="height: 48; width: 648"></html:textarea>
				
			</p>
			<p align="left" >
				<a  href="CopyRightRegistration.do?linkno=9" id="olegbutton1">Back</a>
			</p>			
			
			<p align="right">
				<html:submit styleId="olegbutton1" value="Continue"></html:submit>
			</p>
			</html:form>


		</logic:equal>



	</div>
</div>
<div class="tile"></div>

