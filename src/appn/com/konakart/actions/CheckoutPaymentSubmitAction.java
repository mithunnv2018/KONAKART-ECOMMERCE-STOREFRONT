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
import com.konakart.appif.OrderIf;
import com.konakart.appif.OrderStatusHistoryIf;
import com.konakart.forms.CheckoutForm;

/**
 * Gets called after submitting the checkout payment page.
 */
public class CheckoutPaymentSubmitAction extends BaseAction
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
            CheckoutForm localForm = (CheckoutForm) form;

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

            OrderIf checkoutOrder = kkAppEng.getOrderMgr().getCheckoutOrder();
            if (checkoutOrder == null || checkoutOrder.getStatusTrail() == null
                    || checkoutOrder.getStatusTrail().length == 0)
            {
                return mapping.findForward("CheckoutDelivery");
            }

            // Set the comment
            OrderStatusHistoryIf[] oshArray = checkoutOrder.getStatusTrail();
            OrderStatusHistoryIf osh = oshArray[0];
            osh.setComments(localForm.getComment());
            osh.setUpdatedById(kkAppEng.getOrderMgr().getIdForUserUpdatingOrder(checkoutOrder));
            checkoutOrder.setStatusTrail(oshArray);

            // Set the coupon code
            checkoutOrder.setCouponCode(localForm.getCouponCode());
            kkAppEng.getOrderMgr().setCouponCode(localForm.getCouponCode());
            
            // Set the GiftCert code
            checkoutOrder.setGiftCertCode(localForm.getGiftCertCode());
            kkAppEng.getOrderMgr().setGiftCertCode(localForm.getGiftCertCode());

            // Set the reward points
            checkoutOrder.setPointsRedeemed(0);
            kkAppEng.getOrderMgr().setRewardPoints(0);

            if (kkAppEng.getRewardPointMgr().isEnabled())
            {
                int pointsAvailable = kkAppEng.getRewardPointMgr().pointsAvailable();
                if (localForm.getRewardPoints() != null && localForm.getRewardPoints().length() > 0
                        && pointsAvailable > 0)
                {
                    try
                    {
                        checkoutOrder.setPointsRedeemed(Integer.parseInt(localForm
                                .getRewardPoints()));
                        kkAppEng.getOrderMgr().setRewardPoints(
                                Integer.parseInt(localForm.getRewardPoints()));
                    } catch (Exception e)
                    {
                    }
                }
            }

            // Attach the payment details to the order
            kkAppEng.getOrderMgr().addPaymentDetailsToOrder(localForm.getPayment());

            return mapping.findForward("CheckoutConfirmation");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
