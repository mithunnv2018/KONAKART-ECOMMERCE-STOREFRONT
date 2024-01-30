package com.konakart.oleg;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.logging.SimpleFormatter;

import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.struts.upload.FormFile;
import org.apache.torque.TorqueException;
import org.apache.torque.util.BasePeer;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.app.Basket;
import com.konakart.app.Category;
import com.konakart.app.Country;
import com.konakart.app.KKException;
import com.konakart.app.Zone;
import com.konakart.appif.BasketIf;
import com.konakart.appif.CategoryIf;
import com.konakart.appif.ProductIf;
import com.konakart.oleg.actions.OlegAddNewAuthorAction;
import com.konakart.oleg.actions.OlegAddNewClaimantsAction;
import com.konakart.oleg.actions.OlegAddNewTitleAction;
import com.konakart.oleg.db.AuthorDetailsBean;
import com.konakart.oleg.db.FormSubmitCopyrightBean;
import com.konakart.oleg.forms.CertificationForm;
import com.konakart.oleg.forms.CorrespondentForm;
import com.konakart.oleg.forms.LimitationClaimForm;
import com.konakart.oleg.forms.MailCertificateForm;
import com.konakart.oleg.forms.NewClaimantsForm;
import com.konakart.oleg.forms.RightsPermissionForm;
import com.konakart.oleg.forms.SpecialhandlingForm;
import com.konakart.oleg.forms.TypeOfWorkForm;
import com.workingdogs.village.Record;

public class OlegTasks {

	static final String RETURNACTIONCOPYRIGHT = "ShowCopyrightRegistration";
	static HttpServletRequest request2;
	public final static String LISTOFOBJECTS = "LISTOFOBJECTS";
	public final static String LISTOFTITLETYPE = "listoftitletype";
	public final static String LISTOFAUTHORCONTRIBUTION = "LISTOFAUTHORCONTRIBUTION";
	private static final String UPLOAD_TEMP_FOLDER_2 = "c:\\report\\temp";
	private static final String UPLOAD_FINAL_FOLDER_2 = "c:\\report\\uploadedfiles";
	public final static String FORMCOPYID = "formcopyid";
	public static final ArrayList<Country> listofcountries=doRetrieveCountries();

