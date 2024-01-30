package com.konakart.oleg.actions;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.forms.NewClaimantsForm;

public class OlegDeleteNewClaimantsAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable";
	public static final  String PARAM_DELETE="deleterow"; 

    // Local Forwards

    
    public OlegDeleteNewClaimantsAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	System.out.println("OlegDeleteNewClaimantsAction.execute()");
    	
    	String parameter = request.getParameter(PARAM_DELETE);
        try {
			if(parameter!=null && parameter.isEmpty()==false)
			{
				int delrow=Integer.parseInt(parameter);
				HttpSession session = request.getSession();
				
				ArrayList<NewClaimantsForm> list2=(ArrayList<NewClaimantsForm>) session.getAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS);
				if(list2!=null && list2.isEmpty()==false)
				{
					list2.remove(delrow);
					session.setAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS, list2);
					
					System.out.println("Done updating session claimants ="+list2.toString());
				}
				else
				{
					System.out.println("Bad News Session in claimants is null ");
				}
			}
		} catch (Exception e) {
			System.err.println("Sorry Error "+e.getMessage());
		}
    	
    	return mapping.findForward("success");
    }

}