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

public class OlegLink2 extends com.konakart.actions.BaseAction {
    

	 // Local Forwards
    public static final String FORWARD_success = "success"; 
    

    
    public OlegLink2() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	try {
			HttpSession session = request.getSession();
			if(session.getAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES)!=null)
//			if(session.getAttribute(OlegTasks.LISTOFTITLETYPE)!=null)
			{
				ArrayList<HashMap> listabc = (ArrayList<HashMap>) session.getAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES);
				HashMap data2=new HashMap();
				data2.put("listoftitletype", listabc);
				OlegTasks.doSaveListOfObjects(session, 2, data2);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	
    	return mapping.findForward(FORWARD_success);
    }

}