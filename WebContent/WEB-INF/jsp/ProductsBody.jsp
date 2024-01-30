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
<%@ taglib uri="/tags/struts-nested" prefix="nested" %>

<bean:define id="kkEng" name="konakartKey" type="com.konakart.al.KKAppEng"/>
<bean:define id="prodMgr" name="kkEng" property="productMgr" type="com.konakart.al.ProductMgr"/>
<bean:define id="searchAll" name="kkEng" property="SEARCH_ALL" type="java.lang.String"/>

<bean:define id="currentCat" name="prodMgr" property="selectedCategory" type="com.konakart.appif.CategoryIf"/>
<bean:define id="currentManu" name="prodMgr" property="selectedManufacturer" type="com.konakart.appif.ManufacturerIf"/>

<bean:define id="prodArray" name="prodMgr" property="currentProducts"/>
<bean:define id="manuArray" name="prodMgr" property="currentManufacturers"/>
<bean:define id="catArray" name="prodMgr" property="currentCategories"/>

<bean:define id="maxRows" name="prodMgr" property="maxDisplaySearchResults"/>

<!-- Messages -->
<bean:define id="sortProductsByPrice"><bean:message key="products.body.sort.products.by.price"/></bean:define>
<bean:define id="sortProductsByName"><bean:message key="products.body.sort.products.by.name"/></bean:define>
<bean:define id="letsSeeWhatWeHaveHere"><bean:message key="products.body.lets.see.what.we.have.here"/></bean:define>
<bean:define id="getWhileHot"><bean:message key="products.body.get.while.hot"/></bean:define>
<bean:define id="newProds"><bean:message key="products.body.new.products"/></bean:define>
<bean:define id="searchedProds"><bean:message key="products.body.search.prods"/></bean:define>


