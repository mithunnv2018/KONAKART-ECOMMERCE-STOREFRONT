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
import com.konakart.appif.WishListItemIf;
import com.konakart.forms.EditWishListForm;

/**
 * It receives the navDir parameter to page through the list of wish list items.
 */
public class NavigateGiftRegistryItemsAction extends BaseAction
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
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }
            
            EditWishListForm ewf = (EditWishListForm) form;

            // Clear the list since the form remains for the session
            ewf.getItemList().clear();

            String navDir = request.getParameter("navDir");
            if (navDir == null)
            {
                return mapping.findForward("Welcome");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Navigation direction from application = " + navDir);
            }

            kkAppEng.getWishListMgr().navigateCurrentWishListItems(navDir);
            
            if (kkAppEng.getWishListMgr().getCurrentWishList() != null && kkAppEng.getWishListMgr().getCurrentWishListItems() != null)
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
                ewf.setFinalPriceExTax(kkAppEng.getWishListMgr().getCurrentWishList().getFinalPriceExTax());
                ewf.setFinalPriceIncTax(kkAppEng.getWishListMgr().getCurrentWishList().getFinalPriceIncTax());
                ewf.setId(kkAppEng.getWishListMgr().getCurrentWishList().getId());
                ewf.setListName(kkAppEng.getWishListMgr().getCurrentWishList().getName());
            }
            kkAppEng.nav.set(getCatMessage(request, "header.weddinglist.contents"), request);

            return mapping.findForward("ShowGiftRegistryItems");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
