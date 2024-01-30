package com.konakart.oleg.actions;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.forms.LimitationClaimForm;

public class OlegLimitclaimLink6Action extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 
    
    
    
    public OlegLimitclaimLink6Action() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	try 
    	{
			LimitationClaimForm form2=(LimitationClaimForm) form;
			
			FormFile uploadfile = form2.getUploadfile();
			HttpSession session = request.getSession();
			
			if(uploadfile!=null && !(uploadfile.getFileName().equalsIgnoreCase("")))
			{
				session.setAttribute("FILE_UPLOADED2", uploadfile.getFileName());
				OlegTasks.doSaveUploadedFile2(uploadfile,request);
			}
			
			HashMap data2=new HashMap();
			data2.put("limitationclaim", form2);
			
			OlegTasks.doSaveListOfObjects(session, 6, data2);
		}
    	catch (Exception e) 
    	{
			
		}
    	
    	return mapping.findForward(FORWARD_success);
    }

}