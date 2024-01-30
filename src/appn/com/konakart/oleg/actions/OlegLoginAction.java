package com.konakart.oleg.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.appif.KKEngIf;
import com.konakart.forms.LoginForm;

public class OlegLoginAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String OLEG_USERID="OLEG_USERID";
    
    public OlegLoginAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("OlegLoginAction.execute()");
    	try {
    		System.out.println("Hi mith request.getAttribute(oleglogin"+request.getAttribute("oleglogin"));
    		HttpSession session = request.getSession();
    		if(request.getParameter("oleglogout")!=null)
    		{
    			oleglogout(request,response,form);
    			return mapping.findForward("loginagain");
    		}
    		if(request.getParameter("oleglogin")!=null)
//    		if(session.getAttribute("oleglogin")!=null)
    		{
				KKAppEng kkAppEng = this.getKKAppEng(request, response);
				KKEngIf eng = kkAppEng.getEng();
				
				this.loggedIn(request, response, kkAppEng, "index.jsp");
				session.setAttribute(OlegLoginAction.OLEG_USERID,null);
				LoginForm user=(LoginForm) form;
				String user2 = user.getUser();
				String password = user.getPassword();
				
				String login = eng.login(user2, password);
				if(login==null)
				{
					request.setAttribute("isLoginError", "Sorry your login credentials not valid");
					return mapping.findForward("error");
				}
				session.setAttribute(OLEG_USERID, login);
				session.setAttribute("oleglogin", null);
    		}
		} catch (Exception e) {
			System.err.println("Sorry errror here "+e.getMessage());
			request.setAttribute("isLoginError", "Sorry your login credentials not valid");
			e.printStackTrace();
			return mapping.findForward("error");
		}
    	
    	return mapping.findForward("success");
    }

	private void oleglogout(HttpServletRequest request, HttpServletResponse response, ActionForm form) {
		System.out.println("OlegLoginAction.oleglogout()");
		try {
			HttpSession session = request.getSession();
			String sessionuserid = (String) session.getAttribute(OLEG_USERID);
			
			if(sessionuserid!=null )
			{
				KKAppEng kkAppEng = this.getKKAppEng(request, response);
				kkAppEng.getEng().logout(sessionuserid);
				session.setAttribute(OLEG_USERID, null);
				System.out.println("Hi mith Logged out right = "+this.loggedIn(request, response, kkAppEng, null));
			}
		} catch (Exception e) {
			System.err.println("Sorrry error here oleglogout "+e.getMessage());
		}	
		
	}

}