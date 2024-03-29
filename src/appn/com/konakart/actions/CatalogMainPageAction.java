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
import com.konakart.bl.ProductMgr;

/**
 * Gets called before viewing the main page.
 */
public class CatalogMainPageAction extends BaseAction
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

            // Reset the state of the objects connected to the session. i.e. Selected product etc.
            kkAppEng.reset();

            // Clear the navigation
            kkAppEng.nav.clear();

            // Get the new products for all categories
            kkAppEng.getProductMgr().fetchNewProductsArray(/* categoryId */ProductMgr.DONT_INCLUDE, /* fetchDescription */
            true);

            /*
             * Example of how to apply promotions to the products without needing to add them to the
             * cart. You can decide not to change the actual price of the product but instead to
             * display information informing that the product is discounted using a type of
             * promotion (i.e. 3 for 2). If you do change the price of the product by setting the
             * "subtractValueFromPrice" booleans, then you need to use the discounted price when
             * adding the product to the cart and modify the promotion to not add the discount as an
             * OrderTotal to the order.
             */
            // PromotionOptions options = new PromotionOptions();
            // options.setSubtractValueFromPriceExTax(true);
            // options.setSubtractValueFromPriceIncTax(true);
            // options.setPromotionRule(PromotionOptions.PRM_RULE_CHOOSE_LARGEST);
            //
            // ProductIf[] newProds = kkAppEng.getEng().getPromotionsPerProducts(
            // kkAppEng.getSessionId(),
            // kkAppEng.getCustomerMgr().getCurrentCustomer().getId(),
            // kkAppEng.getProductMgr().getNewProducts(),
            // kkAppEng.getProductMgr().getAllPromotions(), /* couponCodes */null, options);
            // kkAppEng.getProductMgr().setNewProducts(newProds);

            return mapping.findForward("Success");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }

}
