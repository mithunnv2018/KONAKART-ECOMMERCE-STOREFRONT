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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.al.WishListMgr;
import com.konakart.app.CustomerSearch;
import com.konakart.appif.CustomerSearchIf;
import com.konakart.forms.SearchGiftRegistryForm;

/**
 * Performs a search based on data from the SearchGiftRegistryForm.
 */
public class GiftRegistrySearchSubmitAction extends BaseAction
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
            ActionForward redirForward = checkSSL(kkAppEng, request, custId,/* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            // Instantiate a CustomerSearch object required by the engine
            CustomerSearchIf cs = new CustomerSearch();

            // Get the form passed in
            SearchGiftRegistryForm sgrf = (SearchGiftRegistryForm) form;

            // Populate the CustomerSearch object from the form
            if (sgrf.getCustomerFirstName() != null && !sgrf.getCustomerFirstName().equals(""))
            {
                cs.setFirstName(sgrf.getCustomerFirstName());
            }
            if (sgrf.getCustomerLastName() != null && !sgrf.getCustomerLastName().equals(""))
            {
                cs.setLastName(sgrf.getCustomerLastName());
            }
            if (sgrf.getCustomer1FirstName() != null && !sgrf.getCustomer1FirstName().equals(""))
            {
                cs.setFirstName1(sgrf.getCustomer1FirstName());
            }
            if (sgrf.getCustomer1LastName() != null && !sgrf.getCustomer1LastName().equals(""))
            {
                cs.setLastName1(sgrf.getCustomer1LastName());
            }
            if (sgrf.getEventDateString() != null && !sgrf.getEventDateString().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                Date d = sdf.parse(sgrf.getEventDateString());
                if (d != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(d);
                    cs.setEventDate(gc);
                }
            }
            
            cs.setType(WishListMgr.WEDDING_LIST_TYPE);

            // Call the engine to do the product search
            kkAppEng.getWishListMgr().searchForWishLists(cs);

            kkAppEng.nav.set(getCatMessage(request, "header.navigation.results"), request);
            return mapping.findForward("GiftRegistrySearchSubmit");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }
}
