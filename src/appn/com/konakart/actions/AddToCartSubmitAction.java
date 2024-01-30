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
import com.konakart.app.Basket;
import com.konakart.app.Option;
import com.konakart.app.WishListItem;
import com.konakart.appif.BasketIf;
import com.konakart.appif.OptionIf;
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.AddToCartForm;
import com.konakart.oleg.OlegTasks;

/**
 * Adds products to the cart or the wish list based on the "AddToCart" form.
 */
public class AddToCartSubmitAction extends BaseAction
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

            // If true, we are adding to the wish list and not to the basket
            boolean addToWishList = false;

            AddToCartForm acf = (AddToCartForm) form;
            if (acf.getAddToWishList() != null && acf.getAddToWishList().equalsIgnoreCase("true"))
            {
                addToWishList = true;
            }

            // Check that a product exists to add
            try
            {
                Integer.parseInt(acf.getProductId());
            } catch (Exception e)
            {
                if (addToWishList)
                {
                    return mapping.findForward("ShowWishListItems");
                }
                return mapping.findForward("ShowCart");
            }

            KKAppEng kkAppEng = this.getKKAppEng(request, response);
            
            //MITHUN DONE ADDED CODE HERE AS ON 25/01/2013
            String checkIfProductIsCopyRight = OlegTasks.checkIfProductIsCopyRight(kkAppEng,acf.getProductId(),request);
            if(!checkIfProductIsCopyRight.isEmpty())
            {
            	return mapping.findForward(checkIfProductIsCopyRight);
            }

            custId = this.loggedIn(request, response, kkAppEng, null);
            // Check to see whether the user is logged in if adding to wish list          
            if (addToWishList)
            {
                boolean allowWLBool = kkAppEng.getWishListMgr().allowWishListWhenNotLoggedIn();                            
                custId = this.loggedIn(request, response, kkAppEng, "PreSelectProd");
                if (custId < 0)
                {
                    if (allowWLBool && kkAppEng.getCustomerMgr().getCurrentCustomer() != null)
                    {
                        custId = kkAppEng.getCustomerMgr().getCurrentCustomer().getId();
                    } else
                    {
                        return mapping.findForward(loginForward);
                    }
                }

                // If it is a temporary customer, then he needs to register to add products to the
                // wish list
                if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                        && kkAppEng.getCustomerMgr().getCurrentCustomer().getType() == com.konakart.bl.CustomerMgr.CUST_TYPE_NON_REGISTERED_CUST)
                {
                    if (allowWLBool && kkAppEng.getCustomerMgr().getCurrentCustomer() != null)
                    {
                        custId = kkAppEng.getCustomerMgr().getCurrentCustomer().getId();
                    } else
                    {
                        return mapping.findForward(loginForward);
                    }
                }
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            /*
             * Get the selected options from the form and place them in an array of option objects
             */
            OptionIf[] opts = null;
            if (acf.getNumOptions() > 0)
            {
                OptionIf[] localOpts = new OptionIf[acf.getNumOptions()];
                for (int i = 0; i < acf.getNumOptions(); i++)
                {
                    OptionIf o = new Option();
                    o.setId(acf.getOptionId(i));
                    o.setValueId(acf.getValueId(i));
                    o.setType(acf.getType(i));
                    o.setQuantity(acf.getQuantity(i));
                    localOpts[i] = o;
                }
                opts = localOpts;
            }

            if (addToWishList)
            {
                /*
                 * Add an item to the customer's wish list
                 */
                WishListItemIf wli = new WishListItem();
                wli.setOpts(opts);
                wli.setProductId(Integer.parseInt(acf.getProductId()));
                // WishListId defaults to -1 to pick up default wish list or create a new one
                try
                {
                    Integer.parseInt(acf.getWishListId());
                } catch (Exception e)
                {
                    if (log.isWarnEnabled())
                    {
                        log.warn("AddToCartSubmitAction called with a non integer WishList Id : "
                                + acf.getWishListId());
                    }
                    return mapping.findForward("ShowWishListItems");
                }
                wli.setWishListId(new Integer(acf.getWishListId()).intValue());
                // Medium priority
                wli.setPriority(3);
                // Quantity = 1
                wli.setQuantityDesired(1);
                // Add the item
                kkAppEng.getWishListMgr().addToWishList(wli);
                // Refresh the customer's wish list
                kkAppEng.getWishListMgr().fetchCustomersWishLists();

                /*
                 * When running as a portlet the attribute is lost so we save it in the session
                 */
                if (runningInPortal(kkAppEng) && request.getSession() != null)
                {
                    request.getSession().setAttribute("wishListId", wli.getWishListId());
                } else
                {
                    request.setAttribute("wishListId", wli.getWishListId());
                }

                return mapping.findForward("ShowWishListItems");
            }

            /*
             * Create a basket item. Only the product id is required to save the basket item. Note
             * that the array of options may be null.
             */
            BasketIf b = new Basket();
            b.setQuantity(1);
            b.setOpts(opts);
            b.setProductId(Integer.parseInt(acf.getProductId()));

            kkAppEng.getBasketMgr().addToBasket(b, /* refresh */true);

            return mapping.findForward("ShowCart");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
