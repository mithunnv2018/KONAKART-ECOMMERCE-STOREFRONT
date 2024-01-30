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

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.app.ProductSearch;
import com.konakart.appif.DataDescriptorIf;
import com.konakart.appif.ProductSearchIf;
import com.konakart.forms.SearchProductForm;

/**
 * Performs a search based on data from the SearchProductForm.
 */
public class AdvancedSearchSubmitAction extends BaseAction
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
            ActionForward redirForward = checkSSL(kkAppEng, request, custId,/* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            // Instantiate a ProductSearch object required by the engine
            ProductSearchIf ps = new ProductSearch();
            ps.setReturnCategoryFacets(true);
            ps.setReturnManufacturerFacets(true);

            // Get the form passed in
            SearchProductForm spf = (SearchProductForm) form;

            // Populate the ProductSearch object from the form
            ps.setCategoryId(spf.getCategoryId());

            if (spf.getDateAddedFrom() != null && !spf.getDateAddedFrom().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                Date d = sdf.parse(spf.getDateAddedFrom());
                if (d != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(d);
                    ps.setDateAddedFrom(gc);
                }
            }

            if (spf.getDateAddedTo() != null && !spf.getDateAddedTo().equals(""))
            {
                SimpleDateFormat sdf = new SimpleDateFormat(getCatMessage(request, "date.format"));
                Date d = sdf.parse(spf.getDateAddedTo());
                if (d != null)
                {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(d);
                    ps.setDateAddedTo(gc);
                }
            }

            ps.setManufacturerId(spf.getManufacturerId());

            if (spf.getPriceFrom() != null && !spf.getPriceFrom().equals(""))
            {
                ps.setPriceFrom(new BigDecimal(spf.getPriceFrom()));

                /*
                 * If the user currency is different to the default currency then we need to convert
                 * it into the default currency.
                 */
                if (!kkAppEng.getDefaultCurrency().getCode().equals(
                        kkAppEng.getUserCurrency().getCode()))
                {
                    ps.setPriceFrom(ps.getPriceFrom().divide(kkAppEng.getUserCurrency().getValue(),
                            5, BigDecimal.ROUND_UP));
                }
            }

            if (spf.getPriceTo() != null && !spf.getPriceTo().equals(""))
            {
                ps.setPriceTo(new BigDecimal(spf.getPriceTo()));

                /*
                 * If the user currency is different to the default currency then we need to convert
                 * it into the default currency.
                 */
                if (!kkAppEng.getDefaultCurrency().getCode().equals(
                        kkAppEng.getUserCurrency().getCode()))
                {
                    ps.setPriceTo(ps.getPriceTo().divide(kkAppEng.getUserCurrency().getValue(), 5,
                            BigDecimal.ROUND_UP));
                }
            }

            if (spf.getSearchText() != null && spf.getSearchText().length() > 0)
            {
                ps.setSearchText(spf.getSearchText());
            }

            if (spf.isSearchInDescription())
            {
                ps.setWhereToSearch(ProductSearch.SEARCH_IN_PRODUCT_DESCRIPTION);
            } else
            {
                ps.setWhereToSearch(0);
            }

            /*
             * Get the current dataDescriptor from the productMgr and add a constraint on a custom
             * field if the field has been set. Then set the dataDescriptor.
             */
            DataDescriptorIf dd = kkAppEng.getProductMgr().getDataDesc();
            if (spf.getCustom1() != null && spf.getCustom1().length() > 0)
            {
                dd.setCustom1(spf.getCustom1());
            } else
            {
                dd.setCustom1(null);
            }
            kkAppEng.getProductMgr().setDataDesc(dd);

            // Set the SEARCH_STRING customer tag for this customer
            if (spf.getSearchText() != null && spf.getSearchText().length() > 0)
            {
                kkAppEng.getCustomerTagMgr().insertCustomerTag(TAG_SEARCH_STRING,
                        spf.getSearchText());
            }

            // Call the engine to do the product search
            kkAppEng.getProductMgr().searchForProducts(ps);

            kkAppEng.nav.set(getCatMessage(request, "header.navigation.results"), request);
            return mapping.findForward("AdvancedSearchSubmit");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }
}
