package com.konakart.oleg.actions;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.forms.MailCertificateForm;

public class OlegMailCertificateLink9Action extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards

    public static final String FORWARD_success = "success"; 

    
    
    public OlegMailCertificateLink9Action() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	try 
    	{
			System.out.println("OlegMailCertificateLink9Action.execute()");
			MailCertificateForm form2=(MailCertificateForm) form;
			
			HttpSession session = request.getSession();
			
			HashMap data2=new HashMap();
			data2.put("mailcertificate", form2);
			OlegTasks.doSaveListOfObjects(session, 9, data2);
		}
    	catch (Exception e) 
    	{
			System.err.println("Sorry error "+e.getMessage());
			e.printStackTrace();
		}
    	return mapping.findForward(FORWARD_success);
    }

}