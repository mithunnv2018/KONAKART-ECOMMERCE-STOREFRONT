package com.konakart.oleg.forms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionMapping;
import org.apache.torque.util.BasePeer;

import com.konakart.forms.BaseForm;
import com.konakart.oleg.db.TitleTypeBean;
import com.workingdogs.village.Record;

public class NewTitleForm extends BaseForm{

	Integer titletypeid;
	String titletype,titleofwork;
	ArrayList<TitleTypeBean> listoftitletype=new ArrayList<TitleTypeBean>();
	
	 
	public NewTitleForm()
	{
		super();
		System.out.println("Start doLoadTitleType in NewTitleForm");
		try 
		{
			List<Record> executeQuery = BasePeer.executeQuery("SELECT * FROM tbl_titletype");
//			ArrayList<HashMap> listoftitletype=new ArrayList<HashMap>();
			
			if(executeQuery!=null)
			{
				for (Iterator<Record> iterator = executeQuery.iterator();
				iterator.hasNext();)
				{
					Record next = iterator.next();
					TitleTypeBean a=new TitleTypeBean();
					a.setTitletype_id(next.getValue(1).asInt());
					a.setTitletype_aliasname(next.getValue(3).asString());
					
					listoftitletype.add(a);
				}
			}
			System.out.println("Size of titletype="+listoftitletype.size());
		 
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("doLoadTitleType()"+e.getMessage());
		}
	}
	public String getTitletype() {
		return titletype;
	}

	public void setTitletype(String titletype) {
		this.titletype = titletype;
	}

	public String getTitleofwork() {
		return titleofwork;
	}

	public void setTitleofwork(String titleofwork) {
		this.titleofwork = titleofwork;
	}
	public ArrayList<TitleTypeBean> getListoftitletype() {
		return listoftitletype;
	}
	public void setListoftitletype(ArrayList<TitleTypeBean> listoftitletype) {
		this.listoftitletype = listoftitletype;
	}
	public Integer getTitletypeid() {
		return titletypeid;
	}
	public void setTitletypeid(Integer titletypeid) {
		this.titletypeid = titletypeid;
	}
	@Override
	public String toString() {
		return "NewTitleForm [titletypeid=" + titletypeid + ", titletype="
				+ titletype + ", titleofwork=" + titleofwork + "]";
	}
	
	
	
}
