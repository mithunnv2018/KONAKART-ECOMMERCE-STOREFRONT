package com.konakart.oleg.actions;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.torque.TorqueException;
import org.apache.torque.util.BasePeer;

import com.konakart.al.KKAppEng;
import com.konakart.app.EmailOptions;
import com.konakart.appif.EmailIf;
import com.konakart.appif.EmailOptionsIf;
import com.konakart.oleg.OlegTasks;
import com.workingdogs.village.DataSetException;
import com.workingdogs.village.Record;

public class OlegSendEmailAction extends com.konakart.actions.BaseAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_welcome = "welcome"; 
    public static final String GLOBAL_FORWARD_Exception = "Exception"; 
    public static final String GLOBAL_FORWARD_Unavailable = "Unavailable"; 

    // Local Forwards

    
    public OlegSendEmailAction() {
    }
    
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
//    	this.getDataSource(request).getConnection()
    	System.out.println("OlegSendEmailAction.execute()");
    	try {
			KKAppEng kkAppEng = this.getKKAppEng(request, response);
			String report2="";
			int id = kkAppEng.getCustomerMgr().getCurrentCustomer().getId();
			System.out.println("Before sending email id="+kkAppEng.getCustomerMgr().getCurrentCustomer().getEmailAddr());
			report2+="Before sending email id="+kkAppEng.getCustomerMgr().getCurrentCustomer().getEmailAddr();

//    	String Param_titleofwork="My biography";
//    	String Param_regnumber="100902019";
//    	String Param_filename="DYWM-logo.jpg";
//    	String Param_doctype="Biography";
//    	String Param_regdate="20/03/2012:08:08:27";
//    	String Param_expdate="19/03/2051";
//    	String Param_securitycode="eeadadaeadad23123132322332312deqwew";
//    	String Param_firstauthor="Swerve Administrator , 56 Another Road,London, W1";
//    	
			HashMap params3=new HashMap();
//    	params3.put("Param_titleofwork", Param_titleofwork);
//    	params3.put("Param_regnumber",Param_regnumber);
//    	params3.put("Param_filename",Param_filename);
//    	params3.put("Param_doctype",Param_doctype);
//    	params3.put("Param_regdate",Param_regdate);
//    	params3.put("Param_expdate",Param_expdate);
//    	params3.put("Param_securitycode",Param_securitycode);
//    	params3.put("Param_firstauthor",Param_firstauthor);
			
			params3 = doRetrieveCertificateReportInfo(request);
//    	Connection connection = this.getDataSource(request).getConnection();
			
			String doPDF2 = OlegTasks.doPDF2(request,(String)params3.get("Param_regnumber"), params3);
			
			 
			System.out.println("File location of newley generated PDF is "+doPDF2);
			 
			EmailOptionsIf arg2=new EmailOptions();
			arg2.setCountryCode("en");
			arg2.setFriendlyAttachmentName("Certificate.pdf");
			arg2.setFullAttachmentFilename(doPDF2);
			arg2.setTemplateName("GenericCustEmail");
			
			
			
			
			EmailIf send2 = kkAppEng.getEng().sendTemplateEmailToCustomer1(id, "PFA ", arg2);
			System.out.println("Mith Send to following emaid="+send2.getAddress());
			System.out.println("Mith Send following Message="+send2.getBody());
			report2+="Mith Send to following emaid="+send2.getAddress()+" "+"Mith Send following Message="+send2.getBody();
			
			request.setAttribute("emailinfo2", report2);
		} catch (Exception e) {
			System.err.println("Sorry eror ar email "+e.getMessage());
			e.printStackTrace();
		}
		
    	return mapping.findForward("success");
    }
    
    /*
     * To retrieve certificate report info ffrom db
     */
    private HashMap doRetrieveCertificateReportInfo(HttpServletRequest request)
    {
    	System.out
				.println("OlegSendEmailAction.doRetrieveCertificateReportInfo()");
    	HashMap params3=new HashMap();
    	
    	try {
			HttpSession session = request.getSession();
			Integer formcopyid = (Integer) session.getAttribute(OlegTasks.FORMCOPYID);
			System.out.println("Form Copy ID ="+formcopyid);
			if(formcopyid!=null)
			{
			
				String Param_titleofwork="";
				String Param_regnumber="",Param_filename="";
				String Param_regdate="",Param_expdate="",Param_securitycode="",Param_doctype="",Param_firstauthor="";
				Integer typeworkid=-1;
				String Param_claimantname="";
				String Param_previousregno="";
				String Param_previousregdate="";
				
				String query1="SELECT titledetails_name FROM tbl_titles_details WHERE formcopy_id="+formcopyid;
				System.out.println("query 1 ="+query1);
				List<Record> executeQuery = BasePeer.executeQuery(query1);
				if(executeQuery!=null && executeQuery.size()>0)
				{
					Record record = executeQuery.get(0);
					Param_titleofwork= record.getValue(1).asString();
				}
				String query2="SELECT typework_id, formcopy_regcode ,formcopy_regdate ,formcopy_regenddate ,formcopy_securitycode,formcopy_previousregno,formcopy_previousregdate FROM tbl_formsubmit_copyright WHERE formcopy_id="+formcopyid;
				List<Record> executeQuery2 = BasePeer.executeQuery(query2);
				if(executeQuery2!=null && executeQuery2.size()>0)
				{
					Record record = executeQuery2.get(0);
					typeworkid= record.getValue(1).asIntegerObj();
					Param_regnumber= record.getValue(2).asString();
					Param_regdate=record.getValue(3).asString();
					Param_expdate=record.getValue(4).asString();
					Param_securitycode=record.getValue(5).asString();
					Param_previousregno=record.getValue(6).asString();
					Param_previousregdate=record.getValue(7).asString();
					
					
				}
				String query3="SELECT typework_aliasname FROM tbl_typeofwork WHERE typework_id="+typeworkid;
				List<Record> executeQuery3 = BasePeer.executeQuery(query3);
				if(executeQuery3!=null && executeQuery3.size()>0)
				{
					Record record = executeQuery3.get(0);
					Param_doctype= record.getValue(1).asString();
				}
				
				String query4="SELECT author_name , author_organizationname FROM tbl_authors_details WHERE formcopy_id="+formcopyid;
				List<Record> executeQuery4 = BasePeer.executeQuery(query4);
				if(executeQuery4!=null && executeQuery4.size()>0)
				{
					Record record = executeQuery4.get(0);
					String asString = record.getValue(1).asString();
					String asString2 = record.getValue(2).asString();
					if(!asString.isEmpty() && !asString.contains("null"))
					{
						Param_firstauthor=asString;
					}
					else
					{
						Param_firstauthor=asString2;
					}
					
				}
				
				String query5="SELECT limit_uploadedfilename FROM tbl_limitationclaim WHERE formcopy_id="+formcopyid;
				List<Record> executeQuery5 = BasePeer.executeQuery(query5);
				if(executeQuery5!=null && executeQuery5.size()>0)
				{
					Record record = executeQuery5.get(0);
					Param_filename=record.getValue(1).asString();
					if(Param_filename.trim().isEmpty() || Param_filename.contains("null"))
					{
						Param_filename="--";
					}
				}
				
				String query6="SELECT clam_orgainzation,clam_fname,clam_mname,clam_lname FROM tbl_claimants_details WHERE  formcopy_id="+formcopyid;
				List<Record> executeQuery6 = BasePeer.executeQuery(query6);
				if(executeQuery6!=null && executeQuery6.size()>0)
				{
					Record record = executeQuery6.get(0);
					String tempname = record.getValue(1).asString();
					if(tempname.trim().isEmpty()==false)
					{
						Param_claimantname=tempname;//record.getValue(0).asString();
					}
					else
					{
						Param_claimantname=record.getValue(2).asString()+" "+record.getValue(3).asString()+" "+record.getValue(4).asString();
					}
				}
				
				
				params3.put("Param_titleofwork", Param_titleofwork);//tbl_titles_details	    	
				params3.put("Param_regnumber",Param_regnumber);//tbl_formsubmit_copyright
				 
				params3.put("Param_filename",Param_filename);//tbl_limitationclaim
			
				params3.put("Param_doctype",Param_doctype);//tbl_formsubmit_copyright >> tbl_typeofwork  
				
				params3.put("Param_regdate",Param_regdate);//tbl_formsubmit_copyright
				
				params3.put("Param_expdate",Param_expdate);//tbl_formsubmit_copyright
				
				params3.put("Param_securitycode",Param_securitycode);//tbl_formsubmit_copyright
				
				params3.put("Param_firstauthor",Param_firstauthor);//tbl_authors_details

				params3.put("Param_claimantname",Param_claimantname);//tbl_authors_details

				params3.put("Param_previousregno",Param_previousregno);//tbl_authors_details
				params3.put("Param_previousregdate",Param_previousregdate);//tbl_authors_details
				
			}
		} catch (Exception e) {
			System.err.println("Sorry Error "+e.getMessage());
			e.printStackTrace();
		}  
    	return params3;
    }

}