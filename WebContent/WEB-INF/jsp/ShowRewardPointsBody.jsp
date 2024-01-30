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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="rewardPointMgr" name="kkEng" property="rewardPointMgr" type="com.konakart.al.RewardPointMgr"/>
<bean:define id="rewardPointArray" name="rewardPointMgr" property="currentRewardPoints"/>
<bean:define id="maxRows" name="rewardPointMgr" property="maxRows"/>

<table width="100%" >
	<tr>
		<td valign="top">
			<div class="body">
				<div class="body-header">
					<table width="100%" class="body-header">
						<tr>
							<td class="pageHeading" valign="top"><bean:message key="show.rewardpoints.body.rewardpoints" arg0="<%=String.valueOf(rewardPointMgr.pointsAvailable())%>"/></td>						
						 </tr>
					</table>
				 </div>
				 <div class="body-content-div">
					<logic:empty name="rewardPointMgr" property="currentRewardPoints">
						<div class="msg-box">
							<bean:message key="show.rewardpoints.body.no.rewardpoints"/>.	
						</div>
						<br/>					
					</logic:empty>
					<logic:notEmpty name="rewardPointMgr" property="currentRewardPoints">					
						<table border="0" width="100%" cellspacing="0" cellpadding="2" class="productListing">
							<tr>
								<td align="left" class="productListing-heading"><bean:message key="show.rewardpoints.body.date"/></td>
								<td align="left" class="productListing-heading"><bean:message key="show.rewardpoints.body.description"/></td>
								<td align="right" class="productListing-heading"><bean:message key="show.rewardpoints.body.points"/></td>
							</tr>				
							<logic:iterate id="rp" name="rewardPointArray" length="maxRows" type="com.konakart.appif.RewardPointIf">	
								<tr>
									<td align="left" class="productListing-data"><%=kkEng.getDateAsString(rp.getDateAdded())%></td>
									<td align="left" class="productListing-data"><%=rp.getDescription()%></td>
									<%if (rp.getTransactionType()==0) { %>
										<td align="right" class="productListing-data"><%=rp.getInitialPoints()%></td>
									<%} else { %>
										<td align="right" class="productListing-data">(<%=rp.getInitialPoints()%>)</td>
									<%}%>								
								</tr>														
							</logic:iterate>	
						</table>	
						  
						<br/>
						<table border="0" width="100%" cellspacing="0" cellpadding="2">
							<tr>
								<td class="smallText"><bean:message key="show.rewardpoints.body.displaying"/>&nbsp;<b><%=rewardPointMgr.getCurrentOffset() + 1%></b> <bean:message key="show.rewardpoints.body.to"/> <b><%=rewardPointMgr.getNumberOfRewardPoints() + rewardPointMgr.getCurrentOffset()%></b> (<bean:message key="show.rewardpoints.body.of"/> <b><%=rewardPointMgr.getTotalNumberOfRewardPoints()%></b> <bean:message key="show.rewardpoints.body.transactions"/>)</td>
								<td class="smallText" align="right">
									<logic:equal name="rewardPointMgr" property="showBack" value="1">
										<html:link page="/NavigateRewardPoints.do" paramId="navDir" paramName="rewardPointMgr" paramProperty="navBack" styleClass="pageResults"><u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u></html:link>&nbsp;&nbsp;
									</logic:equal>
									<logic:notEqual name="rewardPointMgr" property="showBack" value="1">
										<u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u>&nbsp;&nbsp;
									</logic:notEqual>
									<logic:equal name="rewardPointMgr" property="showNext" value="1">
										<html:link page="/NavigateRewardPoints.do" paramId="navDir" paramName="rewardPointMgr" paramProperty="navNext" styleClass="pageResults"><u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></html:link>
									</logic:equal>
									<logic:notEqual name="rewardPointMgr" property="showNext" value="1">
										<u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u>
									</logic:notEqual>
								</td>
							</tr>
						</table>
						<br/>
				  	</logic:notEmpty>
				</div>
			</div>						
			<div class="tile">
				<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
					<div class="button-tile">
						<html:link page="/MyAccount.do">
							<span class="button"><span><bean:message key="common.back"/></span></span>
						</html:link>							                        				
					</div>
				</div></div></div></div></div></div></div></div>
			</div> 	
		</td>
	</tr>
</table>
