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

import java.util.GregorianCalendar;

/**
 * 
 * Form used to register a new customer.
 * 
 */
@SuppressWarnings("serial")
public class RegisterCustomerForm extends BaseForm
{

    private String gender;

    private String firstName;

    private String lastName;

    private GregorianCalendar birthDate;

    private String birthDateString;

    private String emailAddr;

    private String telephoneNumber;
    
    private String telephoneNumber1;

    // Optional - used for address
    private String addrTelephone;

    // Optional - used for address
    private String addrTelephone1;

    // Optional - used for address
    private String addrEmail;

    private String faxNumber;

    private String password;

    private String passwordConfirmation;

    private String newsletter;

    private boolean newsletterBool;

    private boolean setAsPrimaryBool = false;

    private int productNotifications;

    private String company;

    private String streetAddress;
   
    private String streetAddress1;

    private String suburb;

    private String postcode;

    private String city;

    private String state;

    private int countryId=0;

    private String customerCustom1;

    private String customerCustom2;

    private String customerCustom3;

    private String customerCustom4;

    private String customerCustom5;

    private String addressCustom1;

    private String addressCustom2;

    private String addressCustom3;

    private String addressCustom4;

    private String addressCustom5;

    /**
     * @return Returns the birthDate.
     */
    public GregorianCalendar getBirthDate()
    {
        return birthDate;
    }

    /**
     * @param birthDate
     *            The birthDate to set.
     */
    public void setBirthDate(GregorianCalendar birthDate)
    {
        this.birthDate = birthDate;
    }

    /**
     * @return Returns the birthDateString.
     */
    public String getBirthDateString()
    {
        return birthDateString;
    }

    /**
     * @param birthDateString
     *            The birthDateString to set.
     */
    public void setBirthDateString(String birthDateString)
    {
        this.birthDateString = birthDateString;
    }

    /**
     * @return Returns the city.
     */
    public String getCity()
    {
        return city;
    }

    /**
     * @param city
     *            The city to set.
     */
    public void setCity(String city)
    {
        this.city = city;
    }

    /**
     * @return Returns the company.
     */
    public String getCompany()
    {
        return company;
    }

    /**
     * @param company
     *            The company to set.
     */
    public void setCompany(String company)
    {
        this.company = company;
    }

    /**
     * @return Returns the countryId.
     */
    public int getCountryId()
    {
        return countryId;
    }

    /**
     * @param countryId
     *            The countryId to set.
     */
    public void setCountryId(int countryId)
    {
        this.countryId = countryId;
    }

    /**
     * @return Returns the emailAddr.
     */
    public String getEmailAddr()
    {
        return emailAddr;
    }

    /**
     * @param emailAddr
     *            The emailAddr to set.
     */
    public void setEmailAddr(String emailAddr)
    {
        this.emailAddr = emailAddr;
    }

    /**
     * @return Returns the faxNumber.
     */
    public String getFaxNumber()
    {
        return faxNumber;
    }

    /**
     * @param faxNumber
     *            The faxNumber to set.
     */
    public void setFaxNumber(String faxNumber)
    {
        this.faxNumber = faxNumber;
    }

    /**
     * @return Returns the firstName.
     */
    public String getFirstName()
    {
        return firstName;
    }

