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
import com.konakart.forms.NewsletterForm;

/**
 * Gets called after submitting the edit newsletter page.
 */
public class EditNewsletterSubmitAction extends BaseAction
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

            NewsletterForm localForm = (NewsletterForm) form;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "EditNewsletter");

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

            // Call the engine to modify the newsletter subscription if there have been changes
            // requested
            if (localForm.isNewsletterBool())
            {
                if (!kkAppEng.getCustomerMgr().getCurrentCustomer().getNewsletter().equals("1"))
                {
                    kkAppEng.getCustomerMgr().getCurrentCustomer().setNewsletter("1");
                    kkAppEng.getCustomerMgr().editCustomer(
                            kkAppEng.getCustomerMgr().getCurrentCustomer());
                }

            } else
            {
                if (!kkAppEng.getCustomerMgr().getCurrentCustomer().getNewsletter().equals("0"))
                {
                    kkAppEng.getCustomerMgr().getCurrentCustomer().setNewsletter("0");
                    kkAppEng.getCustomerMgr().editCustomer(
                            kkAppEng.getCustomerMgr().getCurrentCustomer());
                }
            }

            // Add a message to say all OK
            ActionMessages msgs = new ActionMessages();
            msgs.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                    "after.login.body.newsletterOk"));
            this.saveMessages(request, msgs);

            return mapping.findForward("MyAccount");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
