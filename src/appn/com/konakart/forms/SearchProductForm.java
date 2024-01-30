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

/**
 * 
 * This form allows you to search for products using various constraints.
 * 
 */
@SuppressWarnings("serial")
public class SearchProductForm extends BaseForm
{

    private String priceFrom;

    private String priceTo;

    private String dateAddedFrom;

    private String dateAddedTo;

    private int manufacturerId = -1;

    private int categoryId = -1;

    private boolean searchInDescription = false;

    private String searchText;

    private String custom1;

    private String custom2;

    private String custom3;

    private String custom4;

    private String custom5;

    /**
     * @return Returns the categoryId.
     */
    public int getCategoryId()
    {
        return categoryId;
    }

    /**
     * @param categoryId
     *            The categoryId to set.
     */
    public void setCategoryId(int categoryId)
    {
        this.categoryId = categoryId;
    }

    /**
     * @return Returns the manufacturerId.
     */
    public int getManufacturerId()
    {
        return manufacturerId;
    }

    /**
     * @param manufacturerId
     *            The manufacturerId to set.
     */
    public void setManufacturerId(int manufacturerId)
    {
        this.manufacturerId = manufacturerId;
    }

    /**
     * @return Returns the searchText.
     */
    public String getSearchText()
    {
        return searchText;
    }

    /**
     * @param searchText
     *            The searchText to set.
     */
    public void setSearchText(String searchText)
    {
        this.searchText = searchText;
    }

    /**
     * @return Returns the searchInDescription.
     */
    public boolean isSearchInDescription()
    {
        return searchInDescription;
    }

    /**
     * @param searchInDescription
     *            The searchInDescription to set.
     */
    public void setSearchInDescription(boolean searchInDescription)
    {
        this.searchInDescription = searchInDescription;
    }

    /**
     * @return Returns the dateAddedFrom.
     */
    public String getDateAddedFrom()
    {
        return dateAddedFrom;
    }

    /**
     * @param dateAddedFrom
     *            The dateAddedFrom to set.
     */
    public void setDateAddedFrom(String dateAddedFrom)
    {
        this.dateAddedFrom = dateAddedFrom;
    }

    /**
     * @return Returns the dateAddedTo.
     */
    public String getDateAddedTo()
    {
        return dateAddedTo;
    }

    /**
     * @param dateAddedTo
     *            The dateAddedTo to set.
     */
    public void setDateAddedTo(String dateAddedTo)
    {
        this.dateAddedTo = dateAddedTo;
    }

    /**
     * @return Returns the priceFrom.
     */
    public String getPriceFrom()
    {
        return priceFrom;
    }

    /**
     * @param priceFrom
     *            The priceFrom to set.
     */
    public void setPriceFrom(String priceFrom)
    {
        this.priceFrom = priceFrom;
    }

    /**
     * @return Returns the priceTo.
     */
    public String getPriceTo()
    {
        return priceTo;
    }

    /**
     * @param priceTo
     *            The priceTo to set.
     */
    public void setPriceTo(String priceTo)
    {
        this.priceTo = priceTo;
    }

    /**
     * @return Returns the custom1.
     */
    public String getCustom1()
    {
        return custom1;
    }

    /**
     * @param custom1 The custom1 to set.
     */
    public void setCustom1(String custom1)
    {
        this.custom1 = custom1;
    }

    /**
     * @return Returns the custom2.
     */
    public String getCustom2()
    {
        return custom2;
    }

    /**
     * @param custom2 The custom2 to set.
     */
    public void setCustom2(String custom2)
    {
        this.custom2 = custom2;
    }

    /**
     * @return Returns the custom3.
     */
    public String getCustom3()
    {
        return custom3;
    }

    /**
     * @param custom3 The custom3 to set.
     */
    public void setCustom3(String custom3)
    {
        this.custom3 = custom3;
    }

    /**
     * @return Returns the custom4.
     */
    public String getCustom4()
    {
        return custom4;
    }

    /**
     * @param custom4 The custom4 to set.
     */
    public void setCustom4(String custom4)
    {
        this.custom4 = custom4;
    }

    /**
     * @return Returns the custom5.
     */
    public String getCustom5()
    {
        return custom5;
    }

    /**
     * @param custom5 The custom5 to set.
     */
    public void setCustom5(String custom5)
    {
        this.custom5 = custom5;
    }
}
