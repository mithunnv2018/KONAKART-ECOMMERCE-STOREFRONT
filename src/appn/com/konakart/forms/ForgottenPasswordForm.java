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
 * Form used to request a new password to be sent.
 *  
 */
@SuppressWarnings("serial")
public class ForgottenPasswordForm extends BaseForm {

    private String emailAddr;

    /**
     * @return Returns the emailAddr.
     */
    public String getEmailAddr()
    {
        return emailAddr;
    }

    /**
     * @param emailAddr The emailAddr to set.
     */
    public void setEmailAddr(String emailAddr)
    {
        this.emailAddr = emailAddr;
    }


}
