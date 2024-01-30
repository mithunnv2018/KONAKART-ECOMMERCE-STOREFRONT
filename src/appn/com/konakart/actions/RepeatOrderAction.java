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
import com.konakart.al.KKNotInStockException;

/**
 * Called to repeat an order. Retrieves the id from the orderId parameter.
 */
public class RepeatOrderAction extends BaseAction
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
            ActionForward redirForward = checkSSL(kkAppEng, request, custId,/* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null)
            {
                return mapping.findForward("MyAccount");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Order Id from application = " + orderIdStr);
            }

            int orderId;
            try
            {
                orderId = Integer.parseInt(orderIdStr);
            } catch (Exception e)
            {
                return mapping.findForward("MyAccount");
            }

            try
            {
                kkAppEng.getOrderMgr().repeatOrder(orderId, /* addToCurrentBasket */false, /* copyCustomFields */
                true);

                /*
                 * The order just created is in kkAppEng.getOrderMgr().getCheckoutOrder(). The
                 * original order is in kkAppEng.getOrderMgr().getSelectedOrder(). Some further
                 * editing may be done here before leaving the action class. See commented code:
                 */

                // Customize an address
                // kkAppEng.getOrderMgr().getCheckoutOrder().setBillingFormattedAddress(
                // "Peter Smith<br>12, Sunny Lane,<br>Stoke On Trent,<br>Staffs");
            } catch (KKNotInStockException e)
            {
                return mapping.findForward("ShowCartItems");
            }

            // Check to see whether one page checkout is enabled
            boolean onePageC = isOnePageCheckout(kkAppEng);
            if (onePageC)
            {
                // We need to set this so that it can be used to save the order through the GWT code
                kkAppEng.getOrderMgr().setHostAndPort(
                        request.getServerName() + ":" + request.getServerPort());

                // Set the breadcrumb navigation
                kkAppEng.nav.set(getCatMessage(request, "header.checkout"), request);

                // Tell the GWT code to use the current checkoutOrder
                kkAppEng.getOrderMgr().setUseCheckoutOrder(true);

                return mapping.findForward("OnePageCheckout");
            }

            return mapping.findForward("CheckoutConfirmation");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }
}
