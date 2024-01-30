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
import com.konakart.al.WishListUIItem;
import com.konakart.appif.WishListIf;
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.EditWishListForm;

/**
 * Called to display the wish list items normally after searching for a gift registry
 */
public class ShowGiftRegistryItemsAction extends BaseAction
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

            EditWishListForm ewf = (EditWishListForm) form;

            // Clear the list since the form remains for the session
            ewf.getItemList().clear();

            /*
             * If there are items in the wish list, then we have to create a list of WishListUIItem
             * objects and populate them since these are the objects that we will use to display the
             * wish list items on the screen.
             * 
             * To find the correct wish list we look for a parameter and then an attribute
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
                    return mapping.findForward("Welcome");
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

            WishListIf wishList = kkAppEng.getWishListMgr()
                    .fetchWishListWithoutItems(wishListIdInt);
            kkAppEng.getWishListMgr().navigateCurrentWishListItems(
                    kkAppEng.getWishListMgr().getNavStart());

            if (wishList != null && kkAppEng.getWishListMgr().getCurrentWishListItems() != null)
            {
                WishListItemIf[] items = kkAppEng.getWishListMgr().getCurrentWishListItems();
                int length = items.length;

                /*
                 * We need to make this check since we always fetch an extra item in order to decide
                 * whether to enable the next button or not.
                 */
                if (length > kkAppEng.getWishListMgr().getMaxItemRows())
                {
                    length = kkAppEng.getWishListMgr().getMaxItemRows();
                }

                for (int i = 0; i < length; i++)
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
                ewf.setListName(wishList.getName());
            }
            kkAppEng.nav.set(getCatMessage(request, "header.weddinglist.contents"), request);

            return mapping.findForward("ShowGiftRegistryItems");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
