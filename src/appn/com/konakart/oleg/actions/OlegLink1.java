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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.actions.BaseAction;
import com.konakart.al.KKAppEng;
import com.konakart.app.Basket;
import com.konakart.appif.BasketIf;
import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.forms.TypeOfWorkForm;

/**
 * Gets called before displaying the About Us page
 */
public class OlegLink1 extends BaseAction
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
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    {
        
        try
        {
//        	KKAppEng kkAppEng = this.getKKAppEng(request, response);
//
//        	BasketIf b = new Basket();
//            b.setQuantity(1);
//            b.setProductId(selectedProd.getId());
//.
//        	kkAppEng.getBasketMgr().addToBasket(b, true);

        	System.out.println("reached link1 actions");
        	 
        	TypeOfWorkForm form2=(TypeOfWorkForm) form;
        	
        	//log.info("The Type of work Selected is alias= "+form2.getTypeworkaliasname() );
        	
        	HttpSession session = request.getSession();
        	ArrayList<HashMap> listoftypeofwork=(ArrayList<HashMap>)session.getAttribute("listoftypeofwork");
        	HashMap hashMap = listoftypeofwork.get(0);
        	Integer typeworkid = (Integer) hashMap.get("typeworkid");
        	System.out.println("The Type of work Selected is = "+hashMap.toString());

        	HashMap  data2=new HashMap();
        	data2.put("typeworkid", typeworkid);//form2.getTypeworkid());
        	data2.put("previousregno", form2.getPreviousregno());
        	data2.put("previousregdate", form2.getPreviousregdate());
        	
        	OlegTasks.doSaveListOfObjects(session,1,data2); 
        	
            return mapping.findForward(SUCCESS);

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }
    }
}
