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
 * This simple form only contains the manufacturerId.
 *  
 */
@SuppressWarnings("serial")
public class FilterByManufacturerForm extends BaseForm {

	private int manufacturerId;

	/**
	 * @return Returns the manufacturerId.
	 */
	public int getManufacturerId() {
		return manufacturerId;
	}

	/**
	 * @param manufacturerId
	 *            The manufacturerId to set.
	 */
	public void setManufacturerId(int manufacturerId) {
		this.manufacturerId = manufacturerId;
	}
}
