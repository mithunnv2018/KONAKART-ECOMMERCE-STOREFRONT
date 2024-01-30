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
import com.konakart.appif.OrderIf;

/**
 * Action called before showing the JSP that collects credit card details
 */
public class CheckoutServerPaymentAction extends BaseAction
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
    	System.out.println("CheckoutServerPaymentAction.execute() atulmith");
        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "CheckoutDelivery");

            // Check to see whether the user is logged in
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

            // Get the order
            OrderIf order = kkAppEng.getOrderMgr().getCheckoutOrder();
            if (order == null)
            {
                throw new KKAppException("There is no order.");
            }

            if (order.getPaymentDetails() == null)
            {
                throw new KKAppException("There is no PaymentDetails object attached to the order.");
            }

            if (order.getPaymentDetails().getCode() == null)
            {
                throw new KKAppException(
                        "The PaymentDetails object contains a null code so we cannot determine which payment gateway to use.");
            }

            kkAppEng.nav.set(getCatMessage(request, "header.checkout"), request);
            kkAppEng.nav.add(getCatMessage(request, "header.payment"), request);

            return mapping.findForward("CollectCreditCardDetails");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
