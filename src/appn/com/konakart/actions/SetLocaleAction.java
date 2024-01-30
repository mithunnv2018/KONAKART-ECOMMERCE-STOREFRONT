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

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.bl.ProductMgr;

/**
 * Changes the locale.
 */
public class SetLocaleAction extends BaseAction
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

            // The locale parameter is hard coded in the struts-config file
            String locale = mapping.getParameter();

            if (locale == null)
            {
                throw new KKAppException("The locale parameter must be initialised");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Locale set from application = " + locale);
            }

            /*
             * The locale should be in the form languageCode_countryCode (i.e. en_GB, it_IT). We
             * need to split up the two codes.
             */
            String[] codes = locale.split("_");

            /*
             * Set the current locale in KonaKart so that calls to the engine use this locale.
             */
            kkAppEng.setLocale(codes[0], codes[1]);

            // Set the message resources in kkAppEng
            kkAppEng.setMsgResources(getResources(request));

            // Set the current locale so that it's picked up by Struts
            setLocale(request, new Locale(codes[0], codes[1]));

            // Save the current locale in a cookie
            setKKCookie(CUSTOMER_LOCALE, locale, request, response, kkAppEng);

            // Edit the customer to set the new locale
            if (custId > -1 && kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                    && kkAppEng.getCustomerMgr().getCurrentCustomer().getId() == custId)
            {
                kkAppEng.getCustomerMgr().editCustomerLocale(locale);
            }

            // Reset the state of the objects connected to the session. i.e. Selected product etc.
            kkAppEng.reset();

            // Clear the navigation
            kkAppEng.nav.clear();

            // Get the new products for all categories
            kkAppEng.getProductMgr().fetchNewProductsArray(/* categoryId */ProductMgr.DONT_INCLUDE, /* fetchDescription */
            true);

            return mapping.findForward("SetLocale");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }
}
