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
import com.konakart.appif.ManufacturerIf;
import com.konakart.bl.ConfigConstants;
import com.konakart.forms.FilterByManufacturerForm;

/**
 * Gets called to search by manufacturers based on the parameters in the FilterByManufacturerForm.
 */
public class SearchByManufacturerSubmitAction extends ManufacturerBaseAction
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

            FilterByManufacturerForm f = (FilterByManufacturerForm) form;

            // Check to see whether we are here after the SEO redirect.
            ManufacturerIf selectedManu = kkAppEng.getProductMgr().getSelectedManufacturer();
            String manuId = request.getParameter("manuId");
            int manuIdInt = -1;
            if (manuId != null)
            {
                try
                {
                    manuIdInt = new Integer(manuId).intValue();
                } catch (Exception e)
                {

                }
            }

            // Check to see whether we are here after the SEO redirect.
            int seoFormat = kkAppEng.getConfigAsInt(ConfigConstants.SEO_URL_FORMAT);
            if (seoFormat == SEO_DIRECTORY)
            {
                if (request.getParameter("seo") != null)
                {
                    if (selectedManu == null || selectedManu.getId() != manuIdInt)
                    {
                        if (f.getManufacturerId() > 0)
                        {
                            /*
                             * First time action is called before redir and form contains valid data
                             */
                            kkAppEng.getProductMgr().fetchProductsPerManufacturer(
                                    f.getManufacturerId());
                        } else if (manuIdInt > -1)
                        {
                            /*
                             * If action is called by copy and paste of URL, form will be empty but
                             * manuId should be valid.
                             */
                            kkAppEng.getProductMgr().fetchProductsPerManufacturer(manuIdInt);
                        }
                    }
                    manageRedir(kkAppEng, request);
                    return mapping.findForward("SearchByManufacturerSubmit");
                }
            } else if (seoFormat == SEO_PARAMETERS)
            {
                if (selectedManu != null
                        && selectedManu.getId() == manuIdInt
                        && request.getParameter(getCatMessage(request, "seo.product.manufacturer")) != null)
                {
                    manageRedir(kkAppEng, request);
                    return mapping.findForward("SearchByManufacturerSubmit");
                }
            }

            if (f.getManufacturerId() > 0)
            {
                /*
                 * First time action is called before redir and form contains valid data
                 */
                kkAppEng.getProductMgr().fetchProductsPerManufacturer(f.getManufacturerId());
            } else if (manuIdInt > -1)
            {
                /*
                 * If action is called by copy and paste of URL, form will be empty but manuId
                 * should be valid.
                 */
                kkAppEng.getProductMgr().fetchProductsPerManufacturer(manuIdInt);
            }

            /*
             * If the url we get from the request is set to null (as is sometimes the case when we
             * have been implemented as a portlet), then we mustn't do a redirect. Also don't do it
             * if SEO is switched off.
             */
            if (request.getRequestURL() == null
                    || !(seoFormat == SEO_DIRECTORY || seoFormat == SEO_PARAMETERS))
            {
                manageRedir(kkAppEng, request);
                return mapping.findForward("SearchByManufacturerSubmit");
            }

            // Do a 301 redirect (permanent) so that search engines index the URL
            manageAction(kkAppEng, request, response, seoFormat, SEO_SEARCH_BY_MANU_CODE);

            return null;
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }

}
