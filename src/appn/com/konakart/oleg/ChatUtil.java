package com.konakart.oleg;

import java.util.HashMap;

import org.apache.torque.TorqueException;
import org.apache.torque.util.BasePeer;
import org.jivesoftware.smack.AccountManager;
import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.Connection;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.SASLAuthentication;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Message.Type;
import org.jivesoftware.smack.packet.Registration;
import org.jivesoftware.smackx.Form;
import org.jivesoftware.smackx.search.UserSearchManager;

import com.konakart.al.KKAppEng;
import com.konakart.app.EmailOptions;
import com.konakart.app.KKException;
import com.konakart.appif.EmailIf;
import com.konakart.appif.EmailOptionsIf;

public class ChatUtil {

	public static final String SESSION_CONN = "SESSION_CONN";
	public static final String SESSION_MESSAGE = "SESSION_MESSAGE";
	public static final String SESSION_END_ALERT = "SESSION_END_ALERT";
	
	public static final String SESSION_PAID_CONN = "SESSION_PAID_CONN";
	public static final String SESSION_PAID_MESSAGE = "SESSION_PAID_MESSAGE";
	public static final String SESSION_PAID_END_ALERT = "SESSION_PAID_END_ALERT";
	public static final long PING_INTERVAL = 3000;
	public static final String SESSION_PAID_CHATLOG = "SESSION_PAID_CHATLOG";
	public static final String SESSION_PAID_CHATLOG_ID = "SESSION_PAID_CHATLOG_ID";
	public static final String SESSION_PAID_ADMIN_NAME = "SESSION_PAID_ADMIN_NAME";
	
	
	public static XMPPConnection connection = null;

	public ChatUtil() {

	}

	public static String doTestConn() {
		// ConnectionConfiguration config2=new
		// ConnectionConfiguration("198.38.92.127",5223);
		XMPPConnection conn = new XMPPConnection("198.38.92.127");
		try {
			conn.connect();
			conn.login("mithun", "mithun");
			boolean connected = conn.isConnected();
			if (connected) {
				ChatManager chatManager = conn.getChatManager();
				Chat chat = chatManager.createChat("mybuddy",
						new MessageListener() {
							public void processMessage(
									org.jivesoftware.smack.Chat arg0,
									org.jivesoftware.smack.packet.Message arg1) {

							}
						});
				Message mess = new Message("hhhh", Type.chat);

				chat.sendMessage(mess);
			}
			String return2 = "ISconnected=" + connected;
			return return2;
		} catch (XMPPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return e.getMessage();
		} finally {
			conn.disconnect();
		}

	}

	public static void doSendMailtoAdmin(KKAppEng kkAppEng,int id,String message)
	{
		EmailOptionsIf arg2=new EmailOptions();
		arg2.setCountryCode("en");
 		arg2.setTemplateName("GenericCustEmail");
		
		
		
		
		EmailIf send2=null;
		try {
			send2 = kkAppEng.getEng().sendTemplateEmailToCustomer1(id, message, arg2);
		} catch (KKException e) {
			System.err.println("Error in sendmailtoadmin "+e.getMessage());
			e.printStackTrace();
		}
		System.out.println("Mith Send to following emaid="+send2.getAddress());
		System.out.println("Mith Send following Message="+send2.getBody());
		
	}
	
