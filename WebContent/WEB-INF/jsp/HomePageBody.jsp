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
<head>
<link rel="stylesheet" href="styles/global2.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
 
	<!-- src="http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js" -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	
<script src="script/slides.min.jquery.js"></script>
<script>
	$(function() {
		$('#slides').slides({
			preload : true,
			preloadImage : 'img/loading.gif',
			play : 5000,
			pause : 2500,
			hoverPause : true
		});
	});
</script>

</head>
<bean:define id="kkEng" name="konakartKey"
	type="com.konakart.al.KKAppEng" />

<logic:notPresent name="org.apache.struts.action.MESSAGE"
	scope="application">
	<font color="red"> ERROR: Application resources not loaded --
		check servlet container logs for error messages. </font>
</logic:notPresent>

<div id="container">
	<div id="example">

		<div id="slides">
			<div class="slides_container">

				<a href="#"> <img src="images/slides/slide1.jpg" width="100%"
					height="270" /> </a> <a href="#"> <img
					src="images/slides/slide2.jpg" width="100%" height="270" /> </a> <a
					href="#"> <img src="images/slides/slide3.jpg" width="100%"
					height="270" /> </a> <a href="#"> <img
					src="images/slides/slide4.jpg" width="100%" height="270" /> </a> <a
					href="#"> <img src="images/slides/slide5.jpg" width="100%"
					height="270" /> </a>

			</div>
			<a href="#" class="prev"><img src="img/arrow-prev.png" width="24"
				height="43" alt="Arrow Prev"> </a> <a href="#" class="next"><img
				src="img/arrow-next.png" width="24" height="43" alt="Arrow Next">
			</a>
		</div>


	</div>

</div>

<div class="body">
	<div class="body-header">
		<img src="<%=kkEng.getImageBase()%>/table_background_default.gif"
			border="0" alt="<bean:message key="home.page.body.welcome"/>"
			title=" <bean:message key="home.page.body.welcome"/> "
			width="<%=kkEng.getHeadingImageWidth()%>"
			height="<%=kkEng.getHeadingImageHeight()%>">
		<bean:message key="home.page.body.welcome" />
	</div>

	<div class="body-content-div">

		<table>
			<tr>
				<td>Duly Noted Ltd. <br /> Copyright Services provided here in
					the UK. <br /> Copyright is the name given to the legal protection
					of certain types of work that fit under the global umbrella of
					Intellectual Property (IP). It prevents any individual, or any
					company or enterprise, from recreating, publishing, or broadcasting
					works that have been copyrighted, without express written authority
					from the person, company, or enterprise to who the copyright has
					been registered. <br /> A copyright can be taken out for various
					forms of IP which include but are not limited to: ·
					<ul>
						<li>Written works</li>
						<li>Works of drama (including mime and dance) – performing
							arts</li>
						<li>Works of music – performing arts ·</li>
						<li>Works of visual art (e.g. paintings, engravings,
							sculptures, photographs, drawings and sketches, architectural
							works, maps and logos</li>
						<li>Designs or layouts for book covers and sleeves – visual
							arts</li>
						<li>Sound recordings and broadcasts</li>
						<li>Visual recordings and broadcasts</li>

					</ul>

					<h3>Help is at Hand</h3>

					<p>
						The world of copyright is quite complex and can be quite
						confusing. If you require any help to indentify the exact kind of
						copyright that you require, then please contact our experienced,
						friendly customer support team by clicking on <a
							href="http://sn128w.snt128.mail.live.com/Downloads/customer%20support"
							target="_blank"><span
							style="line-height: 115%; font-size: 10pt"><font
								color="#0000ff">this link</font>
						</span>
						</a>
					</p>

					<p>Duly Noted is your fast, simple and cost effective way of
						registering your copyright here in the UK. But we also offer a
						complete range of services including:</p>

					<ul>
						·
						<li>Copyright tracking and monitoring</li>
						<li>Defamation dispute management</li>
						<li>Complete online media patrolling</li>
						<li>Global tracking and monitoring</li>
						<li>Enforcement</li>
						<li>Litigation</li>
						<li>Revenue Recovery</li>
					</ul> <br />
					<p>
						Whatever concern you may have to do with copyrighting, Duly Noted
						are here to help. Please feel free to approach <a
							href="http://sn128w.snt128.mail.live.com/Downloads/Oor%20help%20team"
							target="_blank"><span
							style="line-height: 115%; font-size: 10pt"><font
								color="#0000ff">our help team</font>
						</span>
						</a> in secure confidence, to find the best, speedy resolution to any
						copyright issue.
					</p>
				</td>
				</tr>
		</table>

	</div>
</div>
