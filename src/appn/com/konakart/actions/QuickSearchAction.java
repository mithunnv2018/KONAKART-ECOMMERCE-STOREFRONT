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

package com.konakart.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.app.ProductSearch;
import com.konakart.appif.ProductSearchIf;

/**
 * Gets called to perform a quick search based on the searchText parameter.
 */
public class QuickSearchAction extends BaseAction
{

    /**
     * 
     * @param mapping
     *            The ActionMapping used to select this instance
     * @param form
     *            The optional ActionForm bean for this request (if any)
     * @param request
     *            The HTTP request we are processing
     * @param response
     *            The HTTP response we are creating
     * 
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    {

        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, null);

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            String searchText = request.getParameter("searchText");
            if (log.isDebugEnabled())
            {
                log.debug("Search text from application = " + searchText);
            }

            ProductSearchIf ps = new ProductSearch();
            ps.setReturnCategoryFacets(true);
            ps.setReturnManufacturerFacets(true);
            ps.setManufacturerId(ProductSearch.SEARCH_ALL);
            ps.setCategoryId(ProductSearch.SEARCH_ALL);
            ps.setWhereToSearch(0);

            ps.setSearchText(searchText);
            kkAppEng.getProductMgr().searchForProducts(ps);

            // Set the SEARCH_STRING customer tag for this customer
            if (searchText != null && searchText.length() > 0)
            {
                kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_SEARCH_STRING, searchText);
            }

            kkAppEng.nav.set(getCatMessage(request, "header.navigation.results"), request);
            return mapping.findForward("QuickSearch");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
