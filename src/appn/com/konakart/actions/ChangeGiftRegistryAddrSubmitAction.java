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
import com.konakart.appif.AddressIf;
import com.konakart.appif.WishListIf;
import com.konakart.forms.ChangeAddrForm;

/**
 * Gets called when moving on to the next page of the checkout process after the delivery address
 * page
 */
public class ChangeGiftRegistryAddrSubmitAction extends BaseAction
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

            ChangeAddrForm localForm = (ChangeAddrForm) form;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "MyAccount");

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

            WishListIf currentWishList = kkAppEng.getWishListMgr().getCurrentWishList();
            if (currentWishList != null)
            {
                currentWishList.setAddressId(new Integer(localForm.getAddrId()).intValue());

                // Edit the wish list
                kkAppEng.getWishListMgr().editWishList(currentWishList);

                // Refresh the customer's wish list
                kkAppEng.getWishListMgr().fetchCustomersWishLists();

                // Set the selected address object onto the current wish list
                if (kkAppEng.getCustomerMgr().getCurrentCustomer().getAddresses() != null)
                {
                    for (int i = 0; i < kkAppEng.getCustomerMgr().getCurrentCustomer()
                            .getAddresses().length; i++)
                    {
                        AddressIf addr = kkAppEng.getCustomerMgr().getCurrentCustomer()
                                .getAddresses()[i];
                        if (addr.getId() == currentWishList.getAddressId())
                        {
                            currentWishList.setAddress(addr);
                        }
                    }
                }

            }

            return mapping.findForward("EditGiftRegistryPage");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
