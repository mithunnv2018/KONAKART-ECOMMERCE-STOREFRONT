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
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

import com.konakart.al.NotifiedProductItem;

/**
 * 
 * This form contains all of the information required in order to edit a list of notified products.
 */

@SuppressWarnings("serial")
public class EditNotifiedProductForm extends BaseForm
{
    private ArrayList<NotifiedProductItem> itemList;

    private boolean globalNotificationBool;

    /**
     * Constructor
     */
    public EditNotifiedProductForm()
    {

    }

    public void reset(ActionMapping mapping, HttpServletRequest request)
    {
        if (itemList != null)
        {
            for (Iterator<NotifiedProductItem> iter = itemList.iterator(); iter.hasNext();)
            {
                NotifiedProductItem npi = iter.next();
                npi.setRemove(false);
            }
        }
        globalNotificationBool = false;
    }

    /**
     * @return List of items
     */
    public ArrayList<NotifiedProductItem> getItemList()
    {
        return itemList;
    }

    /**
     * @param itemList
     */
    public void setItemList(ArrayList<NotifiedProductItem> itemList)
    {
        this.itemList = itemList;
    }

    /**
     * @return Returns the globalNotificationBool.
     */
    public boolean isGlobalNotificationBool()
    {
        return globalNotificationBool;
    }

    /**
     * @param globalNotificationBool
     *            The globalNotificationBool to set.
     */
    public void setGlobalNotificationBool(boolean globalNotificationBool)
    {
        this.globalNotificationBool = globalNotificationBool;
    }

}
