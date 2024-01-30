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
package com.konakart.bl.modules.payment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.konakart.app.GeoZone;
import com.konakart.app.KKException;
import com.konakart.app.NameValue;
import com.konakart.appif.NameValueIf;
import com.konakart.appif.PaymentDetailsIf;
import com.konakart.bl.modules.BaseModule;

/**
 * Base class for Payment Modules.
 */
public class BasePaymentModule extends BaseModule
{
    /**
     * The <code>Log</code> instance for this application.
     */
    protected Log log = LogFactory.getLog(BasePaymentModule.class);

    /**
     * Ensures that the zone is within one of the Geo Zones contained in the DeliveryInfo object.
     * 
     * @param info
     * @param zone
     * @throws KKException
     */
    protected void checkZone(PaymentInfo info, int zone) throws KKException
    {
        boolean found = false;
        if (info.getDeliveryGeoZoneArray() != null && info.getDeliveryGeoZoneArray().length > 0)
        {
            for (int i = 0; i < info.getDeliveryGeoZoneArray().length; i++)
            {
                GeoZone gz = info.getDeliveryGeoZoneArray()[i];
                if (gz.getGeoZoneId() == zone)
                {
                    found = true;
                }
            }
        }
        if (!found)
        {
            throw new KKException(
                    "The delivery address of the order is not within the GeoZone, id = " + zone);
        }
    }

    /**
     * Split the name into first name and surname using simple logic... The surname is assumed to be
     * the last whitespace-separated item; everything before that is used as the first name.
     * 
     * @param name
     *            the name as a String to convert.
     * @return a String array where the first element is the first name and the second element is
     *         the surname.
     */
    protected String[] splitNameIntoFirstAndLastNames(String name)
    {
        String[] result = new String[2];

        if (name != null)
        {
            String[] names = name.split(" ");
            int len = names.length;
            if (len >= 2)
            {
                StringBuffer firstName = new StringBuffer();
                for (int i = 0; i < len - 1; i++)
                {
                    if (firstName.length() == 0)
                    {
                        firstName.append(names[i]);
                    } else
                    {
                        firstName.append(" ");
                        firstName.append(names[i]);
                    }
                }
                result[0] = firstName.toString();
                result[1] = names[len - 1];
            }
        }

        return result;
    }

    /**
     * This method is optionally called from the sub class to load up the parameters into a
     * HashTable for efficient subsequent processing
     * 
     * @param pd
     *            PaymentDetails object
     * @param ccParmList
     *            name value pair list of CC parameters
     * @return a hash map containing the parameters for rapid lookup
     */
    protected HashMap<String, String> hashParameters(PaymentDetailsIf pd,
            List<NameValueIf> ccParmList)
    {
        HashMap<String, String> paramHash = new HashMap<String, String>();

        if (pd != null)
        {
            if (pd.getParameters() != null)
            {
                for (int c = 0; c < pd.getParameters().length; c++)
                {
                    paramHash
                            .put(pd.getParameters()[c].getName(), pd.getParameters()[c].getValue());
                }
            }
        }

        if (ccParmList != null)
        {
            for (int c = 0; c < ccParmList.size(); c++)
            {
                paramHash.put(ccParmList.get(c).getName(), ccParmList.get(c).getValue());
            }
        }

        return paramHash;
    }

    /**
     * Add more parameters to the PaymentDetails object. Normally this method would be on the
     * PaymentDetails class but it's placed here instead because of the automatic code generation
     * that occurs on the PaymentDetails class for web services, JSON and RMI etc.
     * 
     * @param pd
     *            the PaymentDetails object
     * @param newParameters
     *            The parameters to set.
     */
    protected void addParameters(PaymentDetailsIf pd, List<NameValueIf> newParameters)
    {
        List<NameValueIf> parmList = new ArrayList<NameValueIf>();

        // Add the new parameters to our temporary list
        if (newParameters != null)
        {
            for (int p = 0; p < newParameters.size(); p++)
            {
                parmList.add(newParameters.get(p));
            }
        }

        // Add the existing parameters to our temporary list
        if (pd.getParameters() != null)
        {
            for (int p = 0; p < pd.getParameters().length; p++)
            {
                parmList.add(pd.getParameters()[p]);
            }
        }

        // Now replace the parameters with a new set
        NameValue[] nvArray = new NameValue[parmList.size()];
        parmList.toArray(nvArray);
        pd.setParameters(nvArray);
    }
}
