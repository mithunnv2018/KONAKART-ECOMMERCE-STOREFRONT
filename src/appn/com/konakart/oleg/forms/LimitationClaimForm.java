package com.konakart.oleg.forms;

import org.apache.struts.upload.FormFile;

import com.konakart.forms.BaseForm;

public class LimitationClaimForm extends BaseForm {

	String excluded_text,excluded_2dartwork,excluded_photo;
	String excluded_jewelrydesign,excluded_architectural;
	String excluded_sculpture,excluded_drawing,excluded_map,excluded_other;
	
	 
	String included_text,included_2dartwork,included_photo;
	String included_jewelrydesign,included_architectural;
	String included_sculpture,included_drawing,included_map,included_other;
	
	String firstprevreg,firstyear,secondprevreg,secondyear;
	FormFile uploadfile;
	Integer limit_id;
	String filename;
	public LimitationClaimForm() {
		
	}


	public String getExcluded_text() {
		return excluded_text;
	}


	public void setExcluded_text(String excluded_text) {
		this.excluded_text = excluded_text;
	}


	public String getExcluded_2dartwork() {
		return excluded_2dartwork;
	}


	public void setExcluded_2dartwork(String excluded_2dartwork) {
		this.excluded_2dartwork = excluded_2dartwork;
	}


	public String getExcluded_photo() {
		return excluded_photo;
	}


	public void setExcluded_photo(String excluded_photo) {
		this.excluded_photo = excluded_photo;
	}


	public String getExcluded_jewelrydesign() {
		return excluded_jewelrydesign;
	}


	public void setExcluded_jewelrydesign(String excluded_jewelrydesign) {
		this.excluded_jewelrydesign = excluded_jewelrydesign;
	}


	public String getExcluded_architectural() {
		return excluded_architectural;
	}


	public void setExcluded_architectural(String excluded_architectural) {
		this.excluded_architectural = excluded_architectural;
	}


	public String getExcluded_sculpture() {
		return excluded_sculpture;
	}


	public void setExcluded_sculpture(String excluded_sculpture) {
		this.excluded_sculpture = excluded_sculpture;
	}


	public String getExcluded_drawing() {
		return excluded_drawing;
	}


	public void setExcluded_drawing(String excluded_drawing) {
		this.excluded_drawing = excluded_drawing;
	}


	public String getExcluded_map() {
		return excluded_map;
	}


	public void setExcluded_map(String excluded_map) {
		this.excluded_map = excluded_map;
	}


	public String getExcluded_other() {
		return excluded_other;
	}


	public void setExcluded_other(String excluded_other) {
		this.excluded_other = excluded_other;
	}


	public String getIncluded_text() {
		return included_text;
	}


	public void setIncluded_text(String included_text) {
		this.included_text = included_text;
	}


	public String getIncluded_2dartwork() {
		return included_2dartwork;
	}


	public void setIncluded_2dartwork(String included_2dartwork) {
		this.included_2dartwork = included_2dartwork;
	}


	public String getIncluded_photo() {
		return included_photo;
	}


	public void setIncluded_photo(String included_photo) {
		this.included_photo = included_photo;
	}


	public String getIncluded_jewelrydesign() {
		return included_jewelrydesign;
	}


	public void setIncluded_jewelrydesign(String included_jewelrydesign) {
		this.included_jewelrydesign = included_jewelrydesign;
	}


	public String getIncluded_architectural() {
		return included_architectural;
	}


	public void setIncluded_architectural(String included_architectural) {
		this.included_architectural = included_architectural;
	}


	public String getIncluded_sculpture() {
		return included_sculpture;
	}


	public void setIncluded_sculpture(String included_sculpture) {
		this.included_sculpture = included_sculpture;
	}


	public String getIncluded_drawing() {
		return included_drawing;
	}


	public void setIncluded_drawing(String included_drawing) {
		this.included_drawing = included_drawing;
	}


	public String getIncluded_map() {
		return included_map;
	}


	public void setIncluded_map(String included_map) {
		this.included_map = included_map;
	}


	public String getIncluded_other() {
		return included_other;
	}


	public void setIncluded_other(String included_other) {
		this.included_other = included_other;
	}


	public String getFirstprevreg() {
		return firstprevreg;
	}


	public void setFirstprevreg(String firstprevreg) {
		this.firstprevreg = firstprevreg;
	}


	public String getFirstyear() {
		return firstyear;
	}


	public void setFirstyear(String firstyear) {
		this.firstyear = firstyear;
	}


	public String getSecondprevreg() {
		return secondprevreg;
	}


	public void setSecondprevreg(String secondprevreg) {
		this.secondprevreg = secondprevreg;
	}


	public String getSecondyear() {
		return secondyear;
	}


	public void setSecondyear(String secondyear) {
		this.secondyear = secondyear;
	}


	@Override
	public String toString() {
		return "LimitationClaimForm [excluded_text=" + excluded_text
				+ ", excluded_2dartwork=" + excluded_2dartwork
				+ ", excluded_photo=" + excluded_photo
				+ ", excluded_jewelrydesign=" + excluded_jewelrydesign
				+ ", excluded_architectural=" + excluded_architectural
				+ ", excluded_sculpture=" + excluded_sculpture
				+ ", excluded_drawing=" + excluded_drawing + ", excluded_map="
				+ excluded_map + ", excluded_other=" + excluded_other
				+ ", included_text=" + included_text + ", included_2dartwork="
				+ included_2dartwork + ", included_photo=" + included_photo
				+ ", included_jewelrydesign=" + included_jewelrydesign
				+ ", included_architectural=" + included_architectural
				+ ", included_sculpture=" + included_sculpture
				+ ", included_drawing=" + included_drawing + ", included_map="
				+ included_map + ", included_other=" + included_other
				+ ", firstprevreg=" + firstprevreg + ", firstyear=" + firstyear
				+ ", secondprevreg=" + secondprevreg + ", secondyear="
				+ secondyear + ", uploadfile=" + uploadfile + ", limit_id="
				+ limit_id + ", filename=" + filename + "]";
	}


	public FormFile getUploadfile() {
		return uploadfile;
	}


	public void setUploadfile(FormFile uploadfile) {
		this.uploadfile = uploadfile;
	}


	public Integer getLimit_id() {
		return limit_id;
	}


	public void setLimit_id(Integer limit_id) {
		this.limit_id = limit_id;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}
	

}
