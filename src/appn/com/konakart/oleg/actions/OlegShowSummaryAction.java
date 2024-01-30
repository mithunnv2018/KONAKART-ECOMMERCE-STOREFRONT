package com.konakart.oleg.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OlegShowSummaryAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards

    
    public OlegShowSummaryAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
       
    	String parameter = request.getParameter("formcopyid");
    	if(parameter!=null && parameter.length()>0)
    	{
    		int formcopyid = Integer.parseInt(parameter);
    		
    		
    	}
    	
    	
    	return mapping.findForward("success");
    }

}