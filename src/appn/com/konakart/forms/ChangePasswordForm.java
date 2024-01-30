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
 * Form used to change password.
 *  
 */
@SuppressWarnings("serial")
public class ChangePasswordForm extends BaseForm {

    private String currentPassword;
    private String newPassword;
    private String confirmPassword;
    
    /**
     * @return Returns the confirmPassword.
     */
    public String getConfirmPassword()
    {
        return confirmPassword;
    }
    /**
     * @param confirmPassword The confirmPassword to set.
     */
    public void setConfirmPassword(String confirmPassword)
    {
        this.confirmPassword = confirmPassword;
    }
    /**
     * @return Returns the currentPassword.
     */
    public String getCurrentPassword()
    {
        return currentPassword;
    }
    /**
     * @param currentPassword The currentPassword to set.
     */
    public void setCurrentPassword(String currentPassword)
    {
        this.currentPassword = currentPassword;
    }
    /**
     * @return Returns the newPassword.
     */
    public String getNewPassword()
    {
        return newPassword;
    }
    /**
     * @param newPassword The newPassword to set.
     */
    public void setNewPassword(String newPassword)
    {
        this.newPassword = newPassword;
    }



}
