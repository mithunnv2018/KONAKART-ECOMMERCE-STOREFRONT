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
	<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
	<logic:notEmpty name="prodMgr" property="selectedProduct">
		<bean:define id="prod" name="prodMgr" property="selectedProduct" type="com.konakart.appif.ProductIf"/>
		<div class="tile">
			<div class="write-review-tile">
				<!--- box border -->
				<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
				<!-- -->
				<div class="tile-header">
					<img src="<%=kkEng.getImageBase()%>/icons/reviews.png" border="0"/>
					<bean:message key="write.review.tile.reviews"/>	
				</div>
				<div class="tile-content">
					<html:link page="/WriteReview.do" paramId="prodId" paramName="prod" paramProperty="id">
						<img style="float: left; padding-right: 4px" src="<%=kkEng.getImageBase()%>/box_write_review.gif" border="0" alt="<bean:message key="common.write.review"/>" title=" <bean:message key="common.write.review"/> " width="50" height="50">
					</html:link>	
					<html:link page="/WriteReview.do" paramId="prodId" paramName="prod" paramProperty="id"><bean:message key="write.review.tile.writereview.onprod"/></html:link><br/><br/>
				</div>
				<!--- end of box border -->
				</div></div></div></div></div></div></div></div>
				<!-- -->
			</div>
		</div>
	</logic:notEmpty>
</logic:notEmpty>

