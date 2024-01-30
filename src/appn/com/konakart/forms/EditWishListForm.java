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

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

import com.konakart.al.WishListUIItem;

/**
 * 
 * This form contains all of the information required in order to edit a list of wish list items.
 * The item may be removed or the priority of the item may be changed.
 */
@SuppressWarnings("serial")
public class EditWishListForm extends BaseForm
{
    private static final String pName = "itemList[";

    private ArrayList<WishListUIItem> itemList = new ArrayList<WishListUIItem>();

    private BigDecimal finalPriceIncTax;

    private BigDecimal finalPriceExTax;
    
    private int id;
    
    private String listName;

    /**
     * Constructor
     */
    public EditWishListForm()
    {

    }

    /**
     * Method reset Dynamically creates the appropriate itemList based on the request. When the user
     * deletes something from the wish list and then clicks the back button, he sees the items in
     * the wish list again but the list in the form isn't long enough so if he clicks update again,
     * we get a Struts array index out of bounds error when the bean copier tries to index a list
     * element that doesn't exist. From the request parameters we figure out the largest index and
     * add items to the array if they are needed.
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
            itemList.add(new WishListUIItem());
        }
    }

    /**
     * @return Returns the itemList.
     */
    public ArrayList<WishListUIItem> getItemList()
    {
        return itemList;
    }

    /**
     * @param itemList
     *            The itemList to set.
     */
    public void setItemList(ArrayList<WishListUIItem> itemList)
    {
        this.itemList = itemList;
    }

    /**
     * @return the finalPriceIncTax
     */
    public BigDecimal getFinalPriceIncTax()
    {
        return finalPriceIncTax;
    }

    /**
     * @param finalPriceIncTax
     *            the finalPriceIncTax to set
     */
    public void setFinalPriceIncTax(BigDecimal finalPriceIncTax)
    {
        this.finalPriceIncTax = finalPriceIncTax;
    }

    /**
     * @return the finalPriceExTax
     */
    public BigDecimal getFinalPriceExTax()
    {
        return finalPriceExTax;
    }

    /**
     * @param finalPriceExTax
     *            the finalPriceExTax to set
     */
    public void setFinalPriceExTax(BigDecimal finalPriceExTax)
    {
        this.finalPriceExTax = finalPriceExTax;
    }

    /**
     * @return the listName
     */
    public String getListName()
    {
        return listName;
    }

    /**
     * @param listName the listName to set
     */
    public void setListName(String listName)
    {
        this.listName = listName;
    }

    /**
     * @return the id
     */
    public int getId()
    {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id)
    {
        this.id = id;
    }
}
