package com.konakart.oleg.forms;

import java.util.ArrayList;

import com.konakart.app.Country;
import com.konakart.app.Zone;
import com.konakart.forms.BaseForm;
import com.konakart.oleg.OlegTasks;

public class MailCertificateForm extends BaseForm {

	String firstname, middlename, lastname;
	String organizationname;
	String address1, address2, city, state, postalcode;
	Integer mailc_id,countryid;
	ArrayList<Country> listofcountries = new ArrayList<Country>();
	ArrayList<Zone> listofstates = new ArrayList<Zone>();

	public MailCertificateForm() {
		listofcountries = OlegTasks.doRetrieveCountries();
		listofstates = OlegTasks.doRetrieveStateZones();
		countryid=222;

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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
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

	public Integer getCountryid() {
		return countryid;
	}

	public void setCountryid(Integer countryid) {
		this.countryid = countryid;
	}

	public ArrayList<Country> getListofcountries() {
		return listofcountries;
	}

	public void setListofcountries(ArrayList<Country> listofcountries) {
		this.listofcountries = listofcountries;
	}

	public ArrayList<Zone> getListofstates() {
		return listofstates;
	}

	public void setListofstates(ArrayList<Zone> listofstates) {
		this.listofstates = listofstates;
	}

	@Override
	public String toString() {
		return "MailCertificateForm [firstname=" + firstname + ", middlename="
				+ middlename + ", lastname=" + lastname + ", organizationname="
				+ organizationname + ", address1=" + address1 + ", address2="
				+ address2 + ", city=" + city + ", state=" + state
				+ ", postalcode=" + postalcode + ", mailc_id=" + mailc_id
				+ ", countryid=" + countryid + ", listofcountries="
				+ listofcountries + ", listofstates=" + listofstates + "]";
	}

	public Integer getMailc_id() {
		return mailc_id;
	}

	public void setMailc_id(Integer mailc_id) {
		this.mailc_id = mailc_id;
	}

}
