package com.konakart.oleg.db;

import java.util.ArrayList;

public class AuthorDetailsBean {

	Integer author_id,formcopy_id;
	String author_name;
	String author_fname,author_mname,author_lname;
	String author_workmadeforhire,author_anonym;
	String author_psedonym,author_psedonymname;
	String author_DOB,author_DOD;
 	Integer author_citizencountryid,author_domicile;
 	String author_organizationname;
 	ArrayList author_contribution=null;

	public Integer getAuthor_id() {
		return author_id;
	}
	public void setAuthor_id(Integer author_id) {
		this.author_id = author_id;
	}
	public Integer getFormcopy_id() {
		return formcopy_id;
	}
	public void setFormcopy_id(Integer formcopy_id) {
		this.formcopy_id = formcopy_id;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	public String getAuthor_fname() {
		return author_fname;
	}
	public void setAuthor_fname(String author_fname) {
		this.author_fname = author_fname;
	}
	public String getAuthor_mname() {
		return author_mname;
	}
	public void setAuthor_mname(String author_mname) {
		this.author_mname = author_mname;
	}
	public String getAuthor_lname() {
		return author_lname;
	}
	public void setAuthor_lname(String author_lname) {
		this.author_lname = author_lname;
	}
	public String getAuthor_workmadeforhire() {
		return author_workmadeforhire;
	}
	public void setAuthor_workmadeforhire(String author_workmadeforhire) {
		this.author_workmadeforhire = author_workmadeforhire;
	}
	public String getAuthor_anonym() {
		return author_anonym;
	}
	public void setAuthor_anonym(String author_anonym) {
		this.author_anonym = author_anonym;
	}
	public String getAuthor_psedonym() {
		return author_psedonym;
	}
	public void setAuthor_psedonym(String author_psedonym) {
		this.author_psedonym = author_psedonym;
	}
	public String getAuthor_psedonymname() {
		return author_psedonymname;
	}
	public void setAuthor_psedonymname(String author_psedonymname) {
		this.author_psedonymname = author_psedonymname;
	}
	public String getAuthor_DOB() {
		return author_DOB;
	}
	public void setAuthor_DOB(String author_DOB) {
		this.author_DOB = author_DOB;
	}
	public String getAuthor_DOD() {
		return author_DOD;
	}
	public void setAuthor_DOD(String author_DOD) {
		this.author_DOD = author_DOD;
	}
	public Integer getAuthor_citizencountryid() {
		return author_citizencountryid;
	}
	public void setAuthor_citizencountryid(Integer author_citizencountryid) {
		this.author_citizencountryid = author_citizencountryid;
	}
	public Integer getAuthor_domicile() {
		return author_domicile;
	}
	public void setAuthor_domicile(Integer author_domicile) {
		this.author_domicile = author_domicile;
	}
	@Override
	public String toString() {
		return "AuthorDetailsBean [author_id=" + author_id + ", formcopy_id="
				+ formcopy_id + ", author_name=" + author_name
				+ ", author_fname=" + author_fname + ", author_mname="
				+ author_mname + ", author_lname=" + author_lname
				+ ", author_workmadeforhire=" + author_workmadeforhire
				+ ", author_anonym=" + author_anonym + ", author_psedonym="
				+ author_psedonym + ", author_psedonymname="
				+ author_psedonymname + ", author_DOB=" + author_DOB
				+ ", author_DOD=" + author_DOD + ", author_citizencountryid="
				+ author_citizencountryid + ", author_domicile="
				+ author_domicile + "]";
	}
	public String getAuthor_organizationname() {
		return author_organizationname;
	}
	public void setAuthor_organizationname(String author_organizationname) {
		this.author_organizationname = author_organizationname;
	}
	public ArrayList getAuthor_contribution() {
		return author_contribution;
	}
	public void setAuthor_contribution(ArrayList author_contribution) {
		this.author_contribution = author_contribution;
	}
 	


}
