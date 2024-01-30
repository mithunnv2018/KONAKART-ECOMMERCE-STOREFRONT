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
 * Used to enter product review information.
 * 
 */
@SuppressWarnings("serial")
public class WriteReviewForm extends BaseForm
{

    private int rating;

    private String reviewText;

    private String custom1;

    private String custom2;

    private String custom3;

    /**
     * @return Returns the rating.
     */
    public int getRating()
    {
        return rating;
    }

    /**
     * @param rating
     *            The rating to set.
     */
    public void setRating(int rating)
    {
        this.rating = rating;
    }

    /**
     * @return Returns the reviewText.
     */
    public String getReviewText()
    {
        return reviewText;
    }

    /**
     * @param reviewText
     *            The reviewText to set.
     */
    public void setReviewText(String reviewText)
    {
        this.reviewText = reviewText;
    }

    /**
     * @return Returns the custom1.
     */
    public String getCustom1()
    {
        return custom1;
    }

    /**
     * @param custom1
     *            The custom1 to set.
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
     * @param custom2
     *            The custom2 to set.
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
     * @param custom3
     *            The custom3 to set.
     */
    public void setCustom3(String custom3)
    {
        this.custom3 = custom3;
    }

}
