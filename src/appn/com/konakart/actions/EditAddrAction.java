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
import org.apache.struts.action.ActionMessages;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;

/**
 * Gets called before the edit address page.
 */
public class EditAddrAction extends BaseAction
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

            String addrId = request.getParameter("addrId");

            if (addrId != null)
            {
                kkAppEng.getCustomerMgr().setSelectedAddrFromId(new Integer(addrId).intValue());
            }

            // Check to see whether the user is logged in
            custId = this.loggedIn(request, response, kkAppEng, "EditAddr");
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

            /*
             * If we had to login and have been sent back here, then the parameter will no longer be
             * there, but we we may have already set the selected addr before calling the login page
             */
            if (addrId == null && kkAppEng.getCustomerMgr().getSelectedAddr() == null)
            {
                throw new KKAppException("The addr Id parameter must be initialised");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Addr Id from application = " + addrId);
            }

            /*
             * Empty the array of zones so that it isn't presented during the next addr submit
             * attempt in a drop list. Only empty it if the customer isn't being re-shown the screen
             * because of an error.
             */
            ActionMessages errors = getErrors(request);
            if (errors == null || errors.isEmpty())
            {
                kkAppEng.getCustomerMgr().emptyZonesForRegistration();
            }

            kkAppEng.nav.add(getCatMessage(request, "header.update.entry"), request);
            return mapping.findForward("EditAddrPage");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
