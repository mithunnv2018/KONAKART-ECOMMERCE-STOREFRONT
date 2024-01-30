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
import com.konakart.oleg.forms.NewTitleForm;

public class OlegAddNewTitleAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 
    
    public static final String SESSION_FOR_ALLTITLES="SESSION_FOR_ALLTITLES";

    
    public OlegAddNewTitleAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
         
    	NewTitleForm form2=(NewTitleForm) form;
    	ArrayList<HashMap> listforsession=new ArrayList<HashMap>();
    	
    	String titleofwork = form2.getTitleofwork();
    	Integer titletypeid = form2.getTitletypeid();
    	String titletype= form2.getTitletypeid().toString();;
    	HttpSession session = request.getSession();
    	
    	if(session.getAttribute(SESSION_FOR_ALLTITLES)!=null)
    	{
    		listforsession= (ArrayList<HashMap>) session.getAttribute(SESSION_FOR_ALLTITLES);
    	}
    	
    	if(session.getAttribute(OlegTasks.LISTOFTITLETYPE)!=null)
    	{
    		System.out.println("Session name exists="+OlegTasks.LISTOFTITLETYPE);
    		ArrayList<HashMap> abc2= (ArrayList<HashMap>) session.getAttribute(OlegTasks.LISTOFTITLETYPE);
    		for (HashMap hashMap : abc2) {
				Integer object2 = (Integer) hashMap.get("titletype_id");
				if(object2.compareTo(titletypeid)==0)
				{
					titletype= (String) hashMap.get("titletype_aliasname");
				}
			}
    	}
    	else
    	{
    		System.out.println("Session Not exist");
    	}
    	HashMap abc=new HashMap();
    	abc.put("titleofwork", titleofwork);
    	abc.put("titletype",titletype);
    	abc.put("titletypeid", titletypeid);
    	listforsession.add(abc);
    	
    	session.setAttribute(SESSION_FOR_ALLTITLES, listforsession);
    	
    	return mapping.findForward(FORWARD_success);
    }

}