    /**
     * @param firstName
     *            The firstName to set.
     */
    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }

    /**
     * @return Returns the gender.
     */
    public String getGender()
    {
        return gender;
    }

    /**
     * @param gender
     *            The gender to set.
     */
    public void setGender(String gender)
    {
        this.gender = gender;
    }

    /**
     * @return Returns the lastName.
     */
    public String getLastName()
    {
        return lastName;
    }

    /**
     * @param lastName
     *            The lastName to set.
     */
    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }

    /**
     * @return Returns the newsletter.
     */
    public String getNewsletter()
    {
        return newsletter;
    }

    /**
     * @param newsletter
     *            The newsletter to set.
     */
    public void setNewsletter(String newsletter)
    {
        this.newsletter = newsletter;
    }

    /**
     * @return Returns the password.
     */
    public String getPassword()
    {
        return password;
    }

    /**
     * @param password
     *            The password to set.
     */
    public void setPassword(String password)
    {
        this.password = password;
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
     * @return Returns the productNotifications.
     */
    public int getProductNotifications()
    {
        return productNotifications;
    }

    /**
     * @param productNotifications
     *            The productNotifications to set.
     */
    public void setProductNotifications(int productNotifications)
    {
        this.productNotifications = productNotifications;
    }

    /**
     * @return Returns the state.
     */
    public String getState()
    {
        return state;
    }

    /**
     * @param state
     *            The state to set.
     */
    public void setState(String state)
    {
        this.state = state;
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
     * @return Returns the suburb.
     */
    public String getSuburb()
    {
        return suburb;
    }

    /**
     * @param suburb
     *            The suburb to set.
     */
    public void setSuburb(String suburb)
    {
        this.suburb = suburb;
    }

    /**
     * @return Returns the telephoneNumber.
     */
    public String getTelephoneNumber()
    {
        return telephoneNumber;
    }

    /**
     * @param telephoneNumber
     *            The telephoneNumber to set.
     */
    public void setTelephoneNumber(String telephoneNumber)
    {
        this.telephoneNumber = telephoneNumber;
    }

    /**
     * @return Returns the passwordConfirmation.
     */
    public String getPasswordConfirmation()
    {
        return passwordConfirmation;
    }

    /**
     * @param passwordConfirmation
     *            The passwordConfirmation to set.
     */
    public void setPasswordConfirmation(String passwordConfirmation)
    {
        this.passwordConfirmation = passwordConfirmation;
    }

    /**
     * @return Returns the newsletterBool.
     */
    public boolean isNewsletterBool()
    {
        return newsletterBool;
    }

    /**
     * @param newsletterBool
     *            The newsletterBool to set.
     */
    public void setNewsletterBool(boolean newsletterBool)
    {
        this.newsletterBool = newsletterBool;
    }

    /**
     * @return Returns the setAsPrimaryBool.
     */
    public boolean isSetAsPrimaryBool()
    {
        return setAsPrimaryBool;
    }

    /**
     * @param setAsPrimaryBool
     *            The setAsPrimaryBool to set.
     */
    public void setSetAsPrimaryBool(boolean setAsPrimaryBool)
    {
        this.setAsPrimaryBool = setAsPrimaryBool;
    }

    /**
     * @return Returns the addressCustom1.
     */
    public String getAddressCustom1()
    {
        return addressCustom1;
    }

    /**
     * @param addressCustom1
     *            The addressCustom1 to set.
     */
    public void setAddressCustom1(String addressCustom1)
    {
        this.addressCustom1 = addressCustom1;
    }

    /**
     * @return Returns the addressCustom2.
     */
    public String getAddressCustom2()
    {
        return addressCustom2;
    }

    /**
     * @param addressCustom2
     *            The addressCustom2 to set.
     */
    public void setAddressCustom2(String addressCustom2)
    {
        this.addressCustom2 = addressCustom2;
    }

    /**
     * @return Returns the addressCustom3.
     */
    public String getAddressCustom3()
    {
        return addressCustom3;
    }

    /**
     * @param addressCustom3
     *            The addressCustom3 to set.
     */
    public void setAddressCustom3(String addressCustom3)
    {
        this.addressCustom3 = addressCustom3;
    }

    /**
     * @return Returns the addressCustom4.
     */
    public String getAddressCustom4()
    {
        return addressCustom4;
    }

    /**
     * @param addressCustom4
     *            The addressCustom4 to set.
     */
    public void setAddressCustom4(String addressCustom4)
    {
        this.addressCustom4 = addressCustom4;
    }

    /**
     * @return Returns the addressCustom5.
     */
    public String getAddressCustom5()
    {
        return addressCustom5;
    }

    /**
     * @param addressCustom5
     *            The addressCustom5 to set.
     */
    public void setAddressCustom5(String addressCustom5)
    {
        this.addressCustom5 = addressCustom5;
    }

    /**
     * @return Returns the customerCustom1.
     */
    public String getCustomerCustom1()
    {
        return customerCustom1;
    }

    /**
     * @param customerCustom1
     *            The customerCustom1 to set.
     */
    public void setCustomerCustom1(String customerCustom1)
    {
        this.customerCustom1 = customerCustom1;
    }

    /**
     * @return Returns the customerCustom2.
     */
    public String getCustomerCustom2()
    {
        return customerCustom2;
    }

    /**
     * @param customerCustom2
     *            The customerCustom2 to set.
     */
    public void setCustomerCustom2(String customerCustom2)
    {
        this.customerCustom2 = customerCustom2;
    }

    /**
     * @return Returns the customerCustom3.
     */
    public String getCustomerCustom3()
    {
        return customerCustom3;
    }

    /**
     * @param customerCustom3
     *            The customerCustom3 to set.
     */
    public void setCustomerCustom3(String customerCustom3)
    {
        this.customerCustom3 = customerCustom3;
    }

    /**
     * @return Returns the customerCustom4.
     */
    public String getCustomerCustom4()
    {
        return customerCustom4;
    }

    /**
     * @param customerCustom4
     *            The customerCustom4 to set.
     */
    public void setCustomerCustom4(String customerCustom4)
    {
        this.customerCustom4 = customerCustom4;
    }

    /**
     * @return Returns the customerCustom5.
     */
    public String getCustomerCustom5()
    {
        return customerCustom5;
    }

    /**
     * @param customerCustom5
     *            The customerCustom5 to set.
     */
    public void setCustomerCustom5(String customerCustom5)
    {
        this.customerCustom5 = customerCustom5;
    }

    /**
     * @return the addrTelephone
     */
    public String getAddrTelephone()
    {
        return addrTelephone;
    }

    /**
     * @param addrTelephone the addrTelephone to set
     */
    public void setAddrTelephone(String addrTelephone)
    {
        this.addrTelephone = addrTelephone;
    }

    /**
     * @return the addrTelephone1
     */
    public String getAddrTelephone1()
    {
        return addrTelephone1;
    }

    /**
     * @param addrTelephone1 the addrTelephone1 to set
     */
    public void setAddrTelephone1(String addrTelephone1)
    {
        this.addrTelephone1 = addrTelephone1;
    }

    /**
     * @return the telephoneNumber1
     */
    public String getTelephoneNumber1()
    {
        return telephoneNumber1;
    }

    /**
     * @param telephoneNumber1 the telephoneNumber1 to set
     */
    public void setTelephoneNumber1(String telephoneNumber1)
    {
        this.telephoneNumber1 = telephoneNumber1;
    }

    /**
     * @return the addrEmail
     */
    public String getAddrEmail()
    {
        return addrEmail;
    }

    /**
     * @param addrEmail the addrEmail to set
     */
    public void setAddrEmail(String addrEmail)
    {
        this.addrEmail = addrEmail;
    }

    /**
     * @return the streetAddress1
     */
    public String getStreetAddress1()
    {
        return streetAddress1;
    }

    /**
     * @param streetAddress1 the streetAddress1 to set
     */
    public void setStreetAddress1(String streetAddress1)
    {
        this.streetAddress1 = streetAddress1;
    }

}
