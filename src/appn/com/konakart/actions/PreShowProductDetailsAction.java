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
import com.konakart.appif.ProductIf;

/**
 * Called to show the details of a product when you don't have the product id. An example of this is
 * when you attempt to add a product to the wish list but you need to login first It gets the id
 * from the current product and then calls ShowProductDetailsAction passing the id as a parameter.
 */
public class PreShowProductDetailsAction extends BaseAction
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
            /*
             * Get the product id from the selected product and add it to the path of the
             * ActionForward as a parameter.
             */
            KKAppEng kkAppEng = this.getKKAppEng(request, response);
            ProductIf selectedProd = kkAppEng.getProductMgr().getSelectedProduct();
            ActionForward af = mapping.findForward("SelectProd");
            if (selectedProd != null)
            {
                StringBuffer path = new StringBuffer(af.getPath());
                path.append("?prodId=");
                path.append(selectedProd.getId());
                return new ActionForward(path.toString());
            }
            return af;

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
