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

<div class="body">
	<div class="body-header">
		<img  style="float:right" src="<%=kkEng.getImageBase()%>/table_background_specials.gif" border="0" alt="<bean:message key="information.tile.aboutus"/>" title=" <bean:message key="information.tile.aboutus"/> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="information.tile.aboutus"/>
	 </div>
	<div class="body-content-div">
		<p>
		Intellectual property protection has emerged a key area of concern to prevent pilferage of economic losses as the world is swept over by globalization and rapid economic liberalization. The increasing focus on obtaining comprehensive, the best possible, and quality patent protection demands superior legal and technical expertise assuring swift and thorough patent application process and leading to safeguarding of your ownership of intangible assets. Our specialization in patent application drafting keeping in view the differential industry needs for inventions, symbols, words, and artistic achievements of diverse genre and diligent patent search guarantee protection against any infringement.
		</p>
		<p>
		Trademark is perceived as the sine qua non of a brand in today's global economy. An intelligently created, well-publicized, and vigilantly maintained trademark is essential to build and expand a business. Trademarks give distinctive identity to individual, business, and corporate users and form the basis of their commercial reputation and customer loyalty. 
		</p>
		<p>
		Copyright confers protection on intellectual property and assures one ownership of his hard won innovations. It bears the name of the innovator and guarantees him royalty and economic advantage from commercial exploitation. However, in the fast paced globalization and varying economic scenario,  it is essential to register copyrights to obtain protection against infringement. The advent of IT and other technology has necessitated that copyright violations are prevented across a broad spectrum and originality of the work is substantiated and zealously guarded on all mediums.
		</p>
		<p>
		Duly Noted provides registered agent services for all types of business entities who require statutory representations during the legal process. As your designated registered agent, we work as statutory agent of clients and receive their service of process, renewal notices, and tax and regulatory correspondences. Our due diligence in executing duties of a registered agent allow clients enjoy liability protection and value-based benefits in legal, copyright, and patent matters and avoid inconvenient and embarrassing situations associated with these fields.
		</p>
		<p>
		Reliable filing and retrieval services have emerged as key components of a business entity. Organizations have to file for patents, copyright, trademarks, tax registration, and a host of similar legal requirements at designated courts and public offices during their start up, growth, and expansion. They also need retrieval services that can effectively monitor the approval process and collect required documents from public records. Filing and retrieval services must be reliable, focused on your requirements, and swift to reflect your business needs. Duly Noted offers to act as registered agents for all entities and deploy dedicated workforce for their filing and retrieval service requisites.
		</p>
	</div>
</div>						
<div class="tile">
		<div class="button-left"><div class="button-right"><div class="button-bottom"><div class="button-bottom-left"><div class="button-bottom-right"><div class="button-top"><div class="button-top-left"><div class="button-top-right">
			<div class="button-tile" align="right">
				<html:link page="/Welcome.do">
					<span class="button"><span><bean:message key="common.continue"/></span></span>
				</html:link>
			</div>
		</div></div></div></div></div></div></div></div>
</div> 	

