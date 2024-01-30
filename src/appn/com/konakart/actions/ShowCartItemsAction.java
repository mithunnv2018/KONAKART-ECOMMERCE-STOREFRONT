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

import com.konakart.al.CartItem;
import com.konakart.al.KKAppEng;
import com.konakart.app.CreateOrderOptions;
import com.konakart.app.Option;
import com.konakart.appif.BasketIf;
import com.konakart.appif.CreateOrderOptionsIf;
import com.konakart.appif.OrderIf;
import com.konakart.forms.EditCartForm;

/**
 * Called to display the new cart items after editing the cart. It uses the EditCartForm.
 */
public class ShowCartItemsAction extends BaseAction
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

            EditCartForm ecf = (EditCartForm) form;

            // Clear the list since the form remains for the session
            ecf.getItemList().clear();

            // Set the coupon code from the one saved in the order manager
            if (kkAppEng.getOrderMgr().getCouponCode() == null)
            {
                ecf.setCouponCode("");
            } else
            {
                ecf.setCouponCode(kkAppEng.getOrderMgr().getCouponCode());
            }

            // Set the GiftCert code from the one saved in the order manager
            if (kkAppEng.getOrderMgr().getGiftCertCode() == null)
            {
                ecf.setGiftCertCode("");
            } else
            {
                ecf.setGiftCertCode(kkAppEng.getOrderMgr().getGiftCertCode());
            }

            // Set the reward points from the ones saved in the order manager
            if (kkAppEng.getOrderMgr().getRewardPoints() == 0)
            {
                ecf.setRewardPoints("");
            } else
            {
                ecf.setRewardPoints(String.valueOf(kkAppEng.getOrderMgr().getRewardPoints()));
            }

            /*
             * If the current customer has items in his basket, then we have to create a list of
             * CartItem objects and populate them since these are the objects that we will use to
             * display the basket items on the screen.
             */
            if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                    && kkAppEng.getCustomerMgr().getCurrentCustomer().getBasketItems() != null
                    && kkAppEng.getCustomerMgr().getCurrentCustomer().getBasketItems().length > 0)
            {

                // We update the basket with the quantities in stock
                BasketIf[] items = kkAppEng.getEng().updateBasketWithStockInfoWithOptions(
                        kkAppEng.getCustomerMgr().getCurrentCustomer().getBasketItems(),
                        kkAppEng.getBasketMgr().getAddToBasketOptions());

                /*
                 * Create a temporary order to get order totals that we can display in the edit cart
                 * screen. Comment this out if you don't want to show extra information such as
                 * shipping and discounts before checkout.
                 */
                createTempOrder(kkAppEng, custId, items, ecf);

                for (int i = 0; i < items.length; i++)
                {
                    BasketIf b = items[i];
                    if (b != null && b.getProduct() != null)
                    {
                        CartItem item = new CartItem(b.getId(), b.getProduct().getId(), b
                                .getProduct().getName(), b.getProduct().getImage(),
                                b.getFinalPriceExTax(), b.getFinalPriceIncTax(), b.getQuantity(),
                                b.getQuantityInStock());
                        // Set the options of the new CartItem
                        if (b.getOpts() != null && b.getOpts().length > 0)
                        {
                            String[] optNameArray = new String[b.getOpts().length];
                            for (int j = 0; j < b.getOpts().length; j++)
                            {
                                if (b.getOpts()[j] != null)
                                {
                                    if (b.getOpts()[j].getType() == Option.TYPE_VARIABLE_QUANTITY)
                                    {
                                        optNameArray[j] = b.getOpts()[j].getName() + " "
                                                + b.getOpts()[j].getQuantity() + " "
                                                + b.getOpts()[j].getValue();
                                    } else
                                    {
                                        optNameArray[j] = b.getOpts()[j].getName() + " "
                                                + b.getOpts()[j].getValue();
                                    }
                                } else
                                {
                                    optNameArray[j] = "";
                                }
                            }
                            item.setOptNameArray(optNameArray);
                        }

                        ecf.getItemList().add(item);
                    }
                }
            }

            kkAppEng.nav.set(getCatMessage(request, "header.cart.contents"), request);
            return mapping.findForward("ShowCart");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

    /*
     * Populate checkout order with a temporary order created before the checkout process really
     * begins. If the customer hasn't registered or logged in yet, we use the default customer to
     * create the order.
     * 
     * With this temporary order we can give the customer useful information on shipping costs and
     * discounts without him having to login.
     */
    private void createTempOrder(KKAppEng kkAppEng, int custId, BasketIf[] items, EditCartForm ecf)
    {
        try
        {
            String sessionId = null;

            // Reset the checkout order
            kkAppEng.getOrderMgr().setCheckoutOrder(null);

            CreateOrderOptionsIf options = new CreateOrderOptions();
            if (custId < 0)
            {
                options.setUseDefaultCustomer(true);
            } else
            {
                sessionId = kkAppEng.getSessionId();
                options.setUseDefaultCustomer(false);
            }

            // Add extra info to the options
            if (kkAppEng.getFetchProdOptions() != null)
            {
                options.setPriceDate(kkAppEng.getFetchProdOptions().getPriceDate());
                options.setCatalogId(kkAppEng.getFetchProdOptions().getCatalogId());
                options.setUseExternalPrice(kkAppEng.getFetchProdOptions().isUseExternalPrice());
                options.setUseExternalQuantity(kkAppEng.getFetchProdOptions()
                        .isUseExternalQuantity());
            }

            // Create the order
            OrderIf order = kkAppEng.getEng().createOrderWithOptions(sessionId, items, options,
                    kkAppEng.getLangId());

            if (order == null)
            {
                return;
            }

            /*
             * We set the customer id to that of the guest customer so that promotions with
             * expressions are calculated correctly
             */
            if (custId < 0)
            {
                order.setCustomerId(kkAppEng.getCustomerMgr().getCurrentCustomer().getId());
            }

            // Populate the order with the coupon code if it exists
            if (ecf.getCouponCode() != null && ecf.getCouponCode().length() > 0)
            {
                order.setCouponCode(ecf.getCouponCode());
            }

            // Populate the order with the GiftCert code if it exists
            if (ecf.getGiftCertCode() != null && ecf.getGiftCertCode().length() > 0)
            {
                order.setGiftCertCode(ecf.getGiftCertCode());
            }

            // Populate the order with the redeemed points
            if (!(ecf.getRewardPoints() == null || ecf.getRewardPoints().length() == 0))
            {
                try
                {
                    order.setPointsRedeemed(Integer.parseInt(ecf.getRewardPoints()));
                } catch (Exception e)
                {
                }
            }

            // Set the checkout order to be the new order
            kkAppEng.getOrderMgr().setCheckoutOrder(order);

            // Get shipping quotes and select the first one
            kkAppEng.getOrderMgr().createShippingQuotes();
            if (kkAppEng.getOrderMgr().getShippingQuotes() != null
                    && kkAppEng.getOrderMgr().getShippingQuotes().length > 0)
            {
                kkAppEng.getOrderMgr().getCheckoutOrder()
                        .setShippingQuote(kkAppEng.getOrderMgr().getShippingQuotes()[0]);
            }

            // Populate the checkout order with order totals
            kkAppEng.getOrderMgr().populateCheckoutOrderWithOrderTotals();

        } catch (Exception e)
        {
            // If the order can't be created we don't report back an exception
            if (log.isWarnEnabled())
            {
                log.warn("A temporary order could not be created", e);
            }
        }
    }

}
