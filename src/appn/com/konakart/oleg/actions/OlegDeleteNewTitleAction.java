package com.konakart.oleg.actions;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OlegDeleteNewTitleAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    public static final String PARAM_DELETE="deleterow";
    // Local Forwards

    
    public OlegDeleteNewTitleAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	System.out.println("OlegDeleteNewTitleAction.execute()");
    	String parameter = request.getParameter(PARAM_DELETE);
    	String sessionvar2 = OlegAddNewTitleAction.SESSION_FOR_ALLTITLES;
    	
    	try {
			if(parameter!=null && parameter.isEmpty()==false)
			{
				int delrow = Integer.parseInt(parameter);
				HttpSession session = request.getSession();
				ArrayList<HashMap> list2 = (ArrayList<HashMap>) session.getAttribute(sessionvar2);
				list2.remove(delrow);
				session.setAttribute(sessionvar2, list2);
				System.out.println("Done updating session which contains ="+list2.toString());
			}
		} catch (Exception e) {
			System.err.println("Sory error here "+e.getMessage());
			e.printStackTrace();
		}
    	
    	
    	return mapping.findForward("success");
    }

}