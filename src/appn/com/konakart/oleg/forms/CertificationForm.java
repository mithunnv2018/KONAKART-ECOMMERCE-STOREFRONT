package com.konakart.oleg.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

import com.konakart.forms.BaseForm;

public class CertificationForm extends BaseForm {

	String icertify,nameofindividual,trackingnumber;
	String note;
	Integer cert_id;
	public CertificationForm() {
		// TODO Auto-generated constructor stub
	}
	 
	public String getIcertify() {
		return icertify;
	}

	public void setIcertify(String icertify) {
		this.icertify = icertify;
	}

	public String getNameofindividual() {
		return nameofindividual;
	}

	public void setNameofindividual(String nameofindividual) {
		this.nameofindividual = nameofindividual;
	}

	public String getTrackingnumber() {
		return trackingnumber;
	}

	public void setTrackingnumber(String trackingnumber) {
		this.trackingnumber = trackingnumber;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	public String toString() {
		return "CertificationForm [icertify=" + icertify
				+ ", nameofindividual=" + nameofindividual
				+ ", trackingnumber=" + trackingnumber + ", note=" + note
				+ ", cert_id=" + cert_id + "]";
	}

	public Integer getCert_id() {
		return cert_id;
	}

	public void setCert_id(Integer cert_id) {
		this.cert_id = cert_id;
	}
	
	

}
