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

<div class="tile">
	<div class="languages-tile">
		<!--- box border -->
		<div class="left"><div class="right"><div class="bottom"><div class="bottom-left"><div class="bottom-right"><div class="top"><div class="top-left"><div class="top-right">
		<!-- -->
		<div class="tile-header">
			<img src="<%=kkEng.getImageBase()%>/icons/languages.png" border="0"/>
			<bean:message key="languages.tile.languages"/>
		</div>
		<div class="tile-content" align="center">
			<html:link page="/SetLocale_en_GB.do" paramId="locale"   title="English">  <img src="<%=kkEng.getImageBase()%>/en_GB/icon.gif" border="0" alt="English"   title=" English " width="24" height="15"></html:link>		    					
			<html:link page="/SetLocale_de_DE.do" paramId="locale"   title="Deutsch">  <img src="<%=kkEng.getImageBase()%>/de_DE/icon.gif" border="0" alt="Deutsch"   title=" Deutsch" width="24" height="15"></html:link>			    					
			<html:link page="/SetLocale_es_ES.do" paramId="locale"   title="Espanol">  <img src="<%=kkEng.getImageBase()%>/es_ES/icon.gif" border="0" alt="Espanol"   title=" Espanol" width="24" height="15"></html:link>
			<html:link page="/SetLocale_pt_BR.do" paramId="locale"   title="Português"><img src="<%=kkEng.getImageBase()%>/pt_BR/icon.gif" border="0" alt="Português" title=" Português" width="24" height="15"></html:link>
		</div>
		<!--- end of box border -->
		</div></div></div></div></div></div></div></div>
		<!-- -->
	</div>
</div>
