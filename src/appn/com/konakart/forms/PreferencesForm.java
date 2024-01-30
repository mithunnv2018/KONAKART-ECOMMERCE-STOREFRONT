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
 * Form used to enter customer preferences
 *  
 */
@SuppressWarnings("serial")
public class PreferencesForm extends BaseForm {

	private int productPageSize;

    private int orderPageSize;
    
    private int reviewPageSize;

    /**
     * @return the productPageSize
     */
    public int getProductPageSize()
    {
        return productPageSize;
    }

    /**
     * @param productPageSize the productPageSize to set
     */
    public void setProductPageSize(int productPageSize)
    {
        this.productPageSize = productPageSize;
    }

    /**
     * @return the orderPageSize
     */
    public int getOrderPageSize()
    {
        return orderPageSize;
    }

    /**
     * @param orderPageSize the orderPageSize to set
     */
    public void setOrderPageSize(int orderPageSize)
    {
        this.orderPageSize = orderPageSize;
    }

    /**
     * @return the reviewPageSize
     */
    public int getReviewPageSize()
    {
        return reviewPageSize;
    }

    /**
     * @param reviewPageSize the reviewPageSize to set
     */
    public void setReviewPageSize(int reviewPageSize)
    {
        this.reviewPageSize = reviewPageSize;
    }	
}
