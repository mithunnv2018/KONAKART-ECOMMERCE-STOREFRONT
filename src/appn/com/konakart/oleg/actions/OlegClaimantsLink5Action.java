package com.konakart.oleg.actions;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.forms.NewClaimantsForm;

public class OlegClaimantsLink5Action extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 

    
    public OlegClaimantsLink5Action() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
       
    	try 
    	{
			System.out.println("Start execute "+this.getClass().toString());
			HttpSession session = request.getSession();
			if(session.getAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS)!=null)
			{
				ArrayList<NewClaimantsForm> listofclaimants= (ArrayList<NewClaimantsForm>) session.getAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS);
				HashMap data2=new HashMap();
				data2.put("listofclaimants", listofclaimants);
				OlegTasks.doSaveListOfObjects(session, 5, data2);
				
			}
    		
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return mapping.findForward(FORWARD_success);
    	
    }

}