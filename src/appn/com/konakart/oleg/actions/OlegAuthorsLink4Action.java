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
import com.konakart.oleg.db.AuthorDetailsBean;

public class OlegAuthorsLink4Action extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 
    

    
    public OlegAuthorsLink4Action() {
    }
    /*
     * (non-Javadoc)
     * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     * map key is "listofauthors"
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
         
    	try 
    	{
			System.out.println("Start "+this.getClass().toString());
			HttpSession session = request.getSession();
			
			if(session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS)!=null)
			{
				ArrayList<AuthorDetailsBean> attribute = (ArrayList<AuthorDetailsBean>) session.getAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS);
				HashMap data2=new HashMap();
				data2.put("listofauthors", attribute);
				OlegTasks.doSaveListOfObjects(session, 4, data2);
			}
		} 
    	catch (Exception e) 
    	{
			System.err.println("sorry error "+this.getClass().toString()+" "+e.getMessage());
			e.printStackTrace();
		}
    	return mapping.findForward(FORWARD_success);
    }

}