<div class="body">
		<div class="body-header">
			<logic:equal name="prodMgr" property="headerToShow" value="byManufacturer">
				<img src="<%=kkEng.getImageBase()%>/<%=currentCat.getImage()%>" border="0" alt="<%=letsSeeWhatWeHaveHere%>" title=" <%=letsSeeWhatWeHaveHere%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
				<%=letsSeeWhatWeHaveHere%>
				<logic:greaterThan name="prodMgr" property="currentManufacturersLength" value="1">
					<%
							com.konakart.forms.FilterByManufacturerForm myForm = (com.konakart.forms.FilterByManufacturerForm) request.getAttribute("FilterByManufacturerForm"); 
							if (myForm == null) 
							{ 
								myForm = new com.konakart.forms.FilterByManufacturerForm();
								request.setAttribute("FilterByManufacturerForm",myForm);
							}
							if ( currentManu != null  && currentManu.getId() > -1 && myForm != null) { 
								myForm.setManufacturerId(currentManu.getId());
							}
					%>
					<html:form action="/FilterProd.do" ><span class="small"><bean:message key="products.body.show"/>:</span>&nbsp;
						<html:select name="FilterByManufacturerForm" property="manufacturerId" onchange="submit()">
							<html:option key="products.body.all.manufacturers" value="<%=searchAll%>"></html:option>
							<html:options collection="manuArray" property="id"  labelProperty="name"></html:options>
						</html:select>
					</html:form>
				</logic:greaterThan>				
				<logic:notEmpty name="prodMgr" property="currentTagGroups">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>
											<%int selected=0;%>
											<nested:iterate id="tagGroup" name="prodMgr" property="currentTagGroups" type="com.konakart.appif.TagGroupIf">
												<td valign="top">
													<table>
														<tr><td/><td class="taggroup"><%=tagGroup.getName()%>:</td></tr>
														<logic:notEmpty name="tagGroup" property="tags">
															<nested:iterate id="tag" name="tagGroup" property="tags" type="com.konakart.appif.TagIf">
																<%if ( tag.isSelected()) { selected++;%>
																	<tr><td width="20px"><img src="<%=kkEng.getImageBase()%>/arrow_green.gif" border="0"></td><td class="tag"><html:link page="/FilterProdByTags.do" paramId="tagId" paramName="tag" paramProperty="id"><span class="selectedtags"><%=tag.getName()+" ("+tag.getNumProducts()+")"%></span></html:link></td></tr>
																<% } else { %>
																	<tr><td width="20px"/><td class="tag"><html:link page="/FilterProdByTags.do" paramId="tagId" paramName="tag" paramProperty="id"><%=tag.getName()+" ("+tag.getNumProducts()+")"%></html:link></td></tr>
																<% } %>
															</nested:iterate>
														</logic:notEmpty>
													</table>
												</td>
											</nested:iterate>	
										</td>
									</tr>
								</table>
							</td>														
						</tr>
						<%if (selected>0){%>
						<tr>
							<td>
								<table>
									<tr>
										<td class="tag" align="right" width="100%">
											<html:link page="/RemoveTags.do"><bean:message key="products.body.clear.filters"/></html:link>
										</td>
										<td>
											<html:link page="/RemoveTags.do"><img src="<%=kkEng.getImageBase()%>/remove_filters.gif" border="0"></html:link>
										</td>
									</tr>
								</table>
							</td>														
						</tr>
						<% } %>
					</table>
				</logic:notEmpty>
			</logic:equal>
			<logic:equal name="prodMgr" property="headerToShow" value="byCategory">
				<img src="<%=kkEng.getImageBase()%>/<%=currentManu.getImage()%>" border="0" alt="<%=letsSeeWhatWeHaveHere%>" title=" <%=letsSeeWhatWeHaveHere%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
				<%=letsSeeWhatWeHaveHere%>
				<logic:notEmpty name="prodArray">
					<logic:greaterThan name="prodMgr" property="currentCategoriesLength" value="1">
						<html:form action="/FilterProdByCategory.do" ><span class="small"><bean:message key="products.body.show"/>:</span>&nbsp;
							<html:select name="FilterByCategoryForm" property="categoryId" onchange="submit()">
								<html:option key="products.body.all.categories" value="<%=searchAll%>"></html:option>
								<html:options collection="catArray" property="id"  labelProperty="name"></html:options>
							</html:select>
						</html:form>
					</logic:greaterThan>
				</logic:notEmpty>
			</logic:equal>	
			<logic:equal name="prodMgr" property="headerToShow" value="allSpecials">
				<img src="<%=kkEng.getImageBase()%>/table_background_specials.gif" border="0" alt="<%=getWhileHot%>" title=" <%=getWhileHot%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
				<%=getWhileHot%>				
			</logic:equal>
			<logic:equal name="prodMgr" property="headerToShow" value="allNewProds">
				<img src="<%=kkEng.getImageBase()%>/table_background_products_new.gif" border="0" alt="<%=newProds%>" title=" <%=newProds%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">
				<%=newProds%>
			</logic:equal>
			<logic:equal name="prodMgr" property="headerToShow" value="search">
				<img src="<%=kkEng.getImageBase()%>/table_background_browse.gif" border="0" alt="<%=searchedProds%>" title=" <%=searchedProds%> " width="<%=kkEng.getHeadingImageWidth()%>" height="<%=kkEng.getHeadingImageHeight()%>">				
				<%=searchedProds%>
				<logic:notEmpty name="prodArray">
					<logic:greaterThan name="prodMgr" property="currentCategoriesLength" value="0">
						<br/>
						<%
								com.konakart.forms.FilterByCategoryForm myForm = (com.konakart.forms.FilterByCategoryForm) request.getAttribute("FilterByCategoryForm"); 
								if (myForm == null) 
								{ 
									myForm = new com.konakart.forms.FilterByCategoryForm();
									request.setAttribute("FilterByCategoryForm",myForm);
								}
								if ( currentCat != null  && currentCat.getId() > -1 && myForm != null) { 
									myForm.setCategoryId(currentCat.getId());
								}								
						%>
						<html:form action="/FilterSearchByCategory.do" ><span class="small"><bean:message key="products.body.show"/>:</span>&nbsp;
							<html:select name="FilterByCategoryForm" property="categoryId" onchange="submit()">
								<html:option key="products.body.all.categories" value="<%=searchAll%>"></html:option>
								<html:options collection="catArray" property="id"  labelProperty="name"></html:options>
							</html:select>
						</html:form>
					</logic:greaterThan>
					<logic:greaterThan name="prodMgr" property="currentManufacturersLength" value="0">
						<%
								com.konakart.forms.FilterByManufacturerForm myForm = (com.konakart.forms.FilterByManufacturerForm) request.getAttribute("FilterByManufacturerForm"); 
								if (myForm == null) 
								{ 
									myForm = new com.konakart.forms.FilterByManufacturerForm();
									request.setAttribute("FilterByManufacturerForm",myForm);
								}
								if ( currentManu != null  && currentManu.getId() > -1 && myForm != null) { 
									myForm.setManufacturerId(currentManu.getId());
								}								
						%>
						<html:form action="/FilterSearchByManufacturer.do" ><span class="small"><bean:message key="products.body.show"/>:</span>&nbsp;
							<html:select name="FilterByManufacturerForm" property="manufacturerId" onchange="submit()">
								<html:option key="products.body.all.manufacturers" value="<%=searchAll%>"></html:option>
								<html:options collection="manuArray" property="id"  labelProperty="name"></html:options>
							</html:select>
						</html:form>
					</logic:greaterThan>				
				</logic:notEmpty>
			</logic:equal>
		</div>
		<logic:equal name="prodMgr" property="headerToShow" value="expired">
		     <tr>
        		<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
     		</tr>
      		<tr>
	        	<td class="msg-box">
      				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
 			 		<tr>
    						<td><bean:message key="products.body.products.have.expired"/>.</td>
  					</tr>
				</table>
				</td>
	   		</tr>
		</logic:equal>
		<logic:notEqual name="prodMgr" property="headerToShow" value="expired">	
	     	<logic:empty name="prodArray">
	      		<tr>
	        		<td><img src="<%=kkEng.getImageBase()%>/pixel_trans.gif" border="0" alt="" width="100%" height="10"></td>
	     		</tr>
	      		<tr>
		        	<td class="msg-box">
	      				<table border="0" width="100%" cellspacing="0" cellpadding="2" class="body-content-tab">
	 			 		<tr>
	    						<td><bean:message key="products.body.there.are.no.products.to.list.in.this.category"/>.</td>
	  					</tr>
					</table>
					</td>
		   		</tr>
	      	</logic:empty>
	      	<logic:notEmpty name="prodArray">
				<div class="body-content-div">
					<table border="0" width="100%" cellspacing="0" cellpadding="2" class="productListing">
						<tr>
							<td align="center" class="productListing-heading">&nbsp;&nbsp;</td>
							<td class="productListing-heading">
								&nbsp;<html:link page="/SortProd.do" paramId="orderBy" paramName="prodMgr" paramProperty="obName" title="<%=sortProductsByName%>" styleClass="productListing-heading"><bean:message key="products.body.product.name"/></html:link>&nbsp;
							</td>
							<td align="right" class="productListing-heading">
								&nbsp;<html:link page="/SortProd.do" paramId="orderBy" paramName="prodMgr" paramProperty="obPrice" title="<%=sortProductsByPrice%>" styleClass="productListing-heading"><bean:message key="products.body.price"/></html:link>&nbsp;
							</td>
							<td align="center" class="productListing-heading">&nbsp;<bean:message key="products.body.buy.now"/>&nbsp;</td>
						</tr>
		
						<% int i=0; %>
						<logic:iterate id="prod" name="prodArray" length="maxRows" type="com.konakart.appif.ProductIf">
							<%i++; if ( i % 2 == 0) { %>
								<tr class="productListing-even">
							<% } else { %>
								<tr class="productListing-odd">
							<% } %>
								<td align="center" class="productListing-data">
									&nbsp;<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><img src="<%=kkEng.getImageBase()%>/<%=prod.getImage()%>" border="0" alt="<%=prod.getName()%>" title=" <%=prod.getName()%> " width="<%=kkEng.getSmallImageWidth()%>" height="<%=kkEng.getSmallImageHeight()%>"></html:link>&nbsp;
								</td>
								<td class="productListing-data">
									&nbsp;<html:link page="/SelectProd.do" paramId="prodId" paramName="prod" paramProperty="id"><%=prod.getName()%></html:link>&nbsp;
								</td>
								<logic:empty name="prod" property="specialPriceExTax">
									<%if (kkEng.displayPriceWithTax()){%>
									<td align="right" class="productListing-data">&nbsp;<%=kkEng.formatPrice(prod.getPriceIncTax())%>&nbsp;</td>
									<%}else{%>
									<td align="right" class="productListing-data">&nbsp;<%=kkEng.formatPrice(prod.getPriceExTax())%>&nbsp;</td>
									<%}%>		    											                        				
								</logic:empty>
								<logic:notEmpty name="prod" property="specialPriceExTax">									
									<%if (kkEng.displayPriceWithTax()){%>
										<td align="right" class="productListing-data">&nbsp;<s><%=kkEng.formatPrice(prod.getPriceIncTax())%></s>&nbsp;&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceIncTax())%></span>&nbsp;</td>
									<%}else{%>
										<td align="right" class="productListing-data">&nbsp;<s><%=kkEng.formatPrice(prod.getPriceExTax())%></s>&nbsp;&nbsp;<span class="productSpecialPrice"><%=kkEng.formatPrice(prod.getSpecialPriceExTax())%></span>&nbsp;</td>
									<%}%>		    											                        				
								</logic:notEmpty>
		
								<td align="center" class="productListing-data">
									<html:link page="/AddToCartFromProdId.do" paramId="prodId" paramName="prod" paramProperty="id">
										<span class="button"><span><bean:message key="categories.body.buy.now"/></span></span>
									</html:link>&nbsp;
								</td>
							</tr>
						</logic:iterate>
					</table>
					<table border="0" width="100%" cellspacing="0" cellpadding="2">
						<tr>
							<td class="smallText">
								<bean:message key="products.body.displaying"/><b><%=prodMgr.getCurrentOffset() + 1%></b> <bean:message key="products.body.to"/> <b><%=prodMgr.getNumberOfProducts() + prodMgr.getCurrentOffset()%></b> (<bean:message key="products.body.of"/> <b><%=prodMgr.getTotalNumberOfProducts()%></b> <bean:message key="products.body.products"/>)
							</td>
							<td class="smallText" align="right">
								<%=prodMgr.getNumPages()%> <bean:message key="products.body.result.pages"/>:&nbsp;
								<logic:equal name="prodMgr" property="showBack" value="1">
								    <%  
								    java.util.HashMap backMap = new java.util.HashMap(); 
								    backMap.put("navDir", prodMgr.getNavBack());  
								    backMap.put("t", prodMgr.getProdTimestamp());  
								    request.setAttribute("backParams", backMap);  
								    %>  								    
									<html:link page="/NavigateProd.do" name="backParams" styleClass="pageResults"><u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u></html:link>&nbsp;&nbsp;
								</logic:equal>
								<logic:notEqual name="prodMgr" property="showBack" value="1">
									<u>[&lt;&lt;&nbsp;<bean:message key="common.prev"/>]</u>&nbsp;&nbsp;
								</logic:notEqual>
								<%
								   int j = 0;
						           for (java.util.Iterator<Integer> iterator = prodMgr.getPageList().iterator(); iterator.hasNext();)
						            {
						                Integer pageNum =  iterator.next();
								        java.util.HashMap pageMap = new java.util.HashMap(); 
									    pageMap.put("navDir", pageNum.toString());  
									    pageMap.put("t", prodMgr.getProdTimestamp());  
									    request.setAttribute("pageParams"+j, pageMap);  
								        if (prodMgr.getCurrentPage()==pageNum.intValue())
								        {
								 %>
							                <html:link page="/NavigateProd.do" name="<%=\"pageParams\"+j%>"  styleClass="pageResults"><b><u><%=pageNum.intValue()%></u></b>&nbsp;</html:link>
								 <%		} else
								        {
								 %>
							                <html:link page="/NavigateProd.do" name="<%=\"pageParams\"+j%>" styleClass="pageResults"><u><%=pageNum.intValue()%></u>&nbsp;</html:link>											
								 <%		}
						                j++;
						            }									
								 %>
								<logic:equal name="prodMgr" property="showNext" value="1">
								    <%  
								    java.util.HashMap nextMap = new java.util.HashMap(); 
								    nextMap.put("navDir", prodMgr.getNavNext());  
								    nextMap.put("t", prodMgr.getProdTimestamp());  
								    request.setAttribute("nextParams", nextMap);  
								    %>  								    
									<html:link page="/NavigateProd.do" name="nextParams" styleClass="pageResults"><u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></html:link></td>
								</logic:equal>
								<logic:notEqual name="prodMgr" property="showNext" value="1">
									<u>[<bean:message key="common.next"/>&nbsp;&gt;&gt;]</u></td>
								</logic:notEqual>
						</tr>
					</table>
				</div>
			</logic:notEmpty>
		</logic:notEqual>	
</div>


