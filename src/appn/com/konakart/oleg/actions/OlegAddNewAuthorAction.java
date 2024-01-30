package com.konakart.oleg.actions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.db.AuthorDetailsBean;
import com.konakart.oleg.forms.NewAuthorsForm;

public class OlegAddNewAuthorAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards
    public static final String FORWARD_success = "success"; 
    public static final String SESSION_FOR_ALLAUTHORS="SESSION_FOR_ALLAUTHORS";
    public static final String SESSION_FOR_AUTHOR_CONTRIBUTED="SESSION_FOR_AUTHOR_CONTRIBUTED";

    
    public OlegAddNewAuthorAction() {
    }
    /*
     * (non-Javadoc)
     * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     * Using the Key for Session attribute = ALLAUTHORSLIST
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
       
    	try {
    		ArrayList<AuthorDetailsBean> listofallauthors=new ArrayList<AuthorDetailsBean>();
			NewAuthorsForm form2=(NewAuthorsForm) form;
			AuthorDetailsBean bean=new AuthorDetailsBean();
			HttpSession session = request.getSession();
			String authorcreatedother = form2.getAuthorcreatedother();
			ArrayList selectedauthorcontribution = retrieveCorrectIds(session,form2.getSelectedauthorcontribution(),authorcreatedother);
			//TODO HERE SET THE OTHERS
			
			bean.setAuthor_fname(form2.getFirstname());
			bean.setAuthor_mname(form2.getMiddlename());
			bean.setAuthor_lname(form2.getLastname());
			if(form2.getOrganizationame()!=null && !form2.getOrganizationame().isEmpty())
			{
				bean.setAuthor_organizationname(form2.getOrganizationame());
			}
			else
			{
				bean.setAuthor_name(bean.getAuthor_fname()+" "+bean.getAuthor_mname()+" "+bean.getAuthor_lname());
			}
			bean.setAuthor_workmadeforhire(form2.getIsauthorscontribution());
			bean.setAuthor_anonym(form2.getIsanonymous());
			bean.setAuthor_psedonym(form2.getIspseudonymous());
			bean.setAuthor_citizencountryid( form2.getCitizenship());
			bean.setAuthor_domicile(form2.getDomicile());
			bean.setAuthor_psedonymname(form2.getPseudonym());
			bean.setAuthor_DOB(form2.getYearofbirth());
			bean.setAuthor_DOD(form2.getYearofdeath());
			bean.setAuthor_contribution(selectedauthorcontribution);
			
			if(session.getAttribute(SESSION_FOR_ALLAUTHORS)!=null)
			{
				listofallauthors=(ArrayList<AuthorDetailsBean>) session.getAttribute(SESSION_FOR_ALLAUTHORS);
			}
			
			listofallauthors.add(bean);
			session.setAttribute(SESSION_FOR_ALLAUTHORS, listofallauthors);
//			String index=SESSION_FOR_AUTHOR_CONTRIBUTED+listofallauthors.size();
//			session.setAttribute(index,selectedauthorcontribution);
			
			
		} catch (Exception e) {
			System.err.println("Sorry error here "+e.getMessage());
			e.printStackTrace();
		}
    	
     	
    	
    	return mapping.findForward(FORWARD_success);
    }
    /*
     * To retrieve "authorcon_id" from given "authorcon_aliasname" 
     */
    private ArrayList  retrieveCorrectIds(HttpSession session, String [] a,String others)
    {
    	if(a==null)
    	{
    		return null;
    	}
    	List<String> asList = Arrays.asList(a);
    	ArrayList  returnlist=new ArrayList ();
    	returnlist.add(others);
    	if(session.getAttribute(OlegTasks.LISTOFAUTHORCONTRIBUTION)!=null)
    	{
    		ArrayList<HashMap> authcontributed = (ArrayList<HashMap>)session.getAttribute(OlegTasks.LISTOFAUTHORCONTRIBUTION);
    		for(int i=0;i<authcontributed.size();i++)
    		{
    			HashMap map2 = authcontributed.get(i);
    			String alias = (String) map2.get("authorcon_aliasname");
    			if(asList.contains(alias))
    			{
    				returnlist.add((Integer) map2.get("authorcon_id"));
    			}
    		}
    	}
    	return returnlist;
    }

}