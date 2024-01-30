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
 * This form allows you to search for gift registries using various constraints.
 * 
 */
@SuppressWarnings("serial")
public class SearchGiftRegistryForm extends BaseForm
{

    /** to find wish lists for all customers with this first name */
    private String customerFirstName;

    /** to find wish lists for all customers with this last name */
    private String customerLastName;

    /**
     * to find wish lists for all 2nd customers with this first name. i.e. Wedding list
     */
    private String customer1FirstName;

    /**
     * to find wish lists for all 2nd customers with this last name. i.e. Wedding list
     */
    private String customer1LastName;

    /** to find wish lists for all customers living in this city */
    private String customerCity;

    /** to find wish lists for all customers living in this state */
    private String customerState;

    /** to find wish lists for all customers living in this city or state */
    private String cityOrState;

    /** to find wish lists for events such as wedding lists or birthday lists */
    private String eventDateString;

    /** custom1 */
    private String custom1;

    /** custom2 */
    private String custom2;

    /** custom3 */
    private String custom3;

    /** custom4 */
    private String custom4;

    /** custom5 */
    private String custom5;

    /**
     * @return the cityOrState
     */
    public String getCityOrState()
    {
        return cityOrState;
    }

    /**
     * @param cityOrState
     *            the cityOrState to set
     */
    public void setCityOrState(String cityOrState)
    {
        this.cityOrState = cityOrState;
    }

    /**
     * @return the custom1
     */
    public String getCustom1()
    {
        return custom1;
    }

    /**
     * @param custom1
     *            the custom1 to set
     */
    public void setCustom1(String custom1)
    {
        this.custom1 = custom1;
    }

    /**
     * @return the custom2
     */
    public String getCustom2()
    {
        return custom2;
    }

    /**
     * @param custom2
     *            the custom2 to set
     */
    public void setCustom2(String custom2)
    {
        this.custom2 = custom2;
    }

    /**
     * @return the custom3
     */
    public String getCustom3()
    {
        return custom3;
    }

    /**
     * @param custom3
     *            the custom3 to set
     */
    public void setCustom3(String custom3)
    {
        this.custom3 = custom3;
    }

    /**
     * @return the custom4
     */
    public String getCustom4()
    {
        return custom4;
    }

    /**
     * @param custom4
     *            the custom4 to set
     */
    public void setCustom4(String custom4)
    {
        this.custom4 = custom4;
    }

    /**
     * @return the custom5
     */
    public String getCustom5()
    {
        return custom5;
    }

    /**
     * @param custom5
     *            the custom5 to set
     */
    public void setCustom5(String custom5)
    {
        this.custom5 = custom5;
    }

    /**
     * @return the customerFirstName
     */
    public String getCustomerFirstName()
    {
        return customerFirstName;
    }

    /**
     * @param customerFirstName the customerFirstName to set
     */
    public void setCustomerFirstName(String customerFirstName)
    {
        this.customerFirstName = customerFirstName;
    }

    /**
     * @return the customerLastName
     */
    public String getCustomerLastName()
    {
        return customerLastName;
    }

    /**
     * @param customerLastName the customerLastName to set
     */
    public void setCustomerLastName(String customerLastName)
    {
        this.customerLastName = customerLastName;
    }

    /**
     * @return the customer1FirstName
     */
    public String getCustomer1FirstName()
    {
        return customer1FirstName;
    }

    /**
     * @param customer1FirstName the customer1FirstName to set
     */
    public void setCustomer1FirstName(String customer1FirstName)
    {
        this.customer1FirstName = customer1FirstName;
    }

    /**
     * @return the customer1LastName
     */
    public String getCustomer1LastName()
    {
        return customer1LastName;
    }

    /**
     * @param customer1LastName the customer1LastName to set
     */
    public void setCustomer1LastName(String customer1LastName)
    {
        this.customer1LastName = customer1LastName;
    }

    /**
     * @return the customerCity
     */
    public String getCustomerCity()
    {
        return customerCity;
    }

    /**
     * @param customerCity the customerCity to set
     */
    public void setCustomerCity(String customerCity)
    {
        this.customerCity = customerCity;
    }

    /**
     * @return the customerState
     */
    public String getCustomerState()
    {
        return customerState;
    }

    /**
     * @param customerState the customerState to set
     */
    public void setCustomerState(String customerState)
    {
        this.customerState = customerState;
    }

    /**
     * @return the eventDateString
     */
    public String getEventDateString()
    {
        return eventDateString;
    }

    /**
     * @param eventDateString the eventDateString to set
     */
    public void setEventDateString(String eventDateString)
    {
        this.eventDateString = eventDateString;
    }

}
