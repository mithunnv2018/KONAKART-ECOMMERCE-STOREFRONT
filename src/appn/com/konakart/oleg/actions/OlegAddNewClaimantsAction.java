package com.konakart.oleg.actions;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.forms.NewClaimantsForm;

public class OlegAddNewClaimantsAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 
    public static final String SESSION_FOR_ALLCLAIMANTS="SESSION_FOR_ALLCLAIMANTS";
    

    
    public OlegAddNewClaimantsAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	try 
    	{
			NewClaimantsForm form2=(NewClaimantsForm) form;
			ArrayList<NewClaimantsForm> listofclaimants=new ArrayList<NewClaimantsForm>();
			
			
			HttpSession session = request.getSession();
			if(session.getAttribute(SESSION_FOR_ALLCLAIMANTS)!=null)
			{
				listofclaimants= (ArrayList<NewClaimantsForm>) session.getAttribute(SESSION_FOR_ALLCLAIMANTS);
			}
			
			listofclaimants.add(form2);
			
			session.setAttribute(SESSION_FOR_ALLCLAIMANTS, listofclaimants);
			
		}
    	catch (Exception e)
    	{
			System.err.println("Sorry erroe in execute "+getClass().toString());
			e.printStackTrace();
		}
    	return mapping.findForward(FORWARD_success);
    }

}