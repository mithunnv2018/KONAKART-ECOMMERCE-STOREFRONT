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

import com.konakart.al.KKAppEng;
import com.konakart.al.WishListMgr;
import com.konakart.al.WishListUIItem;
import com.konakart.app.Basket;
import com.konakart.appif.BasketIf;
import com.konakart.appif.WishListIf;
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.EditWishListForm;

/**
 * Gets called to edit the wish list.
 */
public class EditWishListSubmitAction extends BaseAction
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
            if (custId < 0)
            {
                if (custId < 0)
                {
                    if (kkAppEng.getWishListMgr().allowWishListWhenNotLoggedIn()
                            && kkAppEng.getCustomerMgr().getCurrentCustomer() != null)
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

            EditWishListForm ewf = (EditWishListForm) form;

            // Find the wish list
            int wishListId = ewf.getId();
            WishListIf wishList = null;
            if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                    && kkAppEng.getCustomerMgr().getCurrentCustomer().getWishLists() != null)
            {
                for (int i = 0; i < kkAppEng.getCustomerMgr().getCurrentCustomer().getWishLists().length; i++)
                {
                    WishListIf wl = kkAppEng.getCustomerMgr().getCurrentCustomer().getWishLists()[i];
                    if (wl.getId() == wishListId)
                    {
                        wishList = wl;
                        kkAppEng.getWishListMgr().setCurrentWishList(wl);
                        break;
                    }
                }
            }

            if (wishList == null || wishList.getWishListItems() == null)
            {
                return mapping.findForward("ShowWishList");
            }

            /*
             * Get the list of WishListUIItem objects from the form and update or delete the
             * selected items
             */
            for (Iterator iter = ewf.getItemList().iterator(); iter.hasNext();)
            {
                WishListUIItem item = (WishListUIItem) iter.next();

                /*
                 * We need to find the WishListItem object corresponding to the WishListUIItem
                 * object and we remove it or update it if required.
                 */
                for (int j = 0; j < wishList.getWishListItems().length; j++)
                {
                    WishListItemIf wli = wishList.getWishListItems()[j];
                    if (wli.getId() == item.getWishListItemId())
                    {
                        if (item.isAddToBasket())
                        {
                            // add the item to the cart
                            BasketIf b = new Basket();
                            b.setQuantity(1);
                            b.setOpts(wli.getOpts());
                            b.setProductId(wli.getProductId());
                            kkAppEng.getBasketMgr().addToBasket(b, /* refresh */true);
                        }

                        if (item.isRemove())
                        {
                            // remove the wish list item
                            kkAppEng.getWishListMgr().removeFromWishList(wli);
                        } else if (item.getPriority() != wli.getPriority()
                                || item.getQuantityDesired() != wli.getQuantityDesired())
                        {
                            // remove the wish list item
                            kkAppEng.getWishListMgr().removeFromWishList(wli);
                            // add the wish list item with new values
                            wli.setPriority(item.getPriority());
                            wli.setQuantityDesired(item.getQuantityDesired());
                            kkAppEng.getWishListMgr().addToWishList(wli);
                        }
                    }
                }
            }

            // Update the wish list data
            kkAppEng.getWishListMgr().fetchCustomersWishLists();

            kkAppEng.nav.set(getCatMessage(request, "header.wishlist.contents"), request);
            if (wishList.getListType() != WishListMgr.WISH_LIST_TYPE)
            {
                /*
                 * When running as a portlet the attribute is lost so we save it in the session
                 */
                if (runningInPortal(kkAppEng) && request.getSession() != null)
                {
                    request.getSession().setAttribute("wishListId", wishList.getId());
                } else
                {
                    request.setAttribute("wishListId", wishList.getId());
                }
            }
            return mapping.findForward("ShowWishList");
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
