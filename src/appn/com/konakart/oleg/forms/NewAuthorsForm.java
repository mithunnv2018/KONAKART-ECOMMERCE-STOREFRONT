package com.konakart.oleg.forms;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionMapping;
import org.apache.torque.util.BasePeer;

//import com.konakart.al.KKAppEng;
import com.konakart.app.Country;
//import com.konakart.app.EngineConfig;
//import com.konakart.app.KKException;
//import com.konakart.app.KKWSEng;
import com.konakart.appif.CountryIf;
//import com.konakart.appif.EngineConfigIf;
//import com.konakart.appif.KKEngIf;
import com.konakart.forms.BaseForm;
import com.konakart.oleg.OlegTasks;
import com.konakart.om.CountriesPeer;
import com.workingdogs.village.Record;

public class NewAuthorsForm extends BaseForm {

	String firstname, organizationame, middlename, lastname;
	String isauthorscontribution;
	String pseudonym, yearofbirth, yearofdeath;
	String isanonymous, ispseudonymous;
	Integer citizenship, domicile;
	ArrayList<Country> listofcountries = new ArrayList<Country>();
	String[] authorcontribution = null;
	String[] selectedauthorcontribution = null;
	String authorcreatedother;

	public NewAuthorsForm() {

		citizenship=222;
		domicile=222;
		
		try {
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT * FROM countries");
			for (int i = 0; i < executeQuery.size(); i++) {
				Record record = executeQuery.get(i);
				Integer asIntegerObj = record.getValue(1).asIntegerObj();
				String asString = record.getValue(2).asString();
				Country abc = new Country();
				abc.setId(asIntegerObj);
				abc.setName(asString);
				listofcountries.add(abc);

			}

			ArrayList<HashMap> doLoadAuthorContribution = doLoadAuthorContribution();

			if (doLoadAuthorContribution != null) {
				System.out.println("doLoadAuthorContribution is not null");
				authorcontribution = new String[doLoadAuthorContribution.size()];

				for (int j = 0; j < doLoadAuthorContribution.size(); j++) {
					HashMap hashMap = doLoadAuthorContribution.get(j);
					authorcontribution[j] = (String) hashMap
							.get("authorcon_aliasname");
					if (j == 0) {
						String def=(String) hashMap.get("authorcon_aliasname");
						selectedauthorcontribution =new String[0];
//						selectedauthorcontribution[0]=def;
					}
				}
			}
			else
			{
				System.out.println("doLoadAuthorContribution is null");
			}

		} catch (Exception e) {
			System.err.println("Sorry Mith constructor error" + e.getMessage());
			e.printStackTrace();
		}

	}
	
	public static ArrayList<HashMap> doLoadAuthorContribution()
	{
	 	System.out.println("started doLoadAuthorContribution");
		try 
		{
			List<Record> executeQuery = BasePeer.executeQuery("SELECT * FROM tbl_authorcontribution");
			ArrayList<HashMap> listofauthorcontribution=new ArrayList<HashMap>();
			
			if(executeQuery!=null)
			{
				for (Iterator<Record> iterator = executeQuery.iterator();
				iterator.hasNext();)
				{
					Record next = iterator.next();
					HashMap a=new HashMap();
					a.put("authorcon_id",next.getValue(1).asIntegerObj());
					a.put("authorcon_aliasname",next.getValue(3).asString());
					
					listofauthorcontribution.add(a);
				}
			}
			System.out.println("Size of authorcontribution="+listofauthorcontribution.size());
	 		return listofauthorcontribution;	
		} 
		catch (Exception e) 
		{
			System.err.println("Sorry error "+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getOrganizationame() {
		return organizationame;
	}

	public void setOrganizationame(String organizationame) {
		this.organizationame = organizationame;
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

	public String getIsauthorscontribution() {
		return isauthorscontribution;
	}

	public void setIsauthorscontribution(String isauthorscontribution) {
		this.isauthorscontribution = isauthorscontribution;
	}

	public String getYearofbirth() {
		return yearofbirth;
	}

	public void setYearofbirth(String yearofbirth) {
		this.yearofbirth = yearofbirth;
	}

	public String getYearofdeath() {
		return yearofdeath;
	}

	public void setYearofdeath(String yearofdeath) {
		this.yearofdeath = yearofdeath;
	}

	public String getIsanonymous() {
		return isanonymous;
	}

	public void setIsanonymous(String isanonymous) {
		this.isanonymous = isanonymous;
	}

	public String getIspseudonymous() {
		return ispseudonymous;
	}

	public void setIspseudonymous(String ispseudonymous) {
		this.ispseudonymous = ispseudonymous;
	}

	public String getPseudonym() {
		return pseudonym;
	}

	public void setPseudonym(String pseudonym) {
		this.pseudonym = pseudonym;
	}

	public ArrayList<Country> getListofcountries() {
		return listofcountries;
	}

	public Integer getCitizenship() {
		return citizenship;
	}

	public void setCitizenship(Integer citizenship) {
		this.citizenship = citizenship;
	}

	public Integer getDomicile() {
		return domicile;
	}

	public void setDomicile(Integer domicile) {
		this.domicile = domicile;
	}

	public void setListofcountries(ArrayList<Country> listofcountries) {
		this.listofcountries = listofcountries;
	}

	@Override
	public void reset(ActionMapping mapping, ServletRequest request) {
		// TODO Auto-generated method stub
		super.reset(mapping, request);
		firstname = "";
		organizationame = "";
		middlename = "";
		lastname = "";
		isauthorscontribution = "";
		pseudonym = "";
		yearofbirth = "";
		yearofdeath = "";
		isanonymous = "";
		ispseudonymous = "";
		citizenship = -1;
		domicile = -1;
		// listofcountries=new ArrayList<Country>();

	}

	public String[] getAuthorcontribution() {
		return authorcontribution;
	}

	public void setAuthorcontribution(String[] authorcontribution) {
		this.authorcontribution = authorcontribution;
	}

	public String[] getSelectedauthorcontribution() {
		return selectedauthorcontribution;
	}

	public void setSelectedauthorcontribution(
			String[] selectedauthorcontribution) {
		this.selectedauthorcontribution = selectedauthorcontribution;
	}

	public String getAuthorcreatedother() {
		return authorcreatedother;
	}

	public void setAuthorcreatedother(String authorcreatedother) {
		this.authorcreatedother = authorcreatedother;
	}

	@Override
	public String toString() {
		return "NewAuthorsForm [firstname=" + firstname + ", organizationame="
				+ organizationame + ", middlename=" + middlename
				+ ", lastname=" + lastname + ", isauthorscontribution="
				+ isauthorscontribution + ", pseudonym=" + pseudonym
				+ ", yearofbirth=" + yearofbirth + ", yearofdeath="
				+ yearofdeath + ", isanonymous=" + isanonymous
				+ ", ispseudonymous=" + ispseudonymous + ", citizenship="
				+ citizenship + ", domicile=" + domicile
				+ ", authorcontribution=" + Arrays.toString(authorcontribution)
				+ ", selectedauthorcontribution="
				+ Arrays.toString(selectedauthorcontribution)
				+ ", authorcreatedother=" + authorcreatedother + "]";
	}

}
