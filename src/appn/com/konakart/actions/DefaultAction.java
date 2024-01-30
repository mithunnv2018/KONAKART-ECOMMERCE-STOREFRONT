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

/**
 * Action gets called when URL maps to no other actions. This will also get called after the
 * redirect for creating the directory structure URL. In this case we attempt to decode the final
 * part of the URL which contains the information as to which struts action we need to call. For
 * example : http://localhost:8780/konakart/Hardware/Graphics-Cards/1,4,-1,2.do . All the necessary
 * information is contained in the part "1,4,-1,2"
 */
public class DefaultAction extends BaseAction
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
            try
            {
                StringBuffer url = request.getRequestURL();
                
                //System.out.println("DefaultAction Url = "+url);
                
                int fromIndex = 0;
                int index = 0;
                while ((index = url.indexOf("/", fromIndex)) > -1)
                {
                    fromIndex = index + 1;
                }
                String cmd = url.substring(fromIndex, url.length() - SEO_TYPE_LENGTH);
                if (cmd != null && cmd.length() > 0)
                {
                    String[] cmdArray = cmd.split(SEO_DELIM);
                    if (cmdArray.length > 0)
                    {
                        ActionForward forward = null;
                        StringBuffer pathSb = null;
                        int cmdInt = Integer.parseInt(cmdArray[0]);
                        switch (cmdInt)
                        {
                        case SEO_SEL_CAT_CODE:
                            forward = mapping.findForward(SEO_SEL_CAT);
                            pathSb = new StringBuffer(forward.getPath());
                            if (cmdArray.length > 1)
                            {
                                for (int i = 1; i < cmdArray.length; i++)
                                {
                                    String val = cmdArray[i];
                                    switch (i)
                                    {
                                    case 1:
                                        pathSb.append("?catId=");
                                        pathSb.append(val);
                                        break;
                                    case 2:
                                        if (val != null && val.length() > 0)
                                        {
                                            pathSb.append("&manuId=");
                                            pathSb.append(val);
                                        }
                                        break;
                                    case 3:
                                        if (val != null && val.length() > 0)
                                        {
                                            pathSb.append("&prodsFound=");
                                            pathSb.append(val);
                                        }
                                        break;

                                    default:
                                        break;
                                    }

                                }
                                pathSb.append("&seo=1");
                                return new ActionForward(pathSb.toString());
                            }
                            break;
                        case SEO_SEL_PROD_CODE:
                            forward = mapping.findForward(SEO_SEL_PROD);
                            pathSb = new StringBuffer(forward.getPath());
                            if (cmdArray.length > 1)
                            {
                                for (int i = 1; i < cmdArray.length; i++)
                                {
                                    String val = cmdArray[i];
                                    switch (i)
                                    {
                                    case 1:
                                        pathSb.append("?prodId=");
                                        pathSb.append(val);
                                        break;
                                    default:
                                        break;
                                    }
                                }
                                pathSb.append("&seo=1");
                                return new ActionForward(pathSb.toString());
                            }
                            break;
                        case SEO_PRODS_FOR_MANU_CODE:
                            forward = mapping.findForward(SEO_PRODS_FOR_MANU);
                            pathSb = new StringBuffer(forward.getPath());
                            if (cmdArray.length > 1)
                            {
                                for (int i = 1; i < cmdArray.length; i++)
                                {
                                    String val = cmdArray[i];
                                    switch (i)
                                    {
                                    case 1:
                                        pathSb.append("?manuId=");
                                        pathSb.append(val);
                                        break;
                                    default:
                                        break;
                                    }
                                }
                                pathSb.append("&seo=1");
                                return new ActionForward(pathSb.toString());
                            }
                            break;
                        case SEO_SEARCH_BY_MANU_BY_LINK_CODE:
                            forward = mapping.findForward(SEO_SEARCH_BY_MANU_BY_LINK);
                            pathSb = new StringBuffer(forward.getPath());
                            if (cmdArray.length > 1)
                            {
                                for (int i = 1; i < cmdArray.length; i++)
                                {
                                    String val = cmdArray[i];
                                    switch (i)
                                    {
                                    case 1:
                                        pathSb.append("?manuId=");
                                        pathSb.append(val);
                                        break;
                                    default:
                                        break;
                                    }
                                }
                                pathSb.append("&seo=1");
                                return new ActionForward(pathSb.toString());
                            }
                            break;
                        case SEO_SEARCH_BY_MANU_CODE:
                            forward = mapping.findForward(SEO_SEARCH_BY_MANU);
                            pathSb = new StringBuffer(forward.getPath());
                            if (cmdArray.length > 1)
                            {
                                for (int i = 1; i < cmdArray.length; i++)
                                {
                                    String val = cmdArray[i];
                                    switch (i)
                                    {
                                    case 1:
                                        pathSb.append("?manuId=");
                                        pathSb.append(val);
                                        break;
                                    default:
                                        break;
                                    }
                                }
                                pathSb.append("&seo=1");
                                return new ActionForward(pathSb.toString());
                            }
                            break;
                        default:
                            break;
                        }
                    } else
                    {
                        return mapping.findForward("Welcome");
                    }
                    return mapping.findForward("Welcome");
                }
            } catch (Exception e)
            {
                if (log.isDebugEnabled())
                {
                    e.printStackTrace();
                }
                return mapping.findForward("Welcome");
            }
            return mapping.findForward("Welcome");
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
