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
import com.konakart.bl.ConfigConstants;

/**
 * This Action should always get called before showing the MyAccount page. It fetches data from the
 * DB before displaying the page.
 */
public class CatalogAfterLoginAction extends BaseAction
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

            // Check to see whether the user is logged in
            custId = this.loggedIn(request, response, kkAppEng, "MyAccount");
            if (custId < 0)
            {
                return mapping.findForward(loginForward);
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            /*
             * Populate the customer's orders array with the last three orders he made. We need to
             * get them every time this action is called because the state of an order may change
             * through an IPN call back and this would never get shown if we cached the orders when
             * the customer logs in or just after submitting an order.
             */
            kkAppEng.getOrderMgr().populateCustomerOrders();

            /*
             * Get the digital downloads for this customer. The digital downloads are generated
             * after an order has been paid for. The payment notification may occur through a
             * callback and so need to check every time a customer goes to his "MyAccount" page.
             */
            kkAppEng.getProductMgr().fetchDigitalDownloads();

            /*
             * Get the customer wish lists that he may want to edit from this page
             */
            String giftRegistryEnabled = kkAppEng.getConfig(ConfigConstants.ENABLE_GIFT_REGISTRY);
            if (giftRegistryEnabled != null && giftRegistryEnabled.equalsIgnoreCase("TRUE"))
            {
                kkAppEng.getWishListMgr().fetchCustomersWishLists();
            }

            return mapping.findForward("MyAccount");
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
