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
package com.konakart.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

/**
 * 
 * Form used to select whether to receive a newsletter.
 * 
 */
@SuppressWarnings("serial")
public class NewsletterForm extends BaseForm
{

    private boolean newsletterBool;
    
    public void reset( ActionMapping mapping, HttpServletRequest request)
    {
        newsletterBool=false;
    }
 
    /**
     * @return Returns the newsletterBool.
     */
    public boolean isNewsletterBool()
    {
        return newsletterBool;
    }

    /**
     * @param newsletterBool
     *            The newsletterBool to set.
     */
    public void setNewsletterBool(boolean newsletterBool)
    {
        this.newsletterBool = newsletterBool;
    }
}
