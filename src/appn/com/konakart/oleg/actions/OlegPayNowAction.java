package com.konakart.oleg.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.oleg.OlegTasks;

public class OlegPayNowAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards

    
    public OlegPayNowAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
      
    	System.out.println("OlegPayNowAction.execute()");
    	try {
			KKAppEng kkAppEng = this.getKKAppEng(request, response);
			kkAppEng.getBasketMgr().emptyBasket();
			OlegTasks.addCopyRightToCart(kkAppEng, request);
			
			boolean doSaveAllToDB = OlegTasks.doSaveAllToDB(request);
			System.out.println("Done Update to DB Successfully ="+doSaveAllToDB);
			
		} catch (Exception e) {
			System.err.println("Sorry error here "+e.getMessage());
			e.printStackTrace();
		}
    	
    	return mapping.findForward("success");
    }

}