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
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.appif.CustomerTagIf;

/**
 * Gets called to logout.
 */
public class LogoutAction extends BaseAction
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
            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            // Get recently viewed products before logging out
            CustomerTagIf prodsViewedTagCust = kkAppEng.getCustomerTagMgr().getCustomerTag(
                    TAG_PRODUCTS_VIEWED);

            // Log out
            kkAppEng.getCustomerMgr().logout();

            // Manage cookies
            manageCookieLogout(request, response, kkAppEng);

            // Set recently viewed products for the guest customer if changed while logged in
            CustomerTagIf prodsViewedTagGuest = kkAppEng.getCustomerTagMgr().getCustomerTag(
                    TAG_PRODUCTS_VIEWED);
            updateRecentlyViewedProducts(kkAppEng, prodsViewedTagCust, prodsViewedTagGuest);

            kkAppEng.nav.set(getCatMessage(request, "header.logout.page"), request);
            
            //DONE MITHUN ADDE BELOW LINE
            HttpSession session = request.getSession();
            session.invalidate();
            System.out.println("Done session invalidate at logout!");
            return mapping.findForward("OlegLogoutPage");
//            return mapping.findForward("LogoutPage");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