	public final static String FILEDOWNLOADURL="FILEDOWNLOADURL";
	public static String doGetCountry(Integer countryid)
	{
		for (Country abc : listofcountries) {
			if(abc.getId()==countryid.intValue())
			{
				return abc.getName();
			}
		}
		return "";
	}
	/*
	 * Checks if the category of the product is a "CopyRight" type category.
	 */
	public static String checkIfProductIsCopyRight(KKAppEng kkAppEng,
			String prodId, HttpServletRequest request) {
		try {
			// kkAppEng.getEng().sendOrderConfirmationEmail1(arg0, arg1, arg2,
			// arg3)
			request2 = request;
			CategoryIf currentCat = kkAppEng.getCategoryMgr().getCurrentCat();
			System.out.println("HIIIII CAT NAME IS" + currentCat.getName());
			String name = currentCat.getName();
			/*
			 * kkAppEng.getProductMgr().fetchSelectedProduct(new
			 * Integer(prodId).intValue()); ProductIf selectedProd =
			 * kkAppEng.getProductMgr().getSelectedProduct(); Integer categoryId
			 * = selectedProd.getCategoryId(); Category cat=new Category();
			 * cat.setId(categoryId); if(cat==null) {
			 * System.err.println("Sorrry Category is null"); return ""; }
			 * if(categoryId==null) {
			 * System.err.println("Sorry CategoryID is null"); return ""; }
			 * System.err.println("Test "+cat.toString()); CategoryIf
			 * findCategory = cat.findCategory(categoryId); String name =
			 * findCategory.getName();
			 */

			// System.out.println("Hi i m here="+categoryId.toString());
			// if(categoryId.intValue()==22)//LOCALSYSTEM=22//ONLINE=25
			if (name.contains("Copyrights UK")) {
				doLoadTypeOfWork(prodId);
				doLoadTitleType();
				doLoadAuthorContribution();
				return RETURNACTIONCOPYRIGHT;
			} else {
				return "";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.err.println("Sorry some exception = " + e.getMessage());

		}
		return "";
		// return "";
	}

	/*
	 * 
	 * the keys used are : 1) link1 2)
	 */
	public static void doSaveListOfObjects(HttpSession session,
			int statusoflinkno, HashMap data2) {
		HashMap storeslistofobject = new HashMap();

		if (session.getAttribute(LISTOFOBJECTS) != null) {
			storeslistofobject = (HashMap) session.getAttribute(LISTOFOBJECTS);
			System.out.println("LISTOFOBJECTS IS OK");
		} else {
			System.out.println("LISTOFOBJECTS IS NULL");
		}
		if (statusoflinkno == 1) {
			System.out.println("Gone from link1");
			Integer typeworkid = (Integer) data2.get("typeworkid");
			String previousregno=(String) data2.get("previousregno");
			String previousdate=(String) data2.get("previousregdate");
			storeslistofobject.put("link1", typeworkid);
			storeslistofobject.put("link1.1",previousregno);
			storeslistofobject.put("link1.2", previousdate);
			

		} else if (statusoflinkno == 2) {
			System.out.println("Gone from link2");
			ArrayList<HashMap> abc = (ArrayList<HashMap>) data2
					.get("listoftitletype");
			storeslistofobject.put("link2", abc);
		} else if (statusoflinkno == 3) {
			System.out.println("Gone from link3");
			FormSubmitCopyrightBean hasbeenpublished = (FormSubmitCopyrightBean) data2
					.get("published");
			storeslistofobject.put("link3", hasbeenpublished);
		} else if (statusoflinkno == 4) {
			System.out.println("Gone from link4");

			ArrayList<HashMap> real = new ArrayList<HashMap>();
			ArrayList<AuthorDetailsBean> abc = (ArrayList<AuthorDetailsBean>) data2
					.get("listofauthors");
			for (int i = 0; i < abc.size(); i++) {
				// String key2 =
				// OlegAddNewAuthorAction.SESSION_FOR_AUTHOR_CONTRIBUTED
				// + (i + 1);

				HashMap row = new HashMap();
				row.put("authors", abc.get(i));
				row.put("authorcontribution", abc.get(i)
						.getAuthor_contribution());
				// session.getAttribute(key2));
				real.add(row);

			}
			storeslistofobject.put("link4", real);
		} else if (statusoflinkno == 5) {
			System.out.println("Gone from link5");
			ArrayList<NewClaimantsForm> abc = (ArrayList<NewClaimantsForm>) data2
					.get("listofclaimants");
			storeslistofobject.put("link5", abc);
		} else if (statusoflinkno == 6) {
			System.out.println("Gone from link6");
			LimitationClaimForm abc = (LimitationClaimForm) data2
					.get("limitationclaim");
			storeslistofobject.put("link6", abc);
		} else if (statusoflinkno == 7) {
			System.out.println("Gone from link7");
			RightsPermissionForm abc = (RightsPermissionForm) data2
					.get("rightpermission");
			storeslistofobject.put("link7", abc);
		} else if (statusoflinkno == 8) {
			System.out.println("Gone from link8");
			CorrespondentForm abc = (CorrespondentForm) data2
					.get("correspondent");
			storeslistofobject.put("link8", abc);
		} else if (statusoflinkno == 9) {
			System.out.println("Gone from link9");
			MailCertificateForm abc = (MailCertificateForm) data2
					.get("mailcertificate");
			storeslistofobject.put("link9", abc);
		} else if (statusoflinkno == 10) {
			System.out.println("Gone from link10");
			SpecialhandlingForm abc = (SpecialhandlingForm) data2
					.get("specialhandling");
			storeslistofobject.put("link10", abc);
		} else if (statusoflinkno == 11) {
			System.out.println("Gone from link11");
			CertificationForm abc = (CertificationForm) data2
					.get("certification");
			storeslistofobject.put("link11", abc);
		}

		session.setAttribute(LISTOFOBJECTS, storeslistofobject);
		System.out.println("Done Saving to Session "
				+ storeslistofobject.toString());
	}

	private static Integer getNextPrimaryKey(String columname, String tablename) {
		List<Record> executeQuery2;
		System.out.println("OlegTasks.getNextPrimaryKey() " + tablename);
		Integer pk = 1;

		try {
			executeQuery2 = BasePeer.executeQuery("select max(" + columname
					+ ") from " + tablename);

			Record record = executeQuery2.get(0);

			pk = record.getValue(1).asIntegerObj();
			pk++;
		} catch (Exception e) {

			e.printStackTrace();
		}
		if (pk == null) {
			return 1;
		}
		return pk;
	}

	public static boolean doSaveAllToDB(HttpServletRequest request) {
		System.out.println("OlegTasks.doSaveAllToDB()");
		HttpSession session = request.getSession();
		HashMap list2 = (HashMap) session.getAttribute(LISTOFOBJECTS);
		ArrayList<HashMap> listoftitles = new ArrayList<HashMap>();

		try {
			Integer typeworkid = (Integer) list2.get("link1");
			String previousregno=(String) list2.get("link1.1");
			String previousregdate=(String) list2.get("link1.2");
			
			Integer formcopyid = 1;
			System.out.println("Made it to link1 " + typeworkid);
			if (typeworkid != null) {
				List<Record> executeQuery = BasePeer
						.executeQuery("SELECT * FROM tbl_formsubmit_copyright");
				if (executeQuery.size() > 0) {
					/*
					 * List<Record> executeQuery2 = BasePeer .executeQuery(
					 * "select max(formcopy_id) from tbl_formsubmit_copyright");
					 * Record record = executeQuery2.get(0);
					 */formcopyid = getNextPrimaryKey("formcopy_id",
							"tbl_formsubmit_copyright"); // record.getValue(1).asIntegerObj();
					System.out.println("Form copy id is " + formcopyid);

				} else {
					formcopyid = 1;
					System.out.println("Copy id is reset to one");
				}
				int executeStatement = BasePeer
						.executeStatement("INSERT INTO tbl_formsubmit_copyright (formcopy_id,typework_id,countries_id,formcopy_previousregno,formcopy_previousregdate)  VALUES("
								+ formcopyid + "," + typeworkid + ",1,'"+previousregno+"','"+previousregdate+"') ");
				session.setAttribute(FORMCOPYID, formcopyid);

				System.out.println("Insert to tbl_formsubmit_copyright rows="
						+ executeStatement);

			} else {
				System.err
						.println("Sorry cannot proceed typework not selected");
				return false;
			}
			if (list2.get("link2") != null) {
				listoftitles = (ArrayList<HashMap>) list2.get("link2");

				for (int i = 0; i < listoftitles.size(); i++) {
					HashMap hashMap = listoftitles.get(i);
					Integer titletypeid = (Integer) hashMap.get("titletypeid");
					String titleofwork = (String) hashMap.get("titleofwork");
					System.out.println("tbl_titles_details index=" + i
							+ " total size=" + listoftitles.size()
							+ " content =" + hashMap.toString());

					String sql = "INSERT INTO tbl_titles_details ( formcopy_id, titletype_id, titledetails_name)  VALUES("
							+ formcopyid
							+ " , "
							+ titletypeid
							+ " , '"
							+ titleofwork + "' )";
					System.out.println("sql for link is " + sql);
					int executeStatement2 = BasePeer.executeStatement(sql);
					System.out
							.println("Insert to tbl_titles_details no of insert="
									+ executeStatement2);
				}

			} else {
				System.err.println("Sorry link2 lsitoftitles  is null");
			}

			if (list2.get("link3") != null) {
				FormSubmitCopyrightBean bean = (FormSubmitCopyrightBean) list2
						.get("link3");
				System.out.println("Ok link3 is starting save");
				String countries2 = "";
				if (bean.getCountries_id().intValue() != -1) {
					countries2 = " ,  countries_id="
							+ bean.getCountries_id().intValue();
				}

				Date instance2 = Calendar.getInstance().getTime();
				Calendar instance = Calendar.getInstance();
				instance.add(Calendar.YEAR, 40);
				Date newtime = instance.getTime();
				SimpleDateFormat formatter = new SimpleDateFormat(
						"dd/MM/yyyy H:mm:ss");
				String currentdate = formatter.format(instance2);
				String nextdate = formatter.format(newtime);

				String securitycode = doRetrieveCode(1);
				String regcode = doRetrieveCode(2);

				int executeStatement3 = BasePeer
						.executeStatement("UPDATE  tbl_formsubmit_copyright SET   formcopy_workpublished='"
								+ bean.getFormcopy_workpublished()
								+ "', formcopy_yearofcomp='"
								+ bean.getFormcopy_yearofcomp()
								+ "', formcopy_dateoffirstpub='"
								+ bean.getFormcopy_dateoffirstpub()
								+"'"
								+ countries2
								+ ", formcopy_internotype='"
								+ bean.getFormcopy_internotype()
								+ "', formcopy_internumber='"
								+ bean.getFormcopy_internumber()
								+ "', formcopy_preregnos='"
								+ bean.getFormcopy_preregnos()
								+ "', formcopy_regdate='"
								+ currentdate
								+ "', formcopy_regenddate='"
								+ nextdate
								+ "' , "
								+ "formcopy_securitycode='"
								+ securitycode
								+ "' , formcopy_regcode='"
								+ regcode
								+ "' "
								+",  formcopy_userid='"
								+bean.getFormcopy_userid()
								+"' "
								+ " WHERE formcopy_id="
								+ formcopyid);
				System.out.println("Ok link3 inserted rows="
						+ executeStatement3);

			} else {
				System.err.println("Sorry link3 is null");
			}

			if (list2.get("link4") != null) {
				ArrayList<HashMap> listofauthors = (ArrayList<HashMap>) list2
						.get("link4");
				for (int i = 0; i < listofauthors.size(); i++) {
					HashMap hashMap = listofauthors.get(i);
					AuthorDetailsBean b2 = (AuthorDetailsBean) hashMap
							.get("authors");
					ArrayList abc = (ArrayList) hashMap
							.get("authorcontribution");
					if (b2 != null) {

						int author_id = getNextPrimaryKey("author_id",
								"tbl_authors_details");

						int executeStatement = BasePeer
								.executeStatement("INSERT INTO tbl_authors_details "
										+ "( author_id , author_name, author_fname, author_mname, author_lname, author_workmadeforhire, "
										+ "author_citizencountryid, author_domicile, author_anonym, author_psedonym, "
										+ "author_psedonymname, author_DOB, author_DOD, formcopy_id, author_organizationname) "
										+ "VALUES("
										+ author_id
										+ ","
										+ "'"
										+ b2.getAuthor_name()
										+ "','"
										+ b2.getAuthor_fname()
										+ "' , '"
										+ b2.getAuthor_mname()
										+ "' , '"
										+ b2.getAuthor_lname()
										+ "' , '"
										+ b2.getAuthor_workmadeforhire()
										+ "' "
										+ ", "
										+ b2.getAuthor_citizencountryid()
										+ " , "
										+ b2.getAuthor_domicile()
										+ " , '"
										+ b2.getAuthor_anonym()
										+ "' ,'"
										+ b2.getAuthor_psedonym()
										+ "' "
										+ ", '"
										+ b2.getAuthor_psedonymname()
										+ "' , '"
										+ b2.getAuthor_DOB()
										+ "' , '"
										+ b2.getAuthor_DOD()
										+ "' , "
										+ formcopyid
										+ " , '"
										+ b2.getAuthor_organizationname()
										+ "')");
						System.out
								.println("no of rows saved tbl_authors_details= "
										+ executeStatement);

						for (int j2 = 0; j2 < abc.size(); j2++) {
							if (j2 == 0) {
								String others = (String) abc.get(j2);
								if (others != null && !others.isEmpty()) {
									int executeStatement2 = BasePeer
											.executeStatement("INSERT INTO tbl_authorcontribution_details(author_id,   author_checked, author_others)"
													+ "VALUES( "
													+ ""
													+ author_id
													+ " , 'No' , '"
													+ others + "'" + ")");
									System.out
											.println("Saved others in table tbl_authorcontribution_details");
								}
							} else {
								if (abc.get(j2) != null) {
									Integer authorconid = (Integer) abc.get(j2);
									int executeStatement2 = BasePeer
											.executeStatement("INSERT INTO tbl_authorcontribution_details(author_id, authorcon_id, author_checked, author_others)"
													+ "VALUES( "
													+ ""
													+ author_id
													+ " , "
													+ authorconid
													+ " , 'Yes' , ''" + ")");
									System.out
											.println("Saved  in table tbl_authorcontribution_details index="
													+ j2
													+ " authorcontribdetail size="
													+ abc.size());
								}
							}
						}

					} else {
						System.err
								.println("Sorry link4 doesnot have a map key=authors");
					}

				}

				// authors , authorcontribution
			} else {
				System.err.println("Sorry link4 is null");
			}

			if (list2.get("link5") != null) {
				ArrayList<NewClaimantsForm> listofclaimants = (ArrayList<NewClaimantsForm>) list2
						.get("link5");

				for (int i = 0; i < listofclaimants.size(); i++) {
					NewClaimantsForm b3 = listofclaimants.get(i);
					System.out.println("tbl_claimants_details at index=" + i
							+ " size of list=" + listofclaimants.size());
					String sql = "INSERT INTO tbl_claimants_details(formcopy_id, clam_orgainzation, "
							+ "clam_fname, clam_mname, clam_lname, clam_add1, clam_add2, clam_city, clam_state, clam_postal, "
							+ "countries_id, clam_transferstatment, clam_transferstatother) "
							+ "VALUES( "
							+ formcopyid
							+ " , '"
							+ b3.getOrganizationname()
							+ "' , '"
							+ b3.getFirstname()
							+ "' , '"
							+ b3.getMiddlename()
							+ "' , '"
							+ b3.getLastname()
							+ "' "
							+ ", '"
							+ b3.getAddress1()
							+ "' , '"
							+ b3.getAddress2()
							+ "' , '"
							+ b3.getCity()
							+ "' , '"
							+ b3.getState()
							+ "' , '"
							+ b3.getPostalcode()
							+ "' "
							+ ", "
							+ b3.getCountryid()
							+ " , '"
							+ b3.getTransferstatement()
							+ "' , '"
							+ b3.getOthertransferstatement() + "' " + "   )";
					System.out.println("link 5 sql=" + sql);
					int executeStatement = BasePeer.executeStatement(sql);
					System.out.println("tbl_claimants_details saved "
							+ executeStatement);
				}
			} else {
				System.err.println("Sorry link5 is null");
			}

			if (list2.get("link6") != null) {
				LimitationClaimForm b4 = (LimitationClaimForm) list2
						.get("link6");
				String filename = "";
				if (b4.getUploadfile() != null) {
					FormFile uploadfile = b4.getUploadfile();
					doMoveUploadedFile2(uploadfile, request);
					filename = uploadfile.getFileName();
					// todo move uploadef file from temp to uploadedfiles
				}

				String sql = "INSERT INTO tbl_limitationclaim (formcopy_id, limit_excluded_text, limit_excluded_2dartwork, limit_excluded_photo, "
						+ "limit_excluded_jewelrydesign, limit_excluded_architectural, limit_excluded_sculpture, limit_excluded_drawing, limit_excluded_map,"
						+ " limit_excluded_other, limit_included_text, limit_included_2dartwork, limit_included_photo, limit_included_jewelrydesign, "
						+ "limit_included_architectural, limit_included_sculpture, limit_included_drawing, limit_included_map, limit_included_other, "
						+ "limit_firstprevreg, limit_firstyear, limit_secondprevreg, limit_secondyear , limit_uploadedfilename) "
						+ "VALUES ("
						+ formcopyid
						+ " , '"
						+ b4.getExcluded_text()
						+ "' , '"
						+ b4.getExcluded_2dartwork()
						+ "' , '"
						+ b4.getExcluded_photo()
						+ "' ,"
						+ "'"
						+ b4.getExcluded_jewelrydesign()
						+ "' , '"
						+ b4.getExcluded_architectural()
						+ "' , '"
						+ b4.getExcluded_sculpture()
						+ "' , '"
						+ b4.getExcluded_drawing()
						+ "' , '"
						+ b4.getExcluded_map()
						+ "' , '"
						+ b4.getExcluded_other()
						+ "' , '"
						+ b4.getIncluded_text()
						+ "' , '"
						+ b4.getIncluded_2dartwork()
						+ "' , "
						+ "'"
						+ b4.getIncluded_photo()
						+ "' , '"
						+ b4.getIncluded_jewelrydesign()
						+ "' , '"
						+ b4.getIncluded_architectural()
						+ "' , '"
						+ b4.getIncluded_sculpture()
						+ "' , '"
						+ b4.getIncluded_drawing()
						+ "' , '"
						+ b4.getIncluded_map()
						+ "' , '"
						+ b4.getIncluded_other()
						+ "' , '"
						+ b4.getFirstprevreg()
						+ "' , "
						+ "'"
						+ b4.getFirstyear()
						+ "' , '"
						+ b4.getSecondprevreg()
						+ "' , '"
						+ b4.getSecondyear()
						+ "'"
						+ " , '"
						+ filename + "' " + " )";
				System.out.println("At link 6 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_limitationclaim rows="
						+ executeStatement);
			} else {
				System.err.println("Sorry link6 is null");
			}

			if (list2.get("link7") != null) {
				RightsPermissionForm b4 = (RightsPermissionForm) list2
						.get("link7");
				String sql = "INSERT INTO tbl_rightspermission(formcopy_id, rights_orgainzation, rights_fname, rights_mname, rights_lname, "
						+ "rights_add1, rights_add2, rights_city, rights_state, rights_postal, countries_id, rights_alternatephone, "
						+ "rights_phone, rights_email) " + "VALUES (" + ""
						+ formcopyid
						+ ", "
						+ "'"
						+ b4.getOrganizationname()
						+ "' , "
						+ "'"
						+ b4.getFirstname()
						+ "' , '"
						+ b4.getMiddlename()
						+ "' , '"
						+ b4.getLastname()
						+ "' , '"
						+ b4.getAddress1()
						+ "' , '"
						+ b4.getAddress2()
						+ "',"
						+ "'"
						+ b4.getCity()
						+ "' , '"
						+ b4.getState()
						+ "' , '"
						+ b4.getPostalcode()
						+ "' , "
						+ b4.getCountryid()
						+ " ,'"
						+ b4.getAlternatephone()
						+ "' ,"
						+ "'"
						+ b4.getPhone() + "' , '" + b4.getEmail() + "'" + ") ";
				System.out.println("At link7 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_rightspermission rows="
						+ executeStatement);
			} else {
				System.err.println("Sorry link7 is null");
			}

			if (list2.get("link8") != null) {
				CorrespondentForm b5 = (CorrespondentForm) list2.get("link8");
				String sql = "INSERT INTO tbl_correspondent( formcopy_id, corr_orgainzation, corr_fname, corr_mname, corr_lname, "
						+ "corr_add1, corr_add2, corr_city, corr_state, corr_postal, countries_id, corr_alternatephone, "
						+ "corr_phone, corr_email, corr_fax) " + "VALUES(" + ""
						+ formcopyid
						+ " , '"
						+ b5.getOrganizationname()
						+ "' , '"
						+ b5.getFirstname()
						+ "' , '"
						+ b5.getMiddlename()
						+ "' , '"
						+ b5.getLastname()
						+ "'"
						+ ", '"
						+ b5.getAddress1()
						+ "' , '"
						+ b5.getAddress2()
						+ "' , '"
						+ b5.getCity()
						+ "' , '"
						+ b5.getState()
						+ "' , '"
						+ b5.getPostalcode()
						+ "' ,"
						+ ""
						+ b5.getCountryid()
						+ " , '"
						+ b5.getAlternatephone()
						+ "' , '"
						+ b5.getPhone()
						+ "' , '"
						+ b5.getEmail()
						+ "' , '" + b5.getFax() + "' " + ")";
				System.out.println("At link8 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_correspondent rows="
						+ executeStatement);
			} else {
				System.err.println("Sorry Link8 is null");
			}

			if (list2.get("link9") != null) {
				MailCertificateForm b6 = (MailCertificateForm) list2
						.get("link9");
				String sql = "INSERT INTO tbl_mailcertificate(formcopy_id, mailc_orgainzation, mailc_fname, mailc_mname,"
						+ " mailc_lname, mailc_add1, mailc_add2, mailc_city, mailc_state, "
						+ "mailc_postal, countries_id) " + "VALUES ("
						+ formcopyid
						+ " , '"
						+ b6.getOrganizationname()
						+ "' , '"
						+ b6.getFirstname()
						+ "' , '"
						+ b6.getMiddlename()
						+ "' "
						+ ", '"
						+ b6.getLastname()
						+ "' , '"
						+ b6.getAddress1()
						+ "' , '"
						+ b6.getAddress2()
						+ "' , '"
						+ b6.getCity()
						+ "' , '"
						+ b6.getState()
						+ "'"
						+ ", '"
						+ b6.getPostalcode()
						+ "' , " + b6.getCountryid() + ")";
				System.out.println("At link9 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_mailcertificate rows="
						+ executeStatement);
			} else {
				System.err.println("Sorry link9 is null");
			}

			if (list2.get("link10") != null) {
				SpecialhandlingForm b2 = (SpecialhandlingForm) list2
						.get("link10");
				String sql = "INSERT INTO tbl_specialhandling( formcopy_id, spec_specialhandling, spec_reason_pending,"
						+ " spec_reason_custom, spec_reason_contract, spec_explanation, "
						+ "spec_icertify) "
						+ "VALUES ("
						+ formcopyid
						+ " , '"
						+ b2.getSpecialhandling()
						+ "' , '"
						+ b2.getReason_pending()
						+ "' ,"
						+ "'"
						+ b2.getReason_custom()
						+ "' , '"
						+ b2.getReason_contract()
						+ "' , '"
						+ b2.getExplanation()
						+ "' , "
						+ "'"
						+ b2.getIcertify()
						+ "'" + "" + ")";
				System.out.println("At link10 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_specialhandling rows="
						+ executeStatement);
			} else {
				System.err.println("sorry link10 is null");
			}

			if (list2.get("link11") != null) {
				CertificationForm b3 = (CertificationForm) list2.get("link11");
				String sql = "INSERT INTO tbl_certification(formcopy_id, cert_icertify, cert_nameofindividual, "
						+ "cert_trackingnumber, cert_note) "
						+ "VALUES ("
						+ formcopyid
						+ " , '"
						+ b3.getIcertify()
						+ "' , '"
						+ b3.getNameofindividual()
						+ "' , "
						+ "'"
						+ b3.getTrackingnumber()
						+ "' , '"
						+ b3.getNote()
						+ "'"
						+ "" + ")";
				System.out.println("At link11 sql=" + sql);
				int executeStatement = BasePeer.executeStatement(sql);
				System.out.println("saved tbl_certification rows="
						+ executeStatement);
			} else {
				System.err.println("sorry link11 is null");
			}
			session.setAttribute(LISTOFOBJECTS, null);
			doRemoveFromSession(request);
			return true;
		} catch (Exception e) {
			System.err.println("sorry erro here " + e.getMessage());
			e.printStackTrace();
		}
		return false;

	}
	
	public static void doRemoveFromSession(HttpServletRequest request)
	{
		try {
			System.out.println("OlegTasks.doRemoveFromSession()");
			HttpSession session = request.getSession();
			session.setAttribute("listoftypeofwork", null);
			session.setAttribute(OlegAddNewTitleAction.SESSION_FOR_ALLTITLES, null);
			session.setAttribute(OlegAddNewAuthorAction.SESSION_FOR_ALLAUTHORS, null);
			session.setAttribute(OlegAddNewClaimantsAction.SESSION_FOR_ALLCLAIMANTS, null);
		} catch (Exception e) {
			System.err.println("Sorry erro here "+e.getMessage());
			e.printStackTrace();
		}
		
	}

	/*
	 * To Load the drop down in TYPE OF WORK
	 */
	private static void doLoadTypeOfWork(String prodId) {
		HttpSession session = request2.getSession();
		System.out.println("Started doLoadTypeOfWork...");

		try {
			int parseprodid = Integer.parseInt(prodId);
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT * FROM tbl_typeofwork WHERE products_id="+parseprodid+" ");
			ArrayList<HashMap> listoftypeofwork = new ArrayList<HashMap>();

			if (executeQuery != null) {
				for (Iterator<Record> iterator = executeQuery.iterator(); iterator
						.hasNext();) {
					Record next = iterator.next();
					HashMap a = new HashMap();
					a.put("typeworkid", next.getValue(1).asInt());
					a.put("typeworkaliasname", next.getValue(3).asString());

					listoftypeofwork.add(a);
				}
			}
			System.out.println("Size of typeofwork=" + listoftypeofwork.size());
			session.setAttribute("listoftypeofwork", listoftypeofwork);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.err.println("doLoadTypeofWork error here" + e.getMessage());
		}

	}

	private static void doLoadTitleType() {
		HttpSession session = request2.getSession();
		System.out.println("Start doLoadTitleType");
		try {
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT * FROM tbl_titletype");
			ArrayList<HashMap> listoftitletype = new ArrayList<HashMap>();

			if (executeQuery != null) {
				for (Iterator<Record> iterator = executeQuery.iterator(); iterator
						.hasNext();) {
					Record next = iterator.next();
					HashMap a = new HashMap();
					a.put("titletype_id", next.getValue(1).asIntegerObj());
					a.put("titletype_aliasname", next.getValue(3).asString());

					listoftitletype.add(a);
				}
			}
			System.out.println("Size of titletype=" + listoftitletype.size());
			session.setAttribute(LISTOFTITLETYPE, listoftitletype);

		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("doLoadTitleType()" + e.getMessage());
		}
	}

	public static ArrayList<HashMap> doLoadAuthorContribution() {
		HttpSession session = request2.getSession();
		System.out.println("started doLoadAuthorContribution");
		try {
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT * FROM tbl_authorcontribution");
			ArrayList<HashMap> listofauthorcontribution = new ArrayList<HashMap>();

			if (executeQuery != null) {
				for (Iterator<Record> iterator = executeQuery.iterator(); iterator
						.hasNext();) {
					Record next = iterator.next();
					HashMap a = new HashMap();
					a.put("authorcon_id", next.getValue(1).asIntegerObj());
					a.put("authorcon_aliasname", next.getValue(3).asString());

					listofauthorcontribution.add(a);
				}
			}
			System.out.println("Size of authorcontribution="
					+ listofauthorcontribution.size());
			session.setAttribute(LISTOFAUTHORCONTRIBUTION,
					listofauthorcontribution);
			return listofauthorcontribution;
		} catch (Exception e) {
			System.err.println("Sorry error " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public static ArrayList<Country> doRetrieveCountries() {
		ArrayList<Country> listofcountries = new ArrayList<Country>();
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
		} catch (Exception e) {
			System.err.println("Sorry error doRetrieveCountries "
					+ e.getMessage());
			e.printStackTrace();
		}
		return listofcountries;
	}

	public static ArrayList<Zone> doRetrieveStateZones() {
		ArrayList<Zone> listofstatezones = new ArrayList<Zone>();
		try {
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT * FROM zones WHERE zone_country_id=223");
			for (int i = 0; i < executeQuery.size(); i++) {
				Record record = executeQuery.get(i);
				String asString = record.getValue("zone_name").asString();
				String asString2 = record.getValue("zone_code").asString();

				Zone z = new Zone();
				z.setZoneName(asString);
				z.setZoneCode(asString2);

				listofstatezones.add(z);
			}
		} catch (Exception e) {
			System.err.println("Sorry error at doRetrieveStateZones "
					+ e.getMessage());
			e.printStackTrace();
		}
		return listofstatezones;
	}

	public static String doPDF2(HttpServletRequest request,
			String outputfilename, HashMap params2) throws JRException {

		System.out.println("OlegTasks.doPDF2()");
		// Connection connection = HibernateUtils.currentSession().connection();
		HashMap params = new HashMap();

		// params.put("productid2", tblproductmaster.getProductId());
		// params.put("productName", tblproductmaster.getProductName());
		// params.put("productDesc", tblproductmaster.getProductDesc());
		// params.put("productApp", tblproductmaster.getProductApp());
		// params.put("productPacking", tblproductmaster.getProductPacking());
		params.putAll(params2);
		String imagePath = request.getSession().getServletContext()
				.getRealPath("/images");

		String pdfpath=request.getSession().getServletContext()
		.getRealPath("/report");
		
		String separator = File.separator;
		imagePath += separator;

		params.put("MITHIMAGE", imagePath);

		String reportPath = "";
		// request.getSession().getServletContext().getRealPath("/report");
		// reportPath+=separator;
		// reportPath+="copyright-certificate.jasper";
		reportPath = "c:\\report\\src\\copyright-certificate.jasper";

		// "C:\\suns\\workspace3\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\KONAKART-STORE\\report\\copyright-certificate.jasper";
		System.out.println("Report path is " + reportPath);
		System.out.println("params passed are " + params.toString());
		// jasperPrint = JasperFillManager.fillReport(reportPath,
		// params,beanCollectionDataSource);
		ArrayList emptylist = new ArrayList();
		emptylist.add("one");
		JRBeanCollectionDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(
				emptylist);
		JasperPrint jasperPrint = JasperFillManager.fillReport(reportPath,
				params, beanCollectionDataSource);

		System.out.println("Jasper name is=" + jasperPrint.getName());
		String destFileName = "";
		// request.getSession().getServletContext().getRealPath("/report/copyright");
		// destFileName+=separator;
		// destFileName+="certificate"+outputfilename+".pdf";
		destFileName = "c:\\report\\copyright\\certificate" + outputfilename
				+ ".pdf";
		
		pdfpath += separator+"copyright"+separator+outputfilename+ ".pdf";
		
		JasperExportManager.exportReportToPdfFile(jasperPrint, destFileName);
		JasperExportManager.exportReportToPdfFile(jasperPrint, pdfpath);
		
		System.out.println("Detination pdf file is " + destFileName);

		return destFileName;
	}

	public static String doMoveUploadedFile2(FormFile uploadfile,
			HttpServletRequest request) {
		String returnfile = "";
		try {
			returnfile = uploadfile.getFileName();
			String folder = UPLOAD_FINAL_FOLDER_2;
			File f = new File(UPLOAD_TEMP_FOLDER_2, uploadfile.getFileName());
			if (f.exists()) {
				File f2 = new File(UPLOAD_FINAL_FOLDER_2,
						uploadfile.getFileName());
				boolean renameTo = f.renameTo(f2);
				System.out.println("File final saving path "
						+ f2.getAbsolutePath());
				System.out.println("File is finally saved " + renameTo);
			}
		} catch (Exception e) {
			System.err.println("Sorry error " + e.getMessage());
			e.printStackTrace();
		}
		return returnfile;
	}

	public static String doSaveUploadedFile2(FormFile uploadfile,
			HttpServletRequest request) {
		String fileName = uploadfile.getFileName();
		String returnfilename = UPLOAD_TEMP_FOLDER_2;
		System.out.println("OlegTasks.doSaveUploadedFile2()");
		try {
			if (!fileName.equalsIgnoreCase("")) {
				File f = new File(returnfilename, fileName);

				FileOutputStream fos = new FileOutputStream(f);
				fos.write(uploadfile.getFileData());
				fos.flush();
				fos.close();

				System.out.println("Saved to temp folder name=" + fileName);
			} else {
				System.out.println("Nope the file is null");
			}

		} catch (Exception e) {
			System.err.println("Sorry error here " + e.getMessage());
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * typeofcode==1 means securityu code returned typeofcode == 2 mean reg code
	 * 
	 * @param typeofcode
	 * @return
	 */
	public static String doRetrieveCode(int typeofcode) {
		long timeInMillis = Calendar.getInstance().getTimeInMillis();
		Calendar instance = Calendar.getInstance();
		Date first = instance.getTime();
		instance.add(Calendar.DAY_OF_MONTH, 10);
		Date second = instance.getTime();
		instance.add(Calendar.DAY_OF_MONTH, 10);
		Date third = instance.getTime();

		String returnstring = "";

		// typeofcode==1 means securityu code returned
		if (typeofcode == 1) {
			returnstring = Long.toHexString(first.getTime()) + ""
					+ Long.toHexString(second.getTime()) + "" + ""
					+ Long.toHexString(third.getTime());
		}
		// typeofcode == 2 mean reg code
		else if (typeofcode == 2) {
			returnstring = Long.toString(first.getTime());
		}
		System.out.println("Time in millis " + returnstring);

		System.out.println("Lengh is hex =" + returnstring.length());
		return returnstring;

		// return "";
	}

	public static ArrayList<HashMap> doRetrieveTableForSummary() {
		System.out.println("OlegTasks.doRetrieveTableForSummary()");
		ArrayList<HashMap> returntable = new ArrayList<HashMap>();
		String query = "SELECT formcopy_id, formcopy_yearofcomp, formcopy_regdate FROM tbl_formsubmit_copyright ORDER BY  formcopy_id DESC";
		String query2 = "SELECT author_id, author_name,author_organizationname FROM tbl_authors_details WHERE  formcopy_id=";
		try {
			List<Record> executeQuery = BasePeer.executeQuery(query);
			for (int i = 0; i < executeQuery.size(); i++) {
				HashMap abc = new HashMap();

				Record record = executeQuery.get(i);
				Integer formcopyid = record.getValue(1).asIntegerObj();
				String yearofcomp = record.getValue(2).asString();
				String regdate = record.getValue(3).asString();
				abc.put("formcopyid", formcopyid);
				abc.put("yearofcomp", yearofcomp);
				abc.put("regdate", regdate);

				List<Record> executeQuery2 = BasePeer.executeQuery(query2
						+ formcopyid);
				if (executeQuery2 != null && executeQuery2.isEmpty() == false) {
					Record record2 = executeQuery2.get(0);
					record2.getValue(1);
					abc.put("authorname", record2.getValue(2).asString());
					abc.put("organizationname", record2.getValue(3).asString());

				}

				returntable.add(abc);

			}
			return returntable;
		} catch (Exception e) {
			System.err.println("Sorry error at doRetrieVetableForSummary"
					+ e.getMessage());
			e.printStackTrace();
		}
		return returntable;
	}

	public static HashMap doRetrieveSummaryDetail(HttpServletRequest request,
			Integer formcopyid) {
		System.out.println("OlegTasks.doRetrieveSummaryDetail()");
		HashMap summarydata = new HashMap();
		try {
			// LINK1
			System.out.println("link1 start ");
			String query1 = "SELECT typework_id FROM tbl_formsubmit_copyright WHERE formcopy_id="
					+ formcopyid;
			List<Record> executeQuery = BasePeer.executeQuery(query1);
			Integer typeworkid = 0;
			String typeworkname = "";
			if (executeQuery != null && executeQuery.isEmpty() == false) {
				Record record = executeQuery.get(0);
				typeworkid = record.getValue("typework_id").asIntegerObj();
				String query12 = "SELECT  typework_name FROM tbl_typeofwork WHERE typework_id="
						+ typeworkid;
				List<Record> executeQuery2 = BasePeer.executeQuery(query12);
				Record record2 = executeQuery2.get(0);
				typeworkname = record2.getValue(1).asString();

				HashMap abc = new HashMap();
				abc.put("typeworkid", typeworkid);
				abc.put("typeworkname", typeworkname);

				summarydata.put("link1", abc);
			}

			// LINK2
			System.out.println("link 2 start ");
			String query2 = "SELECT  titletype_id, titledetails_name FROM tbl_titles_details WHERE formcopy_id="
					+ formcopyid;
			ArrayList<HashMap> link2 = new ArrayList<HashMap>();

			String titletype_name = "", titledetails_name = "";
			Integer titletype_id = 0;
			List<Record> executeQuery2 = BasePeer.executeQuery(query2);
			if (executeQuery2 != null && executeQuery2.isEmpty() == false) {
				for (int i = 0; i < executeQuery2.size(); i++) {
					Record record = executeQuery2.get(i);
					titletype_id = record.getValue("titletype_id")
							.asIntegerObj();
					titledetails_name = record.getValue("titledetails_name")
							.asString();
					String query22 = "SELECT  titletype_name FROM tbl_titletype WHERE titletype_id="
							+ titletype_id;
					List<Record> executeQuery3 = BasePeer.executeQuery(query22);
					Record record2 = executeQuery3.get(0);
					titletype_name = record2.getValue("titletype_name")
							.asString();

					HashMap abc = new HashMap();
					abc.put("titletype_id", titletype_id);
					abc.put("titletype_name", titletype_name);
					abc.put("titledetails_name", titledetails_name);
					link2.add(abc);
				}
				summarydata.put("link2", link2);
			} else {
				summarydata.put("link2", null);
			}

			// LINK3
			System.out.println("link 3 start ");
			String query3 = "SELECT   formcopy_workpublished, formcopy_yearofcomp, formcopy_dateoffirstpub,"
					+ " formcopy_nationofpublication, countries_id, formcopy_internotype, formcopy_internumber, "
					+ "formcopy_preregnos, formcopy_userid, formcopy_securitycode, formcopy_regcode, formcopy_regdate, formcopy_regenddate FROM tbl_formsubmit_copyright WHERE formcopy_id="
					+ formcopyid;
			FormSubmitCopyrightBean bean3 = new FormSubmitCopyrightBean();
			List<Record> executeQuery3 = BasePeer.executeQuery(query3);
			if (executeQuery3 != null && executeQuery3.isEmpty() == false) {

				Record record = executeQuery3.get(0);
				bean3.setFormcopy_workpublished(record.getValue(
						"formcopy_workpublished").asString());
				bean3.setFormcopy_yearofcomp(record.getValue(
						"formcopy_yearofcomp").asString());
				bean3.setFormcopy_dateoffirstpub(record.getValue(
						"formcopy_dateoffirstpub").asString());
				bean3.setFormcopy_nationofpublication(record.getValue(
						"formcopy_nationofpublication").asString());
				bean3.setCountries_id(record.getValue("countries_id")
						.asIntegerObj());
				bean3.setFormcopy_internotype(record.getValue(
						"formcopy_internotype").asString());
				bean3.setFormcopy_internumber(record.getValue(
						"formcopy_internumber").asString());
				bean3.setFormcopy_preregnos(record.getValue(
						"formcopy_preregnos").asString());
				bean3.setFormcopy_userid(record.getValue("formcopy_userid")
						.asString());
				bean3.setFormcopy_securitycode(record.getValue(
						"formcopy_securitycode").asString());
				bean3.setFormcopy_regcode(record.getValue("formcopy_regcode")
						.asString());
				bean3.setFormcopy_regdate(record.getValue("formcopy_regdate")
						.asString());
				bean3.setFormcopy_regenddate(record.getValue(
						"formcopy_regenddate").asString());
				summarydata.put("link3", bean3);
			} else {
				summarydata.put("link3", null);
			}

			// LINK 4
			System.out.println("link 4 start ");
			String query4 = "SELECT author_id, author_name, author_fname, author_mname, author_lname," +
					" author_workmadeforhire, author_citizencountryid, author_domicile, author_anonym, " +
					"author_psedonym, author_psedonymname, author_DOB, author_DOD,  author_organizationname " +
					"FROM tbl_authors_details WHERE formcopy_id="+formcopyid;
			
			ArrayList<AuthorDetailsBean> link4=new ArrayList<AuthorDetailsBean>();
			List<Record> executeQuery4 = BasePeer.executeQuery(query4);
			if(executeQuery4!=null && executeQuery4.isEmpty()==false)
			{
				for(int i=0;i<executeQuery4.size();i++)
				{
					AuthorDetailsBean bean=new AuthorDetailsBean();
					Record record = executeQuery4.get(i);
					bean.setAuthor_id( record.getValue("author_id").asIntegerObj());
					bean.setAuthor_name(record.getValue("author_name").asString());
					bean.setAuthor_fname(record.getValue("author_fname").asString());
					bean.setAuthor_mname(record.getValue("author_mname").asString());
					bean.setAuthor_lname(record.getValue("author_lname").asString());
					bean.setAuthor_workmadeforhire(record.getValue("author_workmadeforhire").asString());
					bean.setAuthor_citizencountryid(record.getValue("author_citizencountryid").asIntegerObj());
					bean.setAuthor_domicile(record.getValue("author_domicile").asIntegerObj());
					bean.setAuthor_anonym(record.getValue("author_anonym").asString());
					bean.setAuthor_psedonym(record.getValue("author_psedonym").asString());
					bean.setAuthor_psedonymname(record.getValue("author_psedonymname").asString());
					bean.setAuthor_DOB(record.getValue("author_DOB").asString());
					bean.setAuthor_DOD(record.getValue("author_DOD").asString());
					bean.setAuthor_organizationname(record.getValue("author_organizationname").asString());
				
					String query41="SELECT  authorcon_id, author_checked, author_others FROM tbl_authorcontribution_details WHERE author_id="+bean.getAuthor_id();
					List<Record> executeQuery5 = BasePeer.executeQuery(query41);
					if(executeQuery5!=null && executeQuery5.isEmpty()==false)
					{
						ArrayList authorcontribution=new ArrayList();
						
						for(int j=0;j<executeQuery5.size();j++)
						{
							Record record2 = executeQuery5.get(j);
							Integer authorcon_id=record2.getValue("authorcon_id").asIntegerObj();
							String author_checked= record2.getValue("author_checked").asString();
							String author_others= record2.getValue("author_others").asString();
							if(author_checked.equalsIgnoreCase("No"))
							{
								authorcontribution.add(author_others);
							}
							else
							{
								authorcontribution.add("");
							}
							if(author_checked.equalsIgnoreCase("Yes") && authorcon_id!=null)
							{
								String queryString42="SELECT authorcon_name FROM tbl_authorcontribution WHERE authorcon_id="+authorcon_id;
								List<Record> executeQuery6 = BasePeer.executeQuery(queryString42);
								if(executeQuery6!=null)
								{
									for(int k=0;k<executeQuery6.size();k++)
									{
										Record record3 = executeQuery6.get(k);
										String authorcon_name = record3.getValue("authorcon_name").asString();
										authorcontribution.add(authorcon_name);
										System.out.println("Added non others to authorcontribution");
									}
								}
							}
						}
						bean.setAuthor_contribution(authorcontribution);
					}
					link4.add(bean);
				}
				summarydata.put("link4", link4);
			}
			else
			{
				summarydata.put("link4",null);
			}
			
			//LINK 5
			System.out.println("link 5 start ");
			String query5="SELECT clam_id, clam_orgainzation, clam_fname, clam_mname, clam_lname, clam_add1, clam_add2, " +
					"clam_city, clam_state, clam_postal, countries_id, clam_transferstatment, clam_transferstatother " +
					"FROM tbl_claimants_details WHERE formcopy_id="+formcopyid;

			ArrayList<NewClaimantsForm> link5=new ArrayList<NewClaimantsForm>();
			
			List<Record> executeQuery5 = BasePeer.executeQuery(query5);
			if(executeQuery5!=null && executeQuery5.isEmpty()==false)
			{
				for(int i=0;i<executeQuery5.size();i++)
				{
					NewClaimantsForm bean=new NewClaimantsForm();
					
					Record record = executeQuery5.get(i);
					
					bean.setClamid(record.getValue("clam_id").asIntegerObj());
					bean.setOrganizationname(record.getValue("clam_orgainzation").asString());
					bean.setFirstname(record.getValue("clam_fname").asString());
					bean.setMiddlename(record.getValue("clam_mname").asString());
					bean.setLastname(record.getValue("clam_lname").asString());
					bean.setAddress1(record.getValue("clam_add1").asString());
					bean.setAddress2(record.getValue("clam_add2").asString());
					bean.setCity(record.getValue("clam_city").asString());
					bean.setState(record.getValue("clam_state").asString());
					bean.setPostalcode(record.getValue("clam_postal").asString());
					bean.setCountryid(record.getValue("countries_id").asIntegerObj());
					bean.setTransferstatement(record.getValue("clam_transferstatment").asString());
					bean.setOthertransferstatement(record.getValue("clam_transferstatother").asString());
					
					link5.add(bean);
					
				}
				summarydata.put("link5", link5);
			}
			else
			{
				summarydata.put("link5",null);
			}
			
			//LINK 6
			System.out.println("link 6 start ");
			String query6="SELECT limit_id,  limit_excluded_text, limit_excluded_2dartwork, limit_excluded_photo," +
					" limit_excluded_jewelrydesign, limit_excluded_architectural, limit_excluded_sculpture, " +
					"limit_excluded_drawing, limit_excluded_map, limit_excluded_other, limit_included_text, " +
					"limit_included_2dartwork, limit_included_photo, limit_included_jewelrydesign, " +
					"limit_included_architectural, limit_included_sculpture, limit_included_drawing, limit_included_map, " +
					"limit_included_other, limit_firstprevreg, limit_firstyear, limit_secondprevreg, limit_secondyear, " +
					"limit_uploadedfilename FROM tbl_limitationclaim WHERE formcopy_id="+formcopyid;
			LimitationClaimForm bean=new LimitationClaimForm();
			List<Record> executeQuery6 = BasePeer.executeQuery(query6);
			if(executeQuery6!=null && executeQuery6.isEmpty()==false)
			{
				Record record = executeQuery6.get(0);
				bean.setLimit_id(record.getValue("limit_id").asIntegerObj());
				bean.setExcluded_text(record.getValue("limit_excluded_text").asString());
				bean.setExcluded_2dartwork(record.getValue("limit_excluded_2dartwork").asString());
				bean.setExcluded_photo(record.getValue("limit_excluded_photo").asString());
				bean.setExcluded_jewelrydesign(record.getValue("limit_excluded_jewelrydesign").asString());
				bean.setExcluded_architectural(record.getValue("limit_excluded_architectural").asString());
				bean.setExcluded_sculpture(record.getValue("limit_excluded_sculpture").asString());
				bean.setExcluded_drawing(record.getValue("limit_excluded_drawing").asString());
				bean.setExcluded_map(record.getValue("limit_excluded_map").asString());
				bean.setExcluded_other(record.getValue("limit_excluded_other").asString());
				bean.setIncluded_text(record.getValue("limit_included_text").asString());
				bean.setIncluded_2dartwork(record.getValue("limit_included_2dartwork").asString());
				bean.setIncluded_photo(record.getValue("limit_included_photo").asString());
				bean.setIncluded_jewelrydesign(record.getValue("limit_included_jewelrydesign").asString());
				bean.setIncluded_architectural(record.getValue("limit_included_architectural").asString());
				bean.setIncluded_sculpture(record.getValue("limit_included_sculpture").asString());
				bean.setIncluded_drawing(record.getValue("limit_included_drawing").asString());
				bean.setIncluded_map(record.getValue("limit_included_map").asString());
				bean.setIncluded_other(record.getValue("limit_included_other").asString());
				bean.setFirstprevreg(record.getValue("limit_firstprevreg").asString());
				bean.setFirstyear(record.getValue("limit_firstyear").asString());
				bean.setSecondprevreg(record.getValue("limit_secondprevreg").asString());
				bean.setSecondyear(record.getValue("limit_secondyear").asString());
				bean.setFilename(record.getValue("limit_uploadedfilename").asString());
				summarydata.put("link6", bean);
				
			}
			else
			{
				summarydata.put("link6", null);
			}
			
			//LINK 7
			System.out.println("link 7 start ");
			String query7="SELECT rights_id, rights_orgainzation, rights_fname, rights_mname, rights_lname, rights_add1, " +
					"rights_add2, rights_city, rights_state, rights_postal, countries_id, rights_alternatephone, " +
					"rights_phone, rights_email FROM tbl_rightspermission WHERE formcopy_id="+formcopyid;
			RightsPermissionForm bean7=new RightsPermissionForm();
			List<Record> executeQuery7 = BasePeer.executeQuery(query7);
			if(executeQuery7!=null && executeQuery7.isEmpty()==false)
			{
				Record record = executeQuery7.get(0);
				bean7.setRights_id(record.getValue("rights_id").asIntegerObj());
				bean7.setOrganizationname(record.getValue("rights_orgainzation").asString());
				bean7.setFirstname(record.getValue("rights_fname").asString());
				bean7.setMiddlename(record.getValue("rights_mname").asString());
				bean7.setLastname(record.getValue("rights_lname").asString());
				bean7.setAddress1(record.getValue("rights_add1").asString());
				bean7.setAddress2(record.getValue("rights_add2").asString());
				bean7.setCity(record.getValue("rights_city").asString());
				bean7.setState(record.getValue("rights_state").asString());
				bean7.setPostalcode(record.getValue("rights_postal").asString());
				bean7.setCountryid(record.getValue("countries_id").asIntegerObj());
				bean7.setAlternatephone(record.getValue("rights_alternatephone").asString());
				bean7.setPhone(record.getValue("rights_phone").asString());
				bean7.setEmail(record.getValue("rights_email").asString());
				
				summarydata.put("link7", bean7);
				
			}
			else
			{
				summarydata.put("link7", null);
			}
			
			//LINK 8
			System.out.println("link 8 start ");
			String query8="SELECT corr_id,  corr_orgainzation, corr_fname, corr_mname, corr_lname, corr_add1, " +
					"corr_add2, corr_city, corr_state, corr_postal, countries_id, corr_alternatephone, corr_phone," +
					" corr_email, corr_fax FROM tbl_correspondent WHERE formcopy_id="+formcopyid;
			CorrespondentForm bean8=new CorrespondentForm();
			List<Record> executeQuery8 = BasePeer.executeQuery(query8);
			if(executeQuery8!=null && executeQuery8.isEmpty()==false)
			{
				Record record = executeQuery8.get(0);
				bean8.setCorr_id(record.getValue("corr_id").asIntegerObj());
				bean8.setOrganizationname(record.getValue("corr_orgainzation").asString());
				bean8.setFirstname(record.getValue("corr_fname").asString());
				bean8.setMiddlename(record.getValue("corr_mname").asString());
				bean8.setLastname(record.getValue("corr_lname").asString());
				bean8.setAddress1(record.getValue("corr_add1").asString());
				bean8.setAddress2(record.getValue("corr_add2").asString());
				bean8.setCity(record.getValue("corr_city").asString());
				bean8.setState(record.getValue("corr_state").asString());
				bean8.setPostalcode(record.getValue("corr_postal").asString());
				bean8.setCountryid(record.getValue("countries_id").asIntegerObj());
				bean8.setAlternatephone(record.getValue("corr_alternatephone").asString());
				bean8.setPhone(record.getValue("corr_phone").asString());
				bean8.setEmail(record.getValue("corr_email").asString());
				bean8.setFax(record.getValue("corr_fax").asString());
				
				summarydata.put("link8", bean8);
			}
			else
			{
				summarydata.put("link8", null);
			}
			
			//LINK 9
			System.out.println("link 9 start ");
			String query9="SELECT mailc_id,  mailc_orgainzation, mailc_fname, mailc_mname," +
					" mailc_lname, mailc_add1, mailc_add2, mailc_city, mailc_state, mailc_postal," +
					" countries_id FROM tbl_mailcertificate WHERE formcopy_id="+formcopyid;
			MailCertificateForm bean9=new MailCertificateForm();
			List<Record> executeQuery9 = BasePeer.executeQuery(query9);
			if(executeQuery9!=null && executeQuery9.isEmpty()==false)
			{
				Record record = executeQuery9.get(0);
				bean9.setMailc_id(record.getValue("mailc_id").asIntegerObj());
				bean9.setOrganizationname(record.getValue("mailc_orgainzation").asString());
				bean9.setFirstname(record.getValue("mailc_fname").asString());
				bean9.setMiddlename(record.getValue("mailc_mname").asString());
				bean9.setLastname(record.getValue("mailc_lname").asString());
				bean9.setAddress1(record.getValue("mailc_add1").asString());
				bean9.setAddress2(record.getValue("mailc_add2").asString());
				bean9.setCity(record.getValue("mailc_city").asString());
				bean9.setState(record.getValue("mailc_state").asString());
				bean9.setPostalcode(record.getValue("mailc_postal").asString());
				bean9.setCountryid(record.getValue("countries_id").asIntegerObj());
				
				summarydata.put("link9", bean9);
				
			}
			else
			{
				summarydata.put("link9", null);
			}
			
			//LINK 10
			System.out.println("link 10 start ");
			String query10="SELECT spec_id, spec_specialhandling, spec_reason_pending, spec_reason_custom," +
					" spec_reason_contract, spec_explanation, spec_icertify FROM tbl_specialhandling WHERE  formcopy_id="+formcopyid;
			SpecialhandlingForm bean10=new SpecialhandlingForm();
			List<Record> executeQuery10 = BasePeer.executeQuery(query10);
			if(executeQuery10!=null && executeQuery10.isEmpty()==false)
			{
				Record record = executeQuery10.get(0);
				bean10.setSpec_id(record.getValue("spec_id").asIntegerObj());
				bean10.setSpecialhandling(record.getValue("spec_specialhandling").asString());
				bean10.setReason_pending(record.getValue("spec_reason_pending").asString());
				bean10.setReason_custom(record.getValue("spec_reason_custom").asString());
				bean10.setReason_contract(record.getValue("spec_reason_contract").asString());
				bean10.setExplanation(record.getValue("spec_explanation").asString());
				bean10.setIcertify(record.getValue("spec_icertify").asString());
				summarydata.put("link10", bean10);
				
			}
			else
			{
				summarydata.put("link10", null);
			}
			
			//LINK11
			System.out.println("link 11 start ");
			String query11="SELECT cert_id , cert_icertify, cert_nameofindividual, cert_trackingnumber, cert_note FROM tbl_certification WHERE formcopy_id="+formcopyid;
			CertificationForm bean11=new CertificationForm();
			List<Record> executeQuery11 = BasePeer.executeQuery(query11);
			if(executeQuery11!=null && executeQuery11.isEmpty()==false)
			{
				Record record = executeQuery11.get(0);
				bean11.setCert_id(record.getValue("cert_id").asIntegerObj());
				bean11.setIcertify(record.getValue("cert_icertify").asString());
				bean11.setNameofindividual(record.getValue("cert_nameofindividual").asString());
				bean11.setTrackingnumber(record.getValue("cert_trackingnumber").asString());
				bean11.setNote(record.getValue("cert_note").asString());
				summarydata.put("link11", bean11);
			}
			else
			{
				summarydata.put("link11",null);
			}
			
			
			System.out.println("The summary data contrains="
					+ summarydata.size());
			System.out.println("Summary Data Retrieval success");
			return summarydata;

		} catch (Exception e) {
			System.err.println("Data Retrieval error");
			System.err.println("Error at doRetrieveSummaryDetails "
					+ e.getMessage());
			e.printStackTrace();
		}
		
		return null;
	}
	public static boolean addCopyRightToCart(KKAppEng kkAppEng,
			HttpServletRequest request) {

		System.out.println("OlegTasks.addCopyRightToCart()");
        try {
			ProductIf selectedProd = kkAppEng.getProductMgr().getSelectedProduct();

			BasketIf b = new Basket();
			b.setQuantity(1);
			b.setProductId(selectedProd.getId());

			kkAppEng.getBasketMgr().addToBasket(b, true);
			return true;
		} catch (Exception e) {
			System.err.println("Sorry error in adding to cart "+e.getMessage());
			e.printStackTrace();
		}  	
		
		return false;
	}
}
