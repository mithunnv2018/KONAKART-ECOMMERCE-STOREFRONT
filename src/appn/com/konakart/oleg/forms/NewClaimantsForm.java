package com.konakart.oleg.forms;

import java.util.ArrayList;

import com.konakart.app.Country;
import com.konakart.app.Zone;
import com.konakart.forms.BaseForm;
import com.konakart.oleg.OlegTasks;

public class NewClaimantsForm extends BaseForm {

	String firstname,middlename,lastname,organizationname;
	String address1,address2,state,postalcode,city;
	Integer countryid,clamid;
	String transferstatement,othertransferstatement;
	ArrayList<Zone> listofstatezones=new ArrayList<Zone>();
	ArrayList<Country> listofcountries=new ArrayList<Country>();
	
	public NewClaimantsForm() {
		countryid=222;
		listofstatezones= OlegTasks.doRetrieveStateZones();
		listofcountries=OlegTasks.doRetrieveCountries();
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getMiddlename() {
		return middlename;
	}

	public void setMiddlename(String middlename) {
		this.middlename = middlename;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getOrganizationname() {
		return organizationname;
	}

	public void setOrganizationname(String organizationname) {
		this.organizationname = organizationname;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Integer getCountryid() {
		return countryid;
	}

	public void setCountryid(Integer countryid) {
		this.countryid = countryid;
	}

	public String getTransferstatement() {
		return transferstatement;
	}

	public void setTransferstatement(String transferstatement) {
		this.transferstatement = transferstatement;
	}

	public String getOthertransferstatement() {
		return othertransferstatement;
	}

	public void setOthertransferstatement(String othertransferstatement) {
		this.othertransferstatement = othertransferstatement;
	}

	public ArrayList<Zone> getListofstatezones() {
		return listofstatezones;
	}

	public void setListofstatezones(ArrayList<Zone> listofstatezones) {
		this.listofstatezones = listofstatezones;
	}

	public ArrayList<Country> getListofcountries() {
		return listofcountries;
	}

	public void setListofcountries(ArrayList<Country> listofcountries) {
		this.listofcountries = listofcountries;
	}

 
	public Integer getClamid() {
		return clamid;
	}

	public void setClamid(Integer clamid) {
		this.clamid = clamid;
	}

	@Override
	public String toString() {
		return "NewClaimantsForm [firstname=" + firstname + ", middlename="
				+ middlename + ", lastname=" + lastname + ", organizationname="
				+ organizationname + ", address1=" + address1 + ", address2="
				+ address2 + ", state=" + state + ", postalcode=" + postalcode
				+ ", city=" + city + ", countryid=" + countryid + ", clamid="
				+ clamid + ", transferstatement=" + transferstatement
				+ ", othertransferstatement=" + othertransferstatement
				+ ", listofstatezones=" + listofstatezones
				+ ", listofcountries=" + listofcountries + "]";
	}

}
