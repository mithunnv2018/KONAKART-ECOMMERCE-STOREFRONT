//
// (c) 2006 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is the proprietary property of
// DS Data Systems UK Ltd. and is protected by English copyright law,
// the laws of foreign jurisdictions, and international treaties,
// as applicable. No part of this document may be reproduced,
// transmitted, transcribed, transferred, modified, published, or
// translated into any language, in any form or by any means, for
// any purpose other than expressly permitted by DS Data Systems UK Ltd.
// in writing.
//
package com.konakart.forms;

import java.io.UnsupportedEncodingException;

import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.ValidatorForm;

/**
 * Base form for KonaKart Forms
 */
@SuppressWarnings("serial")
public class BaseForm extends ValidatorForm
{

    /**
     * Set the encoding of the request parameters to UTF-8
     */
    public void reset(ActionMapping mapping, javax.servlet.http.HttpServletRequest request)
    {
        super.reset(mapping, request);
        try
        {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
    }
}
