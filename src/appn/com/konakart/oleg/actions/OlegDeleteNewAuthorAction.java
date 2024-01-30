package com.konakart.oleg.actions;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.db.AuthorDetailsBean;

public class OlegDeleteNewAuthorAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String PARAM_DELETE="deleterow";
    
    public OlegDeleteNewAuthorAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	System.out.println("OlegDeleteNewAuthorAction.execute()");
    	String parameter = request.getParameter(PARAM_DELETE);
        String sessionForAllauthors = OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS;
        try {
			if(parameter!=null && parameter.isEmpty()==false)
			{
				int delrow = Integer.parseInt(parameter);
				HttpSession session = request.getSession();
//				String otherskey=OlegAddNewAuthorAction.SESSION_FOR_AUTHOR_CONTRIBUTED+(delrow+1);
				
				ArrayList<AuthorDetailsBean> list2 = (ArrayList<AuthorDetailsBean>) session.getAttribute(sessionForAllauthors);
				if(list2!=null && list2.isEmpty()==false)
				{
					list2.remove(delrow);
					
					session.setAttribute(sessionForAllauthors, list2);
//					session.setAttribute(otherskey, null);
					
					System.out.println("Done updating session which contains ="+list2.toString());
				}
				else
				{
					System.out.println("Bad News Session is null "+sessionForAllauthors);
				}
			}

			
		} catch (Exception e) {
			System.err.println("Sory error here "+e.getMessage());
			e.printStackTrace();
		}
    	
    	return mapping.findForward("success");
    }

}