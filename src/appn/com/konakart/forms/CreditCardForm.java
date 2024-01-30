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
 * Form used to enter credit card details.
 * 
 */
@SuppressWarnings("serial")
public class CreditCardForm extends BaseForm
{

    /** Credit card number */
    private String number;

    /** Credit card CVV */
    private String cvv;
    
    /** Credit card type */
    private String type;

    /** Credit card expiry month */
    private String expiryMonth;

    /** Credit card expiry year */
    private String expiryYear;

    /** The name of the person on the credit card */
    private String owner;

    /** Postcode used for credit card validation */
    private String postcode;

    /** Street address used for credit card validation */
    private String streetAddress;

    /**
     * @return Returns the cvv.
     */
    public String getCvv()
    {
        return cvv;
    }

    /**
     * @param cvv
     *            The cvv to set.
     */
    public void setCvv(String cvv)
    {
        this.cvv = cvv;
    }

    /**
     * @return Returns the number.
     */
    public String getNumber()
    {
        return number;
    }

    /**
     * @param number
     *            The number to set.
     */
    public void setNumber(String number)
    {
        this.number = number;
    }

    /**
     * @return Returns the owner.
     */
    public String getOwner()
    {
        return owner;
    }

    /**
     * @param owner
     *            The owner to set.
     */
    public void setOwner(String owner)
    {
        this.owner = owner;
    }

    /**
     * @return Returns the postcode.
     */
    public String getPostcode()
    {
        return postcode;
    }

    /**
     * @param postcode
     *            The postcode to set.
     */
    public void setPostcode(String postcode)
    {
        this.postcode = postcode;
    }

    /**
     * @return Returns the streetAddress.
     */
    public String getStreetAddress()
    {
        return streetAddress;
    }

    /**
     * @param streetAddress
     *            The streetAddress to set.
     */
    public void setStreetAddress(String streetAddress)
    {
        this.streetAddress = streetAddress;
    }

    /**
     * @return Returns the type.
     */
    public String getType()
    {
        return type;
    }

    /**
     * @param type The type to set.
     */
    public void setType(String type)
    {
        this.type = type;
    }

    /**
     * @return Returns the expiryMonth.
     */
    public String getExpiryMonth()
    {
        return expiryMonth;
    }

    /**
     * @param expiryMonth The expiryMonth to set.
     */
    public void setExpiryMonth(String expiryMonth)
    {
        this.expiryMonth = expiryMonth;
    }

    /**
     * @return Returns the expiryYear.
     */
    public String getExpiryYear()
    {
        return expiryYear;
    }

    /**
     * @param expiryYear The expiryYear to set.
     */
    public void setExpiryYear(String expiryYear)
    {
        this.expiryYear = expiryYear;
    }

}
