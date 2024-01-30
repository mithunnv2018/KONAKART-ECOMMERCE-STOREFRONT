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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.app.WishList;
import com.konakart.appif.WishListIf;
import com.konakart.forms.CreateGiftRegistryForm;

/**
 * Create a gift registry.
 */
public class CreateGiftRegistrySubmitAction extends BaseAction
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

            CreateGiftRegistryForm grf = (CreateGiftRegistryForm) form;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, null);

            // Check to see whether the user is logged in since this is required to create a gift
            // registry
            custId = this.loggedIn(request, response, kkAppEng, "CreateGiftRegistry");
            if (custId < 0)
            {
                return mapping.findForward(loginForward);
            }

            // If it is a temporary customer, then he needs to register to create a gift registry
            if (kkAppEng.getCustomerMgr().getCurrentCustomer() != null
                    && kkAppEng.getCustomerMgr().getCurrentCustomer().getType() == com.konakart.bl.CustomerMgr.CUST_TYPE_NON_REGISTERED_CUST)
            {
                return mapping.findForward(loginForward);
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            /*
             * Create the gift registry
             */
            WishListIf wl = new WishList();
            wl.setAddressId(grf.getAddressId());
            wl.setCustom1(grf.getCustom1());
            wl.setCustom2(grf.getCustom2());
            wl.setCustom3(grf.getCustom3());
            wl.setCustom4(grf.getCustom4());
            wl.setCustom5(grf.getCustom5());
            wl.setCustomer1FirstName(grf.getCustomer1FirstName());
            wl.setCustomer1LastName(grf.getCustomer1LastName());
            wl.setCustomerFirstName(grf.getCustomerFirstName());
            wl.setCustomerLastName(grf.getCustomerLastName());
            wl.setCustomerId(custId);
            wl.setLinkUrl(grf.getLinkUrl());
            wl.setListType(grf.getListType());
            wl.setName(grf.getName());
            if (grf.getPublicWishList() != null && grf.getPublicWishList().equalsIgnoreCase("true"))
            {
                wl.setPublicWishList(true);
            }else {
                wl.setPublicWishList(false);
            }
            // Set the event date
            if (grf.getEventDateString() != null && !grf.getEventDateString().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                Date d = sdf.parse(grf.getEventDateString());
                if (d != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(d);
                    wl.setEventDate(gc);
                }
            }

            // Add the item
            kkAppEng.getWishListMgr().createWishList(wl);
            // Refresh the customer's wish list
            kkAppEng.getWishListMgr().fetchCustomersWishLists();

            return mapping.findForward("MyAccount");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
