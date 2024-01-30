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
import com.konakart.app.Address;
import com.konakart.app.KKException;
import com.konakart.appif.AddressIf;
import com.konakart.forms.RegisterCustomerForm;

/**
 * Gets called after submitting the edit address page.
 */
public class EditAddrSubmitAction extends BaseAction
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

        // Create a new object here since it may be used if an exception occurs and so has to be
        // visible.
        AddressIf addr = new Address();
        KKAppEng kkAppEng = null;

        try
        {
            int custId;

            RegisterCustomerForm localForm = (RegisterCustomerForm) form;

            kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "EditAddr");

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

            // Empty the array of zones so that it isn't presented during the next addr
            // submit attempt in a drop list.
            kkAppEng.getCustomerMgr().emptyZonesForRegistration();

            // Copy the inputs from the form to an address object
            addr.setId(kkAppEng.getCustomerMgr().getSelectedAddr().getId());
            addr.setCity(localForm.getCity());
            addr.setCompany(localForm.getCompany());
            addr.setCountryId(localForm.getCountryId());
            addr.setCustomerId(kkAppEng.getCustomerMgr().getCurrentCustomer().getId());
            addr.setFirstName(localForm.getFirstName());
            addr.setGender(localForm.getGender());
            addr.setLastName(localForm.getLastName());
            addr.setPostcode(localForm.getPostcode());
            addr.setState(localForm.getState());
            addr.setStreetAddress(localForm.getStreetAddress());
            addr.setStreetAddress1(localForm.getStreetAddress1());
            addr.setSuburb(localForm.getSuburb());
            addr.setTelephoneNumber(localForm.getAddrTelephone());
            addr.setTelephoneNumber1(localForm.getAddrTelephone1());
            addr.setEmailAddr(localForm.getAddrEmail());
            addr.setIsPrimary(localForm.isSetAsPrimaryBool());

            kkAppEng.getCustomerMgr().editCustomerAddress(addr);

            // Add a message to say all OK
            ActionMessages msgs = new ActionMessages();
            msgs
                    .add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                            "address.book.body.editedok"));
            this.saveMessages(request, msgs);

            return mapping.findForward("AddressBook");

        } catch (Exception e)
        {
            try
            {
                if (kkAppEng != null)
                {
                    kkAppEng.getCustomerMgr().fetchZonesForRegistration(addr.getCountryId());
                }
            } catch (KKException e1)
            {
                return mapping.findForward(super.handleException(request, e1));
            }
            return getForward(mapping, request, e, "com.konakart.app.KKInvalidZoneException",
                    getCatMessage(request, "register.customer.body.invalid.zone"),
                    "ApplicationError");
        }
    }
}
