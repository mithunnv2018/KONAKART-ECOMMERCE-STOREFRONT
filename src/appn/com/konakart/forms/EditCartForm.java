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

import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

import com.konakart.al.CartItem;

/**
 * 
 * This form contains all of the information required in order to edit a list of cart items. The
 * item may be removed or the quantity may be changed.
 */
@SuppressWarnings("serial")
public class EditCartForm extends BaseForm
{

    private ArrayList<CartItem> itemList = new ArrayList<CartItem>();

    private String goToCheckout = "";

    private String couponCode;
    
    private String GiftCertCode;
    
    private String rewardPoints;

    private static final String pName = "itemList[";

    /**
     * Constructor
     */
    public EditCartForm()
    {

    }

    /**
     * @return List of items
     */
    public ArrayList<CartItem> getItemList()
    {
        return itemList;
    }

    /**
     * @param itemList
     */
    public void setItemList(ArrayList<CartItem> itemList)
    {
        this.itemList = itemList;
    }

    /**
     * @return Returns the goToCheckout.
     */
    public String getGoToCheckout()
    {
        return goToCheckout;
    }

    /**
     * @param goToCheckout
     *            The goToCheckout to set.
     */
    public void setGoToCheckout(String goToCheckout)
    {
        this.goToCheckout = goToCheckout;
    }

    /**
     * Method reset Dynamically creates the appropriate itemList based on the request. When the user
     * deletes something from the cart and then clicks the back button, he sees the items in the
     * cart again but the list in the form isn't long enough so if he clicks update again, we get a
     * Struts array index out of bounds error when the bean copier tries to index a list element
     * that doesn't exist. From the request parameters we figure out the largest index and add items
     * to the array if they are needed.
     * 
     * @param mapping
     *            The Struts Action mapping
     * @param request
     *            The incoming request
     */
    @SuppressWarnings("unchecked")
    public void reset(ActionMapping mapping, HttpServletRequest request)
    {

        Enumeration paramNames = request.getParameterNames();
        int maxSize = 0;
        while (paramNames.hasMoreElements())
        {
            String paramName = (String) paramNames.nextElement();
            if (paramName != null && paramName.contains(pName))
            {
                int closeBracketIndex = paramName.indexOf("]");
                String indexStr = paramName.substring(pName.length(), closeBracketIndex);
                int index = new Integer(indexStr).intValue();
                if (index > maxSize)
                {
                    maxSize = index;
                }
            }
        }

        while (itemList.size() < maxSize + 1)
        {
            itemList.add(new CartItem());
        }
    }

    /**
     * @return Returns the couponCode.
     */
    public String getCouponCode()
    {
        return couponCode;
    }

    /**
     * @param couponCode
     *            The couponCode to set.
     */
    public void setCouponCode(String couponCode)
    {
        this.couponCode = couponCode;
    }

    /**
     * @return the rewardPoints
     */
    public String getRewardPoints()
    {
        return rewardPoints;
    }

    /**
     * @param rewardPoints the rewardPoints to set
     */
    public void setRewardPoints(String rewardPoints)
    {
        this.rewardPoints = rewardPoints;
    }

    /**
     * @return the giftCertCode
     */
    public String getGiftCertCode()
    {
        return GiftCertCode;
    }

    /**
     * @param giftCertCode the giftCertCode to set
     */
    public void setGiftCertCode(String giftCertCode)
    {
        GiftCertCode = giftCertCode;
    }
}
