package com.konakart.oleg.forms;

import com.konakart.forms.BaseForm;

public class SpecialhandlingForm extends BaseForm {

	String specialhandling;
	String reason_pending,reason_custom,reason_contract;
	String icertify,explanation;
	Integer spec_id;
	public SpecialhandlingForm() {
		// TODO Auto-generated constructor stub
	}

	public String getSpecialhandling() {
		return specialhandling;
	}

	public void setSpecialhandling(String specialhandling) {
		this.specialhandling = specialhandling;
	}

	public String getReason_pending() {
		return reason_pending;
	}

	public void setReason_pending(String reason_pending) {
		this.reason_pending = reason_pending;
	}

	public String getReason_custom() {
		return reason_custom;
	}

	public void setReason_custom(String reason_custom) {
		this.reason_custom = reason_custom;
	}

	public String getReason_contract() {
		return reason_contract;
	}

	public void setReason_contract(String reason_contract) {
		this.reason_contract = reason_contract;
	}

	public String getIcertify() {
		return icertify;
	}

	public void setIcertify(String icertify) {
		this.icertify = icertify;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	@Override
	public String toString() {
		return "SpecialhandlingForm [specialhandling=" + specialhandling
				+ ", reason_pending=" + reason_pending + ", reason_custom="
				+ reason_custom + ", reason_contract=" + reason_contract
				+ ", icertify=" + icertify + ", explanation=" + explanation
				+ ", spec_id=" + spec_id + "]";
	}

	public Integer getSpec_id() {
		return spec_id;
	}

	public void setSpec_id(Integer spec_id) {
		this.spec_id = spec_id;
	}

}
