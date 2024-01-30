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
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import com.konakart.al.KKAppEng;
import com.konakart.app.Customer;
import com.konakart.app.CustomerTag;
import com.konakart.appif.CustomerIf;
import com.konakart.forms.RegisterCustomerForm;

/**
 * Gets called after submitting the edit customer page.
 */
public class EditCustomerSubmitAction extends BaseAction
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

            RegisterCustomerForm localForm = (RegisterCustomerForm) form;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "EditCustomer");

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

            // Copy the inputs from the form to a customer object
            CustomerIf cust = new Customer();
            cust.setGender(localForm.getGender());
            cust.setFirstName(localForm.getFirstName());
            cust.setLastName(localForm.getLastName());
            cust.setBirthDate(localForm.getBirthDate());
            cust.setEmailAddr(localForm.getEmailAddr());
            cust.setFaxNumber(localForm.getFaxNumber());
            cust.setTelephoneNumber(localForm.getTelephoneNumber());
            cust.setTelephoneNumber1(localForm.getTelephoneNumber1());
            cust.setId(kkAppEng.getCustomerMgr().getCurrentCustomer().getId());
            cust.setCustom1(localForm.getCustomerCustom1());
            
            CustomerIf currentCustomer = kkAppEng.getCustomerMgr().getCurrentCustomer();
            if (currentCustomer != null) {
                cust.setType(currentCustomer.getType());
            }

            // Set the date
            if (localForm.getBirthDateString() != null
                    && !localForm.getBirthDateString().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                Date d = sdf.parse(localForm.getBirthDateString());
                if (d != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(d);
                    cust.setBirthDate(gc);
                    
                    // Set the customer tag
                    CustomerTag ct = new CustomerTag();
                    ct.setValueAsDate(d);
                    ct.setName(TAG_BIRTH_DATE);
                    kkAppEng.getCustomerTagMgr().insertCustomerTag(ct);
                }
            }
            
            // Set the IS_MALE customer tag for this customer
            CustomerTag ct = new CustomerTag();
            ct.setName(TAG_IS_MALE);
            ct.setValueAsBoolean(false);
            if (localForm.getGender() != null && localForm.getGender().equalsIgnoreCase("m"))
            {
                ct.setValueAsBoolean(true);
            }
            kkAppEng.getCustomerTagMgr().insertCustomerTag(ct);

            // Call the engine registration method
            try
            {
                kkAppEng.getCustomerMgr().editCustomer(cust);
            } catch (Exception e)
            {
                ActionMessages errors = new ActionMessages();
                errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                        "edit.customer.body.user.exists"));
                this.saveErrors(request, errors);
                return mapping.findForward("EditCustomerSubmitError");
            }

            return mapping.findForward("MyAccount");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
