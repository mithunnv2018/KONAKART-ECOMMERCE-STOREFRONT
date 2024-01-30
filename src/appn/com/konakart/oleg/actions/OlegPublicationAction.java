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
import com.konakart.oleg.db.FormSubmitCopyrightBean;
import com.konakart.oleg.forms.PublicationForm;

public class OlegPublicationAction extends com.konakart.actions.BaseAction {

	// Global Forwards
	public static final String GLOBAL_FORWARD_welcome = "welcome";
	public static final String GLOBAL_FORWARD_Exception = "Exception";
	public static final String GLOBAL_FORWARD_Unavailable = "Unavailable";

	// Local Forwards
	public static final String FORWARD_success = "success";
	public static final String FORWARD_yes = "yes";
	public static final String FORWARD_no = "no";

	public OlegPublicationAction() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.
	 * ActionMapping, org.apache.struts.action.ActionForm,
	 * javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse) Used keys are "hasbeenpublished".
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		try {
			System.out.println("Starting " + this.getClass().toString());
			PublicationForm form2 = (PublicationForm) form;
			KKAppEng kkAppEng = this.getKKAppEng(request, response);
			int id = kkAppEng.getCustomerMgr().getCurrentCustomer().getId();
			String hasbeenpublished = form2.getHasbeenpublished();
			String doprocess = request.getParameter("doprocess");
			if (doprocess == null) {
				if (hasbeenpublished.equalsIgnoreCase("yes")) {
					return mapping.findForward(FORWARD_yes);
				} else if (hasbeenpublished.equalsIgnoreCase("no")) {
					return mapping.findForward(FORWARD_no);
				}
			}
			FormSubmitCopyrightBean bean=new FormSubmitCopyrightBean();
			bean.setFormcopy_userid(id+"");
			if(hasbeenpublished.equalsIgnoreCase("yes"))
			{
				bean.setFormcopy_dateoffirstpub(form2.getDateoffirstpublication());
				bean.setFormcopy_internumber(form2.getIntstandardnumber());
				bean.setFormcopy_internotype(form2.getIntstandardnumtype());
				bean.setCountries_id(form2.getNationoffirstpub());
				bean.setFormcopy_preregnos(form2.getPreregistrationnumber());
				bean.setFormcopy_yearofcomp(form2.getYearofcompletion().toString());
				bean.setFormcopy_workpublished("Yes"); 
			}
			else
			{
				bean.setFormcopy_dateoffirstpub("");
				bean.setFormcopy_internumber("");
				bean.setFormcopy_internotype("");
				bean.setCountries_id(-1);
				bean.setFormcopy_preregnos(form2.getPreregistrationnumber());
				bean.setFormcopy_yearofcomp(form2.getYearofcompletion().toString());
				bean.setFormcopy_workpublished("No");
			}
			HttpSession session = request.getSession();
			HashMap data2 = new HashMap();
			data2.put("published", bean);
			OlegTasks.doSaveListOfObjects(session, 3, data2);
			System.out.println("Done " + this.getClass().toString());

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Sorry error here " + e.getMessage());
		}
		return mapping.findForward(FORWARD_success);
	}

}