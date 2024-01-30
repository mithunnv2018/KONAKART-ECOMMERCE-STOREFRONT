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

<logic:notEmpty name="konakartKey">
	<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
	<bean:define id="revMgr" name="kkEng" property="reviewMgr" type="com.konakart.al.ReviewMgr"/>
	<logic:greaterThan name="revMgr" property="numRandomReviews" value="0">
		<bean:define id="rev" name="revMgr" property="randomReview" type="com.konakart.al.ExtendedReview"/>
		<div class="tile">
			<div class="random-review-tile">
				<!--- box border -->
				<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
				<!-- -->
				<div class="tile-header">
					<span class="kk-right"><html:link page="/ShowAllReviews.do"><img src="<%=kkEng.getImageBase()%>/icons/reviews.png" border="0" alt="<bean:message key="common.more"/>" title=" <bean:message key="common.more"/>"></html:link></span>
					<bean:message key="random.review.tile.reviews"/>
				</div>
				<div class="tile-content" align="center">
					<html:link page="/ShowRandomReviewDetails.do" paramId="revId" paramName="rev" paramProperty="id"><img src="<%=kkEng.getImageBase()%>/<%=rev.getImage()%>" border="0" alt="<%=rev.getProductName()%>" title=" <%=rev.getProductName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>"></html:link>							                							                        					    								
					<br/>
					<html:link page="/ShowRandomReviewDetails.do" paramId="revId" paramName="rev" paramProperty="id"><%=revMgr.truncateDesc(rev.getReviewText(),15,60)%></html:link><br/>						                        				
					<img src="<%=kkEng.getImageBase()%>/stars_<%=rev.getRating()%>.gif" border="0" alt="<%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/>" title=" <%=rev.getRating()%>&nbsp;<bean:message key="show.reviews.body.of.5.stars"/> " width="59" height="11">				
				</div>
				<!--- end of box border -->
				</div></div></div></div></div></div></div></div>
				<!-- -->
			</div>
		</div>	
	</logic:greaterThan>
</logic:notEmpty>
