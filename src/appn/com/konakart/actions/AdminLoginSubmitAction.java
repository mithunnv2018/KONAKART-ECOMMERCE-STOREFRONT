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
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import com.konakart.al.KKAppEng;
import com.konakart.app.KKException;
import com.konakart.appif.CustomerIf;

/**
 * Gets called to login a user by an admin user
 */
public class AdminLoginSubmitAction extends BaseAction
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

            /*
             * Check input parameters
             */
            String customerId = request.getParameter("id");
            if (customerId == null || customerId.length() == 0)
            {
                throw new KKException(
                        "The request must contain a parameter called \"id\" that contains a customer id");
            }

            try
            {
                new Integer(customerId);
            } catch (Exception e1)
            {
                throw new KKException("The parameter called \"id\" must contain an integer value");
            }

            String adminSession = request.getParameter("sess");
            if (adminSession == null || adminSession.length() == 0)
            {
                throw new KKException(
                        "The request must contain a parameter called \"sess\" that contains the session of the administrator perfoming the login");
            }

            /*
             * Ensure we are using the correct protocol. Redirect if not.
             */
            ActionForward redirForward = checkSSL(kkAppEng, request, 0, /* forceSSL */true);
            if (redirForward != null)
            {
                return redirForward;
            }

            /*
             * Perform the login
             */
            String custSession = kkAppEng.getCustomerMgr().loginByAdmin(adminSession,
                    Integer.parseInt(customerId));

            if (custSession == null)
            {
                ActionMessages errors = new ActionMessages();
                errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                        "login.body.login.error"));
                this.saveErrors(request, errors);
                return mapping.findForward("LoginSubmitError");
            }

            /*
             * Get details of the admin user for auditing purposes
             */
             CustomerIf adminUser = kkAppEng.getEng().getCustomer(adminSession);
             kkAppEng.setAdminUser(adminUser);   
                          
            //Set the breadcrumbs
            kkAppEng.nav.set(getCatMessage(request, "header.my.account"), request);

            return mapping.findForward("LoginSubmit");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
