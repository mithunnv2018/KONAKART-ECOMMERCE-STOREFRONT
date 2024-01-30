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

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.app.CustomerRegistration;
import com.konakart.app.CustomerTag;
import com.konakart.app.EmailOptions;
import com.konakart.app.KKException;
import com.konakart.appif.CountryIf;
import com.konakart.appif.CustomerRegistrationIf;
import com.konakart.appif.EmailOptionsIf;
import com.konakart.bl.ConfigConstants;
import com.konakart.forms.RegisterCustomerForm;

/**
 * Gets called after submitting the customer registration page.
 */
public class CustomerRegistrationSubmitAction extends BaseAction
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
        CustomerRegistrationIf cr = new CustomerRegistration();
        KKAppEng kkAppEng = null;

        try
        {
            int custId;
            Date birthDate = null;
            CustomerTag ct = null;

            RegisterCustomerForm localForm = (RegisterCustomerForm) form;

            kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, null);

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */true);
            if (redirForward != null)
            {
                return redirForward;
            }

            // Empty the array of zones so that it isn't presented during the next registration
            // attempt in a drop list.
            kkAppEng.getCustomerMgr().emptyZonesForRegistration();

            // Copy the inputs from the form to the customer registration object
            BeanUtils.copyProperties(cr, form);

            // Set the date
            if (localForm.getBirthDateString() != null
                    && !localForm.getBirthDateString().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                birthDate = sdf.parse(localForm.getBirthDateString());
                if (birthDate != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(birthDate);
                    cr.setBirthDate(gc);
                }
            }

            // Set the newsletter
            if (localForm.isNewsletterBool())
            {
                cr.setNewsletter("1");
            } else
            {
                cr.setNewsletter("0");
            }

            // un-comment if the customer shouldn't be enabled immediately
            // cr.setEnabled(false);

            // Call the engine registration method
            int customerId = kkAppEng.getCustomerMgr().registerCustomer(cr);

            /*
             * If you only want to enable the customer after confirmation, you must save an SSOToken
             * with the customer id. The secret key must be passed in a mail (within a link) to the
             * customer so that when he clicks on the link he calls EnableCustomerSubmitAction. e.g.
             * http
             * ://localhost:8780/konakart/EnableCustomer.do?key=70168e16-eb49-45c4-b47b-e2a2f8c0e6f5
             */
            // SSOTokenIf token = new SSOToken();
            // token.setCustomerId(customerId);
            // String secretKey = kkAppEng.getEng().saveSSOToken(token);
            // System.out.println("key = " + secretKey);

            // Send a welcome email
            EmailOptionsIf options = new EmailOptions();
            options.setCountryCode(kkAppEng.getLocale().substring(0, 2));
            options.setTemplateName(com.konakart.bl.EmailMgr.WELCOME_TEMPLATE);
            kkAppEng.getEng().sendWelcomeEmail1(customerId, options);

            // Set this to false if you don't want to login automatically after registration. Note
            // that customer tags won't be set and the reward points won't be allocated.
            
            boolean loginAfterRegn = true;
            
            if (loginAfterRegn)
            {
                // Now log in the customer
                kkAppEng.getCustomerMgr().login(localForm.getEmailAddr(), localForm.getPassword());
                kkAppEng.nav.set(getCatMessage(request, "header.my.account"), request);

                /*
                 * Set customer tags
                 */

                // Set the BIRTH_DATE customer tag for this customer
                if (birthDate != null)
                {
                    ct = new CustomerTag();
                    ct.setValueAsDate(birthDate);
                    ct.setName(TAG_BIRTH_DATE);
                    kkAppEng.getCustomerTagMgr().insertCustomerTag(ct);
                }

                // Set the COUNTRY_CODE customer tag for this customer
                CountryIf country = kkAppEng.getEng().getCountry(localForm.getCountryId());
                if (country != null && country.getIsoCode3() != null)
                {
                    kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_COUNTRY_CODE,
                            country.getIsoCode3());
                }

                // Set the IS_MALE customer tag for this customer
                ct = new CustomerTag();
                ct.setName(TAG_IS_MALE);
                ct.setValueAsBoolean(false);
                if (localForm.getGender() != null && localForm.getGender().equalsIgnoreCase("m"))
                {
                    ct.setValueAsBoolean(true);
                }
                kkAppEng.getCustomerTagMgr().insertCustomerTag(ct);

                // Set reward points if applicable
                if (kkAppEng.getRewardPointMgr().isEnabled())
                {
                    String pointsStr = kkAppEng
                            .getConfig(ConfigConstants.REGISTRATION_REWARD_POINTS);
                    if (pointsStr != null)
                    {
                        int points = 0;
                        try
                        {
                            points = Integer.parseInt(pointsStr);
                            kkAppEng.getRewardPointMgr().addPoints(points, "REG",
                                    getCatMessage(request, "reward.points.registration"));
                        } catch (Exception e)
                        {
                            log.warn("The REGISTRATION_REWARD_POINTS configuration variable has been set with a non numeric value: "
                                    + pointsStr);
                        }
                    }
                }

                return mapping.findForward("LoginSubmit");
            }
            // Don't login
            kkAppEng.nav.set(getCatMessage(request, "header.registration.submitted"), request);
            return mapping.findForward("CustomerRegistrationSubmit");

        } catch (Exception e)
        {
            /*
             * There could be two cases of application error. The user may already exist, in which
             * case we let the customer try again with a different user name. The zone is invalid
             * for the country. If this occurs we populate a drop down list and force the customer
             * to select from this list.
             */

            if (e.getCause() != null
                    && e.getCause().getClass().getName()
                            .equals("com.konakart.app.KKUserExistsException"))
            {
                return getForward(mapping, request, e, "com.konakart.app.KKUserExistsException",
                        getCatMessage(request, "register.customer.body.user.exists"),
                        "ApplicationError");
            } else if (e.getCause() != null
                    && e.getCause().getClass().getName()
                            .equals("com.konakart.app.KKInvalidZoneException"))
            {
                try
                {
                    if (kkAppEng != null)
                    {
                        kkAppEng.getCustomerMgr().fetchZonesForRegistration(cr.getCountryId());
                    }
                } catch (KKException e1)
                {
                    return mapping.findForward(super.handleException(request, e1));
                }
                return getForward(mapping, request, e, "com.konakart.app.KKInvalidZoneException",
                        getCatMessage(request, "register.customer.body.invalid.zone"),
                        "ApplicationError");
            }

            // For the web services case the cause turns out to be an org.apache.axis.AxisFault.
            // However within the message there is a message that says e.g. nested exception is:
            // com.konakart.app.KKPasswordDoesntMatchException so we search for the name of the
            // exception class that is the cause
            if (e.getMessage() != null
                    && e.getMessage().indexOf("com.konakart.app.KKInvalidZoneException") > -1)
            {
                try
                {
                    if (kkAppEng != null)
                    {
                        kkAppEng.getCustomerMgr().fetchZonesForRegistration(cr.getCountryId());
                    }
                } catch (KKException e1)
                {
                    return mapping.findForward(super.handleException(request, e1));
                }
                return getForward(mapping, request, e, "com.konakart.app.KKInvalidZoneException",
                        getCatMessage(request, "register.customer.body.invalid.zone"),
                        "ApplicationError");
            }
            return getForward(mapping, request, e, "com.konakart.app.KKUserExistsException",
                    getCatMessage(request, "register.customer.body.user.exists"),
                    "ApplicationError");

        }
    }
}
