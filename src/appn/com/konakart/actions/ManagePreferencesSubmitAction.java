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
import com.konakart.forms.PreferencesForm;

/**
 * Gets called after submitting the manage preferences form.
 */
public class ManagePreferencesSubmitAction extends BaseAction
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

            PreferencesForm localForm = (PreferencesForm) form;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "ManagePreferences");

            // Check to see whether the user is logged in
            if (custId < 0)
            {
                /*
                 * Remove any errors that may be present in the current write reviews form so that
                 * we don't see them in the login form
                 */
                clearErrors(request);
                return mapping.findForward(loginForward);
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            /*
             * Save preferences in managers, cookies and tags
             */
            kkAppEng.getProductMgr().setMaxDisplaySearchResults(localForm.getProductPageSize());
            setKKCookie(TAG_PROD_PAGE_SIZE, Integer.toString(localForm.getProductPageSize()), request,
                    response, kkAppEng);
            kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_PROD_PAGE_SIZE,
                    Integer.toString(localForm.getProductPageSize()));

            kkAppEng.getOrderMgr().setPageSize(localForm.getOrderPageSize());
            setKKCookie(TAG_ORDER_PAGE_SIZE, Integer.toString(localForm.getOrderPageSize()), request,
                    response, kkAppEng);
            kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_ORDER_PAGE_SIZE,
                    Integer.toString(localForm.getOrderPageSize()));

            kkAppEng.getReviewMgr().setPageSize(localForm.getReviewPageSize());
            setKKCookie(TAG_REVIEW_PAGE_SIZE, Integer.toString(localForm.getReviewPageSize()), request,
                    response, kkAppEng);
            kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_REVIEW_PAGE_SIZE,
                    Integer.toString(localForm.getReviewPageSize()));

            return mapping.findForward("MyAccount");

        } catch (Exception e)
        {
            return getForward(mapping, request, e,
                    "com.konakart.app.KKPasswordDoesntMatchException", getCatMessage(request,
                            "change.password.body.error"), "Error");
        }
    }
}
