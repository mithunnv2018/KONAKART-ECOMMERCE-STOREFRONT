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
import com.konakart.app.Basket;
import com.konakart.appif.BasketIf;
import com.konakart.appif.ProductIf;
import com.konakart.oleg.OlegTasks;

/**
 * Adds a product to the cart based on the parameter "prodId"
 */
public class AddToCartFromProdIdAction extends BaseAction
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

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, null);

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            String prodId = request.getParameter("prodId");

            if (prodId == null)
            {
                return mapping.findForward("Welcome");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Product Id of selected product from application = " + prodId);
            }

            // Get the product from its Id
            kkAppEng.getProductMgr().fetchSelectedProduct(new Integer(prodId).intValue());
            ProductIf selectedProd = kkAppEng.getProductMgr().getSelectedProduct();
            if (selectedProd == null)
            {
                return mapping.findForward("ShowCart");
            }
            
            
          //MITHUN DONE ADDED CODE HERE AS ON 25/01/2013
            String checkIfProductIsCopyRight = OlegTasks.checkIfProductIsCopyRight(kkAppEng,prodId,request);
            if(!checkIfProductIsCopyRight.isEmpty())
            {
            	return mapping.findForward(checkIfProductIsCopyRight);
            }

            /*
             * If the product has options then we can't add it to the cart directly. We must first
             * go to the product details page so that the options can be selected.
             */
            if (selectedProd.getOpts() != null && selectedProd.getOpts().length > 0)
            {
                request.setAttribute("prodId", prodId);
                return mapping.findForward("ShowProductDetails");
            }

            /*
             * Create a basket item. Only the product id is required to save the basket item. Note
             * that the array of options may be null.
             */
            BasketIf b = new Basket();
            b.setQuantity(1);
            b.setProductId(selectedProd.getId());

            kkAppEng.getBasketMgr().addToBasket(b, /* refresh */true);

            return mapping.findForward("ShowCart");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
