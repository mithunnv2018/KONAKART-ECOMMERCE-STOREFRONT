package com.konakart.oleg.actions;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.forms.CertificationForm;

public class OlegCertificationLink11Action extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 

    

    
    public OlegCertificationLink11Action() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	try 
    	{
    		KKAppEng kkAppEng = this.getKKAppEng(request, response);
			System.out.println("OlegCertificationLink11Action.execute()");
			CertificationForm form2=(CertificationForm) form;
			
			HttpSession session = request.getSession();
			
			HashMap data2=new HashMap();
			data2.put("certification", form2);
			
			OlegTasks.doSaveListOfObjects(session, 11, data2);
			
//			boolean doSaveAllToDB = OlegTasks.doSaveAllToDB(request);
			boolean doneaddedtocart=OlegTasks.addCopyRightToCart(kkAppEng, request);
			
//			System.out.println("Done Update to DB Successfully ="+doSaveAllToDB);
			System.out.println("Done added to cart= "+doneaddedtocart);
    		
		} catch (Exception e) {
			System.err.println("Sorry error "+e.getMessage());
			e.printStackTrace();
		}
    		return mapping.findForward(FORWARD_success);
    }

}