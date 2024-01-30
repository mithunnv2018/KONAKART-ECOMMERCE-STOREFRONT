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
<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>
<bean:define id="revArray" name="revMgr" property="currentReviews"/>
<bean:define id="maxRows" name="revMgr" property="pageSize"/>

<div class="body">
	<div class="body-header">
		<img style="float:right" src="<%=kkEng.getImageBase()%>/table_background_reviews_new.gif" border="0" alt="<bean:message key="show.all.reviews.body.read.others"/>" title=" <bean:message key="show.all.reviews.body.read.others"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="show.all.reviews.body.read.others"/>
	 </div>
	<div class="body-content-div">
		<logic:empty name="revMgr" property="currentReviews">
			<div class="msg-box"><bean:message key="show.reviews.body.no.reviews"/>.</div>
		</logic:empty>
		<logic:iterate id="rev" name="revArray" length="maxRows" type="com.konakart.appif.ReviewIf">
			<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
				<tr>
					<td>
						<html:link page="/ShowReviewDetails.do" paramId="revId" paramName="rev" paramProperty="id"><u><b><%=rev.getProduct().getName()%></b></u></html:link>&nbsp;<bean:message key="show.reviews.body.by"/>&nbsp;<%=rev.getCustomerName()%>
					</td>
					<td class="smallText" align="right"><bean:message key="show.reviews.body.date.added"/>:&nbsp;<%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy").format(rev.getDateAdded().getTime())%></td>
				</tr>
			</table>
			 <div class="msg-box">
				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
					<tr>
						<td width="10"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
						<td width="110" align="center" valign="top" ><html:link page="/ShowReviewDetails.do" paramId="revId" paramName="rev" paramProperty="id"><img src="<%=kkEng.getImageBase()%>/<%=rev.getProduct().getImage()%>" border="0" alt="<%=rev.getProduct().getName()%>" title=" <%=rev.getProduct().getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>"></html:link></td>
						<td valign="top" ><%=revMgr.truncateDesc(rev.getReviewText(),60,100)%><br><br><i><bean:message key="show.reviews.body.rating"/>: <img src="<%=kkEng.getImageBase()%>/stars_<%=rev.getRating()%>.gif" border="0" alt="<%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/>" title=" <%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/> " width="59" height="11"> [<%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/>]</i></td>
						<td width="10" align="right"><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="10" height="1"></td>
					</tr>
				</table>
			</div><br/>
		</logic:iterate>	  
		<logic:notEmpty name="revMgr" property="currentReviews">
			<table border="0" width="100%" cellspacing="0" cellpadding="2">
				<tr>
					<td class="smallText"><bean:message key="show.reviews.body.displaying"/>&nbsp;<b><%=revMgr.getCurrentOffset() + 1%></b> <bean:message key="show.reviews.body.to"/> <b><%=revMgr.getNumberOfReviews() + revMgr.getCurrentOffset()%></b> (<bean:message key="show.reviews.body.of"/> <b><%=revMgr.getTotalNumberOfReviews()%></b> <bean:message key="show.reviews.body.reviews"/>)</td>
					<td class="smallText" align="right">
					    <%=revMgr.getNumPages()%> <bean:message key="products.body.result.pages"/>:&nbsp;
						<logic:equal name="revMgr" property="showBack" value="1">
							<html:link page="/NavigateAllRev.do" paramId="navDir" paramName="revMgr" paramProperty="navBack" styleClass="pageResults"><u>[&lt;&lt;&nbsp;Prev]</u></html:link>&nbsp;&nbsp;
						</logic:equal>
						<logic:notEqual name="revMgr" property="showBack" value="1">
							<u>[&lt;&lt;&nbsp;Prev]</u>&nbsp;&nbsp;
						</logic:notEqual>
								<%
								   int j = 0;
						           for (java.util.Iterator<Integer> iterator = revMgr.getPageList().iterator(); iterator.hasNext();)
						            {
						                Integer pageNum =  iterator.next();
								        java.util.HashMap pageMap = new java.util.HashMap(); 
									    pageMap.put("navDir", pageNum.toString());  
									    request.setAttribute("pageParams"+j, pageMap);  
								        if (revMgr.getCurrentPage()==pageNum.intValue())
								        {
								 %>
							                <html:link page="/NavigateAllRev.do" name="<%=\"pageParams\"+j%>"  styleClass="pageResults"><b><u><%=pageNum.intValue()%></u></b>&nbsp;</html:link>
								 <%		} else
								        {
								 %>
							                <html:link page="/NavigateAllRev.do" name="<%=\"pageParams\"+j%>" styleClass="pageResults"><u><%=pageNum.intValue()%></u>&nbsp;</html:link>											
								 <%		}
						                j++;
						            }									
								 %>
						<logic:equal name="revMgr" property="showNext" value="1">
							<html:link page="/NavigateAllRev.do" paramId="navDir" paramName="revMgr" paramProperty="navNext" styleClass="pageResults"><u>[Next&nbsp;&gt;&gt;]</u></html:link>
						</logic:equal>
						<logic:notEqual name="revMgr" property="showNext" value="1">
							<u>[Next&nbsp;&gt;&gt;]</u>
						</logic:notEqual>
					</td>
				</tr>
			</table>
		 </logic:notEmpty>
	</div>
</div>						