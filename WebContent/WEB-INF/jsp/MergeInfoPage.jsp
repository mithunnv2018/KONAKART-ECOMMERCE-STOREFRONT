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
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>

<html dir="LTR" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KonaKart</title>
<base href="http://localhost/catalog/">
<link rel="stylesheet" type="text/css" href="skin_style.css">
</head>
<body>
	<div class="body-content-div">
		<p ><b>Visitors Cart / Members Cart</b><br><img src="<%=kkEng.getImageBase()%>/pixel_black.gif" border="0" alt="" width="100%" height="1"></p>
		<p ><b><i>Visitors Cart</i></b><br>Every visitor to our online shop will be given a 'Visitors Cart'. This allows the visitor to store their products in a temporary shopping cart. Once the visitor leaves the online shop, so will the contents of their shopping cart.</p>
		<p ><b><i>Members Cart</i></b><br>Every member to our online shop that logs in is given a 'Members Cart'. This allows the member to add products to their shopping cart, and come back at a later date to finalize their checkout. All products remain in their shopping cart until the member has  checked them out, or removed the products themselves.</p>
		<p ><b><i>Info</i></b><br>If a member adds products to their 'Visitors Cart' and decides to log in to the online shop to use their 'Members Cart', the contents of their 'Visitors Cart' will merge with their 'Members Cart' contents automatically.</p>
		<p align="right" ><a href="javascript:window.close();">[ close window ]</a></p>
	</div>
</body>
</html>
