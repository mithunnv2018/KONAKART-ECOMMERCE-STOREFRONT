package com.konakart.oleg.actions;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.torque.TorqueException;
import org.apache.torque.util.BasePeer;
import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.ChatManagerListener;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Message.Type;

import com.konakart.actions.BaseAction;
import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.appif.CategoryIf;
import com.konakart.oleg.ChatUtil;
import com.konakart.oleg.actions.OlegMyChatAction.MyMessageListener;
import com.konakart.oleg.actions.OlegMyChatAction.MyTimer;
import com.workingdogs.village.DataSetException;
import com.workingdogs.village.Record;
import com.workingdogs.village.Value;

public class OlegPaidChatAction extends BaseAction {

	private HttpSession session2;

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		session2 = request.getSession();
		String method2 = request.getParameter("othermethod2");

		if (method2 != null && method2.equals("login")) {
			login(mapping, form, request, response);
		}
		if (method2 != null && method2.equals("sendchat")) {
			sendchat(mapping, form, request, response);
		}
		if (method2 != null && method2.equals("receivechat")) {
			receivechat(mapping, form, request, response);
		}
		if (method2 != null && method2.equals("logout2")) {
			// receivechat(mapping, form, request, response);
			logout2(mapping, form, request, response);
		}
		if (method2 != null && method2.equals("logintimeout")) {
			logintimeout(mapping, form, request, response);
		}
		if (method2 != null && method2.equals("adminparams")) {
			adminparams(mapping, form, request, response);
		}

