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
 * This form contains all of the information required in order to receive information for the
 * checkout process
 */

@SuppressWarnings("serial")
public class CheckoutForm extends BaseForm
{
    private String comment;

    private String shipping;

    private String payment;

    private boolean freeShipping = false;
    
    private String couponCode;
    
    private String GiftCertCode;
    
    private String rewardPoints;

    /**
     * Constructor
     */
    public CheckoutForm()
    {

    }

    /**
     * @return Returns the comment.
     */
    public String getComment()
    {
        return comment;
    }

    /**
     * @param comment
     *            The comment to set.
     */
    public void setComment(String comment)
    {
        this.comment = comment;
    }

    /**
     * @return Returns the shipping.
     */
    public String getShipping()
    {
        return shipping;
    }

    /**
     * @param shipping
     *            The shipping to set.
     */
    public void setShipping(String shipping)
    {
        this.shipping = shipping;
    }

    /**
     * @return Returns the freeShipping.
     */
    public boolean isFreeShipping()
    {
        return freeShipping;
    }

    /**
     * @param freeShipping
     *            The freeShipping to set.
     */
    public void setFreeShipping(boolean freeShipping)
    {
        this.freeShipping = freeShipping;
    }

    /**
     * @return Returns the payment.
     */
    public String getPayment()
    {
        return payment;
    }

    /**
     * @param payment
     *            The payment to set.
     */
    public void setPayment(String payment)
    {
        this.payment = payment;
    }

    /**
     * @return Returns the couponCode.
     */
    public String getCouponCode()
    {
        return couponCode;
    }

    /**
     * @param couponCode The couponCode to set.
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