	public static XMPPConnection doLogin(String username2, String password2,
			String ip) {
		try {
			ConnectionConfiguration config2 = new ConnectionConfiguration(
					"198.38.92.127", 5224);
			XMPPConnection conn = new XMPPConnection(config2);
			SASLAuthentication.supportSASLMechanism("PLAIN", 0);
			conn.connect();
			// conn.login(username2,password2,ip);//"mithun", "mithun");
			conn.loginAnonymously();
			String status = "";
			if (conn.isConnected()) {
				status = "true";

			} else {
				status = "false";

			}
			setConnection(conn);
			return conn;
		} catch (XMPPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	public static XMPPConnection doRealLogin(String username2, String password2 ) {
		try {
			ConnectionConfiguration config2 = new ConnectionConfiguration(
					"198.38.92.127", 5224);
			XMPPConnection conn = new XMPPConnection(config2);
			SASLAuthentication.supportSASLMechanism("PLAIN", 0);
			conn.connect();
			conn.login(username2,password2 );//"mithun", "mithun");
//			conn.loginAnonymously();
			String status = "";
			if (conn.isConnected()) {
				status = "true";

			} else {
				status = "false";

			}
			setConnection(conn);
			return conn;
		} catch (XMPPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	/*
	 * Register new user if not exist early.
	 */
	public static void doRegister(String username2, String password2,
			HashMap attributes, int customerid) {
		try {
			ConnectionConfiguration config2 = new ConnectionConfiguration(
					"198.38.92.127", 5224);
			XMPPConnection conn = new XMPPConnection(config2);
			SASLAuthentication.supportSASLMechanism("PLAIN", 0);
			username2 = doFromatUserName(username2);
			
			conn.connect();
			conn.login("admin","admin");
			if(password2==null || password2.trim().isEmpty())
			{
				System.out.println("Hi mith pasword was empty 123456");
				password2="123456";
			}
			if(checkchatUserExists(conn, username2))
			{
				System.out.println("User exists in chat server="+username2); 
				return ;
			}
			
			System.out.println("User donot exist "+username2);
			AccountManager manager = new AccountManager(conn);

			if (manager.supportsAccountCreation()) {
				
				manager.createAccount(username2, password2, attributes);
				String accountInstructions = manager.getAccountInstructions();
				System.out.println("New registration done server says "
						+ accountInstructions);
				
				Double secs=(double) (1000*60*10);
				int executeStatement = BasePeer
						.executeStatement("INSERT INTO tbl_chat_log (customers_id,products_id,chatlog_remaintime,chatlog_freeorpaid)  VALUES("
								+ customerid
								+ ","
								+ 0
								+ ","
								+secs
								+","
								+"'free'"
								+ ") ");

			} else {
				System.err
						.println("Sorry mith this server cannot register new users!");
			}
			if(conn!=null && conn.isConnected())
			{
				conn.disconnect();
			}
 
//			return conn;
		} catch (XMPPException e) {
			System.err.println("error in register"+e.getMessage());
			e.printStackTrace();
		} catch (TorqueException e) {
			System.err.println("error in regis data base error "+e.getMessage());
			e.printStackTrace();
		}
		return ;

	}

	/** To remove @ from username
	 * @param username2
	 * @return
	 */
	public static String doFromatUserName(String username2) {
		username2=username2.replaceAll("@", "");
//		username2=username2.replace('.', ' ');
//		username2=username2.replaceAll(" ", "");
//		username2=username2.replaceAll("_", "");
		
		return username2;
	}

	private static Boolean checkchatUserExists(Connection mXMPPConnection,
			String username) {
		UserSearchManager search = new UserSearchManager(mXMPPConnection);

		try {
			Form searchForm = search.getSearchForm("search."
					+ mXMPPConnection.getServiceName());

			Form answerForm = searchForm.createAnswerForm();
			answerForm.setAnswer("Username", true);

			answerForm.setAnswer("search", username);

			org.jivesoftware.smackx.ReportedData data = search
					.getSearchResults(answerForm,
							"search." + mXMPPConnection.getServiceName());

			if (data.getRows() != null && data.getRows().hasNext()) {
				
				return true;
			} else {
				return false;
			}
		} catch (Exception ex) {
			System.err.println("Sorry error checkchatuser exist here "
					+ ex.getMessage());
			ex.printStackTrace();
		}
		return false;

	}

	public static XMPPConnection getConnection() {
		return connection;
	}

	public static void setConnection(XMPPConnection connection) {
		ChatUtil.connection = connection;
	}
}
