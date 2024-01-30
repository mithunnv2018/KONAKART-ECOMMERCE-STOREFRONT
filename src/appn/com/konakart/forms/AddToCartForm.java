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
 * This form contains all of the information required in order to add a product to the cart. The
 * optionId and valueId arrays contain the values for certain options which may be applicable for
 * the selected product. valueId[0] contains the selected valueId for the optionId[0] and so on.
 */
@SuppressWarnings("serial")
public class AddToCartForm extends BaseForm
{

    private int[] optionId = new int[20];

    private int[] valueId = new int[20];
    
    private int[] type = new int[20];

    private int[] quantity = new int[20];

    private String productId;

    private int numOptions = 0;

    private String addToWishList = "";

    private String wishListId = "-1";

    /**
     * @param index
     * @return Returns the optionId.
     */
    public int getOptionId(int index)
    {
        return optionId[index];
    }

    /**
     * @param index
     * @param value
     */
    public void setOptionId(int index, int value)
    {
        this.optionId[index] = value;
    }

    /**
     * @param index
     * @return Returns the valueId.
     */
    public int getValueId(int index)
    {
        return valueId[index];
    }

    /**
     * @param index
     * @param value
     */
    public void setValueId(int index, int value)
    {
        this.valueId[index] = value;
    }
    
    /**
     * @param index
     * @return Returns the type.
     */
    public int getType(int index)
    {
        return type[index];
    }

    /**
     * @param index
     * @param value
     */
    public void setType(int index, int value)
    {
        this.type[index] = value;
    }

    /**
     * @param index
     * @return Returns the quantity.
     */
    public int getQuantity(int index)
    {       
        return quantity[index];
    }

    /**
     * @param index
     * @param quantity
     */
    public void setQuantity(int index, int quantity)
    {
        this.quantity[index] = quantity;
    }

    /**
     * @return Returns the productId.
     */
    public String getProductId()
    {
        return productId;
    }

    /**
     * @param productId
     *            The productId to set.
     */
    public void setProductId(String productId)
    {
        this.productId = productId;
    }

    /**
     * @return Returns the numOptions.
     */
    public int getNumOptions()
    {
        return numOptions;
    }

    /**
     * @param numOptions
     *            The numOptions to set.
     */
    public void setNumOptions(int numOptions)
    {
        this.numOptions = numOptions;
    }

    /**
     * If set to "true" we add the product to the wish list rather than to the cart
     * 
     * @return Returns the addToWishList.
     */
    public String getAddToWishList()
    {
        return addToWishList;
    }

    /**
     * If set to "true" we add the product to the wish list rather than to the cart
     * 
     * @param addToWishList
     *            The addToWishList to set.
     */
    public void setAddToWishList(String addToWishList)
    {
        this.addToWishList = addToWishList;
    }

    /**
     * @return the wishListId
     */
    public String getWishListId()
    {
        return wishListId;
    }

    /**
     * @param wishListId
     *            the wishListId to set
     */
    public void setWishListId(String wishListId)
    {
        this.wishListId = wishListId;
    }

}
