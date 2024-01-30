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
import com.konakart.al.KKAppException;
import com.konakart.appif.BasketIf;
import com.konakart.appif.CustomerIf;
import com.konakart.bl.ConfigConstants;

/**
 * Gets called before viewing the checkout delivery page.
 */
public class CheckoutDeliveryAction extends BaseAction
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
    	System.out.println("CheckoutDeliveryAction.execute() atulmith");
        try
        {
            int custId = -1;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            // Check to see whether one page checkout is enabled
            boolean onePageC = isOnePageCheckout(kkAppEng);
            // Check to see whether it's a punchout
            boolean punchout = (kkAppEng.getPunchoutDetails() != null);

            // Check to see whether the user is logged in unless we allow one page checkout or it's
            // punchout
            if (!onePageC && !punchout)
            {
                custId = this.loggedIn(request, response, kkAppEng, "CheckoutDelivery");
                if (custId < 0)
                {
                    return mapping.findForward(loginForward);
                }
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */
                    (onePageC ? true : false));
            if (redirForward != null)
            {
                return redirForward;
            }

            // Update the basket data from the database
            kkAppEng.getBasketMgr().getBasketItemsPerCustomer();

            // Check to see whether there is something in the cart
            CustomerIf cust = kkAppEng.getCustomerMgr().getCurrentCustomer();
            if (cust.getBasketItems() == null || cust.getBasketItems().length == 0)
            {
                return mapping.findForward("ShowCartItems");
            }

            // Check that all cart items have a quantity of at least one
            boolean removed = false;
            for (int i = 0; i < cust.getBasketItems().length; i++)
            {
                BasketIf b = cust.getBasketItems()[i];
                if (b.getQuantity() == 0)
                {
                    kkAppEng.getBasketMgr().removeFromBasket(b, /* refresh */false);
                    removed = true;
                }
            }

            if (removed)
            {
                // Update the basket data from the database
                kkAppEng.getBasketMgr().getBasketItemsPerCustomer();

                // Check to see whether there is something in the cart
                if (cust.getBasketItems() == null || cust.getBasketItems().length == 0)
                {
                    return mapping.findForward("ShowCartItems");
                }
            }

            // Check to see whether we are trying to checkout an item that isn't in stock
            String stockAllowCheckout = kkAppEng.getConfig(ConfigConstants.STOCK_ALLOW_CHECKOUT);
            if (stockAllowCheckout != null && stockAllowCheckout.equalsIgnoreCase("false"))
            {
                // If required, we check to see whether the products are in stock
                BasketIf[] items = kkAppEng.getEng().updateBasketWithStockInfoWithOptions(
                        cust.getBasketItems(), kkAppEng.getBasketMgr().getAddToBasketOptions());
                for (int i = 0; i < items.length; i++)
                {
                    BasketIf basket = items[i];
                    if (basket.getQuantity() > basket.getQuantityInStock())
                    {
                        return mapping.findForward("ShowCartItems");
                    }
                }
            }

            // Insert event
            insertCustomerEvent(kkAppEng, ACTION_ENTER_CHECKOUT);

            // Go to punch out JSP if its a punch out
            if (punchout)
            {
                return mapping.findForward("PunchoutCheckout");
            }

            // Check to see whether we need to do a one page checkout
            if (onePageC)
            {
                // We need to set this so that it can be used to save the order through the GWT code
                kkAppEng.getOrderMgr().setHostAndPort(
                        request.getServerName() + ":" + request.getServerPort());

                // Set the breadcrumb navigation
                kkAppEng.nav.set(getCatMessage(request, "header.checkout"), request);

                // Tell the GWT code to not use the current checkoutOrder but to create a new one
                // from the basket
                kkAppEng.getOrderMgr().setUseCheckoutOrder(false);

                return mapping.findForward("OnePageCheckout");
            }

            // The parameter is hard coded in the struts-config file. If we are returning from a
            // change of address we don't want to reset everything.
            String reset = mapping.getParameter();
            if (reset == null)
            {
                // Create an order object that we will use for the checkout process
                kkAppEng.getOrderMgr().createCheckoutOrder();
            }

            if (kkAppEng.getOrderMgr().getCheckoutOrder() == null)
            {
                throw new KKAppException("A new Order could not be created");
            }

            // Get shipping quotes from the engine
            kkAppEng.getOrderMgr().createShippingQuotes();

            kkAppEng.nav.set(getCatMessage(request, "header.checkout"), request);
            kkAppEng.nav.add(getCatMessage(request, "header.shipping.method"), request);
            return mapping.findForward("CheckoutDelivery");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
