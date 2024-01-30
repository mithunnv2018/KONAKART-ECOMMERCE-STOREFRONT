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

package com.konakart.oleg.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.torque.util.BasePeer;

import com.konakart.actions.BaseAction;
import com.konakart.al.KKAppEng;
import com.konakart.oleg.forms.TypeOfWorkForm;
import com.workingdogs.village.Record;

/**
 * Gets called before displaying the About Us page
 */
public class OlegStartRegAction extends BaseAction
{
	private final static String SUCCESS="success"; 
    /**
     * @param mapping
     *            The ActionMapping used to select this instance
     * @param form
     *            The optional ActionForm bean for this request (if any)
     * @param request
     *            The HTTP request we are processing
     * @param response
     *            The HTTP response we are creating
     * 
     */
	/*
	 * DEPRECATED METHOD
	 */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
        	//DEPRECATED METHOD 
        	System.out.println("Start Reg Action");
        	
/*        	List<Record> executeQuery = BasePeer.executeQuery("SELECT * FROM tbl_typeofwork");
        	ArrayList<HashMap> listoftypeofwork=new ArrayList<HashMap>();
        	
        	if(executeQuery!=null)
        	{
        		for (Iterator<Record> iterator = executeQuery.iterator();
        		iterator.hasNext();)
        		{
        			Record next = iterator.next();
        			HashMap a=new HashMap();
        			a.put("typeworkid",next.getValue(1).asInt());
        			a.put("typeworkaliasname",next.getValue(3).asString());
        			
        			listoftypeofwork.add(a);
        		}
        	}
        	System.out.println("Size of typeofwork="+listoftypeofwork.size());
        	HttpSession session = request.getSession();
    		session.setAttribute("listoftypeofwork", listoftypeofwork);*/
    		
        	
            return mapping.findForward(SUCCESS);

        } catch (Exception e)
        {
        	System.err.println("Sorry error in execute of "+this.getClass().toString());
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
