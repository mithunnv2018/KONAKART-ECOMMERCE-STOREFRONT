package com.konakart.oleg.forms;

import java.util.ArrayList;

import com.konakart.app.Country;
import com.konakart.forms.BaseForm;
import com.konakart.oleg.OlegTasks;


public class PublicationForm extends BaseForm {
	String hasbeenpublished;
	
	Integer nationoffirstpub , yearofcompletion;
	String intstandardnumtype,intstandardnumber,preregistrationnumber,dateoffirstpublication;
	ArrayList<Country> listofcountries=new ArrayList<Country>();
	public PublicationForm() {
		nationoffirstpub=222;
		listofcountries= OlegTasks.doRetrieveCountries();
		
	}

	public String getHasbeenpublished() {
		return hasbeenpublished;
	}

	public void setHasbeenpublished(String hasbeenpublished) {
		this.hasbeenpublished = hasbeenpublished;
	}

	public Integer getNationoffirstpub() {
		return nationoffirstpub;
	}

	public void setNationoffirstpub(Integer nationoffirstpub) {
		this.nationoffirstpub = nationoffirstpub;
	}

	public Integer getYearofcompletion() {
		return yearofcompletion;
	}

	public void setYearofcompletion(Integer yearofcompletion) {
		this.yearofcompletion = yearofcompletion;
	}

	public String getDateoffirstpublication() {
		return dateoffirstpublication;
	}

	public void setDateoffirstpublication(String dateoffirstpublication) {
		this.dateoffirstpublication = dateoffirstpublication;
	}

	public String getIntstandardnumtype() {
		return intstandardnumtype;
	}

	public void setIntstandardnumtype(String intstandardnumtype) {
		this.intstandardnumtype = intstandardnumtype;
	}

	public String getIntstandardnumber() {
		return intstandardnumber;
	}

	public void setIntstandardnumber(String intstandardnumber) {
		this.intstandardnumber = intstandardnumber;
	}

	public String getPreregistrationnumber() {
		return preregistrationnumber;
	}

	public void setPreregistrationnumber(String preregistrationnumber) {
		this.preregistrationnumber = preregistrationnumber;
	}

	public ArrayList<Country> getListofcountries() {
		return listofcountries;
	}

	public void setListofcountries(ArrayList<Country> listofcountries) {
		this.listofcountries = listofcountries;
	}

	@Override
	public String toString() {
		return "PublicationForm [hasbeenpublished=" + hasbeenpublished
				+ ", nationoffirstpub=" + nationoffirstpub
				+ ", yearofcompletion=" + yearofcompletion
				+ ", intstandardnumtype=" + intstandardnumtype
				+ ", intstandardnumber=" + intstandardnumber
				+ ", preregistrationnumber=" + preregistrationnumber
				+ ", dateoffirstpublication=" + dateoffirstpublication + "]";
	}
	

}
