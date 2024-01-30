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

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.CartItem;
import com.konakart.al.KKAppEng;
import com.konakart.appif.BasketIf;
import com.konakart.forms.EditCartForm;

/**
 * Gets called after editing the cart.
 */
public class EditCartSubmitAction extends BaseAction
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
    @SuppressWarnings("unchecked")
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

            EditCartForm ecf = (EditCartForm) form;

            /*
             * Set the coupon code in the order manager
             */
            if (ecf.getCouponCode() == null || ecf.getCouponCode().length() == 0)
            {
                kkAppEng.getOrderMgr().setCouponCode(null);
            } else
            {
                kkAppEng.getOrderMgr().setCouponCode(ecf.getCouponCode());
            }

            /*
             * Set the gift certificate code in the order manager
             */
            if (ecf.getGiftCertCode() == null || ecf.getGiftCertCode().length() == 0)
            {
                kkAppEng.getOrderMgr().setGiftCertCode(null);
            } else
            {
                kkAppEng.getOrderMgr().setGiftCertCode(ecf.getGiftCertCode());
            }

            /*
             * Set the reward points in the order manager. If someone tries to use more points than
             * those available, then use the points available
             */
            kkAppEng.getOrderMgr().setRewardPoints(0);
            if (kkAppEng.getRewardPointMgr().isEnabled())
            {
                int pointsAvailable = kkAppEng.getRewardPointMgr().pointsAvailable();
                if (ecf.getRewardPoints() != null && ecf.getRewardPoints().length() > 0
                        && pointsAvailable > 0)
                {
                    try
                    {
                        int points = Integer.parseInt(ecf.getRewardPoints());
                        if (points > pointsAvailable)
                        {
                            kkAppEng.getOrderMgr().setRewardPoints(pointsAvailable);
                        } else if (points >= 0)
                        {
                            kkAppEng.getOrderMgr().setRewardPoints(points);
                        }
                    } catch (Exception e)
                    {
                    }
                }
            }
            /*
             * Get the list of CartItem objects from the form and update or delete the selected
             * items
             */
            for (Iterator iter = ecf.getItemList().iterator(); iter.hasNext();)
            {
                CartItem item = (CartItem) iter.next();

                /*
                 * We need to find the Basket object corresponding to the CartItem object and we
                 * remove it or update it if required.
                 */
                if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                        && kkAppEng.getCustomerMgr().getCurrentCustomer().getBasketItems() != null)
                {
                    for (int j = 0; j < kkAppEng.getCustomerMgr().getCurrentCustomer()
                            .getBasketItems().length; j++)
                    {
                        BasketIf b = kkAppEng.getCustomerMgr().getCurrentCustomer()
                                .getBasketItems()[j];
                        if (b.getId() == item.getBasketItemId())
                        {
                            if (item.isRemove())
                            {
                                // remove the basket item
                                kkAppEng.getBasketMgr().removeFromBasket(b, /* refresh */false);

                                // insert an event
                                insertCustomerEvent(kkAppEng, ACTION_REMOVE_FROM_CART, b
                                        .getProductId());
                            } else if (item.getQuantity() != b.getQuantity())
                            {
                                // update the basket item quantity
                                if (item.getQuantity() == 0)
                                {
                                    // remove the basket item
                                    kkAppEng.getBasketMgr().removeFromBasket(b, /* refresh */false);

                                    // insert an event
                                    insertCustomerEvent(kkAppEng, ACTION_REMOVE_FROM_CART, b
                                            .getProductId());
                                } else
                                {
                                    b.setQuantity(item.getQuantity());
                                    kkAppEng.getBasketMgr().updateBasket(b, /* refresh */false);
                                }
                            }
                        }
                    }
                }
            }

            // Update the basket data
            kkAppEng.getBasketMgr().getBasketItemsPerCustomer();

            kkAppEng.nav.set(getCatMessage(request, "header.cart.contents"), request);

            if (ecf.getGoToCheckout().equalsIgnoreCase("true"))
            {
                return mapping.findForward("CheckoutDelivery");
            }
            return mapping.findForward("ShowCart");
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }

}
