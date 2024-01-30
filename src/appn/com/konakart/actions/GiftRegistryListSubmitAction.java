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
import com.konakart.al.WishListUIItem;
import com.konakart.app.Basket;
import com.konakart.appif.BasketIf;
import com.konakart.appif.WishListIf;
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.EditWishListForm;

/**
 * Gets called to add items from a gift registry to the cart
 */
public class GiftRegistryListSubmitAction extends BaseAction
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
            ActionForward redirForward = checkSSL(kkAppEng, request, custId,/* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            EditWishListForm ewf = (EditWishListForm) form;

            // Find the wish list
            int wishListId = ewf.getId();
            WishListIf wishList = null;
            WishListItemIf[] wishListItems = null;
            if (kkAppEng.getWishListMgr().getCurrentWishList() == null
                    || kkAppEng.getWishListMgr().getCurrentWishList().getId() != wishListId)
            {
                wishList = kkAppEng.getWishListMgr().fetchWishList(wishListId);
                if (wishList != null)
                {
                    wishListItems = wishList.getWishListItems();
                }
            } else
            {
                wishList = kkAppEng.getWishListMgr().getCurrentWishList();
                wishListItems = kkAppEng.getWishListMgr().getCurrentWishListItems();
            }

            if (wishList == null || wishListItems == null)
            {
                return mapping.findForward("Welcome");
            }

            /*
             * Get the list of WishListUIItem objects from the form and add the selected ones to the
             * cart
             */
            for (Iterator iter = ewf.getItemList().iterator(); iter.hasNext();)
            {
                WishListUIItem item = (WishListUIItem) iter.next();

                /*
                 * We need to find the WishListItem object corresponding to the WishListUIItem
                 * object
                 */
                for (int j = 0; j < wishListItems.length; j++)
                {
                    WishListItemIf wli = wishListItems[j];
                    if (wli.getId() == item.getWishListItemId())
                    {
                        if (item.isAddToBasket())
                        {
                            // add the item to the cart
                            BasketIf b = new Basket();
                            b.setQuantity(1);
                            b.setOpts(wli.getOpts());
                            b.setProductId(wli.getProductId());
                            b.setWishListId(wishList.getId());
                            b.setWishListItemId(item.getWishListItemId());
                            kkAppEng.getBasketMgr().addToBasket(b, /* refresh */true);
                        }
                    }
                }
            }

            kkAppEng.nav.set(getCatMessage(request, "header.weddinglist.contents"), request);

            // This is only needed if we forward back to the wedding list instead of the cart
            // request.setAttribute("wishListId", wishList.getId());

            return mapping.findForward("ShowCartItems");
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
