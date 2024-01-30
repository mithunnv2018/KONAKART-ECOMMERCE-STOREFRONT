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

import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.app.KKException;
import com.konakart.appif.CategoryIf;
import com.konakart.bl.ConfigConstants;

/**
 * Selects a category based on the catId parameter.
 */
public class SelectCategoryAction1 extends BaseAction
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

            String catId = request.getParameter("catId");
            if (catId == null)
            {
                return mapping.findForward("Welcome");
            }

            // Test to see whether the catId is an integer
            int catIdInt;
            try
            {
                catIdInt = new Integer(catId).intValue();
            } catch (Exception e)
            {
                return mapping.findForward("Welcome");
            }

            if (log.isDebugEnabled())
            {
                log.debug("Category Id from application = " + catId);
            }

            // Filter products by manufacturer if required - used by suggested search
            String manuId = request.getParameter("manuId");
            int manuIdInt = -1;
            if (manuId != null)
            {
                try
                {
                    manuIdInt = new Integer(manuId).intValue();
                } catch (Exception e)
                {
                }
            }

            CategoryIf selectedCat = kkAppEng.getCategoryMgr().getCurrentCat();
            int seoFormat = kkAppEng.getConfigAsInt(ConfigConstants.SEO_URL_FORMAT);
            if (seoFormat == SEO_DIRECTORY)
            {
                /*
                 * Since we do a permanent redirect, some browsers cache the redirect URL and so the
                 * default action is called first and then we come here.
                 */
                if (request.getParameter("seo") != null)
                {
                    if (selectedCat == null || selectedCat.getId() != catIdInt)
                    {
                        int prodsFound = kkAppEng.getCategoryMgr().setCurrentCatAndUpdateProducts1(
                                catIdInt);

                        CategoryIf cat = kkAppEng.getCategoryMgr().getCurrentCat();

                        // Go to home page if the category couldn't be found
                        if ((cat != null && cat.getId() < 0) || (cat == null))
                        {
                            return mapping.findForward("Welcome");
                        }
                        return preparePage(mapping, request, kkAppEng, cat, manuIdInt, prodsFound);
                    }
                    /*
                     * We must be here after the SEO redirect. If this is the case, we get the
                     * number of prods found from a parameter of the request and proceed to prepare
                     * the page
                     */
                    int prodsFound = 0;
                    try
                    {
                        prodsFound = new Integer(request.getParameter("prodsFound")).intValue();
                    } catch (Exception e)
                    {
                    }
                    return preparePage(mapping, request, kkAppEng, selectedCat, manuIdInt,
                            prodsFound);
                }
            } else if (seoFormat == SEO_PARAMETERS)
            {
                if (selectedCat != null
                        && selectedCat.getId() == catIdInt
                        && request.getParameter(getCatMessage(request, "seo.product.category")) != null)
                {
                    /*
                     * Check to see whether we are here after the SEO redirect. If this is the case,
                     * we get the number of prods found from a parameter of the request and proceed
                     * to prepare the page
                     */
                    int prodsFound = 0;
                    try
                    {
                        prodsFound = new Integer(request.getParameter("prodsFound")).intValue();
                    } catch (Exception e)
                    {
                    }
                    return preparePage(mapping, request, kkAppEng, selectedCat, manuIdInt,
                            prodsFound);
                }
            }

            /*
             * We tell the engine to get the selected category, add SEO data to the URL and do a
             * redirect
             */
            int prodsFound = kkAppEng.getCategoryMgr().setCurrentCatAndUpdateProducts1(catIdInt);

            CategoryIf cat = kkAppEng.getCategoryMgr().getCurrentCat();

            // Go to home page if the category couldn't be found

            if ((cat != null && cat.getId() < 0) || (cat == null))
            {
                return mapping.findForward("Welcome");
            }

            StringBuffer url = request.getRequestURL();

            /*
             * If the url we get from the request is set to null (as is sometimes the case when we
             * have been implemented as a portlet), then we mustn't do a redirect.
             */
            if (url == null)
            {
                return preparePage(mapping, request, kkAppEng, cat, manuIdInt, prodsFound);
            }

            if (seoFormat == SEO_DIRECTORY)
            {
                int fromIndex = 0;
                int index = 0;
                while ((index = url.indexOf("/", fromIndex)) > -1)
                {
                    fromIndex = index + 1;
                }

                url = new StringBuffer(url.substring(0, fromIndex));

                if (cat.getName() != null && cat.getName().length() > 0)
                {
                    url.append(kkURLEncode(cat.getName()));
                    url.append("/");
                    CategoryIf parentCat = cat.getParent();
                    while (parentCat != null)
                    {
                        url.insert(fromIndex,
                                kkURLEncode(parentCat.getName())
                                        + "/");
                        parentCat = parentCat.getParent();
                    }
                }
                url.append(SEO_SEL_CAT_CODE + SEO_DELIM);
                url.append(cat.getId());
                url.append(SEO_DELIM);
                url.append(manuIdInt);
                url.append(SEO_DELIM);
                url.append(prodsFound);
                url.append(SEO_TYPE);
            } else if (seoFormat == SEO_PARAMETERS)
            {
                // Add the parameters
                url.append("?catId=");
                url.append(cat.getId());
                if (manuIdInt > -1)
                {
                    url.append("&manuId=");
                    url.append(manuIdInt);
                }
                url.append("&prodsFound=");
                url.append(prodsFound);

                // Add seo friendly info
                if (cat.getName() != null && cat.getName().length() > 0
                        && getCatMessage(request, "seo.product.category").length() > 0)
                {
                    url.append("&");
                    url.append(URLEncoder.encode(getCatMessage(request, "seo.product.category"),
                            "UTF-8"));
                    url.append("=");
                    url.append(URLEncoder.encode(cat.getName(), "UTF-8"));
                }
            } else
            {
                // Don't do a redirect
                return preparePage(mapping, request, kkAppEng, cat, manuIdInt, prodsFound);
            }

            // Do a 301 redirect (permanent) so that search engines index URL
            response.setHeader("Location", url.toString());
            setupResponseForSEORedirect(response);
            return null;
        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

    /**
     * Common code to prepare the data required for the page before the JSP draws it
     * 
     * @param mapping
     * @param request
     * @param kkAppEng
     * @param cat
     * @param prodsFound
     * @return Returns an ActionForward
     * @throws KKException
     * @throws KKAppException
     */
    private ActionForward preparePage(ActionMapping mapping, HttpServletRequest request,
            KKAppEng kkAppEng, CategoryIf cat, int manuId, int prodsFound) throws KKException,
            KKAppException
    {

        // Set page title
        String title = getCatMessage(request, "seo.category.title.template");
        title = title.replace("$category", cat.getName());
        kkAppEng.setPageTitle(title);

        // Set the meta description
        String description = getCatMessage(request, "seo.category.meta.description.template");
        description = description.replace("$category", cat.getName());
        kkAppEng.setMetaDescription(description);

        // Set the meta keywords
        String keywords = getCatMessage(request, "seo.meta.keywords.template");
        keywords = keywords.replace("$category", cat.getName());
        keywords = keywords.replace("$manufacturer", "");
        keywords = keywords.replace("$name", "");
        keywords = keywords.replace("$model", "");

        kkAppEng.setMetaKeywords(keywords);

        // Set bread crumbs
        ArrayList<CategoryIf> catList = new ArrayList<CategoryIf>();
        CategoryIf lcat = cat;
        // Put all category hierarchy in a list
        while (true)
        {
            catList.add(lcat);
            if (lcat.getParent() == null)
            {
                break;
            }
            lcat = lcat.getParent();
        }
        // Get cat hierarchy from list to build the bread crumbs
        String url = "/SelectCat.do?catId=";
        for (int i = catList.size() - 1; i > -1; i--)
        {
            CategoryIf lcat1 = catList.get(i);
            if (i == catList.size() - 1)
            {
                kkAppEng.nav.set(lcat1.getName(), url + lcat1.getId());
            } else
            {
                kkAppEng.nav.add(lcat1.getName(), url + lcat1.getId());
            }
        }

        // Set the CATEGORIES_VIEWED customer tag for this customer
        kkAppEng.getCustomerTagMgr().addToCustomerTag(TAG_CATEGORIES_VIEWED, cat.getId());

        // If it is a top level category with sub categories
        if (prodsFound < 0)
        {
            kkAppEng.getProductMgr().fetchNewProductsArray(cat.getId());
            return mapping.findForward("ShowCategories");
        }

        // Filter products by manufacturer if required - used by suggested search
        if (manuId > -1)
        {
            kkAppEng.getProductMgr().filterCurrentProdsByManufacturer(manuId);
        }

        // If there are products then show products
        return mapping.findForward("ShowProducts");

    }
}
