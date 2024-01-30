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
package com.konakart.oleg.forms;

import com.konakart.forms.BaseForm;

/**
 * This is crap doc..
 * This form contains all of the information required in order to add a product to the cart. The
 * optionId and valueId arrays contain the values for certain options which may be applicable for
 * the selected product. valueId[0] contains the selected valueId for the optionId[0] and so on.
 */
@SuppressWarnings("serial")
public class TypeOfWorkForm extends BaseForm
{

    private int typeworkid;
    private String typeworkname;
    private String typeworkaliasname;
    String previousregno;
    String previousregdate;
    
	public int getTypeworkid() {
		return typeworkid;
	}
	public void setTypeworkid(int typeworkid) {
		this.typeworkid = typeworkid;
	}
	public String getTypeworkname() {
		return typeworkname;
	}
	public void setTypeworkname(String typeworkname) {
		this.typeworkname = typeworkname;
	}
	public String getTypeworkaliasname() {
		return typeworkaliasname;
	}
	public void setTypeworkaliasname(String typeworkaliasname) {
		this.typeworkaliasname = typeworkaliasname;
	}
	@Override
	public String toString() {
		return "TypeOfWorkForm [typeworkid=" + typeworkid + ", typeworkname="
				+ typeworkname + ", typeworkaliasname=" + typeworkaliasname
				+ "]";
	}
	public String getPreviousregno() {
		return previousregno;
	}
	public void setPreviousregno(String previousregno) {
		this.previousregno = previousregno;
	}
	public String getPreviousregdate() {
		return previousregdate;
	}
	public void setPreviousregdate(String previousregdate) {
		this.previousregdate = previousregdate;
	}
    
	

}