		return super.execute(mapping, form, request, response);
	}

	public void adminparams(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		System.out.println("OlegPaidChatAction.adminparams()");
		try {
			String parameter = request.getParameter("adminname");
			if (parameter != null) {
				HttpSession session = request.getSession();
				parameter = ChatUtil.doFromatUserName(parameter);
				session.setAttribute(ChatUtil.SESSION_PAID_ADMIN_NAME,
						parameter);
				System.out.println("Done saving admin user " + parameter);
			}
		} catch (Exception e) {
			System.err.println("Sorry erro in adminparams " + e.getMessage());
			e.printStackTrace();
		}

	}

	public ActionForward logintimeout(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("OlegPaidChatAction.logintimeout()");

		try {
			HttpSession session = request.getSession();

			KKAppEng kkAppEng = this.getKKAppEng(request, response);
			Integer custid = kkAppEng.getCustomerMgr().getCurrentCustomer()
					.getId();
			HashMap attribute = (HashMap) retrieveChatRemainTime(kkAppEng,
					custid);
			// session.getAttribute(ChatUtil.SESSION_PAID_CHATLOG);
			Record abc = null;
			long seconds2 = (-1);
			if (attribute != null && attribute.isEmpty() == false) {
				if (attribute.get("free") != null) {
					abc = (Record) attribute.get("free");
				} else if (attribute.get("paid") != null) {
					abc = (Record) attribute.get("paid");
				}
			}
			if (abc != null) {
				updateChatRemainTime(abc.getValue("chatlog_id").asInt());

				seconds2 = abc.getValue("chatlog_remaintime").asLong();

			}
			if (seconds2 <= 0) {
				seconds2 = -1;
				new MyTimer().run();
				
				sendMail2Admin(kkAppEng, session);

			}
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write("" + seconds2);

		} catch (Exception e) {
			System.err.println("Sorry errro in logintimeout " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public void sendMail2Admin(KKAppEng kkAppEng, HttpSession session) {
		System.out.println("OlegPaidChatAction.sendMail2Admin()");
		List<Record> executeQuery;
		String adminemail = "info@dulynoted.co.uk";
		int custid = 0;
		try {
			executeQuery = BasePeer
					.executeQuery("SELECT * FROM customers c  where customers_email_address='"
							+ adminemail + "' ");
			if (executeQuery.isEmpty() == false) {

				Record row = executeQuery.get(0);
				custid = row.getValue("customers_id").asInt();
				String messagepaid = (String) session.getAttribute(ChatUtil.SESSION_PAID_MESSAGE);
				ChatUtil.doSendMailtoAdmin(kkAppEng, custid, messagepaid);
			}
		} catch (Exception e) {
			System.err.println("Sorry exception in sendMail2Admin inn action "+e.getMessage());
			e.printStackTrace();
		} 

	}

	/**
	 * To logout from connection
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward logout2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("OlegPaidChatAction.logout2()");
		try {

			HttpSession session = request.getSession();
			KKAppEng kkAppEng=this.getKKAppEng(request, response);
			
			sendMail2Admin(kkAppEng, session);
			XMPPConnection conn = (XMPPConnection) session
					.getAttribute(ChatUtil.SESSION_PAID_CONN);
			if (conn != null && conn.isConnected()) {
				conn.disconnect();
				System.out.println("Done logout");
			} else {
				System.out
						.println("Sorry could nt logout since is not connected");
			}
			session.setAttribute(ChatUtil.SESSION_PAID_CONN, null);
			session.setAttribute(ChatUtil.SESSION_PAID_MESSAGE, null);
			session2.setAttribute(ChatUtil.SESSION_PAID_CONN, null);
			session2.setAttribute(ChatUtil.SESSION_PAID_MESSAGE, null);

			session2 = session;
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write("Logout");
			// return mapping.findForward("logout");
		} catch (Exception e) {
			System.err.println("Logout error " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * PAID CHAT To be called from client javascript inorder to receive incoming
	 * chat messages
	 */
	public ActionForward receivechat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		System.out.println("OlegPaidChatAction.receivechat()");
		try {
			HttpSession session = request.getSession();
			session2 = session;

			// KKAppEng kkAppEng=this.getKKAppEng(request, response);
			// Integer chatlogid=kkAppEng.getCustomerMgr().getCurrentCustomer()
			// .getId();

			Integer chatlogid = (Integer) session
					.getAttribute(ChatUtil.SESSION_PAID_CHATLOG_ID);
			updateChatRemainTime(chatlogid);

			String message = (String) session
					.getAttribute(ChatUtil.SESSION_PAID_MESSAGE);

			if (message == null || message.isEmpty()) {
				message = " ";
			}
			// if (((String) session.getAttribute(ChatUtil.SESSION_END_ALERT))
			// .equals("false")) {

			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write(message);
			// }
			System.out.println("Send paid response to jsp page!");
		} catch (Exception e) {
			System.err.println("Sorry error in recevei chat " + e.getMessage());
			e.printStackTrace();
		}

		return null;
	}

	/*
	 * called by javascript to send message to user meintion in req param as
	 * "to" and "messagebody" as message
	 */
	public ActionForward sendchat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("OlegPaidChatAction.sendchat()");
		try {
			String status = "";

			String message = request.getParameter("messagebody");
			String to = request.getParameter("to");
			if (message == null || to.isEmpty()) {
				status = "ERROR Sorry no message or to text";
			} else {
				HttpSession session = request.getSession();
				session2 = session;
				XMPPConnection conn = (XMPPConnection) session
						.getAttribute(ChatUtil.SESSION_PAID_CONN);

				// //////////
				String servermessage = (String) session
						.getAttribute(ChatUtil.SESSION_PAID_MESSAGE);
				StringBuffer formatmessage = new StringBuffer("");
				if (servermessage != null)

				{
					formatmessage = new StringBuffer(servermessage);
				}
				Date dnow = new Date();
				SimpleDateFormat ft = new SimpleDateFormat("hh:mm");
				String timenow = ft.format(dnow);

				timenow = "<font color='blue'>(" + timenow + ") Me:</font>";

				if (((String) session
						.getAttribute(ChatUtil.SESSION_PAID_END_ALERT))
						.equals("false")) {

					formatmessage.append(timenow + message + "<br/>");
					session.setAttribute(ChatUtil.SESSION_PAID_MESSAGE,
							formatmessage.toString());
				}

				// ///////////////

				if (conn != null && conn.isConnected()
						&& conn.isAuthenticated()) {
					ChatManager chatManager = conn.getChatManager();
					Chat chat = chatManager.createChat(to,
							new MyMessageListener());
					chat.sendMessage(message);
					status = "OK send to " + to;
				}
			}
			// response.setContentType("text/xml; charset=UTF-8");
			// response.getWriter().write(status);

		} catch (Exception e) {
			System.err.println("erro on sending " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public ActionForward login(ActionMapping mapping, ActionForm form,
			final HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("OlegPaidChatAction.login()");

		XMPPConnection doLogin;
		try {

			KKAppEng kkAppEng = this.getKKAppEng(request, response);
			String username2 = kkAppEng.getCustomerMgr().getCurrentCustomer()
					.getEmailAddr();
			Integer custid = kkAppEng.getCustomerMgr().getCurrentCustomer()
					.getId();
			username2 = ChatUtil.doFromatUserName(username2);
			// this.loggedIn(request, response, kkAppEng, "");
			// String username2 = request.getParameter("username2");
			String password2 = "123456";// request.getParameter("password2");
			HttpSession session = request.getSession();

			String status = "";
			// NOT USING BELOW
			String ip = request.getRemoteHost();
			ip += request.getRemoteAddr();
			session.setAttribute(ChatUtil.SESSION_PAID_MESSAGE, "");

			if (session.getAttribute(ChatUtil.SESSION_PAID_CONN) == null) {
				doLogin = ChatUtil.doRealLogin(username2, password2);

				if (doLogin.isAuthenticated()) {
					session.setAttribute(ChatUtil.SESSION_PAID_CONN, doLogin);
					status = "true";
				} else {
					session.setAttribute(ChatUtil.SESSION_PAID_CONN, null);
					status = "false";
				}
			} else {
				doLogin = (XMPPConnection) session
						.getAttribute(ChatUtil.SESSION_PAID_CONN);
				if (doLogin.isAuthenticated()) {
					// doLogin.loginAnonymously();
					// doLogin.login(username2, password2);
					status = "true";
				} else {
					System.out
							.println("No connection still connection on session");
					status = "false";
				}
			}

			String adminame = (String) session
					.getAttribute(ChatUtil.SESSION_PAID_ADMIN_NAME);

			Chat createChat = doLogin.getChatManager().createChat(
					adminame + "@198.38.92.127", new MyMessageListener());
			// "admin2@198.38.92.127", new MyMessageListener());

			doLogin.getChatManager().addChatListener(new ChatManagerListener() {

				@Override
				public void chatCreated(Chat arg0, boolean arg1) {
					if (!arg1) {
						System.out.println("Inside chatCreated");
						arg0.addMessageListener(new MyMessageListener());
					}
				}
			});

			Message message = new Message(adminame, Type.chat);// "admin2",
																// Type.chat);
			message.setBody("Hi from user after logging in");
			createChat.sendMessage(message);

			// ////ADDED HERE TIMER START
			session.setAttribute(ChatUtil.SESSION_PAID_END_ALERT, "false");
			long seconds2 = 0;
			HashMap retrieveChatRemainTime = retrieveChatRemainTime(kkAppEng,
					custid);
			if (retrieveChatRemainTime.get("free") != null) {
				Record r = (Record) retrieveChatRemainTime.get("free");
				seconds2 = r.getValue("chatlog_remaintime").asLong();
			} else if (retrieveChatRemainTime.get("paid") != null) {
				Record r = (Record) retrieveChatRemainTime.get("paid");
				seconds2 = r.getValue("chatlog_remaintime").asLong();
			}

			/*
			 * Timer timer = new Timer(); // int seconds = 1000 * 60 * 2;
			 * timer.schedule(new MyTimer(), seconds2);
			 */
			// ///////////////////////////////////

			System.out.println("Status is =" + status);
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write("" + seconds2);

			// return mapping.findForward("loggedin");
		} catch (Exception e) {
			System.err.println("Eror here " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	private Long updateChatRemainTime(Integer chatlogid) {
		System.out.println("OlegPaidChatAction.updateChatRemainTime()"
				+ chatlogid);
		try {
			List<Record> executeQuery = BasePeer
					.executeQuery("SELECT chatlog_id,customers_id,products_id,chatlog_remaintime,chatlog_freeorpaid FROM tbl_chat_log WHERE chatlog_id="
							+ chatlogid);
			if (executeQuery != null && executeQuery.size() > 0) {
				Record record = executeQuery.get(0);
				long asLong = record.getValue("chatlog_remaintime").asLong();
				if (asLong > 0) {
					asLong = asLong - ChatUtil.PING_INTERVAL;
					if (asLong < 0) {
						asLong = 0;
					}

					String statementString = "UPDATE tbl_chat_log SET chatlog_remaintime = "
							+ asLong + " WHERE chatlog_id =" + chatlogid;
					int executeStatement = BasePeer
							.executeStatement(statementString);
					System.out.println("Done update " + executeStatement
							+ " for sql=" + statementString);

				}

				return asLong;

			}
		} catch (Exception e) {
			System.err.println("Sorry error in updateChatRemainTime "
					+ e.getMessage());
			e.printStackTrace();
		}
		return -1l;
	}

	private HashMap retrieveChatRemainTime(KKAppEng kkAppEng, Integer custid) {

		System.out.println("OlegPaidChatAction.retrieveChatRemainTime()");
		long seconds = 0;
		Boolean free = true;
		HashMap content = new HashMap();//
		Integer chatlogid = 0;

		try {

			content.put("free", null);

			List<Record> executeQuery = BasePeer
					.executeQuery("Select chatlog_id,customers_id,products_id,chatlog_remaintime,chatlog_freeorpaid FROM tbl_chat_log WHERE customers_id="
							+ custid
							+ " AND chatlog_remaintime > 0 order by  chatlog_id");
			if (executeQuery != null && executeQuery.size() > 0) {
				for (int i = 0; i < executeQuery.size(); i++) {
					Record record = executeQuery.get(i);
					String freeorpaid = record.getValue("chatlog_freeorpaid")
							.asString();
					chatlogid = record.getValue("chatlog_id").asIntegerObj();
					if (freeorpaid.equals("free")) {
						free = true;
						content.put("free", record);
						seconds = record.getValue("chatlog_remaintime")
								.asLong();
						return content;
					} else {
						free = false;
					}
					content.put("paid", record);

				}

				return content;

			}
		} catch (Exception e) {
			System.err.println("Sorry erro in retrieveChatRemaintime "
					+ e.getMessage());
			e.printStackTrace();
		} finally {
			session2.setAttribute(ChatUtil.SESSION_PAID_CHATLOG, content);
			session2.setAttribute(ChatUtil.SESSION_PAID_CHATLOG_ID, chatlogid);
			System.out.println("done updating session chatlog ="
					+ content.toString());
		}
		return null;
	}

	class MyTimer extends TimerTask {
		@Override
		public void run() {
			System.out.println("OlegMyChatAction.MyTimer.run()");
			String stopnow = "<font color='red'>Your time has expired.<br/>Please Logout</font>";
			// TODO Auto-generated method stub
			XMPPConnection conn = (XMPPConnection) session2
					.getAttribute(ChatUtil.SESSION_PAID_CONN);
			Collection<ChatManagerListener> chatListeners = conn
					.getChatManager().getChatListeners();

			for (ChatManagerListener listeners : chatListeners) {
				conn.getChatManager().removeChatListener(listeners);
			}

			KKAppEng kkeng;
			try {
				kkeng = new KKAppEng();

				for (CategoryIf cat : kkeng.getCategoryMgr().getCats()) {

					if (cat.getName().contains("Solicitors")) {
						int id = cat.getId();
						stopnow += "<br/>";
						stopnow += "<a href='SelectCat.do?catId=" + id
								+ " '>Click to buy chat services</a>";
					}
				}
			} catch (KKAppException e) {
				e.printStackTrace();
			}

			session2.setAttribute(ChatUtil.SESSION_PAID_MESSAGE, stopnow);
			session2.setAttribute(ChatUtil.SESSION_PAID_END_ALERT, "true");
		}
	}

	class MyMessageListener implements MessageListener {

		// private HttpServletRequest request2;
		// public MyMessageListener(HttpServletRequest req)
		// {
		// request2=req;
		// }
		public MyMessageListener() {
			// session2=sess;
		}

		@Override
		public void processMessage(Chat chat2, Message message2) {
			System.out.println("MyChat=>MyMessageListener.processMessage()");
			String messagebody = message2.getBody();

			// XMPPConnection conn2=(XMPPConnection)
			// session2.getAttribute(ChatUtil.SESSION_CONN);
			// RosterEntry entry =
			// conn2.getRoster().getEntry(chat2.getParticipant());
			String from = "Admin";// entry.getName();

			StringBuffer body2 = new StringBuffer("");
			body2.append(message2.getBody());
			body2.append("from --" + message2.getFrom());
			// String from = message2.getFrom();
			// int indexOf = from.indexOf('@');
			// from = from.substring(0, indexOf);

			HttpSession session = session2;
			String servermessage = (String) session
					.getAttribute(ChatUtil.SESSION_PAID_MESSAGE);

			if (servermessage == null) {
				servermessage = "";
			}
			Date dnow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("hh:mm");
			String timenow = ft.format(dnow);

			timenow = "<font color='red'>(" + timenow + ")" + from + ":</font>";
			messagebody = timenow + " " + messagebody + "<br/>";

			servermessage += messagebody;

			session.setAttribute(ChatUtil.SESSION_PAID_MESSAGE, servermessage);
			System.out.println("Message on server is " + servermessage);
			System.out.println("Hi Message is = " + body2.toString());

			/*
			 * ScriptEngineManager manager=new ScriptEngineManager();
			 * ScriptEngine engineByName =
			 * manager.getEngineByName("javascript");
			 * 
			 * try { engineByName.eval("addMessage('"+body2.toString()+" ');");
			 * 
			 * } catch (ScriptException e1) { // TODO Auto-generated catch block
			 * e1.printStackTrace(); }
			 */

		}
	}
}
