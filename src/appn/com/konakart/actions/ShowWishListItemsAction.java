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
import com.konakart.al.WishListMgr;
import com.konakart.al.WishListUIItem;
import com.konakart.appif.WishListIf;
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.EditWishListForm;

/**
 * Called to display the wish list items normally after editing the wish list or after adding a new
 * item to the wish list It uses the EditWishListForm.
 */
public class ShowWishListItemsAction extends BaseAction
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

            // Ensure that we are logged in
            custId = this.loggedIn(request, response, kkAppEng, null);
            if (custId < 0)
            {              
                boolean allowWLBool = kkAppEng.getWishListMgr().allowWishListWhenNotLoggedIn();
                if (allowWLBool && kkAppEng.getCustomerMgr().getCurrentCustomer() != null)
                {
                    custId = kkAppEng.getCustomerMgr().getCurrentCustomer().getId();
                } else
                {
                    return mapping.findForward(loginForward);
                }
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId,/* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            EditWishListForm ewf = (EditWishListForm) form;

            // Clear the list since the form remains for the session
            ewf.getItemList().clear();

            /*
             * If the current customer has wish list items in his wish list, then we have to create
             * a list of WishListUIItem objects and populate them since these are the objects that
             * we will use to display the wish list items on the screen.
             * 
             * The KonaKart server can accommodate multiple wish lists for each customer. However in
             * this application we assume that there will only ever be one wish list for a customer.
             * 
             * To find the correct wish list we first look for a parameter and then an attribute. If
             * neither exist then we find the wish list of type WishListMgr.WISH_LIST_TYPE
             */

            // Find the wish list
            int wishListIdInt = -1;
            String wishListIdStr = request.getParameter("wishListId");
            if (wishListIdStr != null)
            {
                try
                {
                    wishListIdInt = new Integer(wishListIdStr).intValue();
                } catch (Exception e)
                {
                    return mapping.findForward("ShowWishListItems");
                }
            }

            if (wishListIdInt == -1)
            {
                Integer wishListIdIntg = null;
                if (runningInPortal(kkAppEng) && request.getSession() != null)
                {
                    wishListIdIntg = (Integer) request.getSession().getAttribute("wishListId");
                    request.getSession().removeAttribute("wishListId");
                } else
                {
                    wishListIdIntg = (Integer) request.getAttribute("wishListId");
                }

                if (wishListIdIntg != null)
                {
                    wishListIdInt = wishListIdIntg.intValue();
                }
            }

            WishListIf wishList = null;
            if (wishListIdInt < 0)
            {
                if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                        && kkAppEng.getCustomerMgr().getCurrentCustomer().getWishLists() != null)
                {
                    for (int i = 0; i < kkAppEng.getCustomerMgr().getCurrentCustomer()
                            .getWishLists().length; i++)
                    {
                        WishListIf wl = kkAppEng.getCustomerMgr().getCurrentCustomer()
                                .getWishLists()[i];
                        if (wl.getListType() == WishListMgr.WISH_LIST_TYPE)
                        {
                            wishList = wl;
                            kkAppEng.getWishListMgr().setCurrentWishList(wl);
                            break;
                        }
                    }
                }
            } else
            {
                if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                        && kkAppEng.getCustomerMgr().getCurrentCustomer().getWishLists() != null)
                {
                    for (int i = 0; i < kkAppEng.getCustomerMgr().getCurrentCustomer()
                            .getWishLists().length; i++)
                    {
                        WishListIf wl = kkAppEng.getCustomerMgr().getCurrentCustomer()
                                .getWishLists()[i];
                        if (wl != null && wl.getId() == wishListIdInt)
                        {
                            wishList = wl;
                            kkAppEng.getWishListMgr().setCurrentWishList(wl);
                            ewf.setListName(wl.getName());
                            break;
                        }
                    }
                }
            }

            if (wishList != null)
            {
                WishListItemIf[] items = wishList.getWishListItems();

                for (int i = 0; i < items.length; i++)
                {
                    WishListItemIf wli = items[i];
                    if (wli != null && wli.getProduct() != null)
                    {
                        // Create a WishListUIItem
                        WishListUIItem item = new WishListUIItem(wli.getId(), wli.getProduct()
                                .getId(), wli.getProduct().getName(), wli.getProduct().getImage(),
                                wli.getFinalPriceExTax(), wli.getFinalPriceIncTax(), wli
                                        .getPriority(), wli.getQuantityDesired(), wli
                                        .getQuantityReceived(), wli.getComments());
                        // Set the options of the new WishListUIItem
                        if (wli.getOpts() != null && wli.getOpts().length > 0)
                        {
                            String[] optNameArray = new String[wli.getOpts().length];
                            for (int j = 0; j < wli.getOpts().length; j++)
                            {
                                if (wli.getOpts()[j] != null)
                                {
                                    optNameArray[j] = wli.getOpts()[j].getName() + " "
                                            + wli.getOpts()[j].getValue();
                                } else
                                {
                                    optNameArray[j] = "";
                                }
                            }
                            item.setOptNameArray(optNameArray);
                        }

                        // Add the new item to the list
                        ewf.getItemList().add(item);
                    }
                }
                ewf.setFinalPriceExTax(wishList.getFinalPriceExTax());
                ewf.setFinalPriceIncTax(wishList.getFinalPriceIncTax());
                ewf.setId(wishList.getId());
            }
            kkAppEng.nav.set(getCatMessage(request, "header.wishlist.contents"), request);

            if (wishList != null && wishList.getListType() != WishListMgr.WISH_LIST_TYPE)
            {
                return mapping.findForward("ShowGiftRegistryItems");
            }
            return mapping.findForward("ShowWishListItems");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
